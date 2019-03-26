//---------------------------------------------------------------------------
// Programa: Tutorial 3
// Autor: Daniel Navarro Medrano
// Fecha: 27/2/97
//---------------------------------------------------------------------------

PROGRAM Tutorial_3;
INCLUDE "imports.prg";
//Declaramos las Variables
GLOBAL
    raqueta1,raqueta2; // Identificadores de las raquetas
	  fichero;
    b1;
    i=0;
    j=0;
    string str;
//Comenzamos a Ejecutar el Codigo
BEGIN
        // Se selecciona el modo de video
        set_mode(320,200,32);
        // Carga el fichero con los gráficos del juego
        fichero=load_fpg("Graficos_Pong.fpg");
        // Pone el fondo de pantalla
        put_screen(fichero,1);
        // Enciende la pantalla
        fade_on();

        // Crea las dos raquetas y coge sus identificadores
        raqueta1=raqueta(6,24,_q,_a);
        raqueta2=raqueta(314,24,_p,_l);

        // Crea el proceso de la bola
        b1 = bola(160,100,1,1);

        //Ponemos los 2 Marcadores
        write_int(0,30,35,0,&j);
        write_int(0,290,35,0,&i);

        //Llamamos al Proceso Partida para contar los puntos
        partida();
        FRAME
//---------------------------------------------------------------------------
// Proceso bola
// Maneja la bola del juego
// Entradas: x,y   = Coordenadas del gráfico
//           ix,iy = Incrementos en cada una de las coordenadas
//---------------------------------------------------------------------------
PROCESS bola(x,y,ix,iy);
BEGIN
	file=fichero;
    graph=3;    // Selecciona el gráfico
    REPEAT
        // Lo muestra en pantalla más veces que los demas
        FRAME(25);
        // Comprueba si rebota con los laterales superior e inferior
        IF (y==14 or y==186)
            // Cambia la direccion vertical
            iy=-iy;
        END
        // Comprueba si rebota con las raquetas
        IF ((x==10 and abs(y-raqueta1.y)<22) or
           (x==310 and abs(y-raqueta2.y)<22))
            // Cambia la direccion horizontal
            ix=-ix;
        END
        // Mueve la pelota
        x=x+ix;
        y=y+iy;
    // Repite hasta que se salga de pantalla
    UNTIL (out_region(id,0))
    // Crea una nueva pelota
    b1 = bola(160,100,ix,iy);
END
//---------------------------------------------------------------------------
// Proceso raqueta
// Maneja las raquetas de los jugadores
// Entradas: x,y    = Coordenadas de los gráficos
//           arriba = Tecla para moverse hacia arriba
//           abajo  = Tecla para moverse hacia abajo
//---------------------------------------------------------------------------

PROCESS raqueta(x,y,arriba,abajo)
BEGIN
	file=fichero;
    // Selecciona el gráfico
    graph=2;
    LOOP
        // Muestra la imagen
        FRAME;
        // Si se pulsa la tecla para arriba y no ha llegado al limite
        IF (key(arriba) and y>24)
            y=y-4;  // Mueve la raqueta
        END
        // Si se pulsa la tecla para abajo y no ha llegado al limite
        IF (key(abajo) and y<176)
            y=y+4; // Mueve la raqueta
        END
    END
END
//Proceso Partida --------------------------------------------------------------------
function int partida()
BEGIN
    str="Hola";
    write_string(0,100,100,0,&str);
END
