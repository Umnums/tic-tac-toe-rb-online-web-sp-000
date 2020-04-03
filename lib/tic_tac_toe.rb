
def position_taken?(board,index)
  if (board[index] == "" || board[index] == " " || board[index] == nil)
        return false
  else
    puts "true"
    return true
  end
end

def valid_move?(board, index)
  if (index >= 0 && index <= 8 && !position_taken?(board,index))
    return true
  else
    return false
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end


def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
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


WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left columns
  [1,4,7], # middle columns
  [2,5,8], # right columns
  [0,4,8], # diagonals
  [2,4,6] #diagonals
]

#board = ["", "X", "","","X","","","O",""]
def won?(board)
  counter = 0
  WIN_COMBINATIONS.each do |array|
    index_1 = array[0]
    index_2 = array[1]
    index_3 = array[2]
    pos1 = board[index_1]
    pos2 = board[index_2]
    pos3 = board[index_3]

    if ((pos1 == "X" && pos2 == "X" && pos3 == "X")||(pos1 == "O" && pos2 == "O" && pos3 =="O"))
      #puts "#{array}"
      return array
    end
  end
  return false
end

def full?(board)
  board.none? do |i|
    i == "" || i == " " || i == nil
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  if won?(board)
    array = won?(board)
    index = array[0]
    board[index]
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if (pos == "" || pos == " " || pos == nil)

    else
      count += 1
    end
  end
  return count
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    "X"
  else
    "O"
  end
end


#play(board)
