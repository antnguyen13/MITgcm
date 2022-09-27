17.sep.2022
in mod2:
 - change delta_[x,y] to dL[Normal,tangential] and fix bugs related to that
   in iceplume_calc.F, iceplume_plume_model.F.
 - finished separating ifdef allow_iceplume in external_forcing.F
   (following the separation we did in mod1 inside apply_forcing.F)
