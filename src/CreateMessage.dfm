object CreateMessageFrm: TCreateMessageFrm
  Left = 546
  Top = 264
  Width = 300
  Height = 325
  Caption = 'Message Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object AddMessageButton: TButton
    Left = 80
    Top = 184
    Width = 97
    Height = 25
    Caption = 'Add Message'
    TabOrder = 0
    OnClick = AddMessageButtonClick
  end
  object AddMessage: TMemo
    Left = 24
    Top = 24
    Width = 225
    Height = 145
    Lines.Strings = (
      'AddMessage')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 224
    Width = 89
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end