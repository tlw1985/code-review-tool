unit MessagesSingleton;

interface

 uses
  Classes, MessageHolder;

  type
   TMessagesSingleton = class

   private
    fListOfMessages: TList;
   public
     property ListOfMessages: TList read FListOfMessages;
     procedure AddMessages(aMessageToAdd: TMessageHolder);
     Destructor Destroy; Override;
   end;


implementation

Destructor  TMessagesSingleton.Destroy;
begin
  fListOfMessages.Clear;
  fListOfMessages.Free;
  fListOfMessages := nil;
  inherited;
end;

procedure TMessagesSingleton.AddMessages(aMessageToAdd: TMessageHolder);
begin

  if not Assigned(fListOfMessages) then
  begin
    fListOfMessages := TList.Create;
  end;

  fListOfMessages.Add(aMessageToAdd);
end;

end.
 