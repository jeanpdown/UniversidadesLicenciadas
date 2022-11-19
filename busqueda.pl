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

generadorExpresionRegular(2,$busqueda);

if($opcion eq "Nombre"){
    #imprimirResultados(1,$busqueda);
}


sub imprimirResultados{
    my $columna=$_[0];
    
    # print "la busqueda es $busq";
    # open(IN,"UniversidadesLicenciadas.csv") or die"ERROR";

    #     while(my $line = <IN>){
    #         if($line =~ /^([^\|]+)\|(.*$busq.*)\|(.+)/){   #([^\|]+)
    #             print $line;
    #         }
    #     }
    # close (IN);
}

sub generadorExpresionRegular{
    my $columna=$_[0];
    my $busq=$_[1];
    my $expresion="^";
    
    for(my $i=1;$i<$columna;$i++){
        $expresion.="([^\|]+)\|";

    }
    
    $expresion.="(.*$busq.*)\|(.+)/";
    print "expre $expresion\n";

    return $expresion;
}