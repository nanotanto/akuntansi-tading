unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DbCtrls, DBGrids, ZDataset;

type

  { TfUser }

  TfUser = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ednpwp: TDBEdit;
    edKelompok: TDBEdit;
    DBNavigator1: TDBNavigator;
    edNama: TDBEdit;
    edPerson: TDBEdit;
    edJabatan: TDBEdit;
    edTelp: TDBEdit;
    edHp: TDBEdit;
    edEmail: TDBEdit;
    edAlamat: TDBEdit;
    DBGrid1: TDBGrid;
    cbKelompok: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ZQuery1: TZQuery;
    ZTable1: TZTable;
    procedure cbKelompokChange(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure DBNavigator1StartDrag(Sender: TObject; var DragObject: TDragObject
      );
    procedure edNamaChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fUser: TfUser;

implementation

{$R *.lfm}

{ TfUser }

procedure TfUser.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
begin

end;

procedure TfUser.cbKelompokChange(Sender: TObject);
begin
  edKelompok.Text:=cbKelompok.Text;
end;

procedure TfUser.DBNavigator1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin

end;

procedure TfUser.edNamaChange(Sender: TObject);
begin

end;

end.

