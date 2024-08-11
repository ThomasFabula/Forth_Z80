{--------------------------------- M04 ---------------------------------------}

{-----------------------------------------------------------------------------}
{--- Rabi-Atom-Strahl-Apparatur  HF-Auswertungsprogramm ----------------------}
{-----------------------------------------------------------------------------}
{-----------------------------------------------------------------------------}
{--- Konzepterarbeitung  auf  dem  Apple IIe-Rechner    ----------------------}
{--- in der Programmiersprache PASCAL  unter  CP/M 2.2  ----------------------}
{-----------------------------------------------------------------------------}
{--- Entgueltige  Version  auf  einem j&k-Z80-Rechner   ----------------------}
{--- in der Programmiersprache  FORTH  unter  CP/M 3.0  ----------------------}
{-----------------------------------------------------------------------------}
{------------    Maschinenroutinen in Z80 - Assembler   ----------------------}
{-----------------------------------------------------------------------------}
{--------------------  Version 1.0, August 13, 1985  -------------------------}
{-----------------------------------------------------------------------------}


{-----------------------------------------------------------------------------}
{--- Programmierer: Thomas Fabula , Diplomarbeit -----------------------------}
{--- Institut fuer Angewandte Physik der Uni Bonn ----------------------------}
{-----------------------------------------------------------------------------}



{#############################################################################}

{--------------------------  Variablendeklaration  ---------------------------}


program M04(input,output);

(*$U+*)                          { USER-Break durch Ctrl-C jederzeit moeglich }


  const pi =  3.14159;
        ex =  2.71828 ;


  var   frequ, zahlrate, B_Feld : real;

        x , y , z               : real;
        i , j , k               : integer;

        errorsignal,
        testflag,saved,
        end_of_time             : boolean;

        password                : string[8];
        comment                 : string[80];

        antwort,wahl,dummy      : char;



{-------------------------   Maskengenerierung  ------------------------------}

  procedure STARS;

           begin
            for i:=1 to 80 do write('*');
           end;


 procedure TAGS;

           begin
            for i:=1 to 80 do write('_');
           end;


{-------------------------   Datensicherung  ---------------------------------}

procedure DATA_SAVE;
          begin
           writeln;
           STARS;
           writeln('An dieser Stelle werden spaeter die M04-Daten & Parameter abgespeichert.');
           STARS;
           writeln;
           writeln;
          end;

{-------------------------   Exit M04  ---------------------------------------}

procedure ENDE;

          begin
           writeln;
           writeln;
           writeln('Programm unterbrochen: M04-Parameter und M04-Daten gesichert?');
           write('*** Achtung: Sollen die Messwerte abgespeichert werden (J/N) :');
             readln(antwort);
             if Antwort in ['J','j'] then DATA_SAVE;
              writeln;
              writeln('O.K. - Programm wird entgueltig beendet.');
              writeln;
              for i:=1 to 79 do write('*');
              read;
              clrscr;
             gotoxy(25,12);
             writeln('**********************');
             gotoxy(25,13);
             writeln('***                ***');
             gotoxy(25,14);
             writeln('***   M04 - Ende   ***');
             gotoxy(25,15);
             writeln('***                ***');
             gotoxy(25,16);
             writeln('**********************');
             for i:=1 to 8 do writeln;
             readln;
             clrscr;
          end;


{--------------------------  Passwordabfrage  --------------------------------}

procedure START_M04;

 begin
   clrscr;
    STARS;
    writeln;
    gotoXY(10,3);
    writeln('                PROGRAMM  :  M 0 4 ');
    writeln;
    writeln('           Rabi-Atomstrahl-HF-Spektroskopie');
    writeln;
    STARS;
    write('*** Input Password *** > ');
     for i:=1 to 2 do
      repeat
       read(KBD,password);
       gotoXY(26,8);
       clrEol;
       { until password IN [ 'rabi','RABI' ];   }
      until  password in ['R','r'];                       { Password Schutz }

 end;


{--------------------------  Datei-Lister  -----------------------------------}
{-----------------------------------------------------------------------------}

 procedure SHOW_FILE;

   label    SMURF;

   var  select : integer;
        channel: (PTR,CRT);        { Ausgabekanal }
        FilVar : Text;             { Dateityp }
        Line   : string[80];       { Zeilenziffer }
        FilName: string[15];       { Dateiname }

 begin
  Write('*** Filename ?    <Return> aborts   : ');
  Readln(FilName);
  If FilName <> '' Then
   Begin
    (*$I-*)                      { Compileroption: I/O-Fehler bricht nicht ab }
    Assign(FilVar,FilName);
    Reset(FilVar);
    (*$I+*)                      { Compileroption zuruecksetzen }
    If IOResult = 1 Then
      Begin
       writeln;
       Writeln('*** ERROR:   File ',FilName,' nicht auf Disk !');
       writeln;
       STARS;
       goto SMURF;
      end;
      Begin
       Write('*** Auswahl:   1 = Printer  ,  2 = Bildschirm    : ');
       Readln(Select);
       TAGS;
       If Not Select  in [1,2] Then Select:=1;
       While Not Eof(FilVar) do
        Begin
         Readln(FilVar,Line);
         Case Select of
          1: Writeln(Lst,Line);
          2: Writeln(Line);
         End;
        End;
       End;
      End;
     TAGS;
SMURF: write('Fertig ? ');
    readln(KBD,dummy);
   end;


{--------------------------  Erlaeuterungen  ---------------------------------}

procedure TEXT_M04;

    begin
      writeln;
      STARS;
      writeln;

writeln('Mit Hilfe dieses Programms ist man in der Lage Praezisionsmessungen');
writeln('im HF-Bereich mit der RABI-ATOMSTRAHL-APPARATUR (RABI) durchzufuehren');
writeln('Um eine gegebene Linie exakt auszumessen sind vorher die noetigen');
writeln('Parameter wie z.B. ResonanzFrequ, MessDauer , L , D etc. einzugeben.');
writeln;
writeln('Das Programm gliedert sich in mehrere Teile, ueber deren Funktionen');
writeln('man sich mit Hilfe der <HELP> - Option naehere Informationen "on-line"');
writeln('zukommen lassen kann.');
writeln('Fuer tiefergehende Informationen sei auf das DOCUMENT.M04 - File verwiesen.');
writeln('Dieses File wird mit dem Editor von TURBO-Pascal bzw. mit WORDSTAR geladen');
writeln('und nach Belieben ediert.');
writeln;
  STARS;
  readln;
 end;

{--------------------------  Hauptmenu  --------------------------------------}

procedure MENU_M04;
        begin
         clrscr;
         STARS;
         writeln;
         writeln('                   M 0 4   -   H a u p t - M  E  N  U   :  ');
         writeln('                   --------------------------------------  ');
         writeln;
         STARS;
         writeln;
 writeln('Bitte waehlen Sie die Programm-Option durch Eingabe des <A>nfangsbuchstabens:');
     writeln;
     writeln('              <I>NPUT   ---   Eingabe der Parameter');
     writeln;
     writeln('              <C>OUNT   ---   Messdatenerfassung');
     writeln;
     writeln('              <S>AVE    ---   Messdatensicherung auf Disk');
     writeln;
     writeln('              <O>UTPUT  ---   Messdaten-Darstellung & Ausgabe');
     writeln;
     writeln('              <H>ELP    ---   Unterstuetzung des Benutzers');
     writeln;
     writeln('              <D>OCUM   ---   Programm-Anleitungen');
     writeln;
     writeln('              <Q>UIT    ---   Beenden des Programms');
       writeln;
         for i:=1 to 72 do write('*');
         write(' Wahl:');
         read(KBD,wahl);
        end;


{--------------------------  Parameter-Eingabe  -----------------------------}

 procedure INPUT_M04;

           begin
            if wahl = 'I' then
             Begin
              clrscr;
              writeln;
              write('INPUT-Modul..................>');
              readln(KBD,dummy);
             End;
           End;


{--------------------------  Messwerterfassung  -----------------------------}

 procedure COUNT_M04;

             begin
              if wahl = 'C' then
               Begin
                clrscr;
                writeln;
                write('COUNT-Modul....................>');
                readln;
               End;
             End;



{--------------------------Sicherung der Daten  ----------------------------}

 procedure SAVE_M04;

           begin
            if wahl = 'S' then
             Begin
              clrscr;
              writeln;
              write('SAVE-Modul.....................>');
              readln;
             end;
           End;


{--------------------------  Ausgabe der Messwerte  -------------------------}

 procedure OUTPUT_M04;

         begin
          if wahl = 'O' then
           Begin
            clrscr;
            writeln;
            write('OUTPUT-Modul.....................>');
            readln;
           End;
          End;


{-------------------------  On Line Hilfe  ----------------------------------}

  procedure  HILFE_M04;


            begin
             if  wahl = 'H' then
              Begin
               clrscr;
               writeln;
               write('HELP-Modul....................>');
               readln;
              End;
             End;


{--------------------------  Dokumentation  ---------------------------------}

   procedure  DOCUMENT_M04;

             begin
              if wahl = 'D' then
               Begin
                clrscr;
                writeln;
                writeln('DOCUMENT-Modul..................>');
                writeln;
                STARS;
                writeln;
               End;

   writeln('     Dieses Modul ermoeglicht es einem detaillierte Informationen ueber das');
   writeln('     M04-Programm zu erhalten. Die einzelnen Prozeduren werden ausfuehrlich');
   writeln('     erklaert und das Programm-Handling erlaeutert.');
   writeln;
    STARS;
    write('*** Sollen DOCUMENT-Files geladen werden (J/N):');
    read(antwort);
    write('            *** Ctrl-S = Stop ***');
    if antwort in ['J','j'] then SHOW_FILE;
    { DOCUMENT.M04  wird geladen & angezeigt }
   End;


{--------------------------  Exit M04  ---------------------------------------}

  procedure  QUIT_M04;

               begin
                if  wahl <> 'Q' then
                 Begin
                  clrscr;
                  writeln;
                  writeln('QUIT-Modul.....................>');
                  readln;
                 End;
               End;


{----------------------------------------------------------------------------}
{--------------------   H A U P T P R O G R A M M  --------------------------}
{----------------------------------------------------------------------------}

     begin
      START_M04;
      TEXT_M04;
       Repeat
        MENU_M04;
        Wahl:=UpCase(Wahl);
        Case Wahl of
         'I': INPUT_M04;
         'C': COUNT_M04;
         'S': SAVE_M04;
         'O': OUTPUT_M04;
         'H': HILFE_M04;
         'D': DOCUMENT_M04;
         'Q': QUIT_M04;
        End;
       Until Wahl in ['Q'];
      ENDE;
     end.

{-----------------------------------------------------------------------------}
{----------------------------------  E N D E  --------------------------------}
{-----------------------------------------------------------------------------}

