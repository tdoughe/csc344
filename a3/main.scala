object main extends App {


abstract class S
case class E(left: T, right: Option[E2]) extends S
case class E2(left: E3) extends S
case class E3(left: T, right: Option[E2]) extends S
case class T(left: F, right: Option[T2]) extends S
case class T2(left: F, right: Option[T2]) extends S
case class F(left: A, right: Option[F2])extends S
case class F2(left: Option[F2]) extends S
case class A(opt1: Option[C], opt2: Option[A2]) extends S
case class A2(left: E) extends S
case class C(content: Char) extends S


print("Enter a pattern: ")
val scanner = new java.util.Scanner(System.in);
var input :String = scanner.nextLine();
var inputIndex :Int = 0;
var candidateIndex :Int = 0;
val root: E = parseE();
println(root);
print("Enter a string to compare: ")
var candidate = scanner.nextLine()


while(candidate != "quit"){
 
  if (matchS){
  print("Match!\n")
} 
  else{
    print("Nope\n");
  }
  
  
  println("Enter a string to compare: ")
  var candidate = scanner.nextLine()
  candidateIndex = 0
  val root: E = parseE();
}


def parseS(): E= { parseE }
def parseE(): E= { E(parseT(),parseE2()) }
def parseE2(): Option[E2]= { 
  if (inputIndex < input.length && input.charAt(inputIndex) == '|') {
    inputIndex = inputIndex + 1;
    Some(E2(parseE3()));
  }
  else
    None
}
def parseE3(): E3= { E3(parseT(), parseE2()) }
def parseT(): T= { T(parseF(), parseT2()) }

def parseT2(): Option[T2]= {
  if(inputIndex < input.length){
    Some(T2(parseF(), parseT2()))
  }
  else
    None
}
def parseF(): F= { F(parseA(), parseF2()) }
def parseF2(): Option[F2] = { 
  if(inputIndex < input.length && input.charAt(inputIndex) == '?') {
    inputIndex = inputIndex + 1;
    Some(F2(parseF2()));
  }
  else
    None
}
def parseA(): A= { 
  if(inputIndex < input.length && input.charAt(inputIndex) != '(') {
    inputIndex = inputIndex + 1
    A(Some(C(input.charAt(inputIndex-1))),None);
  }
  else {
    inputIndex = inputIndex + 1;
    (A(None, Some(A2(parseE))));
  }
}
def parseA2(): A2= {
  val temp: A2 = A2(parseE());
  inputIndex = inputIndex + 1;
  temp;
}

def parseC(): C= {
  val temp: C = C(input.charAt(inputIndex));
  inputIndex = inputIndex + 1;
  temp;
}





def matchS(): Boolean = { matchE(root) && candidateIndex == candidate.length }
def matchE(CaseE :E): Boolean = { matchT(CaseE.left) && matchE2(CaseE.right) }
def matchE2(e: Option[E2]) = e match {
  case Some(s) => if(candidate.charAt(candidateIndex) == '|'){
    val tempIndex :Int = candidateIndex;
    candidateIndex = candidateIndex + 1;
    matchE3(s.left)
  }
  else
    false;
  case None => true;
}
def matchE3(CaseE3 :E3): Boolean = { matchT(CaseE3.left) && matchE2(CaseE3.right) }
def matchT(CaseT : T): Boolean = { matchF(CaseT.left) && matchT2(CaseT.right) }
def matchT2(t: Option[T2]): Boolean = t match {
  case Some(s) => matchF(s.left) && matchT2(s.right)
  case None => true;
}
def matchF(CaseF: F): Boolean =  { matchA(CaseF.left) && matchF2(CaseF.right) }
def matchF2(f: Option[F2]):Boolean = f match  {
   case Some(s) =>  if ((candidate.charAt(candidateIndex) == '?')){
     candidateIndex = candidateIndex + 1;
     matchF2(s.left)
   }
   else 
     false;
   case None => true;
}
def matchA(CaseA :A):Boolean = {
  if (candidate.charAt(candidateIndex) == '('){
    candidateIndex = candidateIndex + 1;
    matchA2(CaseA.opt2.get)
  }else
    matchC(CaseA.opt1.get)
  
}
def matchA2(CaseA2 :A2): Boolean = { 
  if (candidate.charAt(candidateIndex) == ')'){
  val tempbool :Boolean = matchE(CaseA2.left);
  candidateIndex = candidateIndex + 1;
  tempbool;
  }
  else 
    false;
}


def matchC(CaseC : C): Boolean = {
  if ( CaseC.content == candidate.charAt(candidateIndex)){
    candidateIndex = candidateIndex + 1;
    
    true;
  }
  else
    false;
  
}

}
