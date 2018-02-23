object BackdropFileForm: TBackdropFileForm
  Left = 194
  Top = 254
  BorderStyle = bsDialog
  Caption = 'Backdrop Image Selector'
  ClientHeight = 209
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 107
    Height = 15
    Caption = 'Backdrop Image File'
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 175
    Height = 15
    Caption = 'World Coordinates File (optional)'
  end
  object ImageFileEdit: TEdit
    Left = 16
    Top = 32
    Width = 224
    Height = 23
    TabOrder = 0
  end
  object ImageFileBtn: TBitBtn
    Left = 241
    Top = 30
    Width = 24
    Height = 24
    Hint = 'Browse'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF00000000000000000000000000C0C0C0000000
      00000000000000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000FFFFFF000000000000000000C0C0C0000000
      0000FFFFFF0000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C0000000
      000000000000000000000000000000000000C0C0C000C0C0C000808080000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000FF
      FF0000000000FFFFFF0000000000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000000000000000000000FFFF00FFFF
      FF00000000000000000000000000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = ImageFileBtnClick
  end
  object WorldFileEdit: TEdit
    Left = 16
    Top = 87
    Width = 224
    Height = 23
    TabOrder = 2
    OnChange = WorldFileEditChange
  end
  object WorldFileBtn: TBitBtn
    Left = 241
    Top = 85
    Width = 24
    Height = 25
    Hint = 'Browse'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C00000000000FFFFFF00000000000000000000000000C0C0C0000000
      00000000000000000000FFFFFF000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000FFFFFF000000000000000000C0C0C0000000
      0000FFFFFF0000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000C0C0C0000000
      000000000000000000000000000000000000C0C0C000C0C0C000808080000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000FFFFFF00000000000000000000000000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000FF
      FF0000000000FFFFFF0000000000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000000000000000000000FFFF00FFFF
      FF00000000000000000000000000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = WorldFileBtnClick
  end
  object OKBtn: TButton
    Left = 16
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 104
    Top = 168
    Width = 74
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object HelpBtn: TButton
    Left = 191
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 7
    OnClick = HelpBtnClick
  end
  object ScaleMapCheckBox: TCheckBox
    Left = 16
    Top = 128
    Width = 224
    Height = 21
    Caption = 'Scale Map to Backdrop Image'
    Ctl3D = True
    Enabled = False
    ParentCtl3D = False
    TabOrder = 4
  end
end