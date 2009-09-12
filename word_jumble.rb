class WordJumble

  LETTERS = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  DIRECTIONS = [:v, :h]
  SPACER = "-"

  def initialize(width, height, words, blank = false)
    @rows = []
    @words = words
    @height = height
    @width = width
    @blank = blank

    height.times do
      col = []
      width.times do
        col.insert(0, SPACER)
      end
      @rows.insert(0, col)
    end

    @words.each do |word|
      next if word > @height || word > @width
      placed = false
      word.reverse! if rand(100) > 85
      
      while !placed
        starting_point = { :x => rand(@width), :y => rand(@height) }
        direction = DIRECTIONS.sort_by { rand }.first
        space_free = true
        if direction == :h and (@width - starting_point[:y] >= word.length)
          y_pointer = starting_point[:y]
          word.split(//).each do |letter|
            space_free = false if @rows[starting_point[:x]][y_pointer] != SPACER and @rows[starting_point[:x]][y_pointer] != letter
            y_pointer = y_pointer + 1
          end
          if space_free
            y_pointer = starting_point[:y]
            word.split(//).each do |letter|
              @rows[starting_point[:x]][y_pointer] = letter
              y_pointer = y_pointer + 1
            end
            placed = true
          end
        elsif direction == :v and (@height - starting_point[:x] >= word.length)
          x_pointer = starting_point[:x]
          word.split(//).each do |letter|
            space_free = false if @rows[x_pointer][starting_point[:y]] != SPACER and @rows[x_pointer][starting_point[:y]] != letter
            x_pointer = x_pointer + 1
          end
          if space_free
            x_pointer = starting_point[:x]
            word.split(//).each do |letter|
              @rows[x_pointer][starting_point[:y]] = letter
              x_pointer = x_pointer + 1
            end
            placed = true
          end
        end
      end
    end
    
    populate 
  end

  def populate
    for r in 0..@rows.length-1
      for c in 0..@rows[r].length-1
        @rows[r][c] = @blank ? ' ' : LETTERS.sort_by { rand }.first if @rows[r][c] == SPACER
      end
    end
  end

  def to_a
    @rows
  end

  def to_s
    result = ""
    @rows.each do |row|
      result << "#{row.join(" ")}\n"
    end
    
    result
  end

end