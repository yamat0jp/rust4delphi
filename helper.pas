unit helper;

interface

uses System.Generics.Collections, System.Threading, System.SysUtils;

type
  TPureObject = class
  public
    class function plus(a, b: integer): integer;
    class function mul(a, b: integer): integer;
    class function minus(a, b: integer): integer;
    class function upperCase(str: string): string;
  end;

  TMyPureObject = class(TPureObject)
  private
    class function startWithN(str: string; c: Char): Boolean;
  public
    class function something: integer; virtual;
    class function filter(params: TArray<string>; c: Char): TArray<string>;
      overload; virtual;
    class function filter(params: TArray<string>; len: integer): TArray<string>;
      overload; virtual;
    class function upperCase(params: TArray<string>): TArray<string>;
      overload; virtual;
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

class function TPureObject.minus(a, b: integer): integer;
begin
  result := plus(a, -b);
end;

class function TPureObject.mul(a, b: integer): integer;
begin
  result := a * b;
end;

class function TPureObject.plus(a, b: integer): integer;
begin
  result := a + b;
end;

class function TPureObject.upperCase(str: string): string;
begin
  result := string.upperCase(str);
end;

{ TMyPureObject }

class function TMyPureObject.filter(params: TArray<string>; len: integer)
  : TArray<string>;
begin
  for var i := 0 to High(params) do
    if Length(params[i]) <> len then
      params[i] := '';
  result := params;
end;

class function TMyPureObject.filter(params: TArray<string>; c: Char)
  : TArray<string>;
begin
  for var i := 0 to High(params) do
    if not startWithN(params[i], c) then
      params[i] := '';
  result := params;
end;

class function TMyPureObject.something: integer;
begin
  result := TRustArray.sum([1, 2, 3, 4, 5]) + plus(4, 5) + mul(7, 8);
end;

class function TMyPureObject.startWithN(str: string; c: Char): Boolean;
begin
  result := (str <> '') and (str[1] = c);
end;

class function TMyPureObject.upperCase(params: TArray<string>): TArray<string>;
begin
  result := [];
  for var str in params do
    result := result + [upperCase(str)];
end;

end.
