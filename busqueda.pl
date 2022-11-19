#!"c:\xampp\perl\bin\perl.exe"
use strict;
use CGI;
use warnings;
use utf8;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="../estilos.css">
    <title>Búsquedas Universidades Licenciadas </title>
</head>
<body>
    <div >
HTML

my $q =CGI->new;
my $busqueda=$q->param("busqueda");
my $opcion=$q->param("opcion");
my $expresion;


if($opcion eq "Nombre"){
    $expresion=generadorExpresionRegular(2,$busqueda);
    imprimirResultados($expresion);
}elsif($opcion eq "Periodo"){


}elsif($opcion eq "DepLocal"){

    
}elsif($opcion eq "DenoPrograma"){

    
}else{

}


sub imprimirResultados{
    my $expresion=$_[0];
    
    open(IN,"UniversidadesLicenciadas.csv") or die"ERROR";
    print "expre $expresion\n";
    while(my $line = <IN>){
             if($line =~ /$expresion/){   #([^\|]+)
                 print $line;
             }
         }
     close (IN);
}

sub generadorExpresionRegular{
    my $columna=$_[0];
    my $busq=$_[1];
    my $expresion="^";
    
    for(my $i=1;$i<$columna;$i++){
        $expresion.="([^\\|]+)\\|";

    }
    
    $expresion.="(.*$busq.*)\\|(.+)";

    return $expresion;
}