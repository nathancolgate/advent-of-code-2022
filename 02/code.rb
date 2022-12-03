@plays = [
  {
    name: "rock",
    them: "A",
    me: "X",
    score: 1,
    defeats: "scissors",
    defeated_by: "paper"
  },
  {
    name: "paper",
    them: "B",
    me: "Y",
    score: 2,
    defeats: "rock",
    defeated_by: "scissors"
  },
  {
    name: "scissors",
    them: "C",
    me: "Z",
    score: 3,
    defeats: "paper",
    defeated_by: "rock"
  }
]

def new_first_score(their_shape, desired_outcome)
  their_play = @keys.detect { |v| v[:them] == their_shape }
  my_play = if desired_outcome == "Y"
    # tie
    their_play
  elsif desired_outcome == "Z"
    # win
    @keys.detect { |v| v[:name] == their_play[:defeated_by] }
  else
    # lose
    @keys.detect { |v| v[:name] == their_play[:defeats] }
  end
  my_play[:score]
end