Program PolishNotation;
{I.S.: User memasukkan notasi infix}
{I.F.: Menghasilkan notasi postfix yang sudah diberi nilai dan dihitung}

Uses Crt;

Type
	Point = ^Data;
	Data = Record
		Character: String;
		Number: Real;
		Next: Point;
	End;

	PointPostfix = ^DataPostfix;
	DataPostfix = Record
		TOperator: String;
		TOperand: Real;
		Next: PointPostfix;
	End;

Function Validation(Infix: String): Boolean;
{I.S.: Var. Infix sudah terdefinisikan}
{I.F.: Menghasilkan hasil benar/true jika validasi berhasil}

Var
	i, Wrong, FoundOperator, FoundDoubleOperand, FoundDoubleOperator: Integer;

Begin
	Wrong := 0;
	FoundOperator := 0;
	FoundDoubleOperand := 0;
	FoundDoubleOperator := 0;
	For i := 1 To Length(Infix) Do
	Begin
		Case Infix[i] Of
			'(', ')' : FoundOperator := FoundOperator + 1;
			'+', '-', 
			'*', '/', 
			'^'       : Begin
							FoundOperator := FoundOperator + 1;
							Case Infix[i + 1] Of
								'+', '-', 
								'*', '/', 
								'^'       : FoundDoubleOperator := FoundDoubleOperator + 1;
							End;
						End;
			'B', 'C', 
			'D', 'E', 
			'F', 'G', 
			'H', 'I', 
			'J', 'K', 
			'L', 'M', 
			'N', 'O', 
			'P', 'Q', 
			'R', 'S', 
			'T', 'U', 
			'V', 'W', 
			'X', 'Y', 
			'Z', 'A' : Begin
							Case Infix[i + 1] Of
								'B', 'C', 
								'D', 'E', 
								'F', 'G', 
								'H', 'I', 
								'J', 'K', 
								'L', 'M', 
								'N', 'O', 
								'P', 'Q', 
								'R', 'S', 
								'T', 'U', 
								'V', 'W', 
								'X', 'Y', 
								'Z', 'A' : FoundDoubleOperand := FoundDoubleOperand + 1;
							End;
					   End;
			Else
				Wrong := Wrong + 1;
		End;
	End;
	Validation := True;
	If (Wrong > 0) Or (FoundOperator < 5) Or (FoundDoubleOperand > 0) Or (FoundDoubleOperator > 0) Then
		Validation := False;
End;

Function IsEmpty(Stack: Point): Boolean;
{I.S.: Var. Stack sudah terdefinisikan}
{I.F.: Menghasilkan hasil benar/true jika Stack bernilai Nil/Null}

Begin
	IsEmpty := False;
	If (Stack = Nil) Then
		IsEmpty := True;
End;

Function OneNode(Stack: Point): Boolean;
{I.S.: Var. Stack sudah terdefinisikan}
{I.F.: Menghasilkan hasil benar/true jika simpul setelah Stack bernilai Nil/Null}

Begin
	OneNode := False;
	If (Stack^.Next = Nil) Then
		OneNode := True;
End;

Procedure Initialize(Var Stack: Point);
{I.S.: Var. Stack sudah terdefinisikan}
{I.F.: Memberi nilai Nil/Null pada Stack}

Begin
	Stack := Nil;
End;

Procedure InitializePostfix(Var First, Last: PointPostfix);
{I.S.: Var. First dan Last sudah terdefinisikan}
{I.F.: Memberi nilai Nil/Null pada First dan Last}

Begin
	First := Nil;
	Last := Nil;
End;

Procedure Push(Var Stack: Point; Elemen: String);
{I.S.: Var. Stack dan Elemen sudah terdefinisikan}
{I.F.: Menambahkan Elemen ke Stack}

Var
	Node: Point;

Begin
	New(Node);
	Node^.Character := Elemen;
	Node^.Next := Stack;
	Stack := Node;
End;

Procedure PushNumber(Var Stack: Point; Elemen: Real);
{I.S.: Var. Stack dan Elemen sudah terdefinisikan}
{I.F.: Menambahkan Elemen ke Stack}

Var
	Node: Point;

Begin
	New(Node);
	Node^.Number := Elemen;
	Node^.Next := Stack;
	Stack := Node;
End;

Procedure Pop(Var Stack: Point; Var Elemen: String);
{I.S.: Var. Stack dan Elemen sudah terdefinisikan}
{I.F.: Menghapus satu simpul dari Stack dan menyimpannya di Elemen}

Var
	Node: Point;

Begin
	Node := Stack;
	Elemen := Node^.Character;
	If (Not OneNode(Stack)) Then
	Begin
		Stack := Stack^.Next;
	End
	Else
	Begin
		Stack := Nil;
	End;
	Dispose(Node);
End;

Procedure PopNumber(Var Stack: Point; Var Elemen: Real);
{I.S.: Var. Stack dan Elemen sudah terdefinisikan}
{I.F.: Menghapus satu simpul dari Stack dan menyimpannya di Elemen}

Var
	Node: Point;

Begin
	Node := Stack;
	Elemen := Node^.Number;
	If (Not OneNode(Stack)) Then
	Begin
		Stack := Stack^.Next;
	End
	Else
	Begin
		Stack := Nil;
	End;
	Dispose(Node);
End;

Procedure AddNodeInLast(Var FirstList, LastList: PointPostfix; TOperator: String; TOperand: Real);
{I.S.: Var. FirstList, LastList, TOperator dan TOperand sudah terdefinisikan}
{I.F.: Menyisipkan TOperator dan TOperand di akhir dari simpul FirstList dan LastList}

Var
	Node: PointPostfix;

Begin
	New(Node);
	Node^.TOperand := TOperand;
	Node^.TOperator := TOperator;
	If (FirstList = Nil) Then
	Begin
		FirstList := Node;
	End
	Else
	Begin
		LastList^.Next := Node;
	End;
	LastList := Node;
End;

Procedure ConvertInfixToPostfix(Infix: String; Var Postfix: String);
{I.S.: Var. Infix dan Postfix sudah terdefinisikan}
{I.F.: Mengubah notasi infix ke notasi postfix yang tersimpan di Var. Infix dan menyimpannya ke Var. Postfix}

Var
	i: Integer;
	Stack: Point;
	LastCharacter: String;
	P: String;

Begin
	Initialize(Stack);
	Push(Stack, '(');
	Infix := Infix + ')';
	P := '';
	WriteLn('Q : ',Infix);
	For i := 1 To Length(Infix) Do
	Begin
		Case Infix[i] Of
			'B', 'C', 
			'D', 'E', 
			'F', 'G', 
			'H', 'I', 
			'J', 'K', 
			'L', 'M', 
			'N', 'O', 
			'P', 'Q', 
			'R', 'S', 
			'T', 'U', 
			'V', 'W', 
			'X', 'Y', 
			'Z', 'A' : P := P + Infix[i];							{ OPERAND KETEMU }
			'('      : Push(Stack, Infix[i]);						{ KURUNG BUKA KETEMU }
			'+', '-', 
			'*', '/', 
			'^'       : Begin 										{ OPERATOR KETEMU }
							Case Infix[i] Of
								'^': Push(Stack, Infix[i]);
								'*',
								'/': Begin
										While (Stack^.Character <> '(')	Do
										Begin
											Case Stack^.Character Of
												'^',
												'*',
												'/' : Begin
														Pop(Stack, LastCharacter);
														P := P + LastCharacter;
													  End;
											End;
										End;
										Push(Stack, Infix[i]);
									 End;
								'+',
								'-': Begin
										While (Stack^.Character <> '(')	Do
										Begin
											Case Stack^.Character Of
												'^', '*',
												'/', '+',
												'-' 	: Begin
															Pop(Stack, LastCharacter);
															P := P + LastCharacter;
														  End;
											End;
										End;
										Push(Stack, Infix[i]);
									 End;
							End;
						End;
			')' : Begin
					While (Stack^.Character <> '(')	Do
					Begin
						Pop(Stack, LastCharacter);
						P := P + LastCharacter;
					End;
					If (i <> Length(Infix)) Then
						Pop(Stack, LastCharacter);
				  End;
		End;
	End;
	Postfix := P;
end;

Procedure InputInfix(Var Infix: String);
{I.S.: Var. Infix sudah terdefinisikan}
{I.F.: Menyimpan notasi infix ke Var. Infix}

Begin
	Repeat
		Write('Masukkan notasi infix : ');
		ReadLn(Infix);
	Until Validation(Infix);
End;

Procedure ConvertAlphabeticToNumeric(Postfix: String; Var ExpressionPFirst, ExpressionPLast: PointPostfix);
{I.S.: Var. Postfix, ExpressionPFirst dan ExpressionPLast sudah terdefinisikan}
{I.F.: Mengubah setiap huruf menjadi angka pada notasi postfix}

Var
	x: Real;
	i: Integer;

Begin
	For i := 1 To Length(Postfix) Do
	Begin
		Case Postfix[i] Of
			'B', 'C', 
			'D', 'E', 
			'F', 'G', 
			'H', 'I', 
			'J', 'K', 
			'L', 'M', 
			'N', 'O', 
			'P', 'Q', 
			'R', 'S', 
			'T', 'U', 
			'V', 'W', 
			'X', 'Y', 
			'Z', 'A' : Begin
						Write('Masukkan angka untuk ', Postfix[i], ' : ');
						ReadLn(x);
						AddNodeInLast(ExpressionPFirst, ExpressionPLast, '', x);
					   End;
			Else
				AddNodeInLast(ExpressionPFirst, ExpressionPLast, Postfix[i], 0);
		End;
	End;
End;

Procedure Calculate(PostfixFirst, PostfixLast: PointPostfix; Var Result: Real);
{I.S.: Var. PostfixFirst, PostfixLast dan Result sudah terdefinisikan}
{I.F.: Menghitung hasil dari notasi postfix}

Var
	Stack: Point;
	Operand1, Operand2, Total: Real;
	Transversal: PointPostfix;
	
Begin
	Initialize(Stack);
	AddNodeInLast(PostfixFirst, PostfixLast, ')', 0);
	Transversal := PostfixFirst;
	While (Transversal^.TOperator <> ')') Do
	Begin
		If 	(Transversal^.TOperator = '-') Then
		Begin
			PopNumber(Stack, Operand2);
			PopNumber(Stack, Operand1);
			Total := Operand1 - Operand2;
			PushNumber(Stack, Total);
		End
		Else If (Transversal^.TOperator = '+') Then
		Begin
			PopNumber(Stack, Operand2);
			PopNumber(Stack, Operand1);
			Total := Operand1 + Operand2;
			PushNumber(Stack, Total);
		End
		Else If (Transversal^.TOperator = '/') Then
		Begin
			PopNumber(Stack, Operand2);
			PopNumber(Stack, Operand1);
			Total := Operand1 / Operand2;
			PushNumber(Stack, Total);
		End
		Else If (Transversal^.TOperator = '*') Then
		Begin
			PopNumber(Stack, Operand2);
			PopNumber(Stack, Operand1);
			Total := Operand1 * Operand2;
			PushNumber(Stack, Total);
		End
		Else If (Transversal^.TOperator = '^') Then
		Begin
			PopNumber(Stack, Operand2);
			PopNumber(Stack, Operand1);
			Total := Exp(Operand2*Ln(Operand1)); 
			{Fungsi exponen diatas ada pada pascal, silakan gunakan cara lain jika menggunakan bahasa pemrograman lain}
			PushNumber(Stack, Total);
		End
		else
		Begin
			PushNumber(Stack, Transversal^.TOperand);
		End;
		Transversal := Transversal^.Next;
	End;
	PopNumber(Stack, Result);
End;

Procedure ShowPostfixNumeric(PostfixFirst: PointPostfix);
{I.S.: Var. PostfixFirst sudah terdefinisikan}
{I.F.: Menampilkan setiap isi dari Var. PostfixFirst}

Var
	Transversal: PointPostfix;

Begin
	Write('P (Dengan format angka) : ');
	Transversal := PostfixFirst;
	While (Transversal <> nil) Do
	Begin
		If 	(Transversal^.TOperator = '-') Or
			(Transversal^.TOperator = '+') Or
			(Transversal^.TOperator = '/') Or
			(Transversal^.TOperator = '*') Or
			(Transversal^.TOperator = '^') Then
		 	Write(Transversal^.TOperator)
		Else
			Write(Transversal^.TOperand:0:0);
		If (Transversal^.Next <> Nil) Then
			Write(', ');
		Transversal := Transversal^.Next;
	End;
	WriteLn;
End;

Procedure InputAndConvertInfix(Var Infix, Postfix: String);
{I.S.: Var. Infix dan Postfix sudah terdefinisikan}
{I.F.: Memasukkan notasi infix dan mengubahnya menjadi notasi postfix}

Begin
	InputInfix(Infix);
	ConvertInfixToPostfix(Infix, Postfix);
	WriteLn('P : ', Postfix);
End;

Procedure ConvertAndCalculate(Postfix: String);
{I.S.: Var. Postfix sudah terdefinisikan}
{I.F.: Mengubah menjadi angka dari setiap huruf di Var. Postfix dan menjumlahkannya sesuai dengan operator yang ada}

Var
	PostfixFirst, PostfixLast: PointPostfix;
	Total: Real;

Begin
	InitializePostfix(PostfixFirst, PostfixLast);
	ConvertAlphabeticToNumeric(Postfix, PostfixFirst, PostfixLast);
	ShowPostfixNumeric(PostfixFirst);
	Calculate(PostfixFirst, PostfixLast, Total);
	Write('Hasil : ', Total:0:2);
End;

Procedure Main();
{I.S.: Sembarang}
{I.F.: Mengubah notasi infix ke notasi postfix dan menjumlahkannya}

Var
	Infix, Postfix: String;

Begin
	InputAndConvertInfix(Infix, Postfix);
	ConvertAndCalculate(Postfix);
End;

Begin
	ClrScr;
	Main();
	ReadLn;
End.
