program pingg;

{$APPTYPE CONSOLE}

uses
  Windows, Messages, SysUtils, Classes;


function GetConOutputHandle : THandle;
begin
  Result := GetStdHandle(STD_OUTPUT_HANDLE)
end;

function GetFullCommandLine() : string;
var
  i : word;
  BS : string;
begin
  BS := '';
  Result := '';
  if ParamCount <= 0 then
    begin
      Exit;
    end;
  for i := 1 to ParamCount do
    begin
      BS := BS + ParamStr(i)+' ';
    end;
  result := BS;
end;

function ExecAndGetConsoleOutput(Commande : String) : Boolean;
var
  StartInfo   : TStartupInfo;
  ProcessInfo : TProcessInformation;
  Fin         : Boolean;
  Sa          : TSecurityAttributes;
begin
  Result := False;
  FillChar (Sa, SizeOf(Sa), #0);
  Sa.nLength := SizeOf (Sa);
  Sa.lpSecurityDescriptor := Nil;
  Sa.bInheritHandle := TRUE;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb := SizeOf(StartInfo);
  StartInfo.dwFlags := STARTF_USESTDHANDLES Or STARTF_USESHOWWINDOW;
  StartInfo.hStdOutput := GetConOutputHandle;
  StartInfo.wShowWindow := SW_HIDE;

  if CreateProcess(Nil, PChar(Commande), Nil, Nil, True, 0, Nil, Nil, StartInfo, ProcessInfo) then
  begin
    Fin:=False;
    repeat
      case WaitForSingleObject(ProcessInfo.hProcess, 200) of
        WAIT_OBJECT_0 :Fin:=True;
        WAIT_TIMEOUT  :;
      End;
    until Fin;
    Result:=True;
  end
  else 
    RaiseLastOSError;

End;

var
  BS : string;

begin
  try
    BS := GetFullCommandLine();
    if BS = '' then
      begin
        Writeln('Usage : pingg x.x [original ping params]');
        Writeln('Will execute ping 192.168.x.x [params]');
        Writeln('A simple program from FZWTE (http://fzwte.net)');        
      end
    else
      begin
        ExecAndGetConsoleOutput('ping 192.168.'+BS);
      end;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
