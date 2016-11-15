unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqlite3conn, sqldblib, IBConnection, FileUtil, Forms,
  Controls, Graphics, Dialogs, ZConnection, ZDataset, LCLType, DBGrids, Menus,
  Buttons, ExtCtrls, StdCtrls, DbCtrls;

type

  { TfUtama }

  TfUtama = class(TForm)
    btBarang: TBitBtn;
    btBeli: TBitBtn;
    btJual: TBitBtn;
    btUtang: TBitBtn;
    btJurnal: TBitBtn;
    btJurnal1: TBitBtn;
    btNeraca: TBitBtn;
    btLaba: TBitBtn;
    bgPersediaan: TGroupBox;
    btTambah: TButton;
    btSimpan: TButton;
    btBatal: TButton;
    btTambahJenis: TButton;
    btSimpanJenis: TButton;
    btBatalJenis: TButton;
    cbNo_Subakun: TDBLookupComboBox;
    DataPersediaan: TDataSource;
    DataMaterial: TDataSource;
    DataSource2: TDataSource;
    DBEdit8: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    cbBarang: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    edBarang: TEdit;
    edHargaJenis: TEdit;
    edJenis: TEdit;
    edPokok: TEdit;
    edKategori: TDBEdit;
    edKelompok: TDBEdit;
    ednama: TEdit;
    edNama_akun: TDBEdit;
    edNo_Akun: TDBEdit;
    edStok: TEdit;
    edSatuan: TEdit;
    edHarga: TEdit;
    edJumlah: TEdit;
    gbBarang: TGroupBox;
    gbMaterial: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    data_user: TMenuItem;
    akun: TMenuItem;
    bank: TMenuItem;
    Panel1: TPanel;
    ZConnection1: TZConnection;
    ZQPersediaan: TZQuery;
    ZQMaterial: TZQuery;
    ZQuery2: TZQuery;
    procedure akunClick(Sender: TObject);
    procedure bankClick(Sender: TObject);
    procedure btBarangClick(Sender: TObject);
    procedure btBatalClick(Sender: TObject);
    procedure btBatalJenisClick(Sender: TObject);
    procedure btBeliClick(Sender: TObject);
    procedure btJualClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure btSimpanJenisClick(Sender: TObject);
    procedure btTambahClick(Sender: TObject);
    procedure btTambahJenisClick(Sender: TObject);
    procedure cbBarangChange(Sender: TObject);
    procedure data_userClick(Sender: TObject);
    procedure edHargaChange(Sender: TObject);
    procedure edJumlahChange(Sender: TObject);
    procedure edPokokChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fUtama: TfUtama;


implementation

uses Unit1, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8;

{$R *.lfm}

{ TfUtama }

procedure TfUtama.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  application.Terminate;
end;

procedure TfUtama.FormCreate(Sender: TObject);
begin

end;

procedure TfUtama.FormActivate(Sender: TObject);
begin


end;

procedure TfUtama.data_userClick(Sender: TObject);
begin
   fuser.Show;
end;

procedure TfUtama.edHargaChange(Sender: TObject);
var
  stok : real;
  harga : real;
  jumlah:real;
begin
  stok:=strtofloat(edstok.text);
  harga:=strtofloat(edharga.text);
  jumlah:=stok*harga;
  edJumlah.Text:=floattostr(jumlah);
end;

procedure TfUtama.edJumlahChange(Sender: TObject);
var
  stok : real;
  pokok : real;
  jumlah:real;
begin
  stok:=strtofloat(edstok.text);
  if edjumlah.Text='0' then
  begin
    edpokok.Text:='0';
  end
  else
  begin
  jumlah:=strtofloat(edjumlah.text);
  pokok:=jumlah/stok;
  edpokok.Text:=floattostr(pokok);
  end;
end;

procedure TfUtama.edPokokChange(Sender: TObject);
begin
end;

procedure TfUtama.akunClick(Sender: TObject);
begin
   fakun.Show;
end;

procedure TfUtama.bankClick(Sender: TObject);
begin
  fbank.Show;
end;

procedure TfUtama.btBarangClick(Sender: TObject);
begin
  bgPersediaan.Visible:=true;
end;

procedure TfUtama.btBatalClick(Sender: TObject);
begin
   fakun.zQuery1.Cancel;
  ZQPersediaan.Cancel;
   edNama.Text:='';
  edStok.Text:='0';
  edharga.Text:='0';
  edjumlah.Text:='0';
  edpokok.Text:='0';
  btsimpan.Enabled:=false;
  bttambah.Enabled:=true;
end;

procedure TfUtama.btBatalJenisClick(Sender: TObject);
begin
  edBarang.Text:='';
  edJenis.Text:='';
  edhargajenis.Text:='';
  cbbarang.SetFocus;
  btsimpanjenis.Enabled:=true;
end;

procedure TfUtama.btBeliClick(Sender: TObject);
begin
  fbeli.ZQjurnal.Append;
  fbeli.ZQpembelian.Append;
  fbeli.ZQutang.Append;
  fBeli.Show;
  zqpersediaan.Close;
  zqpersediaan.SQL.Clear;
  zqpersediaan.SQL.Add('select * from persediaan');
  zqpersediaan.Open;
end;

procedure TfUtama.btJualClick(Sender: TObject);
begin
  fjual.Show;
end;

procedure TfUtama.btSimpanClick(Sender: TObject);
var
  no_subakun1: real;
  akun1 : real;
  x1 :integer;
begin
  akun1:=strtofloat(cbno_subakun.text);
  x1:=1;
  no_subakun1:=akun1+1;
  ZQPersediaan['no_subakun']:=no_subakun1;
  ZQPersediaan['nama']:=edNama.Text;
  ZQPersediaan['satuan']:=edsatuan.Text;
  ZQPersediaan['stok']:=edstok.Text;
  ZQPersediaan['harga']:=edharga.Text;
  ZQPersediaan['jumlah']:=edjumlah.Text;
  ZQPersediaan['harga_pokok']:=edpokok.Text;

  fakun.zQuery1['no_akun']:=zQuery2['no_akun'];
  fakun.zquery1['no_subakun']:=no_subakun1;
  fakun.zquery1['nama_akun']:='Persediaan '+ednama.Text;
  fakun.zquery1['saldo']:=edjumlah.Text;
  fakun.zquery1['kelompok']:=zquery2['kelompok'];
  fakun.zquery1['kategori']:=zquery2['kategori'];

  ZQPersediaan.ApplyUpdates;
  fakun.zquery1.ApplyUpdates;
  btsimpan.Enabled:=false;
  bttambah.Enabled:=true;
  zQuery2.Active:=false;
end;

procedure TfUtama.btSimpanJenisClick(Sender: TObject);
begin
  ZQMaterial.Append;
  ZQMaterial['id_persediaan']:=edBarang.Text;
  ZQMaterial['nama']:=edjenis.Text;
  ZQMaterial['harga']:=edhargajenis.Text;
  ZQMaterial.ApplyUpdates;
  btSimpanJenis.Enabled:=false;
end;

procedure TfUtama.btTambahClick(Sender: TObject);
begin
  zQuery2.Active:=true;
  fakun.zQuery1.Append;
  ZQPersediaan.Append;
  edNama.Text:='';
  edStok.Text:='0';
  edharga.Text:='0';
  edjumlah.Text:='0';
  edpokok.Text:='0';
  edNama.SetFocus;
  btsimpan.Enabled:=true;
  bttambah.Enabled:=false;
end;

procedure TfUtama.btTambahJenisClick(Sender: TObject);
begin
  edBarang.Text:='';
  edJenis.Text:='';
  edhargajenis.Text:='';
  cbbarang.SetFocus;
  btsimpanjenis.Enabled:=true;
end;

procedure TfUtama.cbBarangChange(Sender: TObject);
begin
  edBarang.Text:=cbBarang.Text;
end;



end.

