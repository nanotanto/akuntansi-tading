unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, DbCtrls, DBGrids, ZDataset;

type

  { TfBeli }

  TfBeli = class(TForm)
    btEdit: TButton;
    btTambah: TButton;
    btSimpan: TButton;
    btBatal: TButton;
    cbPPn: TCheckBox;
    DataPembelian: TDataSource;
    DataPersediaan: TDataSource;
    DataJurnal: TDataSource;
    DataUtang: TDataSource;
    DataUser: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    edId: TDBEdit;
    DBNavigator1: TDBNavigator;
    edbayar: TEdit;
    edMitra: TEdit;
    edBarang: TEdit;
    edidJurnal: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    edTglKredit: TDateEdit;
    edTgl: TDateEdit;
    DBGrid1: TDBGrid;
    cbMitra: TDBLookupComboBox;
    cbBarang: TDBLookupComboBox;
    edNo: TEdit;
    edQty: TEdit;
    edHarga: TEdit;
    edJumlah: TEdit;
    edDiskon: TEdit;
    edAngkut: TEdit;
    edLain: TEdit;
    edPPn: TEdit;
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
    ZQPembelian: TZQuery;
    ZQPersediaan: TZQuery;
    ZQJurnal: TZQuery;
    ZQUtang: TZQuery;
    ZQUser: TZQuery;
    procedure btBatalClick(Sender: TObject);
    procedure btbataleditClick(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure btSimpanClick(Sender: TObject);
    procedure btsimpaneditClick(Sender: TObject);
    procedure btTambahClick(Sender: TObject);
    procedure cbBarangChange(Sender: TObject);
    procedure cbMitraChange(Sender: TObject);
    procedure cbPPnChange(Sender: TObject);
    procedure edAngkutChange(Sender: TObject);
    procedure edBarangChange(Sender: TObject);
    procedure edDiskonChange(Sender: TObject);
    procedure edharga1Change(Sender: TObject);
    procedure edHargaChange(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure edJumlahChange(Sender: TObject);
    procedure edLainChange(Sender: TObject);
    procedure edMitraChange(Sender: TObject);
    procedure edNoChange(Sender: TObject);
    procedure edPPnChange(Sender: TObject);
    procedure edQtyChange(Sender: TObject);
    procedure edTglChange(Sender: TObject);
    procedure edTglKreditChange(Sender: TObject);
    procedure edTotalChange(Sender: TObject);
    procedure rbKreditChange(Sender: TObject);
    procedure rbTunaiChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fBeli: TfBeli;
   qty, harga, jumlah, diskon, jmldiskon, angkut, lain, total, ppn: real;
   awal, beli, akhir, stokawal, stokakhir, hpp :real;

implementation

{$R *.lfm}

{ TfBeli }

procedure TfBeli.rbKreditChange(Sender: TObject);
begin
  label13.Visible:=true;
  edtglkredit.Visible:=true;
  edtglkredit.SetFocus;
  edbayar.Text:=rbkredit.Caption;
end;

procedure TfBeli.rbTunaiChange(Sender: TObject);
begin
  label13.Visible:=false;
  edtglkredit.Visible:=false;
  edbayar.Text:=rbtunai.Caption;
 // btsimpan.Enabled:=true;
end;

procedure TfBeli.Edit2Change(Sender: TObject);
begin
 // DBLookupComboBox1.Text:=edMitra.Text;
end;

procedure TfBeli.edJumlahChange(Sender: TObject);
begin
   if edjumlah.Text='' then
  begin
    edjumlah.Text:='0';
  end;
end;

procedure TfBeli.edLainChange(Sender: TObject);
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

procedure TfBeli.edMitraChange(Sender: TObject);
begin

end;

procedure TfBeli.edNoChange(Sender: TObject);
begin

  end;

procedure TfBeli.edPPnChange(Sender: TObject);
begin
  if edppn.Text='' then
  begin
    edppn.Text:='0';
  end;
end;

procedure TfBeli.edQtyChange(Sender: TObject);
begin
  if edqty.Text='' then
  begin
    edqty.Text:='0';

  end;
end;

procedure TfBeli.edTglChange(Sender: TObject);
begin

end;

procedure TfBeli.edTglKreditChange(Sender: TObject);
begin
  //btsimpan.Enabled:=true;
end;

procedure TfBeli.edTotalChange(Sender: TObject);
begin
  if edtotal.Text='' then
  begin
    edtotal.Text:='0';
  end;
end;

procedure TfBeli.btTambahClick(Sender: TObject);
begin
  ZQjurnal.Append;
  ZQpembelian.Append;
  ZQutang.Append;
  edno.Text:='';
  edtgl.Text:='';
  edmitra.Text:='';
  edbarang.Text:='';
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

procedure TfBeli.btBatalClick(Sender: TObject);
begin
  ZQjurnal.Cancel;
  ZQpersediaan.Cancel;
  ZQpembelian.Cancel;
  ZQutang.Cancel;
  edno.Text:='';
  edtgl.Text:='';
  edmitra.Text:='';
  edbarang.Text:='';
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
  bttambah.Enabled:=true;
  btsimpan.Enabled:=false;
end;

procedure TfBeli.btbataleditClick(Sender: TObject);
begin

end;

procedure TfBeli.btEditClick(Sender: TObject);
begin
  btsimpan.Enabled:=true;


 edno.Text:= zqpembelian['no_transaksi'];
 edbarang.Text:= zqpembelian['id_persediaan'];
 edtgl.Text:= zqpembelian['tgl'];
 edmitra.Text:= zqpembelian['id_user'];
 edharga.Text:= zqpembelian['harga'];
 edqty.Text:= zqpembelian['qty'];
 edjumlah.Text:= zqpembelian['jumlah'];
 eddiskon.Text:= zqpembelian['diskon'];
 edtotal.Text:= zqpembelian['total'];
 edangkut.Text:= zqpembelian['biaya_kirim'];
 edlain.Text:=  zqpembelian['biaya_lain'];
 zqpembelian.Edit;

 zqjurnal.Close;
  zqjurnal.SQL.Clear;
  zqjurnal.SQL.Add('select * from jurnal where id like "%'+edidJurnal.Text+'%"');
  zqjurnal.Open;
  zqjurnal.Edit;

  zqutang.Close;
  zqutang.SQL.Clear;
  zqutang.SQL.Add('select * from utang where id_beli like "%'+edid.Text+'%"');
  zqutang.Open;
  zqutang.Edit;


  zqutang.Edit;
  zqpersediaan.Edit;

end;

procedure TfBeli.btSimpanClick(Sender: TObject);
begin

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
  end;


  bttambah.Enabled:=true;
  btsimpan.Enabled:=false;
end;

procedure TfBeli.btsimpaneditClick(Sender: TObject);
begin

end;

procedure TfBeli.cbBarangChange(Sender: TObject);
begin
  edbarang.Text:=cbbarang.Text;
end;

procedure TfBeli.cbMitraChange(Sender: TObject);
begin
  edMitra.Text:=cbMitra.Text;
end;

procedure TfBeli.cbPPnChange(Sender: TObject);
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

procedure TfBeli.edAngkutChange(Sender: TObject);
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

procedure TfBeli.edBarangChange(Sender: TObject);
begin

end;

procedure TfBeli.edDiskonChange(Sender: TObject);
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

procedure TfBeli.edharga1Change(Sender: TObject);
begin

end;

procedure TfBeli.edHargaChange(Sender: TObject);
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

end.

