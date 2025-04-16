# frozen_string_literal: true

# Player is a class that contains relevant user info and its current score
class Player
  MARKS = %w[X O].freeze
  DEFAULT_SCORE = 0

  attr_accessor :score
  attr_reader :mark, :name

  def initialize(name, mark)
    validate_mark!(mark)
    @name = name
    @mark = mark
    @score = DEFAULT_SCORE
  end

  private

  def validate_mark!(mark)
    raise ArgumentError, 'User must mark with X or O' unless MARKS.include?(mark)
  end
end
