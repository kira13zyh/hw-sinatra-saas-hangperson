class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses, :valid
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @valid = ""
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

def guess(letter)
  if letter == nil || letter == ''
    raise ArgumentError
  elsif !(/[a-zA-z]/=~ letter) 
    raise ArgumentError
  end
  letter = letter.downcase
  if word.include? letter
    if !self.guesses.include? letter
      self.guesses += letter
      self.valid = true
    else
      self.valid = false
    end
  else
    if !self.wrong_guesses.include? letter
      self.wrong_guesses += letter
      self.valid = true
    else
      self.valid = false
    end 
  end
end

def check_win_or_lose
  if wrong_guesses.length >= 7
    return :lose
  elsif self.guesses != '' && self.word.gsub(/((?![#{self.guesses}])[A-Za-z])/, '-') == self.word
    return :win
  else
    return :play
  end
end

def word_with_guesses
  # regex = '/[^'+ self.guesses+']/'
  if self.guesses != ''
    return self.word.gsub(/((?![#{self.guesses}])[A-Za-z])/, '-')
  else
    return self.word.gsub(/[a-zA-Z]/, '-')
  end
end


end
