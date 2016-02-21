unit CreateMessage;

interface

uses
  Windows, CodeMessages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolsAPi, BaseDockFrm, StdCtrls,  MessageHolder;

type
  TCreateMessageFrm = class(TBaseDockForm)
    AddMessageButton: TButton;
    AddMessage: TMemo;
    Button1: TButton;
    procedure AddMessageButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

  AddMessage.Text := FCodeMessages.ViewMessage;
end;

procedure TCreateMessageFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   Destroy;
end;

end.