NAME = args

$(NAME): $(NAME).o
	ld -o $(NAME) -T $(NAME).ld $(NAME).o

$(NAME).o: $(NAME).s
	as -o $(NAME).o $(NAME).s

clean:
	rm $(NAME).o $(NAME)
