cls
echo
echo PC FLUO-Testprogramm
copy messdat.scr messdatf.scr
comz2 check
copy messdatf.scr mess.tmp
disp
copy mess.tmp %1.scr
echo FLUO-Datensätze
dir zr*.scr
echo FLUO-Lauf beendet
echo
