unit CodeMessages;

interface

uses
  ToolsAPi, BaseDockFrm, SysUtils, MessagesSingleton, graphics;

  type
    TCodeMessages = class
     private
       fSource: IOTASourceEditor;
       FMess: TMessagesSingleton;
       function GetSource(Module: IOTAMOdule): IOTASourceEditor;
       function GetGraphic: TGraphic;
     public
       procedure AddMessagesToList(AMessageToAdd: String);
       function ViewMessage: String;
       Destructor Destroy; Override;
     end;

implementation

uses
  MessageHolder, Dialogs, classes, controls;

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
      LoadFromFile('C:\Users\tim\Desktop\cross.bmp');
    //  Transparent := True;
     // TransParentColor := BitMap.canvas.pixels[50,50];
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
  Module: IOTAModule;
  MS: IOTAModuleServices;
  EditPos: TOTAEditPos;

  EditorServices: IOTAEditorServices;
  Buffer: IOTAEditBuffer;
  Position: IOTAEditPosition;
  a : IOTAEditOptions;
  graphic: TGraphic;
  list :Tlist;
  Control: TWinControl;
  i : integer;
begin

  if not Supports(BorlandIDEServices, IOTAEditorServices, EditorServices) then
    Exit;

  Buffer := EditorServices.TopBuffer;

  MS := BorlandIDEServices As IOTAModuleServices;
  Module := MS.CurrentModule;
  
  if not assigned(FSource) then
  begin
    FSource := GetSource(Module);
  end;

  EditPos := FSource.EditViews[0].CursorPos;

  if not Assigned(Buffer) then
    Exit;

  Position := Buffer.EditPosition;
  a := Buffer.EditOptions;

  graphic := GetGraphic;
 // Buffer.TopView.GetEditWindow.Form.ActiveControl.
//  Buffer.TopView.GetEditWindow.Form.ActiveControl.Controls
//  list := TList.Create;

 { for i :=0 to  .ControlCount-1 do
  begin
   // control := list[1];
    showmessage(Buffer.TopView.GetEditWindow.Form.ActiveControl.Controls[i].Name + ' index = ' + IntToStr(i));
    control.Hide;
  end;
 control.Hide;  }

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

end.

 