program display_fluodata;


{$I typedef.sys}          { System unabhaengige Typendefinitionen     }
{$I graphix.sys}          { System abhaengige Definitionen & Routinen }
{$I kernel.sys}           { System unabhaengige Support Routinen      }


var  fil             : file of byte;
     i,j,k,m         : integer;
     stuff           : byte;
     bb              : array [1..100,1..9] of byte;
     screen1,screens : integer;
     yfluo           : array [1..100] of real;
     yflu            : array [1..2000] of real;
     test            : boolean;
     y_max,gy_max,xx : real;
     antwort,cha     : char;
     temp,anzahl     : real;       { Anzahl der Fluowerte }


{---------------------}
{-----  Anfang  ------}
{---------------------}

procedure intro;
begin
  clrscr;
  screens:=0;
  writeln('FLUO-Messdatenkonvertierung:');
  writeln('----------------------------');
  writeln;
  {
  write('Test (J/N) ? : '); readln(antwort);
  antwort:=upcase(antwort);
  if (antwort='J')
    then test:=TRUE
    else test:=FALSE;
  }
  repeat
    gotoxy(1,6);
    write('Ab welchen Screen : ');
    readln(screen1);
    gotoxy(1,7);
    write('Wieviele Screens : ');
    readln(screens);
  until (screens<>0);
  anzahl:=screens*100;
end;

{------------------------------------------------}
{-----  Messdatei einlesen & konvertieren  ------}
{------------------------------------------------}

procedure init_array;
begin
  for i:=1 to 100 do
  begin
    for j:=1 to 9 do bb[i,j]:=0;
  end;
  for i:=1 to 2000 do yflu[i]:=0;
end;


procedure in_dat;
begin
  assign(fil,'MESS.TMP');
  reset(fil);

  write('Datei wird eingelesen ...');
  temp:=(screen1)*1024+10240;
  for i:=1 to trunc(temp) do read(fil,stuff);
  writeln('Fertig!');

  { n Screens einlesen }
  if test
    then writeln('Datei wird konvertiert...')
    else write('Datei wird konvertiert...');
  for k:=1 to screens do
  begin
    for i:=1 to 100 do
    begin
      for j:=1 to 9 do
      begin
        read(fil,bb[i,j]);
      end;
    read(fil,stuff);
    end;

    { Bis Ende Screen ueberlesen }
    for i:=1 to 24 do read(fil,stuff);

    { Screens konvertieren }
    for i:=1 to 100 do
    begin
      yfluo[i]:= 1e8*ord(bb[i,1]-48)+1e7*ord(bb[i,2]-48)+1e6*ord(bb[i,3]-48)
                +1e5*ord(bb[i,4]-48)+1e4*ord(bb[i,5]-48)+1e3*ord(bb[i,6]-48)
                +100*ord(bb[i,7]-48)+ord(bb[i,8]-48);
      yflu[m]:=yfluo[i];
      { Sortieren nach Max }
      if  yfluo[i] > y_max then y_max:=yfluo[i];
      m:=m+1;
      if test then write(yflu[i]:10:0);
    end;
    if test then writeln('  FLUO-max : ',y_max:10:0);
  end;
  close(fil);
  if test then
    begin
     writeln;
     writeln('FLUO-max : ',y_max:9:0);
     for i:=1 to trunc(anzahl) do  write(yflu[i]:10:0);
    end;
end;

{-------------------------------------------}
{-----   Zeichnet das FLUO-Spektrum   ------}
{-------------------------------------------}

procedure bild;
var  ii : integer;
begin
  gy_max:=1.25*y_max;
  { Akustisches Zeichen fuer Grafikaufbau }
  writeln(#7);
  InitGraphic;
  SelectScreen(1);
  ClearScreen;
  DefineWorld(1,0,0,anzahl,gy_max);
  SelectWorld(1);
  SelectWindow(1);
  SetBackground(0);
  DrawBorder;
  gotoxy(2,2);
  write('FLUO - Spektrum');
  { gotoxy(2,2); write('Counts'); }
  xx:=0;
  ii:=0;
  repeat
    xx:=xx+1;
    ii:=ii+1;
    DrawPoint(xx,yflu[ii]);
    {
    gotoxy(2,23); write('f : ',xx:9:0);
    gotoxy(2,24); write('Z : ',yflu[ii]:9:0);
    }
  until (xx >= anzahl);
end;

procedure schluss;
begin
  {  gotoxy(70,24); write('Freq.[MHz]'); }
  readln(cha);
  LeaveGraphic;
  writeln('Display beendet.');
end;


{===================    H a u p t p r o g r a m m    ==================}

begin
  test:=FALSE;
  m:=1;
  y_max:=0;
  intro;
  init_array;
  in_dat;
  bild;
  schluss;
end.

{====================   P r o g r a m m - E n d e    ==================}
