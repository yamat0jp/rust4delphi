program rust4delphi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Threading,
  System.Classes,
  System.Generics.Collections,
  helper in 'helper.pas';

procedure main2; // sample code
var
  task: ITask;
begin
  task := TTask.Run(
    procedure
    begin
      Writeln(TMyPureObject.something);
    end);
end;

function findFirst(params: TArray<string>): string;
begin
  result:='no object';
  for var s in params do
    if s <> '' then
      result:=s;
end;

procedure youtube;
var
  tasks: array of ITask;
  params: TArray<string>;
begin
  params := ['Brad', 'Kate', 'Kim', 'Jack', 'Joe'];
  SetLength(tasks, 3);
  tasks[0] := TTask.Run(
    procedure
    begin
      params := TMyPureObject.filter(params, 'K');
    end);
  tasks[1] := TTask.Run(
    procedure
    begin
      params := TMyPureObject.filter(params, 3);
    end);
  tasks[2] := TTask.Run(
    procedure
    begin
      params := TMyPureObject.upperCase(params);
    end);
  TTask.WaitForAll(tasks);
  Finalize(tasks);
  Writeln(findFirst(params));
end;

begin
  try
    { TODO -oUser -cConsole メイン : ここにコードを記述してください }
    main2;
    youtube;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
