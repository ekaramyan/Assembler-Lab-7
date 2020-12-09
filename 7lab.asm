nata segment 'code'
assume cs:nata
org 100h
begin: jmp main
;--------------------------------- DATA
;10 cимволов на месяц
Month DB 10,'January  ',20,'February ' 
DB 30,'March    ',40,'April    '
DB 50,'May      ',60,'June     '
DB 75,'July     ',80,'August   '
DB 90,'September',15,'October  '

Rezult DB 9 Dup(?),'$'
Buf DB 3,3 Dup(?)
Discharge DB ?
Mes DB 'Not found!$'
Eter DB 10,13,'$'
Podskaz DB 'Enter the amount of water discharge:$'
;---------------------------------
main proc near
;------------------------------------- PROGRAM
; ------ Подсказка -------
mov ah,09
lea dx,podskaz
int 21h
; Ввод строки
mov ah,0ah
lea dx,Buf
int 21h
; Преобразование символов в число
; Получаем десятки из буфера
mov bl,buf+2
sub bl,30h
mov al,10
imul bl ; в al - десятки
; Получаем единицы из буфера
mov bl,buf+3
sub bl,30h
; Складываем ------
add al,bl
mov discharge,al ; сохраняем в discharge
; -------- Переход на новую строку ---
mov ah,09h
lea dx,eter
int 21h
; --- сканирование таблицы городов ----
cld ; искать слева направо

mov cx,117 ; сколько байт сканировать
lea di,month ; строка, где искать
mov al,discharge ; что искать
repne scasb ; поиск
je @m2
; ------- Сообщение об отсутствии месяца
mov ah,09h
lea dx,Mes
int 21h
jmp @m3 ; выходим из программы
; -------- переписываем в результат
@m2:
cld
mov si,di
lea di,rezult
mov cl,9
rep movsb
; ----- Вывод результата ----
mov ah,09h
lea dx,rezult
int 21h
;-------------------------------------
@m3: mov ah,08
int 21h
ret
main endp
nata ends
end begin
