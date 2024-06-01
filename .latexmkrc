# 设置如何运行完整的编译过程，包括多次运行xelatex和运行bibtex
$pdflatex = 'xelatex';
$bibtex_use = 1;
$makeindex_use = 1;

# 添加对文件扩展名的支持
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
add_cus_dep('acn', 'acr', 0, 'makeacn2acr');

# 定义zhmakeindex的命令
sub makeglo2gls {
    system("zhmakeindex -s zh.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}
sub makeacn2acr {
    system("zhmakeindex -s zh.ist -o \"$_[0].acr\" \"$_[0].acn\"");
}

$bibtex = 'bibtex %O %B';
$makeindex = 'zhmakeindex %O -s zh.ist -o %D %S';

# 运行顺序的设定
$clean_ext = 'acn acr alg bbl blg glg glo gls ist log out';

# 是否进行交互式编译
$force_mode = 1;

# 使用xelatex进行编译
$latex = 'xelatex %O %S';
$bibtex = 'bibtex %O %B';
$makeindex = 'zhmakeindex %O -s zh.ist -o %D %S';

# 其他设置
$pdf_mode = 1;
$interaction = 'nonstopmode';

# 让latexmk多次运行，以确保所有引用和索引都得到正确解析
push @generated_exts, 'acn', 'acr', 'alg', 'bbl', 'blg', 'glg', 'glo', 'gls', 'ist', 'out';
