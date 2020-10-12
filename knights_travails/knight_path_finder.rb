require_relative "tree_node"
require "byebug"

class KnightPathFinder
    def initialize(start_pos)
        @start_pos = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
    end


    def self.valid_moves(pos) 
        x, y = pos
        knight_moves = [[-2,-1], [-2,1], [2,-1], [2, 1], [-1,-2], [-1,2], [1,2], [1,-2]]

        mod_post = knight_moves.map { |ele| [x + ele[0], y + ele[1]] }
        
        mod_post.select do |posit|
            # x is within the grid length, and y is withint the grid length
            posit.all? { |coord| coord >= 0 && coord <= 7 }
        end
    end

    def new_move_positions(pos)
        new_poses = KnightPathFinder.valid_moves(pos).reject {|posit| @considered_positions.include?(posit)}
        @considered_positions += new_poses
        new_poses
    end

    def build_move_tree(end_pos)
        # [[0,0], [2,1], ... , [8,8]] is a move tree
        # [root.pos, child1.pos, etc.]
        # 
        # when we consider end_pos, return move tree with end_pos appended
        
        # input = end_pos
        # bfs(end_pos)
        # dfs(end_pos)
        queue = [@start_pos]

        until queue.empty?
            
            current = queue.shift
            return move_tree(current) if current.value == end_pos #return mapped move_tree with values of nodes
            new_move_positions(current.value).each do |pos|
                child = PolyTreeNode.new(pos)
                child.parent = current
                queue << child
            end
        end
    end

    def move_tree(node)
    
        if node == @start_pos
            @considered_positions = [@start_pos]
            return [node.value] 
        end

        move_tree(node.parent) + [node.value] 
    end


end