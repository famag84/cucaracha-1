!
! Easy way to remember to  clean the memory
!
!
subroutine allocating(m)
#   include "control_run.h"
    use globales, only: dimR, long, cuantas
    use csys
    use pore
    implicit none
    integer, intent(in) :: m
    integer :: var1=0

    select case ( m ) 
        case ( 0 ) ! Deallocating 
            ! Declared in module csys
#           if CHAIN != 0
            deallocate( avpol, &
                        fdis, &
# if POL == 1 /* PMEP */ 
                        fdis2, &
# endif
# ifdef PAHCL /* used with PAH */ 
                        fdis2, &
# endif
                        pR, in1, Xu,pro,stat=var1 )
#           endif                              
                
            if ( var1 /= 0 ) print*, "There was an error in  memory deallocation. See last lines in main program. "
            var1=0
            !deallocate( x1, stat=var1)
            deallocate( x1, xflag, stat=var1)
            if ( var1 /= 0 ) print*, "There was an error in  memory deallocation. See last lines in main program. "
            deallocate(pHs, vsigma, vcsalt, vcpol, xh,    &  
                     xpot,  &
                     qtot,  &
                     psi, &
                     xpos,  &
!                     xpos2, &
                     xneg,  &
                     xHplus,&
                     xOHmin,&
                     eps,&
# ifdef VDW
                     xtotal,&
#endif /* VDW */
                     pp, &
                     stat=var1)
            if ( var1 /= 0 ) print*, "allocating.f90: There is an erro while deallocating memory for variables: xh - fdis" 
        case ( 1 ) ! Allocating
            !allocate( x1(2*dimR), stat=var1)
            allocate( x1(2*dimR), xflag(2*dimR) , stat=var1)
            if ( var1 /= 0 ) print*, "There is no sufficient memory for variables: x1, xflag" 
            var1=0
#           if CHAIN != 0
            allocate( avpol(dimR), &
                      fdis(dimR), & 
# if POL == 1 /* PMEP */ 
                      fdis2(dimR),&
# endif
# ifdef PAHCL /* used with PAH */ 
                      fdis2(dimR),&
# endif
                      pR(cuantas,long), in1(cuantas,long,3),&
                      Xu(dimR,dimR),pro(cuantas), weight(cuantas) )
#           endif
            if ( var1 /= 0 ) print*, "There is no sufficient memory for variables: x1, xflag" 
            var1=0
            allocate(xh(dimR),    &  
                     xpot(dimR),  &
                     qtot(dimR),  &
                     eps(dimR),  &
                     psi(0:dimR+1), &
                     xpos(dimR),  &
!                     xpos2(dimR), &
                     xneg(dimR),  &
                     xHplus(dimR),&
                     xOHmin(dimR),&
# ifdef VDW
                     xtotal(dimR),&
#endif /* VDW */
                     pp(2*dimR), &
                     stat=var1)
            if ( var1 /= 0 ) print*, "allocating.f90: There is no sufficient memory for variables: xh - fdis" 

    end select
! End allocating

end subroutine allocating
