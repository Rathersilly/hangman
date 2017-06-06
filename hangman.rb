require 'yaml'

class Game
  MAX_GUESSES = 6
  BODY_PARTS = ["     O",
                "     |",
                "    /|",
                "    /|\\",
                "    /",
                "    / \\"]


  def initialize
    setup

  end
  
  def setup
    @dictionary_file = "5desk.txt"
    @word = ""
    @wrong_guesses = 0
    @win_status = nil
    @guess = ""
    @correct_letters = []
    @wrong_letters = []
    @word_so_far = ""
    play_game
  end

  def play_game
    choose_word
    while(@win_status == nil)
      show_man
      get_guess
      update_letters
      
    end
    #@win_status can also = :load.  should refactor a new game_controller class
    if @win_status == :win
      puts "You guessed the word! Dude is saved!"
    elsif @win_status == :loss
      puts "Guy ded.  Word was #{@word}."
    elsif @win_status == :quit
      puts "OK Bye!"
    
    end

  end

  def choose_word(min=5, max = 12)
    #    this is an alternative way of doing what.sample does
    #    File.foreach(@dictionary_file).each_with_index do |line, number|
    #      chosen_word = line if rand < 1.0/(number + 1)
    #    end
    while @word.length < 5 ||  @word.length > 12
      @word = File.readlines(@dictionary_file).sample.strip.upcase
      puts @word
    end
    @word_so_far = "_" * @word.length
    #puts @word
  end



  def get_guess
    @guess = ""
    #need to add sanitization and possibility of save/load commands
    while true
      print 'Type "save", "load", "quit" or Guess a letter: '
      @guess = gets.chomp.upcase
      if @guess == "SAVE"
        save_game
        
      elsif @guess == "LOAD"
        load_game
      elsif @guess == "QUIT"
        quit_game
        break
      elsif @wrong_letters.include?(@guess) || @correct_letters.include?(@guess)
        puts "You already guessed that letter."
      elsif @guess.length == 1 && @guess =~ /\w/
        break
      else
        puts "Please enter something valid!"
      end

    end
    
  end


  def update_letters
    correct_guess_flag = false
    @word.length.times do |i|
      if @guess == @word[i]
        @word_so_far[i] = @word[i]
        correct_guess_flag = true
      end
    end
    if correct_guess_flag == false
      @wrong_guesses += 1
      @wrong_letters.push(@guess) unless @wrong_letters.include?(@guess)
    else
      @correct_letters.push(@guess) unless @correct_letters.include?(@guess)
    end

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
    
    if @wrong_guesses > 0
      puts "     wrong guesses: #{@wrong_letters.join.downcase}"
    else
      puts
    end

  end

  def save_game
    puts YAML::dump(self)
  end
  def load_game
    setup
  end
  def quit_game
    @win_status = :quit
  end


end



game = Game.new

