class Game
  attr_accessor :challenger, :challenged, :winner, :score_string

  def initialize(dict)
    @challenger = Player.new(dict['challenger']) if dict['challenger']
    @challenged = Player.new(dict['challenged']) if dict['challenged']
    @score_string = dict['score']

    if challenger && challenged
      winner = case dict['winner_id']
               when challenger.id
                challenger
               when challenged.id
                challenged
               else
                nil
               end
    end
  end
end
