unit UPedidoServiceImpl;

interface

uses
  UPedidoServiceIntf, UPizzaTamanhoEnum, UPizzaSaborEnum,
  UPedidoRepositoryIntf, UPedidoRetornoDTOImpl, UClienteServiceIntf;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FPedidoRepository: IPedidoRepository;
    FClienteService: IClienteService;

    function calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
    function calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO;
    function consultarPedido(const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;

    constructor Create; reintroduce;
  end;

implementation

uses
  UPedidoRepositoryImpl, System.SysUtils, UClienteServiceImpl,
  FireDAC.Comp.Client;

{ TPedidoService }

function TPedidoService.calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
begin
  Result := 15;
  case APizzaTamanho of
    enPequena:
      Result := 15;
    enMedia:
      Result := 20;
    enGrande:
      Result := 25;
  end;

  if (APizzaSabor = enPortuguesa) then
    Result := Result + 5;
end;

function TPedidoService.calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
begin
  Result := 20;
  case APizzaTamanho of
    enPequena:
      Result := 20;
    enMedia:
      Result := 30;
    enGrande:
      Result := 40;
  end;
end;

constructor TPedidoService.Create;
begin
  inherited;

  FPedidoRepository := TPedidoRepository.Create;
  FClienteService := TClienteService.Create;
end;

function TPedidoService.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String)
  : TPedidoRetornoDTO;
var
  oValorPedido: Currency;
  oTempoPreparo: Integer;
  oCodigoCliente: Integer;
begin
  oValorPedido := calcularValorPedido(APizzaTamanho);
  oTempoPreparo := calcularTempoPreparo(APizzaTamanho, APizzaSabor);
  oCodigoCliente := FClienteService.adquirirCodigoCliente(ADocumentoCliente);

  FPedidoRepository.efetuarPedido(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo, oCodigoCliente);
  Result := TPedidoRetornoDTO.Create(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo);
end;

function TPedidoService.ConsultarPedido(const ADocumentoCliente: String): TPedidoRetornoDTO;
var
 pFDQuery : TFDQuery;
begin
  pFDQuery := TFDQuery.Create(nil);
 try
  FPedidoRepository.ConsultarPedido(ADocumentoCliente, pFDQuery);

  if pFDQuery.IsEmpty then
   raise Exception.Create('O Cliente: '+ ADocumentoCliente + ' n�o possu� pedidos');

   Result := TPedidoRetornoDTO.Create(TPizzaTamanhoEnum(pFDQuery.FieldByName('nr_pizzatamanho').AsInteger),
                                      TPizzaSaborEnum(pFDQuery.FieldByName('nr_pizzasabor').AsInteger),
                                      pFDQuery.FieldByName('vl_pedido').AsCurrency,
                                      pFDQuery.FieldByName('nr_tempopedido').AsInteger);

 finally
  FreeAndNil(pFDQuery);
 end;
end;

end.
