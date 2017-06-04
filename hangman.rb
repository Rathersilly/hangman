
class Game
  MAX_GUESSES = 6
  BODY_PARTS = ["     O",
                "     |",
                "    /|",
                "    /|\\",
                "    /",
                "    / \\"]


  def initialize
    @dictionary_file = "5desk.txt"
    @wrong_guesses = 0
    @win_status = nil
    @guess = ""
    @guessed_letters = []
    @word_so_far
    play_game

  end
  
  def play_game
    choose_word
    while(@win_status == nil)
      show_man
      guess = get_guess
      update_letters
      puts @win_status

      
    end
  end

  def choose_word(min=5, max = 12)
#    File.foreach(@dictionary_file).each_with_index do |line, number|
#      chosen_word = line if rand < 1.0/(number + 1)
#    end
    @word = File.readlines(@dictionary_file).sample.strip.upcase
    @word_so_far = "_" * @word.length
    #puts @word
  end



  def get_guess
    puts "Guess a letter:"
    @guess = gets.chomp.upcase
    @guessed_letters.push(@guess)
 
  end

  def update_letters
    correct_guess_flag = false
    @word.length.times do |i|
      if @guess == @word[i]
        @word_so_far[i] = @word[i]
        correct_guess_flag = true
      end
    end
    @wrong_guesses += 1 if correct_guess_flag == false
    if @word_so_far == @word
      @win_status = :win
      return
    end

    if @wrong_guesses == MAX_GUESSES
      @win_status = :loss
    end
  end

  def show_man
    puts BODY_PARTS[0] if @wrong_guesses > 0
    if @wrong_guesses > 4
      puts BODY_PARTS[3]
      puts BODY_PARTS[@wrong_guesses-1]
    elsif @wrong_guesses >1
      puts BODY_PARTS[@wrong_guesses-1]
      puts
    else
      puts
      puts
    end
    @word_so_far.length.times do |i|
      print @word_so_far[i] + " "
    end
    puts

  end

end



game = Game.new

