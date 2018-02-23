object ReportSelectForm: TReportSelectForm
  Left = 529
  Top = 316
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Graph Selection'
  ClientHeight = 304
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 15
  object BtnOK: TButton
    Left = 77
    Top = 265
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = BtnOKClick
  end
  object BtnCancel: TButton
    Left = 167
    Top = 265
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = BtnCancelClick
  end
  object BtnHelp: TButton
    Left = 257
    Top = 265
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
    OnClick = BtnHelpClick
  end
  object Notebook1: TNotebook
    Left = 0
    Top = 0
    Width = 410
    Height = 249
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 329
    object TPage
      Left = 0
      Top = 0
      Caption = 'TimeSeriesPage'
      ExplicitWidth = 329
      object Label4: TLabel
        Left = 16
        Top = 8
        Width = 51
        Height = 15
        Caption = 'Start Date'
      end
      object Label5: TLabel
        Left = 240
        Top = 8
        Width = 47
        Height = 15
        Caption = 'End Date'
      end
      object Label1: TLabel
        Left = 240
        Top = 63
        Width = 86
        Height = 15
        Caption = 'Object Category'
      end
      object Label3: TLabel
        Left = 16
        Top = 120
        Width = 47
        Height = 15
        Caption = 'Variables'
      end
      object Label15: TLabel
        Left = 16
        Top = 64
        Width = 68
        Height = 15
        Caption = 'Time Format'
      end
      object StartDateCombo1: TComboBox
        Left = 16
        Top = 27
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 0
      end
      object EndDateCombo1: TComboBox
        Left = 240
        Top = 27
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
      end
      object CategoryCombo: TComboBox
        Left = 240
        Top = 84
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 3
        OnClick = CategoryComboClick
      end
      object VariableListBox: TCheckListBox
        Left = 16
        Top = 136
        Width = 190
        Height = 97
        ItemHeight = 18
        Style = lbOwnerDrawFixed
        TabOrder = 4
        OnClick = VariableListBoxClick
      end
      object TimeAxisCombo: TComboBox
        Left = 16
        Top = 84
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 2
        Text = 'Elapsed Time'
        Items.Strings = (
          'Elapsed Time'
          'Date/Time')
      end
      object ObjectsPanel: TPanel
        Left = 240
        Top = 120
        Width = 151
        Height = 113
        BevelOuter = bvNone
        TabOrder = 5
        object ObjectsLabel: TLabel
          Left = 0
          Top = 0
          Width = 40
          Height = 15
          Caption = 'Objects'
        end
        object ItemsListBox: TListBox
          Left = 0
          Top = 16
          Width = 121
          Height = 97
          ItemHeight = 15
          TabOrder = 0
        end
        object BtnAdd: TBitBtn
          Left = 121
          Top = 16
          Width = 25
          Height = 25
          Hint = 'Add Item'
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            700077777777777770007777700077777000777770C077777000777770C07777
            7000770000C000077000770CCCCCCC077000770000C000077000777770C07777
            7000777770C07777700077777000777770007777777777777000777777777777
            7000}
          TabOrder = 1
          OnClick = BtnAddClick
        end
        object BtnDelete: TBitBtn
          Left = 121
          Top = 40
          Width = 25
          Height = 25
          Hint = 'Remove Item'
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777777777700077777777777770007777777777777000777777777777
            70007700000000077000770CCCCCCC0770007700000000077000777777777777
            7000777777777777700077777777777770007777777777777000777777777777
            7000}
          TabOrder = 2
          OnClick = BtnDeleteClick
        end
        object BtnMoveUp: TBitBtn
          Left = 121
          Top = 64
          Width = 25
          Height = 25
          Hint = 'Move Item Up'
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777777777700077770000077770007777066607777000777706660777
            7000777706660777700070000666000070007706666666077000777066666077
            7000777706660777700077777060777770007777770777777000777777777777
            7000}
          TabOrder = 3
          OnClick = BtnMoveUpClick
        end
        object BtnMoveDown: TBitBtn
          Left = 121
          Top = 88
          Width = 25
          Height = 25
          Hint = 'Move Item Down'
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            7000777777777777700077777707777770007777706077777000777706660777
            7000777066666077700077066666660770007000066600007000777706660777
            7000777706660777700077770666077770007777000007777000777777777777
            7000}
          TabOrder = 4
          OnClick = BtnMoveDownClick
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'ScatterPage'
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 51
        Height = 15
        Caption = 'Start Date'
      end
      object Label6: TLabel
        Left = 168
        Top = 16
        Width = 47
        Height = 15
        Caption = 'End Date'
      end
      object StartDateCombo2: TComboBox
        Left = 16
        Top = 32
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 0
      end
      object EndDateCombo2: TComboBox
        Left = 168
        Top = 32
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
      end
      object XVariableBox: TGroupBox
        Left = 16
        Top = 72
        Width = 145
        Height = 169
        Caption = 'X-Variable'
        TabOrder = 2
        object Label9: TLabel
          Left = 16
          Top = 24
          Width = 86
          Height = 15
          Caption = 'Object Category'
        end
        object Label10: TLabel
          Left = 16
          Top = 72
          Width = 35
          Height = 15
          Caption = 'Object'
        end
        object Label11: TLabel
          Left = 16
          Top = 120
          Width = 42
          Height = 15
          Caption = 'Variable'
        end
        object XCategoryCombo: TComboBox
          Left = 16
          Top = 40
          Width = 113
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 0
          OnClick = CategoryComboClick
        end
        object XObjectEdit: TEdit
          Left = 16
          Top = 88
          Width = 91
          Height = 23
          TabOrder = 1
        end
        object XObjectBtn: TBitBtn
          Left = 108
          Top = 88
          Width = 21
          Height = 21
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            700077777777777770007777700077777000777770C077777000777770C07777
            7000770000C000077000770CCCCCCC077000770000C000077000777770C07777
            7000777770C07777700077777000777770007777777777777000777777777777
            7000}
          TabOrder = 2
          TabStop = False
          OnClick = BtnAddClick
        end
        object XVariableCombo: TComboBox
          Left = 16
          Top = 136
          Width = 113
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 3
        end
      end
      object YVariableBox: TGroupBox
        Left = 168
        Top = 72
        Width = 145
        Height = 169
        Caption = 'Y-Variable'
        TabOrder = 3
        object Label12: TLabel
          Left = 16
          Top = 24
          Width = 86
          Height = 15
          Caption = 'Object Category'
        end
        object Label13: TLabel
          Left = 16
          Top = 72
          Width = 35
          Height = 15
          Caption = 'Object'
        end
        object Label14: TLabel
          Left = 16
          Top = 120
          Width = 42
          Height = 15
          Caption = 'Variable'
        end
        object YCategoryCombo: TComboBox
          Left = 16
          Top = 40
          Width = 113
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 0
          OnClick = CategoryComboClick
        end
        object YObjectEdit: TEdit
          Left = 16
          Top = 88
          Width = 91
          Height = 23
          TabOrder = 1
        end
        object YObjectBtn: TBitBtn
          Left = 108
          Top = 88
          Width = 21
          Height = 21
          Glyph.Data = {
            DE000000424DDE0000000000000076000000280000000D0000000D0000000100
            0400000000006800000000000000000000001000000010000000000000000000
            BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
            700077777777777770007777700077777000777770C077777000777770C07777
            7000770000C000077000770CCCCCCC077000770000C000077000777770C07777
            7000777770C07777700077777000777770007777777777777000777777777777
            7000}
          TabOrder = 2
          TabStop = False
          OnClick = BtnAddClick
        end
        object YVariableCombo: TComboBox
          Left = 16
          Top = 136
          Width = 113
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 3
        end
      end
    end
  end
end
