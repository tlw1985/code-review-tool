unit RegisterDockForm;

interface

uses
  ToolsAPI,
  CreateMessage,
  DesignIntf;

type
  TDockFormExpert = class(TNotifierObject, IOTANotifier, IOTAWizard, IOTAMenuWizard)
  public
    procedure Execute;
    function GetIDString: string;
    function GetMenuText: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Destroyed;
  end;

  procedure Register;

implementation

procedure Register;
begin
  RegisterPackageWizard(TDockFormExpert.Create as IOTAMenuWizard);
  TCreateMessageFrm.CreateExampleDockForm;
end;

{ TDockFormExpert }

procedure TDockFormExpert.Destroyed;
begin
  TCreateMessageFrm.RemoveExampleDockForm;
end;

procedure TDockFormExpert.Execute;
begin
  TCreateMessageFrm.ShowExampleDockForm;
end;

function TDockFormExpert.GetIDString: string;
begin
  Result := 'Code Review Tool Example';
end;

function TDockFormExpert.GetMenuText: string;
begin
  Result := 'Create Messages Form';
end;

function TDockFormExpert.GetName: string;
begin
  Result := 'Messages Form';
end;

function TDockFormExpert.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

initialization
finalization
  TCreateMessageFrm.RemoveExampleDockForm;

end.
