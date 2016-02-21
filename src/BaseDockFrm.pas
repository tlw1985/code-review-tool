unit BaseDockFrm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, dialogs,
  // You must link to the DesignIde/DsnIdeXX package to compile this unit
  DockForm;

type
  TBaseDockForm = class(TDockableForm)
 public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TBaseDockFormClass = class of TBaseDockForm;

   procedure ShowDockableForm(Form: TBaseDockForm);
   procedure CreateDockableForm(var FormVar: TBaseDockForm; FormClass: TBaseDockFormClass);
   procedure FreeDockableForm(var FormVar: TBaseDockForm);

implementation

{$R *.dfm}

uses DeskUtil;

procedure ShowDockableForm(Form: TBaseDockForm);
begin
  if not Assigned(Form) then
    Exit;
  if not Form.Floating then
  begin
    Form.ForceShow;
    FocusWindow(Form);
  end
  else
    Form.Show;
end;

procedure RegisterDockableForm(FormClass: TBaseDockFormClass;
  var FormVar; const FormName: string);
begin
  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress(FormName, @FormVar);

  RegisterDesktopFormClass(FormClass, FormName, FormName);
end;

procedure UnRegisterDockableForm(var FormVar; const FormName: string);
begin
  if @UnregisterFieldAddress <> nil then
    UnregisterFieldAddress(@FormVar);
end;

procedure CreateDockableForm(var FormVar: TBaseDockForm; FormClass: TBaseDockFormClass);
begin
  TCustomForm(FormVar) := FormClass.Create(nil);
  RegisterDockableForm(FormClass, FormVar, TCustomForm(FormVar).Name);
end;

procedure FreeDockableForm(var FormVar: TBaseDockForm);
begin
  if Assigned(FormVar) then
  begin
    UnRegisterDockableForm(FormVar, FormVar.Name);
    FreeAndNil(FormVar);
  end;
end;

{ TIDEDockableForm }

constructor TBaseDockForm.Create(AOwner: TComponent);
begin
  inherited;
  DeskSection := Name;
  AutoSave := True;
  SaveStateNecessary := True;
end;

destructor TBaseDockForm.Destroy;
begin
  SaveStateNecessary := True;
  inherited;
end;

end.
