require 'tree'

require_relative 'Board'
require_relative 'BoardEvaluator'
require_relative 'Move'

class TreeHuggingOpponent
  
  MAX_ITERATIONS = 2
  VERBOSITY = 1
  
  def initialize(board, colour)
    @board = board
    @colour = colour
    @root_node = Tree::TreeNode.new("", Move.new([], nil, 0))
  end
  
  def my_move(x)
    
    if @root_node.has_children?
      if @root_node.content.value >= @root_node["#{x}"].content.value
        comment "Good move!!", 1
      else
        best_moves = []
        @root_node.children do |child|
          if child.content.value <= @root_node.content.value
            best_moves.push child.content.steps.last
          end
        end
        comment "You should have played #{best_moves.to_s}!", 1
      end
    end
    
    prune_all_but x
  end
  
  def next_move
    
    depth = -1
    
    for n in 1..(MAX_ITERATIONS)
      depth += 1
    
      comment "Planning my move #{n}", 2
    
      @root_node.each_leaf do |node|
        if (node.content.steps.length == depth)
          for x in (0..Board::WIDTH - 1)
            future_board = @board.clone
            steps = Array.new(node.content.steps)
            steps.push x
            comment steps.to_s, 3
            count = 0
            begin
              steps.each do |step|
                if count % 2 == 0
                  future_board.set(step, @colour)
                else
                  future_board.set(step, Counter::other(@colour))
                end
                count += 1
              end
              evaluator = BoardEvaluator.new(future_board, @colour)
              value = evaluator.evaluate
              node << Tree::TreeNode.new("#{x}", Move.new(steps, @colour, value))
            rescue
            end
          end
        end
      end

      comment "Predicting your move #{n}", 2

      depth += 1
    
      @root_node.each_leaf do |node|
        if (node.content.steps.length == depth)
          for x in (0..Board::WIDTH - 1)
            future_board = @board.clone
            steps = Array.new(node.content.steps)
            steps.push x
            comment steps.to_s, 3
            count = 0
            begin
              steps.each do |step|
                if count % 2 == 0
                  future_board.set(step, @colour)
                else
                  future_board.set(step, Counter::other(@colour))
                end
                count += 1
              end
              evaluator = BoardEvaluator.new(future_board, @colour)
              value = evaluator.evaluate
              node << Tree::TreeNode.new("#{x}", Move.new(steps, Counter::other(@colour), value))
            rescue
            end
          end
        end
      end

    end
    
    while depth >= 0
      
      comment "Being pessimistic about the outlook in #{depth} moves", 2
      
      @root_node.each do |node|
        if (node.content.steps.length == depth)
          min_value = 1000000000000
          node.children.each do |child|
            if child.content.value < min_value
              min_value = child.content.value
            end
          end
          node.content.value = min_value
        end
      end
      
      depth -= 1
      
      if depth == 0
        break
      end
      
      comment "Being optimistic about the outlook in #{depth} moves", 2
      
      @root_node.each do |node|
        if (node.content.steps.length == depth)
          max_value = -1000000000000
          node.children.each do |child|
            if child.content.value > max_value
              max_value = child.content.value
            end
          end
          node.content.value = max_value
        end
      end
      
      depth -= 1
    end
    
    moves = Array.new
    
    @root_node.children do |child|
      moves.push child.content
    end
    
    x = best_move moves
    prune_all_but x
    
    return x
  end
  
  def best_move(moves)
    comment "Choosing my best move", 2
    moves.sort!
    best_value = moves[0].value
    moves.select! { |move|
      move.value == best_value
    }
    
    return moves[rand(0..moves.length - 1)].steps.last
  end
  
  def prune_all_but(x)
    comment "Pruning the tree of all starting moves apart from #{x}", 2
    
    if (!@root_node.has_children?)
      return
    end
    
    @root_node = @root_node["#{x}"].dup
    
    @root_node.each do |node|
      node.content.steps.slice! 0
    end
    
    comment "I reckon the current score is #{@root_node.content.value}", 2
  end
  
  def comment (s, level)
    if VERBOSITY >= level
      puts s
    end
  end
  
end