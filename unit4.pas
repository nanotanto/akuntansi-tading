unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, DbCtrls, ZDataset;

type

  { TfAkun }

  TfAkun = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    ZQuery1: TZQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fAkun: TfAkun;

implementation

{$R *.lfm}

{ TfAkun }

procedure TfAkun.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TfAkun.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

end.

