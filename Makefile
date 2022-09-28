##
## EPITECH PROJECT, 2021
## project
## File description:
## Makefile
##

NAME	=	my_world
NAME_TESTS	=	unit_tests

# src
SRC_DIR	=	src/
SRC	=	$(shell find $(SRC_DIR) -type f '(' -name "*.c" ')')	\
		bonus/buttons.c	\
		bonus/open_folder_with_maps.c	\
		bonus/load_file.c	\
		bonus/save_file.c
SRC_NO_MAIN	=	$(filter-out $(SRC_DIR)main.c, $(SRC))

# tests
TESTS_DIR	=	tests/
TESTS	=	$(shell find $(TESTS_DIR) -type f '(' -name "*.c" ')')

# compil
OBJ	=	$(SRC:.c=.o)
CC	=	gcc -g

COUNT	=	0
TOTAL_NBR_FILES	=	$(shell echo $(SRC) | wc -w)

# clean
BIN	=	vgcore*	\
		unit_tests*	\

# flags
FLAGS	=	-I./include	\
		-L./lib	\
		-lmy	\
		-g	\

WFLAGS	=	-Wall	\
			-Werror	\
			-Wextra	\

CSFML_FLAGS	=	-lcsfml-graphics	\
			-lcsfml-window	\
			-lcsfml-system	\
			-lcsfml-audio	\
			-lm

TESTS_FLAGS	=	--coverage	\
				-lcriterion

RESET_COLOR	=	\033[0m
BLACK	=	\033[0;30m
RED		=	\033[0;31m
GREEN	=	\033[0;32m
YELLOW	=	\033[0;33m
BLUE	=	\033[0;34m
PURPLE	=	\033[0;35m
CYAN	=	\033[0;36m
WHITE	=	\033[0;37m
BOLD_BLACK	=	\033[1;30m
BOLD_RED	=	\033[1;31m
BOLD_GREEN	=	\033[1;32m
BOLD_YELLOW	=	\033[1;33m
BOLD_BLUE	=	\033[1;34m
BOLD_PURPLE	=	\033[1;35m
BOLD_CYAN	=	\033[1;36m
BOLD_WHITE	=	\033[1;37m

all:	$(NAME)

$(NAME):	$(OBJ)
	@echo -e "$(BOLD_BLUE)Files compilation ok\n$(RESET_COLOR)"
	@make -C lib/my
	$(CC) -o $(NAME) $(OBJ) $(FLAGS) $(CSFML_FLAGS)
	@echo -e "$(BOLD_GREEN)Compilation done$(RESET_COLOR)"

%.o: %.c
	$(eval COUNT=$(shell echo $$(($(COUNT)+1))))
	@echo -e "$(BOLD_CYAN)[$(shell echo $$(( $(COUNT) * 100 / $(TOTAL_NBR_FILES) )))%]$(RESET_COLOR) Compiling $< -> $@"
	@$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -f $(BIN)
	rm -f $(OBJ)
	@echo -e "$(BOLD_YELLOW)Cleaning done\n$(RESET_COLOR)"

fclean:	clean
	rm -f $(NAME)
	make -C lib/my fclean
	@echo -e "$(BOLD_YELLOW)Full cleaning done\n$(RESET_COLOR)"

re:	clean all

gcovr:
		gcovr --exclude tests
		gcovr --exclude tests --branches

tests_run:	fclean
		make -C lib/my
		gcc -o $(NAME_TESTS) $(SRC_NO_MAIN) $(TESTS) $(TESTS_FLAGS) $(FLAGS)
		./$(NAME_TESTS)

.PHONY:		all clean fclean re exec gcovr tests_run
