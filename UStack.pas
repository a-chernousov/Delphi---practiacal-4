unit UStack;

interface
  uses
    UTree;
    
  type
  TTElem = TPtr;
  TTPtr = ^TTNode;
  TTNode = record
    inf : TTElem;
    next : TTPtr;
  end;
  TStack = TTPtr;

   procedure Init (var S : TStack);                         //init!
   procedure Push (var S : TStack; el : TTElem);             //Vstavit v stack
   function TryPush (var S : TStack; el : TTElem) : boolean; //Dostat iz stack
   function Pop (var S : TStack) : TTElem;
   function IsEmpty (var S : TStack) : boolean;
   function TryPop (var S : TStack; var el : TTElem) : boolean;
   function Peek(var stack : TStack): TTElem;                 //Prosmotr verxnego elem


implementation
uses SysUtils;

procedure Init (var S : TStack);
begin
  S:=nil;
end;

function IsEmpty (var S : TStack) : boolean;
begin
  Result:=(S = nil);
end;

function TryPop (var S : TStack; var el : TTElem) : boolean;
var
  z : TTPtr;
begin
  Result:=S<>nil;
  if Result then
    begin
      z:=S;
      el:=z^.inf;
      S:=z^.next;
      dispose(z);
    end;
end;
function TryPush (var S : TStack; el : TTElem) : boolean;
var
  z : TTPtr;
begin
  Result:=true;
  try
    new(z);
    z^.inf:=el;
    z^.next:=S;
    S:=z;
  except
    Result:=false;
  end;
end;

procedure Push (var S : TStack; el : TTElem);
begin
  if not TryPush(S, el) then
    raise Exception.Create('Error');
end;

function Pop (var S : TStack) : TTElem;
begin
  if not TryPop(S, Result) then
    raise Exception.Create('errro');
end;

function Peek(var stack : TStack): TTElem;
var
  topElement: TTElem;
begin
  if IsEmpty(stack) then
    raise Exception.Create('error!!!')
  else
  begin
    topElement := Pop(stack);
    Push(stack, topElement);
    Result := topElement;
  end;
end;

end.

