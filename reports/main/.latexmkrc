$pdf_mode = 1;
$pdflatex = 'pdflatex -shell-escape -interaction=nonstopmode %O %S';
$clean_ext = "acn acr alg glg glo gls ist";

add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
  system("makeglossaries $_[0]");
}
