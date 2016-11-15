unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, DbCtrls, ZDataset;

type

  { TfBank }

  TfBank = class(TForm)
    btTambah: TButton;
    btSimpan: TButton;
    btBatal: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    edNo_Akun: TDBEdit;
    edNama_akun: TDBEdit;
    edKelompok: TDBEdit;
    edKategori: TDBEdit;
    DBEdit8: TDBEdit;
    DBGrid1: TDBGrid;
    cbNo_Subakun: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    edBank: TEdit;
    edSaldo: TEdit;
    gbBank: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure btBatalClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure btTambahClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBank: TfBank;
  no_subakun, akun: real;
  x :integer;

implementation

{$R *.lfm}

{ TfBank }

procedure TfBank.FormCreate(Sender: TObject);
begin

end;

procedure TfBank.btTambahClick(Sender: TObject);
begin
  ZQuery1.Append;
  edBank.Text:='';
  edSaldo.Text:='';
  edBank.SetFocus;
  zQuery2.Active:=true;
end;

procedure TfBank.btSimpanClick(Sender: TObject);
begin
  akun:=strtofloat(cbno_subakun.text);
  x:=1;
  no_subakun:=akun+1;
  zQuery1['no_akun']:=zQuery2['no_akun'];
  zquery1['no_subakun']:=no_subakun;
  zquery1['nama_akun']:=edBank.Text;
  zquery1['saldo']:=edSaldo.Text;
  zquery1['kelompok']:=zquery2['kelompok'];
  zquery1['kategori']:=zquery2['kategori'];
  zquery1.ApplyUpdates;
  edBank.Text:='';
  edSaldo.Text:='';
  zQuery2.Active:=false;

end;

procedure TfBank.btBatalClick(Sender: TObject);
begin
  edBank.Text:='';
  edSaldo.Text:='';
  zquery1.Cancel;
end;

end.

