program ZamianaUPCA_UPCE;
uses
SysUtils;

var
upca: String;
upce: String;
i: Integer;

function sprawdzanieCiaguUPCA(upca: String): boolean;
var
suma : Integer;
begin
suma := 3 * StrToInt(upca[1]) +
1 * StrToInt(upca[2]) +
3 * StrToInt(upca[3]) +
1 * StrToInt(upca[4]) +
3 * StrToInt(upca[5]) +
1 * StrToInt(upca[6]) +
3 * StrToInt(upca[7]) +
1 * StrToInt(upca[8]) +
3 * StrToInt(upca[9]) +
1 * StrToInt(upca[10]) +
3 * StrToInt(upca[11]);
suma := suma mod 10;
suma := 10 - suma;
suma := suma mod 10;
if (suma <> StrToInt(upca[12])) then
Result := false
else
Result := true;
end;

function zamianaUPCE_UPCA(upce: String): String;
var
i: Integer;
CyfrowyUPCE : array[1..8] of Integer;
begin
Result := '000000000000';

if (length(upce) <> 8) then
begin
Result := 'Dlugosc kodu UPC-E musi skladac sie z 8 znakow!';
readln;
exit;
end;

for i:=1 to 8 do
CyfrowyUPCE[i] := StrToInt(upce[i]);

if ((CyfrowyUPCE[1] <> 0) and (CyfrowyUPCE[1] <> 1)) then
begin
Result := 'Numer systemu UPC-E powinien miec wartosc 0 lub 1!';
readln;
exit;
end;

if ((CyfrowyUPCE[7] >= 0) and (CyfrowyUPCE[7] <= 2)) then
begin
Result[4] := upce[7];
Result[5] := '0';
Result[6] := '0';
Result[7] := '0';
Result[8] := '0';
Result[9] := upce[4];
Result[10] := upce[5];
Result[11] := upce[6];
end
else if ((CyfrowyUPCE[7] = 3) and (CyfrowyUPCE[4] >= 3) and (CyfrowyUPCE[4] <= 9)) then
begin
Result[4] := upce[4];
Result[5] := '0';
Result[6] := '0';
Result[7] := '0';
Result[8] := '0';
Result[9] := '0';
Result[10] := upce[5];
Result[11] := upce[6];
end
else if (CyfrowyUPCE[7] = 4) then
begin
Result[4] := upce[4];
Result[5] := upce[5];
Result[6] := '0';
Result[7] := '0';
Result[8] := '0';
Result[9] := '0';
Result[10] := '0';
Result[11] := upce[6];
end
else if ((CyfrowyUPCE[7] >= 5) and (CyfrowyUPCE[7] <= 9)) then
begin
Result[4] := upce[4];
Result[5] := upce[5];
Result[6] := upce[6];
Result[7] := '0';
Result[8] := '0';
Result[9] := '0';
Result[10] := '0';
Result[11] := upce[7];
end
else
begin
Result := 'UPC-E: bledny';
readln;
exit;
end;

Result[2] := upce[2];
Result[3] := upce[3];

Result[1] := upce[1];
Result[12] := upce[8];

if (sprawdzanieCiaguUPCA(Result) <> true) then
begin
Result := 'Suma kontrolna: nieprawidlowa!';
readln;
exit;
end;
end;

function zamianaUPCA_UPCE(upca: String): String;
var
i: Integer;
cyfrowyUPCA : array[1..12] of Integer;
begin
Result := '00000000';

if (length(upca) <> 12) then
begin
Result := 'Dlugosc kodu UPC-A musi skladac sie z 12 znakow!';
readln;
exit;
end;


for i:=1 to 12 do
cyfrowyUPCA[i] := StrToInt(upca[i]);

if (sprawdzanieCiaguUPCA(upca) <> true) then
begin
Result := 'Suma kontrolna: nieprawidlowa';
readln;
exit;
end;

if ((cyfrowyUPCA[1] <> 0) and (cyfrowyUPCA[1] <> 1)) then
begin
Result := 'Numer systemu UPC-A powinien miec wartosc 0 lub 1!';
readln;
exit;
end;

if ((cyfrowyUPCA[4] >= 0) and (cyfrowyUPCA[4] <= 2) and
(cyfrowyUPCA[5] = 0) and (cyfrowyUPCA[6] = 0) and (cyfrowyUPCA[7] = 0) and (cyfrowyUPCA[8] = 0)) then
begin
Result[4] := upca[9];
Result[5] := upca[10];
Result[6] := upca[11];
Result[7] := upca[4];
end
else if ((cyfrowyUPCA[4] >= 3) and (cyfrowyUPCA[4] <= 9) and
(cyfrowyUPCA[5] = 0) and (cyfrowyUPCA[6] = 0) and (cyfrowyUPCA[7] = 0) and (cyfrowyUPCA[8] = 0)  and (cyfrowyUPCA[9] = 0)) then
begin
Result[4] := upca[4];
Result[5] := upca[10];
Result[6] := upca[11];
Result[7] := '3';
end
else if ((cyfrowyUPCA[6] = 0) and (cyfrowyUPCA[7] = 0) and (cyfrowyUPCA[8] = 0) and (cyfrowyUPCA[9] = 0) and (cyfrowyUPCA[10] = 0)) then
begin
Result[4] := upca[4];
Result[5] := upca[5];
Result[6] := upca[11];
Result[7] := '4';
end
else if ((cyfrowyUPCA[11] >= 5) and (cyfrowyUPCA[11] <= 9) and
(cyfrowyUPCA[7] = 0) and (cyfrowyUPCA[8] = 0) and (cyfrowyUPCA[9] = 0) and (cyfrowyUPCA[10] = 0)) then
begin
Result[4] := upca[4];
Result[5] := upca[5];
Result[6] := upca[6];
Result[7] := upca[7];
end
else
begin
Result := 'Zamiana kodu UPC-A na UPC-E jest niemozliwa!';
readln;
exit;
end;

Result[2] := upca[2];
Result[2] := upca[3];

Result[1] := upca[1];
Result[8] := upca[12];
end;


begin
writeln('Wybierz opcje');
writeln('1. UPC-A => UPCE-E');
writeln('2. UPC-E => UPC-A');
readln(i);

if (i=1) then
begin
write('Podaj kod UPC-A: ');
readln(upca);
upce := zamianaUPCA_UPCE(upca);
write('Zamieniony kod UPC-E: ');
writeln(upce);
end
else
begin
write('Podaj kod UPC-E: ');
readln(upce);
upca := zamianaUPCE_UPCA(upce);
writeln('Zamieniony kod UPC-A: ');
writeln(upca);
end;
readln;
end.
