#!/bin/bash

function menu()
{
    clear
    echo -e "\e[1;35m   [Examen Tema 7]\e[0m"
    echo "======================"
    echo -e "\e[1;34m[1]\e[0m. Listar Archivos."
    echo -e "\e[1;34m[2]\e[0m. Ver CWD."
    echo -e "\e[1;34m[3]\e[0m. Crear Directorio."
    echo -e "\e[1;34m[4]\e[0m. Borrar Directorio."
    echo -e "\e[1;34m[5]\e[0m. Crear Usuario."
    echo -e "\e[1;34m[6]\e[0m. Borrar Usuario."
    echo -e "\e[1;34m[7]\e[0m. Salir."
    echo "======================"
    echo -n "OPCION:"
    read OPTION
    return $OPTION
}

function start_script()
{
    while true; do
        menu
        case $OPTION in
            1) ls -la && sleep 2 && menu ;;
            2) echo -n -e "\e[1;35m[Directorio Actual]: \e[0m" && pwd && sleep 3 && menu ;;
            3) script_createdir ;;
            4) script_removedir ;;
            5) add_user ;;
            6) remove_user ;;
            7) echo "Fin de Ejecucion" && sleep 2 && exit 0 ;;
        esac
    done
}

function script_createdir()
{ 
    echo
    echo -e "\e[1;33m[⚙️ CDir]>\e[0m INICIANDO CREADOR DE DIRECTORIOS"
    sleep 2
    echo -e -n "\e[1;34m[⚙️ CDir]>\e[0m INSERTE EL NOMBRE DEL DIRECTORIO A CREAR: "
    read DIRNAME

    if [ -z $DIRNAME ]; then
       echo -e "\e[31m[ERROR]\e[0m EL CAMPO NO PUEDE ESTAR VACIO!! [SALIENDO DE \e[1;34m⚙️ CDir\e[0m]..." 
       sleep 3
       menu
    else
        echo -e "\e[1;34m[⚙️ CDir]>\e[0m CREANDO DIRECTORIO [$DIRNAME] "
        sleep 1
        mkdir $DIRNAME 2> /dev/null
        sleep 3
        echo -e "\e[1;34m[⚙️ CDir]>\e[0m DIRECTORIO [$DIRNAME] CREADO EXITOSAMENTE!! "
        sleep 3
        menu

    fi
}

function script_removedir()
{ 
    echo
    echo -e "\e[1;33m[⚙️ RDir]>\e[0m INICIANDO BORRADOR DE DIRECTORIOS"
    sleep 2
    echo -e -n "\e[1;34m[⚙️ RDir]>\e[0m INSERTE EL NOMBRE DEL DIRECTORIO A REMOVER: "
    read DIRNAME

    if [ -z $DIRNAME ]; then
       echo -e "\e[31m[ERROR]\e[0m EL CAMPO NO PUEDE ESTAR VACIO!! [SALIENDO DE \e[1;34m⚙️ CDir\e[0m]..." 
       sleep 3
       menu
    else
        echo -e "\e[1;34m[⚙️ RDir]>\e[0m ELIMINANDO DIRECTORIO [$DIRNAME] "
        sleep 1
        rm -r $DIRNAME 2> /dev/null
        sleep 3
        echo -e "\e[1;34m[⚙️ RDir]>\e[0m DIRECTORIO [$DIRNAME] BORRADO EXITOSAMENTE!! "
        sleep 3
        menu
    fi
}

function add_user()
{
    echo
    echo -e "\e[1;33m[⚙️ CUser]>\e[0m INICIANDO CREADOR DE USUARIOS"
    sleep 2
    echo -e -n "\e[1;34m[⚙️ CUser]>\e[0m INSERTE EL NOMBRE DE USUARIO A CREAR: "
    read USERNAME

    if [ -z $USERNAME ]; then
       echo -e "\e[31m[ERROR]\e[0m EL CAMPO NO PUEDE ESTAR VACIO!! [SALIENDO DE \e[1;34m⚙️ CUser\e[0m]..." 
       sleep 3
       menu
    else
        echo -e "\e[1;34m[⚙️ CUser]>\e[0m CREANDO USUARIO [$USERNAME] "
        sleep 1
        useradd -m $USERNAME
        sleep 3
        echo -e "\e[1;34m[⚙️ CUser]>\e[0m USUARIO [$USERNAME] CREADO EXITOSAMENTE!! "
        sleep 3
        echo -e -n "\e[1;34m[⚙️ CUser]>\e[0m DESEA ACCEDER AL USUARIO [$USERNAME] [y/n]?: "
        read CHANGEUSR

        case $CHANGEUSR in
            "y"|"Y") sudo su $USERNAME ;;
            "n"|"N") menu ;;
        esac

    fi
}

function remove_user()
{
    echo
    echo -e "\e[1;33m[⚙️ RUser]>\e[0m INICIANDO REMOVEDOR DE USUARIOS"
    sleep 2
    echo -e -n "\e[1;34m[⚙️ RUser]>\e[0m INSERTE EL NOMBRE DE USUARIO A REMOVER: "
    read USERNAME

    if [ -z $USERNAME ]; then
       echo -e "\e[31m[ERROR]\e[0m EL CAMPO NO PUEDE ESTAR VACIO!! [SALIENDO DE \e[1;34m⚙️ RUser\e[0m]..." 
       sleep 3
       menu
    else
        echo -e "\e[1;34m[⚙️ CUser]>\e[0m REMOVIENDO USUARIO [$USERNAME] "
        sleep 1
        userdel -r $USERNAME
        sleep 3
        echo -e "\e[1;34m[⚙️ CUser]>\e[0m USUARIO [$USERNAME] REMOVIDO EXITOSAMENTE!! "
        sleep 3
        menu
    fi
}


if [ $UID -gt 0 ]; then
    echo -e "\e[31m [ERROR] \e[0m DEBE EJECUTRAR $0 COMO \e[1;32mROOT\e[0m"
else
    start_script
fi


#Script by: INovomiast