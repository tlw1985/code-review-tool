unit MessageHolder;

interface

 type
   TMessageHolder = class
  Private
   FMessage: string;
   FLineNumber: Integer;
   FFileName: string;

  Public
    property LineNumber: Integer read FLineNumber write FLineNumber;
    property Messages: string read FMessage write FMessage;
    property FileName: String read FFileName write FFileName;
  end;

implementation

end.
 