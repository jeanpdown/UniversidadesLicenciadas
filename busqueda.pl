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
    
    <link rel="stylesheet" type="text/css" href="estilosPerl.css">
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


@cabeceras=obtenerCabecera();

if($opcion eq "Nombre"){

    $expresion=generadorExpresionRegular(2,$busqueda);
    imprimirResultados($expresion);
}elsif($opcion eq "Periodo"){

    $expresion=generadorExpresionRegular(5,$busqueda);
    imprimirResultados($expresion);

}elsif($opcion eq "DepLocal"){

    $expresion=generadorExpresionRegular(11,$busqueda);
    imprimirResultados($expresion);
    
}elsif($opcion eq "DenoPrograma"){

    $expresion=generadorExpresionRegular(17,$busqueda);
    imprimirResultados($expresion);
    
}else{
    print "ERROR";
}




sub obtenerCabecera{
    open(IN,"UniversidadesLicenciadas.csv") or die"ERROR";

    my @lines=  <IN>;
    my @columnas=split("\\|",$lines[0]);
                
    close (IN);
    return @columnas;
}





sub imprimirResultados{
    my $expresion=$_[0];
    my @columnas;
    open(IN,"UniversidadesLicenciadas.csv") or die"ERROR";
    while(my $line = <IN>){
             if($line =~ /$expresion/){   #([^\|]+)
                @columnas=split("\\|",$line);
                print <<HTML;
                    <div class="contenedor-resultados">
HTML
                foreach my $element (@columnas){
                    print <<HTML;
                    <div >
HTML
                    print $element;
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