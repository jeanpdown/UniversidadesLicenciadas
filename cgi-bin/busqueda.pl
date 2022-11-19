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
    
    <link rel="stylesheet" type="text/css" href="../estilosPerl.css">
    <title>Búsquedas Universidades Licenciadas </title>
</head>
<body>
    <div class="contenedor-busqueda">
HTML

my $q =CGI->new;
my $busqueda=$q->param("busqueda");
my $opcion=$q->param("opcion");
my $expresion;
my @cabeceras;
my $encontrado;


@cabeceras=obtenerCabecera();


$busqueda = uc $busqueda;

if($opcion eq "Nombre" && !($busqueda eq "")){

    $expresion=generadorExpresionRegular(2,$busqueda);
    imprimirResultados($expresion);
}elsif($opcion eq "Periodo" && !($busqueda eq "")){

    $expresion=generadorExpresionRegular(5,$busqueda);
    imprimirResultados($expresion);

}elsif($opcion eq "DepLocal" && !($busqueda eq "")){

    $expresion=generadorExpresionRegular(11,$busqueda);
    imprimirResultados($expresion);
    
}elsif($opcion eq "DenoPrograma" && !($busqueda eq "")){

    $expresion=generadorExpresionRegular(17,$busqueda);
    imprimirResultados($expresion);
    
}else{
    print "<h1>Escriba almenos un digito</h1>";
}


if(!defined($encontrado)){
    print "<h1 class='error'>No encontrado</h1>\n";
}


sub obtenerCabecera{
    open(IN,"../UniversidadesLicenciadas.csv") or die"ERROR";

    my @lines=  <IN>;
    my @columnas=split("\\|",$lines[0]);
                
    close (IN);
    return @columnas;
}




sub imprimirResultados{
    my $expresion=$_[0];
    my @columnas;
    open(IN,"../UniversidadesLicenciadas.csv") or die"ERROR";
    while(my $line = <IN>){

            $line =~ tr/ÁÉÍÓÚ/AEIOU/;

            if($line =~ /$expresion/){
                $encontrado=1;
                @columnas=split("\\|",$line);
                print <<HTML;
                    <div class="contenedor-resultados">
HTML
                for(my $i=1;$i<23;$i++ ){
                    print <<HTML;
                    <div >
HTML
                    print "<b>$cabeceras[$i]</b>: $columnas[$i]";
                    print <<HTML;
                    </div>
HTML

                }
                print <<HTML;
                    </div>
HTML
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
    
    $expresion.="([^\\|]*$busq\[^\\|]*)\\|(.+)";

    return $expresion;
}