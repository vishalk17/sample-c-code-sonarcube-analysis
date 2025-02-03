all: main

main: main.c
	@echo "====================="
	gcc -o main main.c
	@echo "Compiled successfully."
	@echo "====================="

clean:
	@echo "====================="
	rm -f main
	@echo "Cleaned successfully."
	@echo "====================="

