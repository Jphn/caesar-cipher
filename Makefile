# COLORS
BOLD = "\e[1m"
REGULAR = "\e[0m"
RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE = "\033[34m"
PURPLE = "\033[35m"
CYAN = "\033[36m"
WHITE = "\033[37m"

# FUNCTIONS
define p_echo
	@echo $(GREEN)$(BOLD)$(1)$(REGULAR)
endef

DIST = bin
TARGET = main

run: $(DIST)/$(TARGET)
	$(call p_echo,"[RUNNING $(TARGET)]")

	./$(DIST)/$(TARGET)

$(DIST)/$(TARGET): $(TARGET).o $(DIST)/
	$(call p_echo,"[COMPILING $@]")

	ld -s $< -o $@
	rm -rf *.o

$(DIST)/:
	$(call p_echo,"[CREATING DIST FOLDER]")

	mkdir $(DIST)

%.o: %.nasm
	$(call p_echo,"[CREATING OBJECT $@]")

	nasm -f elf64 $<

clean:
	$(call p_echo,"[CLEANING ALL]")

	rm -rf $(DIST)/