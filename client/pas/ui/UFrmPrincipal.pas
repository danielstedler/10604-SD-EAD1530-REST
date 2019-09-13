unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    EdtEnderecoBackend: TLabeledEdit;
    EdtDocumentoCliente: TLabeledEdit;
    CmbTamanhoPizza: TComboBox;
    CmbSaborPizza: TComboBox;
    EdtPortaBackend: TLabeledEdit;
    btn1: TButton;
    lbl2: TLabel;
    lbl3: TLabel;
    Pnl1: TPanel;
    mmoRetornoWebService: TMemo;
    lbl1: TLabel;
    grp1: TGroupBox;
    EdtDocumentoConsulta: TLabeledEdit;
    btnConsultar: TButton;
    grp2: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    EdtValorConsulta: TLabeledEdit;
    EdtTempoConsulta: TLabeledEdit;
    CmbSaborConsulta: TComboBox;
    CmbTamanhoConsulta: TComboBox;
    procedure btn1Click(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Rest.JSON, MVCFramework.RESTClient, UEfetuarPedidoDTOImpl, System.Rtti,
  UPizzaSaborEnum, UPizzaTamanhoEnum, UPedidoRetornoDTOImpl, MVCFramework,
  System.JSON;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  Clt: TRestClient;
  oEfetuarPedido: TEfetuarPedidoDTO;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text,
    StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    oEfetuarPedido := TEfetuarPedidoDTO.Create;
    try

      oEfetuarPedido.PizzaTamanho := TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text);

      oEfetuarPedido.PizzaSabor   := TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text);

      oEfetuarPedido.DocumentoCliente := edtDocumentoCliente.Text;

      mmoRetornoWebService.Text := Clt.doPOST('/efetuarPedido', [],
       TJson.ObjecttoJsonString(oEfetuarPedido)).BodyAsString;
    finally
      oEfetuarPedido.Free;
    end;
  finally
    Clt.Free;
  end;
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
var
  oJsonObject: TJSOnObject;
  Clt: TRestClient;
  oPedidoRetornoDTO : TPedidoRetornoDTO;
  oEfetuarPedido: TEfetuarPedidoDTO;
begin
  Clt := MVCFramework.RESTClient.TRestClient.Create(edtEnderecoBackend.Text,
    StrToIntDef(edtPortaBackend.Text, 80), nil);
  try
    oEfetuarPedido := TEfetuarPedidoDTO.Create;
    oEfetuarPedido.DocumentoCliente := edtDocumentoConsulta.Text;

    try
     mmoRetornoWebService.Text := Clt.doPOST('/consultarPedido', [],
        TJson.ObjecttoJsonString(oEfetuarPedido)).BodyAsString;

     oPedidoRetornoDTO :=  TJson.JsonToObject<TPedidoRetornoDTO>(mmoRetornoWebService.Text);

      EdtValorConsulta.Text := FormatFloat('##,##0.00', oPedidoRetornoDTO.ValorTotalPedido);
      EdtTempoConsulta.Text := oPedidoRetornoDTO.TempoPreparo.ToString;

      CmbTamanhoConsulta.ItemIndex :=  Ord(oPedidoRetornoDTO.PizzaTamanho);
      CmbSaborConsulta.ItemIndex := Ord(oPedidoRetornoDTO.PizzaSabor)

    finally
      oEfetuarPedido.Free;
    end;
  finally
    Clt.Free;
  end;
end;

end.
