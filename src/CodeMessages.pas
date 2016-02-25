unit CodeMessages;

interface

uses
  ToolsAPi,
  BaseDockFrm,
  SysUtils,
  MessagesSingleton,
  graphics,
  forms,
  controls;

  type
    TCodeMessages = class
     private
       fSource: IOTASourceEditor;
       FMess: TMessagesSingleton;
       fMessageLocation: integer;
       fModule: IOTAModule;
       function GetSource(Module: IOTAMOdule): IOTASourceEditor;
     public
       procedure AddMessagesToList(AMessageToAdd: String);
       function ViewMessage: String;
       Constructor Create;
       Destructor Destroy; Override;
       function GetGraphic: TGraphic;
       function NextMessage: String;
       function PrevMessage: string;
    end;

implementation

uses
  MessageHolder, Dialogs, classes;

Destructor TCodeMessages.Destroy;
begin
  FMess.free;
  FMess := nil;
  inherited;
end;

function TCodeMessages.GetGraphic: TGraphic;
var
  Bitmap : TBitMap;
begin
  Bitmap := TBitmap.create;
    with Bitmap do begin
      LoadFromFile('C:\Users\tim\Desktop\DockForm Delphi 7\delphi dot.bmp');
    end;
  Result := Bitmap;
end;

function TCodeMessages.ViewMessage: String;
var
  lMessageHolder: TMessageHolder;
begin

   Result := ' No Message. ';

   if FMess = nil then
   begin
    Fmess := TMessagesSingleton.Create;
   end;

   if FMess.ListOfMessages.count > 0 then
   begin
     lMessageHolder :=  Fmess.ListOfMessages[0];
   end;

   if assigned(lMessageHolder) then
   begin
     Result := lMessageHolder.FileName + IntToStr(lMessageHolder.LineNumber);
   end;
end;

function TCodeMessages.GetSource(Module : IOTAMOdule) : IOTASourceEditor;
Var
  iFileCount : Integer;
  i : Integer;
Begin
  Result := Nil;
  If Module = Nil Then Exit;
  With Module Do
  Begin
    iFileCount := GetModuleFileCount;
    For i := 0 To iFileCount - 1 Do
    begin
      If GetModuleFileEditor(i).QueryInterface(IOTASourceEditor,
       Result) = S_OK Then
      begin
        Break;
      end;
    end;
  end;
end;

procedure TCodeMessages.AddMessagesToList(AMessageToAdd: String);
var
  lMessageContainer: TMessageHolder;
  MS: IOTAModuleServices;
  EditPos: TOTAEditPos;

  EditorServices: IOTAEditorServices;
  Canvas: TControlCanvas;
  Buffer: IOTAEditBuffer;
  Position: IOTAEditPosition;
begin

  if not Supports(BorlandIDEServices, IOTAEditorServices, EditorServices) then
    Exit;

  Buffer := EditorServices.TopBuffer;

  MS := BorlandIDEServices As IOTAModuleServices;
  fModule := MS.CurrentModule;

  if not assigned(FSource) then
  begin
    FSource := GetSource(FModule);
  end;

  EditPos := FSource.EditViews[0].CursorPos;

  if not Assigned(Buffer) then
    Exit;

  Position := Buffer.EditPosition;
  Canvas := TControlCanvas.Create;
  Canvas.Control := Buffer.TopView.GetEditWindow.Form.ActiveControl;
  Canvas.Draw(0, 0, GetGraphic);

  if not Assigned(Position) then
    Exit;

  Position.GotoLine(EditPos.Line);

  lMessageContainer := TMessageHolder.Create;

  lMessageContainer.FileName := FSource.FileName;

  EditPos := FSource.EditViews[0].CursorPos;

  lMessageContainer.LineNumber := EditPos.Line;


  lMessageContainer.Messages := AMessageToAdd;

  if FMess = nil then
  begin
    Fmess := TMessagesSingleton.Create;
  end;

  Fmess.AddMessages(lMessageContainer);
end;

function TCodeMessages.NextMessage: String;
Var
  iFileCount : Integer;
  i : Integer;
  lSource: IOTASourceEditor;
  lMessageHolder: TMessageHolder;
  EditPos: IOTAEditView;
Begin

  inc(fMessageLocation);
  If fModule = Nil Then Exit;
  With fModule Do
  Begin
    iFileCount := GetModuleFileCount;
    For i := 0 To iFileCount - 1 Do
    begin

      If GetModuleFileEditor(i).QueryInterface(IOTASourceEditor,
       lSource) = S_OK Then
      begin
        lMessageHolder := FMess.ListOfMessages[fMessageLocation];
        if lMessageHolder.FileName = lSource.FileName then
        begin
          lSource.Show;
          EditPos := lSource.EditViews[0];
          EditPos.Position.GotoLine(lMessageHolder.LineNumber);
          EditPos.MoveViewToCursor;
          EditPos.Paint;
          result := lMessageHolder.Messages + FileName + ' Line = ' + inttostr(EditPos.Buffer.GetLinesInBuffer);
        end;
        end;
      end;
    end;
  end;


constructor TCodeMessages.Create;
begin
  fMessageLocation := - 1;
end;

function TCodeMessages.PrevMessage: string;
Var
  iFileCount : Integer;
  i : Integer;
  lSource: IOTASourceEditor;
  lMessageHolder: TMessageHolder;
  EditPos: IOTAEditView;
Begin
  if not fMessageLocation = 0 then
  dec(fMessageLocation);
  
  If fModule = Nil Then Exit;
  With fModule Do
  Begin
    iFileCount := GetModuleFileCount;
    For i := 0 To iFileCount - 1 Do
    begin
      If GetModuleFileEditor(i).QueryInterface(IOTASourceEditor,
       lSource) = S_OK Then
      begin
        lMessageHolder := FMess.ListOfMessages[fMessageLocation];
        if lMessageHolder.FileName = lSource.FileName then
        begin
          EditPos := lSource.EditViews[0];
          EditPos.Position.GotoLine(lMessageHolder.LineNumber);
         result := lMessageHolder.Messages + FileName + ' Line = ' + inttostr(EditPos.Buffer.GetLinesInBuffer);
        end;
      end;
    end;
  end;

end;

end.

