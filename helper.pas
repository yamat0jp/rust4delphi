unit helper;

interface

uses System.Generics.Collections, System.Threading;

type
  TPureObject = class
  public
    class function plus(a, b: integer): integer;
    class function mul(a, b: integer): integer;
  end;

  TMyPureObject = class(TPureObject)
  public
    class function something: integer; virtual;
  end;

  TRustArray = class(TArray)
  public
    class function sum(params: array of integer): integer;
  end;

implementation

{ TRustArray }

class function TRustArray.sum(params: array of integer): integer;
begin
  result := 0;
  for var int in params do
    inc(result, int);
end;

{ TPureObject }

class function TPureObject.mul(a, b: integer): integer;
begin
  result := a * b;
end;

class function TPureObject.plus(a, b: integer): integer;
begin
  result := a + b;
end;

{ TMyPureObject }

class function TMyPureObject.something: integer;
begin
  result := TRustArray.sum([1, 2, 3, 4, 5]) + plus(4, 5) + mul(7, 8);
end;

end.
