unit Dtreat;

{-------------------------------------------------------------------}
{                    Unit:    Dtreat.pas                            }
{                    Project: EPA SWMM                              }
{                    Version: 5.1                                   }
{                    Date:    12/2/13    (5.1.000)                  }
{                    Author:  L. Rossman                            }
{                                                                   }
{   Dialog form for editing pollutant treatment expressions at a    }
{   drainage system node.                                           }
{-------------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, Uglobals, Uutils, Uproject, GridEdit;

type
  TTreatmentForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    Panel1: TPanel;
    HintMemo: TMemo;
    Splitter1: TSplitter;
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ExprGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HasChanged: Boolean;
    procedure SetData(const NodeType: Integer; const NodeIndex: Integer);
    procedure GetData(const NodeType: Integer; const NodeIndex: Integer);
  end;

//var
//  TreatmentForm: TTreatmentForm;

implementation

{$R *.dfm}

const
  HintText: String =
    'Treatment expressions have the general form:' + #10 +
    '  R = f(P, R_P, V) ' + #10 +
    'or' + #10 +
    '  C = f(P, R_P, V) ' + #10 +
    'where:' + #10 +
    '  R   = fractional removal,' + #10 +
    '  C   = outlet concentration,' + #10 +
    '  P   = one or more pollutant names,' + #10 +
    '  R_P = one or more pollutant removals' + #10 +
    '        (prepend R_ to pollutant name),' + #10 +
    '  V   = one or more process variables:' + #10 +
    '        FLOW (inflow rate)' + #10 +
    '        DEPTH (water depth)' + #10 +
    '        HRT (hydraulic residence time)' + #10 +
    '        DT (time step in seconds)' + #10 +
    '        AREA (surface area).' + #10 +
    'Some example expressions are:' + #10 +
    '  C = BOD * exp(-0.05*HRT)' + #10 +
    '  R = 0.75 * R_TSS';
  TXT_POLLUTANT = 'Pollutant';
  TXT_TREAT_EXPR = 'Treatment Expression';
  TXT_CAPTION = 'Treatment Editor for Node ';

procedure TTreatmentForm.FormCreate(Sender: TObject);
//-----------------------------------------------------------------------------
//  Form's OnCreate handler.
//-----------------------------------------------------------------------------
var
  I: Integer;
  H: Integer;
begin
  // Set font type and text in the hint memo box
  //HintMemo.Font.Name := 'Courier New';
  HintMemo.Lines.Text := HintText;

  // Set up the Treatment Expression grid
  with Grid do
  begin
    ColWidths[1] := ClientWidth;
    RowCount := Project.Lists[POLLUTANT].Count + 1;
    H := RowCount * (DefaultRowHeight + 1);
    if H < ClientHeight then ClientHeight := H;
    Cells[0,0] := TXT_POLLUTANT;
    Cells[1,0] := TXT_TREAT_EXPR;
    for I := 0 to Project.Lists[POLLUTANT].Count-1 do
      Cells[0, I+1] := Project.Lists[POLLUTANT].Strings[I];
  end;
end;

procedure TTreatmentForm.SetData(const NodeType: Integer;
  const NodeIndex: Integer);
//-----------------------------------------------------------------------------
//  Loads the treatment expressions for a node into the form.
//-----------------------------------------------------------------------------
var
  aNode  : TNode;
  I      : Integer;
  S      : String;
begin
  // Get a reference to the node being edited
  aNode := Project.GetNode(NodeType, NodeIndex);
  Caption := TXT_CAPTION + aNode.ID;

  // Fill in treatment expression grid
  for I := 0 to Project.Lists[POLLUTANT].Count-1 do
  begin
    S := Project.Lists[POLLUTANT].Strings[I];
    Grid.Cells[1,I+1] := aNode.Treatment.Values[S];
  end;
  Grid.Row := 1;
  HasChanged := False;
end;

procedure TTreatmentForm.GetData(const NodeType: Integer;
  const NodeIndex: Integer);
//-----------------------------------------------------------------------------
//  Retrieves the treatment expressions for a node from the form.
//-----------------------------------------------------------------------------
var
  aNode: TNode;
  I    : Integer;
  S    : String;
begin
  // Get a reference to the node being edited
  aNode := Project.GetNode(NodeType, NodeIndex);

  // Save treatment expressions from grid
  aNode.Treatment.Clear;
  with Grid do
  begin
    for I := 1 to RowCount-1 do
    begin
      if Length(Trim(Cells[1,I])) > 0 then
      begin
        S := Cells[0,I] + '=' + Cells[1,I];
        aNode.Treatment.Add(S);
      end;
    end;
  end;
end;

procedure TTreatmentForm.OKBtnClick(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnClick handler for the OK button.
//-----------------------------------------------------------------------------
begin
  ModalResult := mrOK;
end;

procedure TTreatmentForm.ExprGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
//-----------------------------------------------------------------------------
//  OnSetEditText handler for the Treatment Expression grid.
//-----------------------------------------------------------------------------
begin
  HasChanged := True;
end;

procedure TTreatmentForm.HelpBtnClick(Sender: TObject);
begin
 Application.HelpCommand(HELP_CONTEXT, 212470)
end;

end.
