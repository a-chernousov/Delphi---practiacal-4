program main;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  UTree in 'UTree.pas';
  //UStack in 'UStack.pas';

var
  t : TTree;

begin
  init(t);
  input(t);
  print(t);
end.
