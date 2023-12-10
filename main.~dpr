program main;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows,
  math,
  UTree in 'UTree.pas';
  
{ Opisat' protseduru, kotoraya dlya zadannogo N stroit sleduyushcheye derevo
vid: kornem yavlyayetsya uzlom, informatsionnaya chast' kotorogo ravna N; tvaro
uroven' soderzhit uzly so znacheniyami N-1 i N-2; tretiy uroven' – N-3, N-4,
N-5, N-6; i t.d. Posledniy uroven' mozhet byt' nepolnym, on soderzhit uzel
s konechnym znacheniyem – 1.}
procedure CreateTree(n : Telem; var t : TTree);
begin
  if n >= 1  then
    begin
      new(t);
      t.inf := n;
      CreateTree(n-1, t.left);
      CreateTree(n-2, t.right);
    end;
end;

{Posmotrite, yavlyayetsya li zadannoye dvoynoye derevo-sbalansirovannym.}

function Height(Tree: TTree): Integer;
var
  leftHeight, rightHeight: Integer;
begin
  if Tree = nil then
    Result := -1
  else
  begin
    leftHeight := Height(Tree.left);
    rightHeight := Height(Tree.right);
    Result := 1 + Max(leftHeight, rightHeight);
  end;
end;

function IsBalanced(Tree: TTree): Boolean;
var
  leftHeight, rightHeight: Integer;
begin
  if Tree = nil then
    Result := True
  else
  begin
    leftHeight := Height(Tree.left);
    rightHeight := Height(Tree.right);
    Result := Abs(leftHeight - rightHeight) <= 1;
  end;
end;

var
  t : TTree;
  flag : boolean;
begin
  setconsoleCP(1251);
  setconsoleoutputCP(1251);
  init(t);
  Input(t);
  if IsBalanced(t) then
    writeln('Derevo sbalansirovano!')
  else
    writeln('Derevo ne sbalansirovano');
  print(t);
  //CreateTree(5, t);
  //print(t);
  readln;
end.
