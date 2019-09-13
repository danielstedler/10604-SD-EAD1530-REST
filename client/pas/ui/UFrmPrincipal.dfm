object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 550
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 320
    Height = 325
    ActivePage = ts1
    Align = alTop
    TabOrder = 0
    object ts1: TTabSheet
      Caption = '1 - Fazer Pedido'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbl2: TLabel
        Left = 16
        Top = 93
        Width = 90
        Height = 13
        Caption = 'Tamanho da Pizza:'
      end
      object lbl3: TLabel
        Left = 16
        Top = 136
        Width = 74
        Height = 13
        Caption = 'Sabor da Pizza:'
      end
      object EdtEnderecoBackend: TLabeledEdit
        Left = 16
        Top = 24
        Width = 161
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o Pizzaria Backend:'
        TabOrder = 0
        Text = 'http://localhost'
      end
      object EdtDocumentoCliente: TLabeledEdit
        Left = 16
        Top = 64
        Width = 193
        Height = 21
        EditLabel.Width = 98
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero Documento:'
        TabOrder = 1
      end
      object CmbTamanhoPizza: TComboBox
        Left = 16
        Top = 109
        Width = 193
        Height = 21
        TabOrder = 2
        Items.Strings = (
          'enPequena'
          'enMedia'
          'enGrande')
      end
      object CmbSaborPizza: TComboBox
        Left = 16
        Top = 152
        Width = 193
        Height = 21
        TabOrder = 3
        Items.Strings = (
          'enCalabresa'
          'enMarguerita'
          'enPortuguesa')
      end
      object EdtPortaBackend: TLabeledEdit
        Left = 183
        Top = 24
        Width = 114
        Height = 21
        EditLabel.Width = 112
        EditLabel.Height = 13
        EditLabel.Caption = 'Porta Pizzaria Backend:'
        TabOrder = 4
        Text = '8080'
      end
      object btn1: TButton
        Left = 104
        Top = 217
        Width = 105
        Height = 25
        Caption = '&1 - Fazer Pedido'
        TabOrder = 5
        OnClick = btn1Click
      end
    end
    object ts2: TTabSheet
      Caption = '2 - Consultar Pedido'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grp1: TGroupBox
        Left = 0
        Top = 0
        Width = 312
        Height = 105
        Align = alTop
        Caption = 'Filtro'
        TabOrder = 0
        object EdtDocumentoConsulta: TLabeledEdit
          Left = 60
          Top = 29
          Width = 193
          Height = 21
          EditLabel.Width = 98
          EditLabel.Height = 13
          EditLabel.Caption = 'N'#250'mero Documento:'
          TabOrder = 0
        end
        object btnConsultar: TButton
          Left = 98
          Top = 63
          Width = 105
          Height = 25
          Caption = '&2 - Consultar Pedido'
          TabOrder = 1
          OnClick = btnConsultarClick
        end
      end
      object grp2: TGroupBox
        Left = 0
        Top = 105
        Width = 312
        Height = 192
        Align = alClient
        Caption = ' Resultado '
        TabOrder = 1
        object lbl4: TLabel
          Left = 12
          Top = 142
          Width = 74
          Height = 13
          Caption = 'Sabor da Pizza:'
        end
        object lbl5: TLabel
          Left = 12
          Top = 99
          Width = 90
          Height = 13
          Caption = 'Tamanho da Pizza:'
        end
        object EdtValorConsulta: TLabeledEdit
          Left = 12
          Top = 31
          Width = 193
          Height = 21
          EditLabel.Width = 63
          EditLabel.Height = 13
          EditLabel.Caption = 'Valor Pedido:'
          TabOrder = 0
        end
        object EdtTempoConsulta: TLabeledEdit
          Left = 12
          Top = 72
          Width = 193
          Height = 21
          EditLabel.Width = 71
          EditLabel.Height = 13
          EditLabel.Caption = 'Tempo Pedido:'
          TabOrder = 1
        end
        object CmbSaborConsulta: TComboBox
          Left = 12
          Top = 158
          Width = 193
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 2
          Items.Strings = (
            'enCalabresa'
            'enMarguerita'
            'enPortuguesa')
        end
        object CmbTamanhoConsulta: TComboBox
          Left = 12
          Top = 115
          Width = 193
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 3
          Items.Strings = (
            'enPequena'
            'enMedia'
            'enGrange')
        end
      end
    end
  end
  object Pnl1: TPanel
    Left = 0
    Top = 325
    Width = 320
    Height = 225
    Align = alClient
    TabOrder = 1
    object lbl1: TLabel
      Left = 7
      Top = 4
      Width = 118
      Height = 13
      Caption = 'Retorno do WebService:'
    end
    object mmoRetornoWebService: TMemo
      Left = 7
      Top = 23
      Width = 307
      Height = 194
      Lines.Strings = (
        'mmRetornoWebService')
      TabOrder = 0
    end
  end
end
