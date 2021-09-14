# Helper Methods
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
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, player)
    board[index] = player
end

def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
    counter = 0
    board.each do |place|
        if place == "X" || place == "O"
            counter += 1
        end 
    end 
    counter
end

def current_player(board)
    turn_count(board).even? ? 'X' : 'O'
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else 
        turn(board)
    end 
end 

def won?(board)
    WIN_COMBINATIONS.find do |combo|
      board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])
    end
  end 
  
def full?(board)
    board.all?{|place| place == "X" || place == "O"}
end 
  
def draw?(board)
    full?(board) && !won?(board)
end 
  
def over?(board)
    full?(board) || won?(board)
end
  
def winner(board)
    if winning_combo = won?(board)
      board[winning_combo.first]
    end
end 

def play(board) 
    turn(board) until over?(board) || draw?(board)
    if won?(board) 
        player = winner(board)
        puts "Congratulations #{player}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end 