all: mycc
mycc: main.o lex.yy.c
	g++ -o mycc main.o lex.yy.c
main.o: main.cpp lex.yy.c
	g++ -c main.cpp 
part2.tab.h part2.tab.c: part2.y
	bison -d part2.y
lex.yy.c: lexer.l
	flex lexer.l
clean:
	rm *.o *.pdf *.aux *.log mycc *.tab.h *.tab.c lex.yy.c

#dependencies
main.o: lexer.l
lexer.l: part2.tab.h
