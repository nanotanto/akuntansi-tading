program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2, zcomponent, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TfUtama, fUtama);
  Application.CreateForm(TfUser, fUser);
  Application.CreateForm(TfAkun, fAkun);
  Application.CreateForm(TfBank, fBank);
  Application.CreateForm(TfBeli, fBeli);
  Application.CreateForm(TfJual, fJual);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

