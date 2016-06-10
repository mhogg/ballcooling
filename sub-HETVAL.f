
      SUBROUTINE HETVAL(CMNAME,TEMP,TIME,DTIME,STATEV,FLUX,PREDEF,DPRED)

      INCLUDE 'ABA_PARAM.INC'

      CHARACTER*80 CMNAME
      DIMENSION TEMP(2),STATEV(*),PREDEF(*),TIME(2),FLUX(2),DPRED(*)

C     DTIME   = Time increment
C     FLUX(1) = Heat flux (J/s.m^3 = W/m^3)
C     FLUX(2) = Rate of change of heat flux with respect to temperature. This
C               should be non-zero if the heat flux depends on temperature.
C     TEMP(1) = Current temperature
C     TEMP(2) = Temperature increment

C     HFL = -2700 J/K for 8.03kg ball (neg, because release heat when DT is neg)
C     HFL = -336.24 J/K.kg
C     HFL = -2.64e+06 J/K.m^3 (using a density of 7850kg/m^3)
C     HFL = -2.640e+06 * (DT/Dt) W/m^3 (where T=temp, t=time)  

C     If the temperature drops during cooling, then latent heat will be released
      if (TEMP(2) < 0) then
          FLUX(1) = -2.640e+06 / DTIME * TEMP(2)
          FLUX(2) = -2.640e+06 / DTIME
      else
          FLUX(1) = 0.0
          FLUX(2) = 0.0
      end if
      
C     Save heat flux for plotting      
      STATEV(1) = FLUX(1)

      return
      end
      