unit CreateMessage;

interface

uses
  Windows,
  CodeMessages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ToolsAPi,
  BaseDockFrm,
  StdCtrls,
  MessageHolder;

type
  TCreateMessageFrm = class(TBaseDockForm)
    AddMessageButton: TButton;
    AddMessage: TMemo;
    Button1: TButton;
    NextButton: TButton;
    PrevButton: TButton;
    procedure AddMessageButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NextButtonClick(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
  private
    FCodeMessages: TCodeMessages;
  public
    Destructor Destroy; override;
    class procedure RemoveExampleDockForm;
    class procedure ShowExampleDockForm;
    class procedure CreateExampleDockForm;
  end;

var
  CreateMessageFrm: TCreateMessageFrm;
  iEditorIndex: Integer;

implementation

var
  FormInstance: TBaseDockForm = nil;

{$R *.dfm}

procedure TCreateMessageFrm.AddMessageButtonClick(Sender: TObject);
begin
  if not assigned(FCodeMessages) then
  begin
    FCodeMessages := TCodeMessages.Create;
  end;

  FCodeMessages.AddMessagesToList(AddMessage.Text);
  AddMessage.Clear;
end;

class procedure TCreateMessageFrm.CreateExampleDockForm;
begin
  if not Assigned(FormInstance) then
    CreateDockableForm(FormInstance, TCreateMessageFrm);
end;

destructor TCreateMessageFrm.Destroy;
begin
  FCodeMessages.Free;
  inherited;
end;

class procedure TCreateMessageFrm.ShowExampleDockForm;
begin
  CreateExampleDockForm;
  ShowDockableForm(FormInstance);
end;

class procedure TCreateMessageFrm.RemoveExampleDockForm;
begin
  FreeDockableForm(FormInstance);
end;

procedure TCreateMessageFrm.Button1Click(Sender: TObject);
begin
  inherited;

  if not assigned(FCodeMessages) then
  begin
    FCodeMessages := TCodeMessages.Create;
  end;
  AddMessage.Clear;
  AddMessage.Text := FCodeMessages.ViewMessage;
end;

procedure TCreateMessageFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   Destroy;
end;

procedure TCreateMessageFrm.NextButtonClick(Sender: TObject);
begin
  inherited;
  AddMessage.Clear;
  AddMessage.Text := FCodeMessages.NextMessage;
end;

procedure TCreateMessageFrm.PrevButtonClick(Sender: TObject);
begin
  inherited;
  AddMessage.Clear;
  AddMessage.Text := FCodeMessages.PrevMessage;
end;

end.
