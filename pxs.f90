!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!

subroutine pxs
#   include "control_run.h"
!  Esta subrutina se encarga de chequear que  todos los segmentos esten dentro del slab
    use globales
    use csys
    implicit none

    REAL(KIND=8) :: vect
    INTEGER :: i,j
    print* , "long, cuantas: ", long, cuantas
    do j=1,long ! 1 = y, 2 = x, 3 = z... z no se usa...)
        do i=1,cuantas
            vect = sqrt((in1(i,j,1))**2 + in1(i,j,2)**2) ! distancia del centro al segmento
! ATENTO: el segundo parametro de int(expression, KIND) fija la cantidad de memoria asignada para el entero
! KIND=1 => 1 byte! = 2^8 = 256 enteros
!            pR(i,j)=int(vect/delta,1)+1 ! pR tiene la celda donde cae el segmento j de la conf. i
            pR(i,j)=int(vect/delta)+1 ! pR tiene la celda donde cae el segmento j de la conf. i
            if(pR(i, j).gt.dimR) then
                Print*,'ERROR grave en pxs!!!!', pR(i, j)
                stop
            endif         
                  
        enddo
!         print*, j, pR(10, j)
    enddo
end subroutine pxs
