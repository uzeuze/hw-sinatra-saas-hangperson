class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :guesses, :word, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess letter
    if (letter =~ /^[a-z]/i) && !(letter.nil?)
      letter = letter.downcase
    else
      raise ArgumentError.new("Non-Letter character or blank form is not allowed")
    end
    
    if @word.include?(letter)
      if !@guesses.include?(letter)
       @guesses << letter 
       return true
      else
       return false
      end
    else
      if !@wrong_guesses.include?(letter)
       @wrong_guesses << letter 
      return true
      else
      return false
      end
    end
  end
  
  def word_with_guesses
      display = ""
      @word.split("").each do |f|
        if @guesses.include? f
          display << f
        else
          display << '-'
        end
      end
      display
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif @word.split("").uniq.sort == @guesses.split("").sort
      return :win
    else
      return :play
    end
  end
end
