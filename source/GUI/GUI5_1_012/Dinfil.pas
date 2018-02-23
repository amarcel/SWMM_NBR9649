unit Dinfil;

{-------------------------------------------------------------------}
{                    Unit:    Dinfil.pas                            }
{                    Project: EPA SWMM                              }
{                    Version: 5.1                                   }
{                    Date:    12/2/13     (5.1.000)                 }
{                             09/2/14     (5.1.007)                 }
{                             03/19/15    (5.1.008)                 }
{                             08/05/15    (5.1.010)                 }
{                    Author:  L. Rossman                            }
{                                                                   }
{   Dialog form unit for editing subcatchment infiltration          }
{   or storage node exfiltration parameters.                        }
{-------------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Uglobals, Uproject, PropEdit;

type
  TInfilForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Panel3: TPanel;
    OKBtn: TButton;
    CancleBtn: TButton;
    HelpBtn: TButton;
    Panel4: TPanel;
    HintLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    InfilModel: Integer;
    PropEdit1: TPropEdit;
    PropList: TStringlist;
    procedure ShowPropertyHint(Sender: TObject; aRow: LongInt);
  public
    { Public declarations }
    HasChanged: Boolean;
    procedure SetData(InfilData: array of String; const SetInfilModel: Boolean);
    procedure GetData(var InfilData: array of String);
    procedure SetInfilModel(const S: String);
    procedure GetInfilModelName(var S: String);
  end;

//var
//  InfilForm: TInfilForm;

implementation

{$R *.DFM}

const
  TXT_PROPERTY = 'Property';
  TXT_VALUE = 'Value';

  HortonProps: array[0..4] of TPropRecord =
  (
   (Name:'Max. Infil. Rate';  Style: esEdit;  Mask: emPosNumber;  Length: 0),
   (Name:'Min. Infil. Rate';  Style: esEdit;  Mask: emPosNumber;  Length: 0),
   (Name:'Decay Constant';    Style: esEdit;  Mask: emPosNumber;  Length: 0),
   (Name:'Drying Time';       Style: esEdit;  Mask: emPosNumber;  Length: 0),
   (Name:'Max. Volume';       Style: esEdit;  Mask: emPosNumber;  Length: 0)
  );

  GreenAmptProps: array[0..2] of TPropRecord =
  (
    (Name:'Suction Head';    Style: esEdit;  Mask: emPosNumber;  Length: 0),
    (Name:'Conductivity';    Style: esEdit;  Mask: emPosNumber;  Length: 0),
    (Name:'Initial Deficit'; Style: esEdit;  Mask: emPosNumber;  Length: 0)
  );

  CurveNumProps: array[0..2] of TPropRecord =
  (
    (Name:'Curve Number';        Style: esEdit;  Mask: emPosNumber;  Length: 0),
    (Name:'Conductivity';        Style: esHeading; Mask: emNone;     Length: 0),
    (Name:'Drying Time';         Style: esEdit;  Mask: emPosNumber;  Length: 0)
  );

  HortonHint: array[0..4] of String =
  ('Maximum rate on the Horton infiltration curve (in/hr or mm/hr)',
   'Minimum rate on the Horton infiltration curve (in/hr or mm/hr)',
   'Decay constant for the Horton infiltration curve (1/hr)',
   'Time for a fully saturated soil to completely dry (days)',
   'Maximum infiltration volume possible (inches or mm, 0 if not applicable)');

  GreenAmptHint: array[0..2] of String =
  ('Soil capillary suction head (inches or mm)',
   'Soil saturated hydraulic conductivity (in/hr or mm/hr)',
   'Difference between soil porosity and initial moisture content ' +          //(5.1.007)
   '(a fraction)');

   StorageInfilHint: array[0..2] of String =                                   //(5.1.007)
  ('Capillary suction head (inches or mm).',
   'Saturated hydraulic conductivity (in/hr or mm/hr). Enter ' +
   '0 for no seepage.',
   'Difference between porosity and initial moisture content. ' +
   'Enter 0 for constant seepage equal to conductivity.');

  CurveNumHint: array[0..2] of String =
  ('SCS runoff curve number',
   'This property has been deprecated and its value is ignored.',
   'Time for a fully saturated soil to completely dry (days)');

procedure TInfilForm.FormCreate(Sender: TObject);
//-----------------------------------------------------------------------------
//  Form's OnCreate handler.
//-----------------------------------------------------------------------------
var
  I: Integer;
begin
  // Load infiltration options into Combo Box
  for I := 0 to High(InfilOptions) do
    ComboBox1.Items.Add(InfilOptions[I]);
  ComboBox1.ItemHeight := Uglobals.ItemHeight;                                 //(5.1.008)

  // Create Property Editor
  PropEdit1 := TPropEdit.Create(self);
  with PropEdit1 do
  begin
    Parent := Panel1;
    Align := alClient;
    BorderStyle := bsNone;
    Left := 1;
    Top := 1;
    ColHeading1 := TXT_PROPERTY;
    ColHeading2 := TXT_VALUE;
    ValueColor := clNavy;
    OnRowSelect := ShowPropertyHint;
  end;

  // Create Property stringlist
  PropList := TStringlist.Create;
  HasChanged := False;
end;

procedure TInfilForm.FormDestroy(Sender: TObject);
//-----------------------------------------------------------------------------
//  Form's OnDestroy handler.
//-----------------------------------------------------------------------------
begin
  PropList.Free;
  PropEdit1.Free;
end;

procedure TInfilForm.FormShow(Sender: TObject);
//-----------------------------------------------------------------------------
//  Form's OnShow handler.
//-----------------------------------------------------------------------------
begin

////  Following code segment modified for release 5.1.010.  ////               //(5.1.010)
  case InfilModel of
  HORTON_INFIL, MOD_HORTON_INFIL:
   PropEdit1.SetProps(HortonProps, PropList);
  GREEN_AMPT_INFIL, MOD_GREEN_AMPT_INFIL:
    PropEdit1.SetProps(GreenAmptProps, PropList);
  CURVE_NUMBER_INFIL:
    PropEdit1.SetProps(CurveNumProps, PropList);
////

  else
    begin
      Caption := 'Storage Seepage Editor';                                     //(5.1.007)
      ComboBox1.Visible := False;                                              //(5.1.007)
      Panel2.Caption := '  Properties of soil beneath storage unit:';          //(5.1.007)
      PropEdit1.SetProps(GreenAmptProps, PropList);                            //(5.1.007)
    end;
  end;
  PropEdit1.Edit;
end;

////  Procedure modified for release 5.1.010.  ////                            //(5.1.010)
procedure TInfilForm.ComboBox1Change(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnChange handler for ComboBox1.
//-----------------------------------------------------------------------------
begin
  InfilModel := ComboBox1.ItemIndex;
  PropList.Clear;
  case InfilModel of
  HORTON_INFIL, MOD_HORTON_INFIL:
    SetData(Uproject.DefHortonInfil, True);
  GREEN_AMPT_INFIL, MOD_GREEN_AMPT_INFIL:
    SetData(Uproject.DefGreenAmptInfil, True);
  CURVE_NUMBER_INFIL:
    SetData(Uproject.DefCurveNumInfil, True);
  end;
  FormShow(Sender);
end;

procedure TInfilForm.SetInfilModel(const S: String);
//-----------------------------------------------------------------------------
//  Determines which Infiltration model is represented by string S.
//  (S will be empty when the dialog form is used to edit exfiltration         //(5.1.007)
//  parameters for a storage node.)
//-----------------------------------------------------------------------------
var
  I: Integer;
begin
  InfilModel := -1;
  for I := 0 to High(InfilOptions) do
  begin
    if SameText(S, InfilOptions[I]) then InfilModel := I;
  end;

  // Show G-A model in combo box when using dialog for a storage node          //(5.1.007)
  if InfilModel < 0 then ComboBox1.ItemIndex := 2                              //(5.1.007)
  else ComboBox1.ItemIndex := InfilModel;
end;

////  Procedure modified for release 5.1.010.  ////                            //(5.1.010)
procedure TInfilForm.SetData(InfilData: array of String;
  const SetInfilModel: Boolean);
//-----------------------------------------------------------------------------
//  Loads a set of infiltration parameters into the form.
//-----------------------------------------------------------------------------
var
  N: Integer;
  J: Integer;
begin
  ComboBox1.Enabled := SetInfilModel;
  case InfilModel of
  HORTON_INFIL, MOD_HORTON_INFIL:         N := High(HortonProps);
  GREEN_AMPT_INFIL, MOD_GREEN_AMPT_INFIL: N := High(GreenAmptProps);
  CURVE_NUMBER_INFIL:                     N := High(CurveNumProps);
  else                                    N := High(GreenAmptProps);
  end;
  for J := 0 to N do PropList.Add(InfilData[J]);
end;

procedure TInfilForm.GetData(var InfilData: array of String);
//-----------------------------------------------------------------------------
//  Retrieves a set of infiltration parameters from the form.
//-----------------------------------------------------------------------------
var
  J: Integer;
begin
  for J := 0 to PropList.Count-1 do
  begin
   if Length(Trim(PropList[J])) > 0 then InfilData[J] := PropList[J];
  end;
  if not HasChanged then HasChanged := PropEdit1.Modified;
end;

procedure TInfilForm.GetInfilModelName(var S: String);
//-----------------------------------------------------------------------------
//  Retrieves the type of infiltration model selected from the form.
//-----------------------------------------------------------------------------
begin
  S := ComboBox1.Text;
end;

////  Procedure modified for release 5.1.010.  ////                            //(5.1.010)
procedure TInfilForm.ShowPropertyHint(Sender: TObject; aRow: LongInt);
//-----------------------------------------------------------------------------
//  OnRowSelect handler assigned to the PropEdit control. Selects the
//  appropriate hint text to display when a new infiltration property
//  is selected.
//-----------------------------------------------------------------------------
var
  S: String;
begin
  case InfilModel of
  HORTON_INFIL, MOD_HORTON_INFIL:         S := HortonHint[aRow];
  GREEN_AMPT_INFIL, MOD_GREEN_AMPT_INFIL: S := GreenAmptHint[aRow];
  CURVE_NUMBER_INFIL:                     S := CurveNumHint[aRow];
  else                                    S := StorageInfilHint[aRow];
  end;
  HintLabel.Caption := S;
end;

procedure TInfilForm.OKBtnClick(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnClick handler for the OK button.
//-----------------------------------------------------------------------------
begin
  PropEdit1.IsValid;
end;

////  Procedure modified for release 5.1.010.  ////                            //(5.1.010)
procedure TInfilForm.HelpBtnClick(Sender: TObject);
begin
  case InfilModel of
  HORTON_INFIL, MOD_HORTON_INFIL:
    Application.HelpCommand(HELP_CONTEXT, 212690);
  GREEN_AMPT_INFIL, MOD_GREEN_AMPT_INFIL:
    Application.HelpCommand(HELP_CONTEXT, 212700);
  CURVE_NUMBER_INFIL:
    Application.HelpCommand(HELP_CONTEXT, 212710);
  else
    Application.HelpCommand(HELP_CONTEXT, 212700);
  end;
end;

end.
