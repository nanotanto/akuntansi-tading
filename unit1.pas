unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection;

type

  { TfLogin }

  TfLogin = class(TForm)
    btLogin: TButton;
    edLogin: TEdit;
    Label1: TLabel;
    procedure btLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLogin: TfLogin;

implementation

uses Unit2;

{$R *.lfm}

{ TfLogin }

procedure TfLogin.btLoginClick(Sender: TObject);
begin
  if edLogin.Text = '' then
  begin
  futama.Show;
  flogin.Hide;
  futama.Enabled:=true;
  end
  else
  begin
  Showmessage('Password yang dimasukan salah');
           edlogin.Clear;
           edlogin.SetFocus;
  end;
end;

procedure TfLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  application.Terminate;
end;

procedure TfLogin.FormCreate(Sender: TObject);
begin

end;

end.

