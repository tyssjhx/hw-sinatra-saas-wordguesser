class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.


  def guess(char)
    @text = ""
    # begin
    #   if char == nil
    #     raise ArgumentError
    #   end
    # rescue =>e
    #   puts @text = "Invalid guess."
    #   return false
    # end
    if char == nil
      raise ArgumentError
    end

    capchar = char.capitalize
    dwnchar = char.downcase
    validchars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    if (char.empty?) || !(validchars.include? capchar) 
      raise ArgumentError
    end

    if (@word.include? dwnchar) || (@word.include? capchar)
      if (@guesses.include? dwnchar) || (@guesses.include? capchar)
        @text = "You have already used that letter"
        return false
      else
        @guesses = @guesses + char
      end
    else
      if (wrong_guesses.include? dwnchar) || (@wrong_guesses.include? capchar)
        @text = "You have already used that letter"
        return false
      else
        @wrong_guesses = @wrong_guesses + char
      end
    end
    return true
  end
  # Get a word from remote "random word" service

  def word_with_guesses
    word = ""

    for i in 0...@word.length
      if @guesses.include? @word[i,1]
        word += @word[i,1]
      else
        word += "-"
      end
    end
    return word
  end

  def check_win_or_lose
    word = @word.downcase
    guesses = @guesses.downcase

    guessall = 1
    for i in 0...word.length
      if !(guesses.include? word[i,1])
        guessall = 0
        break;
      end
    end
    if (guessall == 0) && ((@guesses.length + @wrong_guesses.length) >= 7)
      return :lose
    elsif guessall == 0
      return :play
    else
      return :win
    end

  end

  def word
    return @word
  end

  def guesses 
    return @guesses
  end

  def wrong_guesses 
    return @wrong_guesses
  end

  def text
    return @text
  end

  def set_text(str)
    @text = str
  end

  def legal
    return @legal
  end

  def set_legal(num)
    @legal = num
  end


  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @legal = 0
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
