function pong_energy()
    use globales, only: delta, radio, dimR, vsalt, vsol, pi, zwall
    use csys, only: sigmaq, xsolbulk, xHplusbulk, xOHminbulk, xnegbulk, xposbulk
    use pore, only: xh, xHplus, xOHmin, xpos, xneg, psi, qtot, fdiswall
    implicit none

    real(kind=8) :: pong_energy, sumpi, sumrho, sumel!, sum_disos
    integer :: iR

! Energía segun Pong:
! Esta energia se obtiene lugeo de reemplazar las expresiones 
! que se obtienen luego de minimizar la energía libre. 

    sumpi = 0.0 ! sumpi :: osmotic pressure contribution (solvent expression)
    sumrho=0.0  ! sumrho:: density of free ions contribution
    sumel=0.0   ! sumel :: No considered superficial charge distributio

!**********************************************************************************
! El calculo de esta energia es la diferencia entre la energia total del sistema 
! y la energia del bulk. Por eso aparecen las magnitudes en bulk. 
!**********************************************************************************
    do iR=1,dimR
        sumpi = sumpi+dlog(xh(iR))/vsol *delta*(dfloat(iR)-0.5)*delta/Radio     
        sumpi = sumpi-dlog(xsolbulk)/vsol *delta*(dfloat(iR)-0.5)*delta/Radio  
        
       sumrho = sumrho + ( - xh(iR) -xHplus(iR) -xOHmin(iR) &
                            -(xpos(iR)+xneg(iR))/vsalt &
!                            - xpos2(iR)/vsalt2 & ! sum over  rho_i i=+,-,si
                          ) /vsol *delta*(dfloat(iR)-0.5)*delta/Radio
! Bulk sumrho
        sumrho = sumrho - ( - xsolbulk -xHplusbulk -xOHminbulk &
                            -(xposbulk+xnegbulk)/vsalt &
!                            - xposbulk2/vsalt2 & ! sum over  rho_i i=+,-,si
                          ) /vsol *delta*(dfloat(iR)-0.5)*delta/Radio
! electrostatic part free energy
        sumel = sumel - qtot(iR) *psi(iR)/2.0 *delta*(dfloat(iR)-0.5)*delta/Radio  
    enddo


!    print*, "surface charge: ", sigmaq*psi(dimR)/2.0
!    print*, " sumpi ", sumpi, " sumrho ", sumrho, " sumel ", sumel        

    pong_energy = sumpi + sumrho + sumel 

end function pong_energy
