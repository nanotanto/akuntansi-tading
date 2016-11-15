unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, DbCtrls, DBGrids, ZDataset;

type

  { TfJual }

  TfJual = class(TForm)
    btBatal: TButton;
    btEdit: TButton;
    btSimpan: TButton;
    btTambah: TButton;
    cbBarang: TDBLookupComboBox;
    cbMitra: TDBLookupComboBox;
    cbPPn: TCheckBox;
    DataJurnal: TDataSource;
    DataPenjualan: TDataSource;
    DataPersediaan: TDataSource;
    DataMaterial: TDataSource;
    DataUser: TDataSource;
    DataUtang: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    cbMaterial: TDBLookupComboBox;
    DBNavigator1: TDBNavigator;
    edAngkut: TEdit;
    edBarang: TEdit;
    edbayar: TEdit;
    edDiskon: TEdit;
    edHarga: TEdit;
    edId: TDBEdit;
    edidJurnal: TDBEdit;
    edMaterial: TEdit;
    edJumlah: TEdit;
    edLain: TEdit;
    edMitra: TEdit;
    edNo: TEdit;
    edPPn: TEdit;
    edQty: TEdit;
    edTgl: TDateEdit;
    edTglKredit: TDateEdit;
    edTotal: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    rbKredit: TRadioButton;
    rbTunai: TRadioButton;
    ZQJurnal: TZQuery;
    zqutang: TZQuery;
    ZQPenjualan: TZQuery;
    ZQPersediaan: TZQuery;
    ZQMaterial: TZQuery;
    zqpembelian: TZQuery;
    ZQUser: TZQuery;
    ZQPiutang: TZQuery;
    procedure btEditClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure btTambahClick(Sender: TObject);
    procedure cbBarangChange(Sender: TObject);
    procedure cbMaterialChange(Sender: TObject);
    procedure cbMitraChange(Sender: TObject);
    procedure cbPPnChange(Sender: TObject);
    procedure edAngkutChange(Sender: TObject);
    procedure edDiskonChange(Sender: TObject);
    procedure edHargaChange(Sender: TObject);
    procedure edJumlahChange(Sender: TObject);
    procedure edLainChange(Sender: TObject);
    procedure edMaterialChange(Sender: TObject);
    procedure edPPnChange(Sender: TObject);
    procedure edQtyChange(Sender: TObject);
    procedure edTotalChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbKreditChange(Sender: TObject);
    procedure rbTunaiChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fJual: TfJual;
   qty, harga, jumlah, diskon, jmldiskon, angkut, lain, total, ppn: real;
   awal, beli, akhir, stokawal, stokakhir, hpp :real;

implementation

{$R *.lfm}

{ TfJual }

procedure TfJual.cbBarangChange(Sender: TObject);
begin

end;

procedure TfJual.btSimpanClick(Sender: TObject);
begin
  ZQMaterial.Close;
  ZQMaterial.SQL.Clear;
  ZQMaterial.SQL.Add('select * from material where nama like "%'+edmaterial.Text+'%"');
  ZQMaterial.Open;
  edbarang.Text:=ZQMaterial['id_persediaan'];


  zqpersediaan.Close;
  zqpersediaan.SQL.Clear;
  zqpersediaan.SQL.Add('select * from persediaan where nama like "%'+edbarang.Text+'%"');
  zqpersediaan.Open;
  ZQjurnal['tgl']:=edtgl.Text;
  ZQjurnal['no_transaksi']:=edno.Text;
  ZQjurnal['no_subakun']:=ZQpersediaan['no_subakun'];
  ZQjurnal['debet_kredit']:='Debet';
  ZQjurnal['jumlah']:=edtotal.Text;
  ZQJurnal['uraian']:='Beli '+edbarang.Text +' dari ' +edmitra.Text;
  ZQjurnal['saldo_awal']:=ZQpersediaan['jumlah'];
  awal:=strtofloat(ZQpersediaan['jumlah']);
  beli:=strtofloat(edtotal.Text);
  akhir:=awal+beli;
  ZQjurnal['saldo_akhir']:=floattostr(akhir);
  ZQjurnal['id_user']:=edmitra.Text;
  ZQjurnal.ApplyUpdates;

  zqpembelian['id_jurnal']:=zqjurnal['id'];
  zqpembelian['no_transaksi']:=edno.Text;
  zqpembelian['id_persediaan']:=edbarang.Text;
  zqpembelian['no_subakun']:=zqpersediaan['no_subakun'];
  zqpembelian['tgl']:=edtgl.Text;
  zqpembelian['stok_awal']:=zqpersediaan['stok'];
  zqpembelian['jmlstok_awal']:=zqpersediaan['jumlah'];
  zqpembelian['id_user']:=edmitra.Text;
  zqpembelian['harga']:=edharga.Text;
  zqpembelian['qty']:=edqty.Text;
  zqpembelian['jumlah']:=edjumlah.Text;
  zqpembelian['diskon']:=eddiskon.Text;
  zqpembelian['total']:=edtotal.Text;
  zqpembelian['biaya_kirim']:=edangkut.Text;
  zqpembelian['biaya_lain']:=edlain.Text;
  stokawal:=strtofloat(zqpersediaan['stok']);
  qty:=strtofloat(edqty.Text);
  stokakhir:=stokawal+qty;
  zqpembelian['stok_akhir']:=floattostr(stokakhir);
  zqpembelian['jmlstok_akhir']:=floattostr(akhir);
  zqpembelian['PPn']:=edppn.Text;
  zqpembelian['bayar']:=edbayar.text;

  zqpersediaan.Edit;
  zqpersediaan['stok']:=floattostr(stokakhir);
  zqpersediaan['harga']:=edharga.Text;
  zqpersediaan['jumlah']:=floattostr(akhir);
  hpp:=akhir/stokakhir;
  zqpersediaan['harga_pokok']:=floattostr(hpp);
  zqpembelian.ApplyUpdates;
  zqpersediaan.ApplyUpdates;

  if rbkredit.Checked then
  begin
  zqutang['id_beli']:=zqpembelian['id'];
  zqutang['tgl']:=edtgl.Text;
  zqutang['no_transaksi']:=edno.Text;
  zqutang['no_subakun']:=zqpersediaan['no_subakun'];
  zqutang['id_persediaan']:=edbarang.Text;
  zqutang['id_user']:=edmitra.Text;
  jumlah:=strtofloat(edjumlah.Text);
  diskon:=strtofloat(eddiskon.Text);
  jmldiskon:=jumlah-diskon;
  zqutang['saldo_awal']:=jmldiskon;
  zqutang['due_date']:=edtglkredit.Text;
  zqutang.ApplyUpdates;

  ZQjurnal.Append;
  ZQjurnal['tgl']:=edtgl.Text;
  ZQjurnal['no_transaksi']:=edno.Text;
  ZQjurnal['no_subakun']:='21010';
  ZQjurnal['debet_kredit']:='kredit';
  ZQjurnal['jumlah']:=edtotal.Text;
  ZQJurnal['uraian']:='Beli Kredit '+edbarang.Text +' dari ' +edmitra.Text;
  ZQjurnal['saldo_awal']:=ZQpersediaan['jumlah'];
  awal:=strtofloat(ZQpersediaan['jumlah']);
  beli:=strtofloat(edtotal.Text);
  akhir:=awal+beli;
  ZQjurnal['saldo_akhir']:=floattostr(akhir);
  ZQjurnal['id_user']:=edmitra.Text;
  ZQjurnal.ApplyUpdates;
  end;


  bttambah.Enabled:=true;
  btsimpan.Enabled:=false;
end;

procedure TfJual.btTambahClick(Sender: TObject);
begin
    ZQjurnal.Append;
  ZQpenjualan.Append;
  ZQpiutang.Append;
  edno.Text:='';
  edtgl.Text:='';
  edmitra.Text:='';
  edbarang.Text:='';
  edMaterial.Text:='';
  edqty.Text:='0';
  edharga.Text:='0';
  edjumlah.Text:='0';
  rbtunai.Checked:=false;
  rbkredit.Checked:=false;
  label13.Visible:=false;
  edtglkredit.Visible:=false;
  eddiskon.Text:='0';
  edangkut.Text:='0';
  edlain.Text:='0';
  edtotal.Text:='';
  edppn.Text:='';
  cbppn.Checked:=false;
  edno.SetFocus;
  bttambah.Enabled:=false;
  btsimpan.Enabled:=true;
  zqpersediaan.Close;
  zqpersediaan.SQL.Clear;
  zqpersediaan.SQL.Add('select * from persediaan');
  zqpersediaan.Open;
end;

procedure TfJual.btEditClick(Sender: TObject);
begin
  btsimpan.Enabled:=true;

 edno.Text:= ZQPenjualan['no_transaksi'];
 edbarang.Text:= ZQPenjualan['id_persediaan'];
 edMaterial.Text:=ZQPenjualan['material'];
 edtgl.Text:= ZQPenjualan['tgl'];
 edmitra.Text:= ZQPenjualan['id_user'];
 edharga.Text:= ZQPenjualan['harga'];
 edqty.Text:= ZQPenjualan['qty'];
 edjumlah.Text:= ZQPenjualan['jumlah'];
 eddiskon.Text:= ZQPenjualan['diskon'];
 edtotal.Text:= ZQPenjualan['total'];
 edangkut.Text:= ZQPenjualan['biaya_kirim'];
 edlain.Text:=  ZQPenjualan['biaya_lain'];
 ZQPenjualan.Edit;

 zqjurnal.Close;
  zqjurnal.SQL.Clear;
  zqjurnal.SQL.Add('select * from jurnal where id like "%'+edidJurnal.Text+'%"');
  zqjurnal.Open;
  zqjurnal.Edit;

  zqpiutang.Close;
  zqpiutang.SQL.Clear;
  zqpiutang.SQL.Add('select * from piutang where id_beli like "%'+edid.Text+'%"');
  zqpiutang.Open;
  zqpiutang.Edit;


  zqpiutang.Edit;
  zqpersediaan.Edit;
end;

procedure TfJual.cbMaterialChange(Sender: TObject);
begin
  edMaterial.Text:=cbMaterial.Text;

end;

procedure TfJual.cbMitraChange(Sender: TObject);
begin
  edMitra.Text:=cbMitra.Text;
end;

procedure TfJual.cbPPnChange(Sender: TObject);
begin
    if cbPPn.Checked then
  begin
    jumlah:=strtofloat(edjumlah.Text);
    diskon:=strtofloat(eddiskon.Text);
    jmldiskon:=jumlah-diskon;
    ppn:=jmldiskon*(1/10);
    edPPn.Text:=floattostr(ppn);
  end
  else
  begin
    edPPn.Text:='';
  end;
end;

procedure TfJual.edAngkutChange(Sender: TObject);
begin
  if edangkut.Text='' then
  begin
    edangkut.Text:='0';
  end;
    jumlah:=strtofloat(edjumlah.Text);
    diskon:=strtofloat(eddiskon.Text);
    jmldiskon:=jumlah-diskon;
    angkut:=strtofloat(edangkut.Text);
    lain:=strtofloat(edlain.Text);
    total:=jmldiskon+angkut+lain;
    edtotal.Text:=floattostr(total);
end;

procedure TfJual.edDiskonChange(Sender: TObject);
begin
  if eddiskon.Text='' then
  begin
    eddiskon.Text:='0';
  end;
  jumlah:=strtofloat(edjumlah.Text);
    diskon:=strtofloat(eddiskon.Text);
    jmldiskon:=jumlah-diskon;
    angkut:=strtofloat(edangkut.Text);
    lain:=strtofloat(edlain.Text);
    total:=jmldiskon+angkut+lain;
    edtotal.Text:=floattostr(total);
end;

procedure TfJual.edHargaChange(Sender: TObject);
begin
   if edharga.Text='' then
  begin
    edharga.Text:='0';

  end;
   qty:=strtofloat(edqty.text);
   harga:=strtofloat(edharga.Text);
   jumlah:=qty*harga;
   edjumlah.Text:=floattostr(jumlah);

   jumlah:=strtofloat(edjumlah.Text);
    diskon:=strtofloat(eddiskon.Text);
    jmldiskon:=jumlah-diskon;
    angkut:=strtofloat(edangkut.Text);
    lain:=strtofloat(edlain.Text);
    total:=jmldiskon+angkut+lain;
    edtotal.Text:=floattostr(total);
end;

procedure TfJual.edJumlahChange(Sender: TObject);
begin
     if edjumlah.Text='' then
  begin
    edjumlah.Text:='0';
  end;
end;

procedure TfJual.edLainChange(Sender: TObject);
begin
   if edlain.Text='' then
  begin
    edlain.Text:='0';
  end;
  jumlah:=strtofloat(edjumlah.Text);
    diskon:=strtofloat(eddiskon.Text);
    jmldiskon:=jumlah-diskon;
    angkut:=strtofloat(edangkut.Text);
    lain:=strtofloat(edlain.Text);
    total:=jmldiskon+angkut+lain;
    edtotal.Text:=floattostr(total);
end;

procedure TfJual.edMaterialChange(Sender: TObject);
begin

end;

procedure TfJual.edPPnChange(Sender: TObject);
begin
    if edppn.Text='' then
  begin
    edppn.Text:='0';
  end;
end;

procedure TfJual.edQtyChange(Sender: TObject);
begin
    if edqty.Text='' then
  begin
    edqty.Text:='0';

  end;
end;

procedure TfJual.edTotalChange(Sender: TObject);
begin
    if edtotal.Text='' then
  begin
    edtotal.Text:='0';
  end;
end;

procedure TfJual.FormCreate(Sender: TObject);
begin

end;

procedure TfJual.rbKreditChange(Sender: TObject);
begin
  label13.Visible:=true;
  edtglkredit.Visible:=true;
  edtglkredit.SetFocus;
  edbayar.Text:=rbkredit.Caption;
end;

procedure TfJual.rbTunaiChange(Sender: TObject);
begin
  label13.Visible:=false;
  edtglkredit.Visible:=false;
  edbayar.Text:=rbtunai.Caption;
end;

end.

