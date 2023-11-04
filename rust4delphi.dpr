program rust4delphi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Threading,
  System.Classes,
  System.Generics.Collections,
  helper in 'helper.pas';

procedure main; // practice or demonstration
var
  task: ITask;
  future: IFuture<integer>;
  tasks: array of ITask;
  cnt: integer;
begin
  cnt := 0;
  task := TTask.Run(
    procedure
    begin
      inc(cnt, TRustArray.sum([3, 2, 5, 7]));
    end);
  future := TTask.future<integer>(
    function: integer
    begin
      result := TRustArray.sum([10, 3, 2, 5]);
    end);
  SetLength(tasks, 2);
  tasks[0] := TTask.Run(
    procedure
    begin
      Writeln(TPureObject.plus(10, 11));
    end);
  tasks[1] := TTask.Run(
    procedure
    begin
      Writeln(TPureObject.mul(7, 9));
    end);
  TTask.WaitForAll(tasks);
  Finalize(tasks);
  task.Wait;
  inc(cnt, future.Value);
  Writeln(cnt);
  Readln;
end;

procedure main2; // sample code
var
  task: ITask;
begin
  task := TTask.Run(
    procedure
    begin
      Writeln(TMyPureObject.something);
    end);
  Readln;
end;

begin
  try
    { TODO -oUser -cConsole メイン : ここにコードを記述してください }
    main;
    main2;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
