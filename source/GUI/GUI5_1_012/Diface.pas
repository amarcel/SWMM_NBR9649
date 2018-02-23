unit Diface;

{-------------------------------------------------------------------}
{                    Unit:    Diface.pas                            }
{                    Project: EPA SWMM                              }
{                    Version: 5.1                                   }
{                    Date:    12/2/13     (5.1.000)                 }
{                             03/19/15    (5.1.008)                 }
{                    Author:  L. Rossman                            }
{                                                                   }
{   Dialog form unit that allows the user to specify an Interface   }
{   File for a project.                                             }
{-------------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Uproject, Uglobals, Uutils;

type
  TIfaceFileForm = class(TForm)
    Label1: TLabel;
    FileTypeCombo: TComboBox;
    UseBtn: TRadioButton;
    SaveBtn: TRadioButton;
    Label3: TLabel;
    FileNameEdit: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    BrowseBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;

    procedure BrowseBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileTypeComboChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure HelpBtnClick(Sender: TObject);
    procedure FileNameEditChange(Sender: TObject);

  private
    { Private declarations }
    SaveStatus: Boolean;
    Fname: String;
    Fdir: String;

  public
    { Public declarations }
    procedure SetData(S: String);
    procedure GetData(var S: String);
  end;

//var
//  IfaceFileForm: TIfaceFileForm;

implementation

{$R *.dfm}

uses
  Fmain;

const
  TXT_SAVE = 'SAVE';
  TXT_USE = 'USE';
  TXT_IFACE_FILE = ' Interface File';
  MSG_NO_DIRECTORY = 'Could not open file selection dialog in directory ';
  MSG_INVALID_NAME = 'You must enter a valid file path and name.';
  MSG_NOT_EXIST = ' does not exist.';

  ExtensionTxt: array[0..5] of PChar =
    ('rff', 'rof', 'txt', 'hsf', 'txt', 'txt');

  FilterTxt: array[0..5] of PChar =
    ('Rainfall files (*.RFF)|*.RFF|All files|*.*',
     'Runoff files (*.ROF)|*.ROF|All files|*.*',
     'RDII files (*.TXT)|*.TXT|All files|*.*',
     'Hotstart files (*.HSF)|*.HSF|All files|*.*',
     'Routing files (*.TXT)|*.TXT|All files|*.*',
     'Routing files (*.TXT)|*.TXT|All files|*.*');

procedure TIfaceFileForm.FormCreate(Sender: TObject);
//-----------------------------------------------------------------------------
//  Form's OnCreate handler.
//-----------------------------------------------------------------------------
var
  I: Integer;
begin
  // Set form's font
  Uglobals.SetFont(self);
  BrowseBtn.Top := FileNameEdit.Top;
  BrowseBtn.Height := FileNameEdit.Height;

  // Load interface file types into the FileTypeCombo box
  with FileTypeCombo do
  begin
    for I := 0 to High(IfaceFileTypes) do
      Items.Add(IfaceFileTypes[I]);
    ItemHeight := Uglobals.ItemHeight;                                         //(5.1.008)
    ItemIndex := 0;
  end;
  Fdir := ProjectDir;
  SaveStatus := True;
  SaveBtn.Checked := True;
end;

procedure TIfaceFileForm.BrowseBtnClick(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnClick handler for the BrowseBtn BitBtn. Uses the MainForm's OpenDialog
//  or SaveDialog controls to select an interface file name.
//-----------------------------------------------------------------------------
var
  I: Integer;
  InitDir: String;
  InitName: String;
  DlgTitle: String;
  DefExt: String;
  Executed: Boolean;
begin
  Executed := False;
  I := FileTypeCombo.ItemIndex;
  DlgTitle := FileTypeCombo.Text + TXT_IFACE_FILE;
  InitDir := ExtractFileDir(FileNameEdit.Text);
  if Length(InitDir) = 0 then InitDir := Fdir;
  DefExt := ExtensionTxt[I];
  if Length(FileNameEdit.Text) > 0 then InitName := FileNameEdit.Text
  else InitName := '*.' + DefExt;

  try
    if UseBtn.Checked then with OpenDialog do
    begin
      Title := DlgTitle;
      Filter := FilterTxt[I];
      DefaultExt := DefExt;
      Filename := InitName;
      InitialDir := InitDir;
      Options := Options + [ofFileMustExist];
      if Execute then
      begin
        Fname := Filename;
        DefaultExt := '';
        Executed := True;
      end;
    end
    else with MainForm.SaveDialog do
    begin
      Title := DlgTitle;
      Filter := FilterTxt[I];
      DefaultExt := DefExt;
      Filename := InitName;
      InitialDir := InitDir;
      if Execute then
      begin
        Fname := Filename;
        DefaultExt := '';
        Executed := True;
      end;
    end;
    if Executed then
    begin
      FileNameEdit.Text := Fname;
      FileNameEdit.SetFocus;
      InitDir := ExtractFileDir(Fname);
      if Length(InitDir) > 0 then Fdir := InitDir;
    end;

  except
    if not DirectoryExists(InitDir)
    then Uutils.MsgDlg(MSG_NO_DIRECTORY + InitDir, mtError, [mbOK])            //(5.1.008)
  end;
end;

procedure TIfaceFileForm.SetData(S: String);
//-----------------------------------------------------------------------------
//  Loads the interface file selection stored in S into the form. The
//  format of the string is: USE/SAVE FileType FileName.
//-----------------------------------------------------------------------------
var
  I, N: Integer;
  Tokens: TStringlist;
begin
  // Create a stringlist to hold the tokenized form of the interface file info
  Tokens := TStringlist.Create;
  try
    // Break the string into USE/SAVE, FileType, and FileName tokens
    Uutils.Tokenize(S, Tokens, N);
    if N >= 3 then
    begin
      if SameText(Tokens[0], TXT_SAVE) then SaveStatus := True
      else SaveStatus := False;
      I := FileTypeCombo.Items.IndexOf(Tokens[1]);
      if I >= 0 then FileTypeCombo.ItemIndex := I;
      FileTypeComboChange(self);
      Fname := Tokens[2];
      if Pos('"', Fname) = 1 then Delete(Fname,1,1);
      if Pos('"', Fname) = Length(Fname)
      then Delete(Fname, Length(Fname), 1);
      FileNameEdit.Text := Fname;
    end;
  finally
    Tokens.Free;
  end;
end;

procedure TIfaceFileForm.GetData(var S: String);
//-----------------------------------------------------------------------------
//  Returns the interface file specified on the form in the string S.
//-----------------------------------------------------------------------------
begin
  if SaveBtn.Checked
  then S := TXT_SAVE + ' '
  else S := TXT_USE + ' ';
  S := S + FileTypeCombo.Text;
  S := S + ' "' + Fname + '"';
end;

procedure TIfaceFileForm.OKBtnClick(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnClick handler for the OK button.
//-----------------------------------------------------------------------------
begin
  Fname := Trim(FileNameEdit.Text);
  if Length(Fname) = 0
  then Uutils.MsgDlg(MSG_INVALID_NAME, mtError, [mbOK])                        //(5.1.008)
  else if UseBtn.Checked and not FileExists(Fname)
  then Uutils.MsgDlg(Fname + MSG_NOT_EXIST, mtError, [mbOK])                   //(5.1.008)
  else ModalResult := mrOK;
end;

procedure TIfaceFileForm.FileTypeComboChange(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnChange handler for the FileTypeCombo box.
//-----------------------------------------------------------------------------
begin
  with FileTypeCombo do
  begin
    // INFLOWS type of interface file chosen --
    // can only USE this type of file
    if ItemIndex = 4 then
    begin
       UseBtn.Checked := True;
       UseBtn.Enabled := False;
       SaveBtn.Enabled := False;
    end

    // OUTFLOWS type of interface file chosen --
    // can only SAVE this type of file
    else if (ItemIndex = 5) then
    begin
      SaveBtn.Checked := True;
      SaveBtn.Enabled := False;
      UseBtn.Enabled := False;
    end
    else
    begin
      SaveBtn.Checked := SaveStatus;
      UseBtn.Checked := not SaveStatus;
      SaveBtn.Enabled := True;
      UseBtn.Enabled := True;
    end;
  end;
end;

procedure TIfaceFileForm.FormKeyPress(Sender: TObject; var Key: Char);
//-----------------------------------------------------------------------------
//  Form's OnKeyPress handler. The "Enter" key behaves the same
//  as the OK button.
//-----------------------------------------------------------------------------
begin
  if Key = #13 then
  begin
    Key:= #0;
    OkBtnClick(Sender);
  end;
end;

procedure TIfaceFileForm.FileNameEditChange(Sender: TObject);
//-----------------------------------------------------------------------------
//  OnChange handler for the FileNameEdit box.
//-----------------------------------------------------------------------------
begin
  FileNameEdit.Hint := FileNameEdit.Text;
end;

procedure TIfaceFileForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT, 212540);
end;

end.
