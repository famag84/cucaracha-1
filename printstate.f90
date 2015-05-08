!
!
!

subroutine printstate(marca)
#   include "control_run.h"
!subroutine printstate
    use globales
    use pore
    use csys
    use FreeEnergy
    implicit none
    character(len=*), intent(in) :: marca
    character(len=14) :: filename="printstate.txt"
    character(len=20) :: imprimo
    ps_i=ps_i+1
     
    open(unit=1984,file=filename,position='append')

    write(imprimo,'(A9,I2,A1)'), "(I5,A25,A",len(marca),")" ! Formato para imprimir lugar del llamado
    write(1984,imprimo), ps_i, " Estado del programa en: ", marca  
    write(1984,'(A10,I3.3, F7.2, A10, F7.2)'), "ipH, pH : ", ipH, pHs(ipH), " pOHbulk :", pOHbulk

    write(1984,'(A20,I4,I4,I7)'), "long, dimR, cuantas:", long, dimR, cuantas ! numero de layers del radio del poro  (tiene que ser par?)
       write(1984,'(A20,G10.5)'), "radio              :", radio
    write(1984,*), "sigma      :", sigma, "sigmaq  :", sigmaq
    write(1984,*), "eps1       :", eps1  , "longporo:", longporo
     
    ! This are all arrays variables:
    write(imprimo,'(A5,I4,A7)'), "(A20,",dimR+2,"G12.4)" ! imprime el formato :D
    write(1984,*), "*** Variables vectoriales ***"
    write(1984,imprimo), "psi                :", psi ! psi se define asi para evitar problemas al construir las fs

    write(imprimo,'(A5,I4,A7)'), "(A20,",2*dimR,"G12.4)"
    write(1984,imprimo), "x1                 :", x1     ! fraccion de volumen solvente

    write(imprimo,'(A5,I4,A7)'), "(A20,",dimR,"G12.4)"
    write(1984,imprimo), "xh                 :", xh     ! fraccion de volumen solvente
!    write(1984,imprimo), "xpot               :", xpot!, xpot_neg(dimR), xpot_pos(dimR)
    write(1984,imprimo), "qtot               :", qtot ! Carga total
    write(1984,imprimo), "xpos               :", xpos ! pos ion
!    write(1984,imprimo), "xpos2              :", xpos2 ! pos ion
    write(1984,imprimo), "xneg               :", xneg ! neg ioni
    write(1984,imprimo), "xHplus             :", xHplus ! H+
    write(1984,imprimo), "xOHmin             :", xOHmin ! OH-
    write(1984,imprimo), "xtotal             :", xtotal ! xtotal para poor solvent
#if CHAIN==1
    write(1984,imprimo), "avpol              :", avpol  ! fraccion de volumen del polimero 
    write(1984,imprimo), "fdis               :", fdis
    write(1984,imprimo), "fdis2              :", fdis2
#endif
    !Energias!
    write(1984,*), "*** ENERGIAS ***" 
    write(1984,*), "fmixs        :", F_Mix_s 
    write(1984,*), "fmixpos      :", F_Mix_pos 
    write(1984,*), "fmixneg      :", F_Mix_neg   
    write(1984,*), "fmixHplus    :", F_Mix_Hplus 
    write(1984,*), "fmixOHmin    :", F_Mix_OHmin 
    write(1984,*), "fconf_pol    :", F_Conf      
    write(1984,*), "fchem_eq     :", F_Eq        
    write(1984,*), "fchem_eq_wall:", F_Eq_wall       
#ifdef VDW
    write(1984,*), "fvdW         :", F_vdW       
#endif
    write(1984,*), "f_electro    :", F_electro   
    write(1984,*), "fpol_sup     :", F_eps  
    write(1984,*), "Free_Energy   :", Free_Energy
    write(1984,*), "Free_Energy2  :", Free_Energy2
    ! This are singlevalue variables    
    write(1984,*), "*** Variables escalares ***"
    write(1984,*), "*** Eq. Quimico ***"
    write(1984,'(A10,F7.3)'), "fdiswall  :", fdiswall
    write(1984,'(A10,F7.3)'), "zwall     :", zwall ! No olvidar que el character '.' usa un espacio de la noteacion.
    write(1984,'(3(A10,F7.3))'), "kwall    :", kwall," pKawall :", pKawall, " Kwall0  :", Kwall0
    write(1984,'(3(A10,F7.3))'), "Ka       :", Ka," pKa     :", pKa, " Ka0     :", Ka0
    write(1984,'(3(A10,F7.3))'), "Kb       :", Kb," pKb     :", pKb, " Kb0     :", Kb0
! BULK
    write(1984,*), "*** BULK ***" 
    write(1984,*), "csalt      :", csalt, "xsalt   :", xsalt
    write(1984,*), "csalt2     :", csalt2, "xsalt2   :", xsalt2
    write(1984,*), "cHplus     :", cHplus
    write(1984,*), "cOHmin     :", cOHmin
    write(1984,*), " xsolbulk   :", xsolbulk 
    write(1984,*), " xposbulk   :", xposbulk
    write(1984,*), " xnegbulk   :", xnegbulk
    write(1984,*), " xHplusbulk :", xHplusbulk
    write(1984,*), " xOHminbulk :", xOHminbulk
    write(1984,*), "expmupos   :", expmupos
    write(1984,*), "expmuneg   :", expmuneg
    write(1984,*), "expmuHplus :", expmuHplus
    write(1984,*), "expmuOHmin :", expmuOHmin
    write(1984,*), "movpos     :", movpos, "movneg  :", movneg
    write(1984,*), "movHplus   :", movHplus, "movOHmin   :", movOHmin
! Variables del programa
    write(1984,*), "*** Variables del programa ***" 
    write(1984,*), "st         :", st
    write(1984,*), "infile     :", infile
!    write(1984,'(A29)'), "Variables in module globales:" 
      write(1984,'(A10,F7.3)'), "error    :", error 
      write(1984,'(A10,F7.3)'), "betae    :", betae 
      write(1984,'(A10,F7.3)'), "errel    :", errel
      write(1984,'(A10,I4)'), "neq      :", neq
    write(1984,'(A29)'), "*** Parametros físicos ***" 
               write(1984,*), "Na                 :", Na
               write(1984,*), "pi                 :", pi
    write(1984,'(A20,F7.3)'), "zpos               :", zpos ! No olvidar que el character '.' usa un espacio de la noteacion.
    write(1984,'(A20,F7.3)'), "lb (Bjerrum length):", lb
    write(1984,'(A20,F7.3)'), "delta              :", delta
    write(1984,'(A20,F7.3)'), "lseg               :", lseg
    write(1984,'(A20,F7.3)'), "vsol               :", vsol
    write(1984,'(A20,F7.3)'), "vpol               :", vpol
    write(1984,'(A20,F7.3)'), "vHplus             :", vHplus
    write(1984,'(A20,F7.3)'), "vsalt              :", vsalt
    write(1984,'(A20,F7.3)'), "vsalt2             :", vsalt2 
    write(1984,'(A20,F7.3)'), "pKw                :", pKw
    write(1984,*), "constq     :", constq 
    write(1984,*), " "
    close(1984)

    return
end subroutine printstate
