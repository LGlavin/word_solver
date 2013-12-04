require 'pry'

class Scrabble
  attr_accessor :solve, :solve_total
  
  def initialize(rack_tiles)
    @rack_tiles = rack_tiles
    @solve = []
    @solve_total = 0 
    possible_words
  end

  def dictionary(path)
    File.readlines(path).map {|line| line.strip}
  end

  def possible_words
    word_list = dictionary('scrabble/words.txt')
    user_input = @rack_tiles.split(//)
    total = 1
    while @rack_tiles.size >= total
     user_input.permutation(total).to_a.uniq.collect do |rack|
        word = rack.join(",").gsub(",","")
          if word_list.include?(word)
          possible = Solve.new(word)
          @solve.push [possible.word, possible.score]
        end
      end
     total += 1
    end
    @solve = @solve.sort_by {|word, score| score}.reverse
    @solve_total = @solve.count
    @solve = @solve[0..9]
  end  
end

class Solve
  attr_accessor :word, :score
  def initialize(word)
    @word = word
    @score = 0
    scorer
  end
 
  LETTER_POINTS =
  { a:1, b:3, c:3, d:2, e:1, f:4, g:2, h:4, i:1,
    j:8, k:5, l:1, m:3, n:1, o:1, p:3, q:10,
    r:1, s:1, t:1, u:1, v:4, w:4, x:8, y:4, z:10 }


 def scorer
  @word.each_char {|tile| @score += LETTER_POINTS[tile.to_sym]}
 end
end





