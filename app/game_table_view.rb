class GameTableView < UITableView

  def initWithPlayerAndFrame(player, frame, opts)
    @player = player
    self.initWithFrame(frame, opts)
  end

   def tableView(tableView, cellForRowAtIndexPath: indexPath)
    game = @games[indexPath.row]
    cell = GameCell.cellForGame(game, inTableView:tableView)

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @games.count
  end

  def load!
    @games = []
    self.dataSource = self

    Latter::API.new.get("/players/#{@player.id}/games") do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_s)
        @games = json.map { |game_hash| Game.new(game_hash) }
        self.reloadData
      else
        App.alert(response.error_message)
      end
    end
  end

end