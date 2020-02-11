WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  separator = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separator
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separator
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def position_taken?(board, idx)
  !(board[idx] == " " || board[idx] == "" || board[idx] == nil)
end

def valid_move?(board, idx)
  !position_taken?(board, idx) && idx.between?(0, 8)
end

def move(board, idx, char)
  board[idx] = char
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  idx = input_to_index(user_input)
  if valid_move?(board, idx)
    move(board, idx, current_player(board))
    display_board(board)
  else
    puts "Invalid move. Please pick a valid space on the board."
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all? { |idx| board[idx] == "X" } || combo.all? { |idx| board[idx] == "O"}
  end
end

def full?(board)
  board.all? { |char| char == "X" || char == "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board).first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
