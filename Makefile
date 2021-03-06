# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: msantos- <msantos-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/17 16:49:30 by msantos-          #+#    #+#              #
#    Updated: 2021/06/30 20:24:46 by msantos-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#PROGRAMS
PROGRAM = so_long

#LIBS
LIBFT = libft_42/libft.a
PRINTF = ft_printf_42/libftprintf.a
LIBS = $(LIBFT) $(PRINTF)

#PATHS
OBJ_PATH = ./objs
SRC_PATH = ./srcs
INCLUDES = -I ./includes

#SRCS
PROGRAM_SRCS = main.c utils.c

#OBJS
PROGRAM_OBJS = $(addprefix $(OBJ_PATH)/,$(PROGRAM_SRCS:.c=.o))

#FLAGS
CC = gcc
CFLAGS = -Wall -Werror -Wextra

#INSTRUCTIONS
all: submodule ft_printf libft so_long

#EVERY TIME A .O IS CALLED AS AN INSTRUCTION THIS WILL BE CREATED IN OBJ_PATH
$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	@mkdir -p $(OBJ_PATH) 2> /dev/null || true
	@$(CC) -o $@ -c $^

submodule:
	@git submodule init
	@git submodule update --remote

#CHECKS THE EXISTANCE OF AN COMPILING FTPRINTF LIBRARY 
ft_printf:
	@make -C ft_printf_42  > /dev/null
libft:
	@make -C libft_42 > /dev/null

so_long: $(PROGRAM_OBJS)
	@$(CC) $(INCLUDES) $(PROGRAM_OBJS) $(LIBFT) $(PRINTF) -o $(PROGRAM)

clean:
	@rm -rf $(OBJ_PATH)

fclean: clean
	@rm -rf $(PROGRAM) $(CLIENT)
	@make fclean -C ft_printf_42 > /dev/null
	@make fclean -C libft_42 > /dev/null

re: fclean all
