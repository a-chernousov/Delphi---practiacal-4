unit UTree;
interface

const
  MinElem = 1;
  MaxElem = 100;
type
  TElem = MinElem .. MaxElem;
  TPtr = ^TNode;
  TNode = record
    inf : TElem;
    left, right : TPtr;
  end;
  TTree = TPtr;

  procedure Init (var Root : TTree);
  function IsEmpty (Root : TTree): boolean;
  procedure Input (var Root : TTree);
  procedure Print (Root : TTree);
  procedure GenerateOrder (var Root : TTree; N : integer);
  procedure GenerateRandom (var Root : TTree; N : integer);
  procedure AddOrder_R (var Root : TTree; el : TElem);
  procedure AddRandom_R (var Root : TTree; el : TElem);
  function SearchInOrder_R (Root : TTree; el : TElem): boolean;
  function SearchInOrder_I (Root : TTree; el : TElem): boolean;
  function SearchInRandom_R (Root : TTree; el : TElem): boolean;
  function DeleteElem (var Root : TTree; el : TElem): boolean;
  procedure Clear (var Root : TTree);
  function MidValue_R (Root : TTree; var mid_val : real) : boolean;
  function MidValue_I (Root : TTree; var mid_val : real) : boolean;

implementation
uses
  UStack;

procedure Init (var Root : TTree);
begin
 Root:=nil;
end;

function IsEmpty (Root : TTree): boolean;
begin
  Result:=Root=nil
end;

function NewNode (el : TElem) : TPtr;
begin
  new(Result);
  Result^.inf:=el;
  Result^.left:=nil;
  Result^.right:=nil;
end;

procedure AddOrder_R (var Root : TTree; el : TElem);
begin
  if Root = nil then
    Root:=NewNode(el)
  else
    if el < Root^.inf then
      AddOrder_R (Root^.left, el)
    else
      AddOrder_R (Root^.right, el)
end;

procedure AddRandom_R (var Root : TTree; el : TElem);
begin
  if Root = nil then
    Root:=NewNode(el)
  else
    if Random(2)=0 then
      AddRandom_R (Root^.left, el)
    else
      AddRandom_R (Root^.right, el)
end; 

procedure Input (var Root : TTree);
var
  el : TElem;
begin
  Clear(Root);
  writeln('Vvedite posledovatelnost (konec vvoda - 0)');
  read(el);
   while (el<>0) do
    begin
      AddOrder_R(Root, el);
      read(el)
    end;
  readln;
end; 

procedure Print_Help (t : TPtr; h: integer);
var
  i : integer;
begin
  if t<> nil then
    begin
      Print_Help(t^.left, h+1);
      for i:=1 to h do
        write('  ');
      writeln(t^.inf);
      Print_Help(t^.right, h+1);
    end;
end;

procedure Print (Root : TTree);
begin
  if Root = nil then
    writeln('?????? ?????')
  else
    Print_Help(Root, 0);
end;

function RandomElem : TElem;
begin
  Result:=MinElem+Random(MaxElem-MinElem);
end;

procedure GenerateOrder (var Root : TTree; N : integer);
var
  i : integer;
begin
  Clear(Root);
  for i:=1 to N do
    AddOrder_R(Root, RandomElem)
end;

procedure GenerateRandom_Help (var t : TTree; N : integer);
var
  nL : integer;
begin
 if N<=0 then
    t:=nil
  else
    begin
      t:=NewNode(RandomElem);
      N:=N-1;
      nL:=Random(N);
      GenerateRandom_Help (t^.left, nL);
      GenerateRandom_Help (t^.right, N-nL);
    end;
end;

procedure GenerateRandom (var Root : TTree; N : integer);
begin
  Clear(Root);
  if n>0 then
    GenerateRandom_Help (Root, N)
end;

function SearchInOrder_R (Root : TTree; el : TElem): boolean;
begin
  if Root = nil then
    Result:=false
  else
    if el = Root^.inf then
      Result:=true
    else
      if el < Root^.inf then
        Result := SearchInOrder_R(Root^.left, el)
      else
        Result := SearchInOrder_R(Root^.right, el)
end;

function SearchInOrder_I (Root : TTree; el : TElem): boolean;
var
  t : TPtr;
begin
  t:=Root;
  Result:=false;
  while (t<>nil) and not Result do
    if el = t^.inf then
      Result:=true
    else
      if el < t^.inf then
        t:=t^.left
      else
        t:=t^.right;
end;

function SearchInRandom_R (Root : TTree; el : TElem): boolean;
begin
  Result:=(Root <> nil) and
          ((Root^.inf = el) or
           SearchInRandom_R(Root^.left, el) or
           SearchInRandom_R(Root^.right, el))
end;

function DeleteElem (var Root : TTree; el : TElem): boolean;
var q : TPtr;
  procedure Del (var r : TPtr);
  begin
    if r^.right<>nil then
      Del(r^.right)
    else
      begin
        q^.inf:=r^.inf;
        q:=r;
        r:=r^.left;
      end;
  end;
begin
  Result:=false;
  if Root <> nil then
    if el<Root^.inf then
      DeleteElem(Root^.left, el)
    else
      if el>Root^.inf then
        DeleteElem(Root^.right, el)
      else
        begin
          Result:=true;
          q:=Root;
          if q^.right = nil then
            Root:=q^.left
          else
            if q^.left = nil then
              Root:=q^.right
            else
              Del(Root^.left);
          dispose(q)
        end;
end;

procedure Clear (var Root : TTree);
begin
  if Root<>nil then
    begin
      Clear(Root^.left);
      Clear(Root^.right);
      dispose(Root);
      Root:=nil
    end;
end;

procedure MidValue_Help (t : TPtr; var Sum : integer; var Cnt :integer);
begin
  if t<>nil then
    begin
      Sum:=Sum+t^.inf;
      inc(Cnt);
      MidValue_Help(t^.left, Sum, Cnt);
      MidValue_Help(t^.right, Sum, Cnt);
    end;
end;

function MidValue_R (Root : TTree; var mid_val : real) : boolean;
var
  Summa : integer;
  count : integer;
begin
  if Root = nil then
    Result:=false
  else
    begin
      Result:=true;
      Summa:=0;
      Count:=0;
      MidValue_Help(Root, Summa, Count);
      mid_val:=Summa/Count
    end;
end;

function MidValue_I (Root : TTree; var mid_val : real) : boolean;
var
  S : TStack;
  t : TPtr;
  Summa : integer;
  count : integer;
begin
  Result:=not IsEmpty(Root);
  if Result then
    begin
      UStack.init(s);
      Summa:=0;
      count:=0;
      UStack.Push(s, Root);
      while not UStack.IsEmpty(s) do
        begin
          t := UStack.Pop(s);
          Summa:=Summa+t^.inf;
          count:=count+1;
          if t^.left<>nil then
            UStack.Push(s, t^.left);
          if t^.right<>nil then
            UStack.Push(s, t^.right);
        end;
      mid_val:=Summa/count;
    end;
end;

end.


