class Node
  attr_accessor :data, :right, :left
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end


class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree(starts = 0, ends = @array.length - 1)
    if starts > ends  
      return nil 
    end
    
    mid = (starts + ends) / 2
    puts mid
    @root = Node.new(@array[mid])
    @root.left = build_tree(starts, mid - 1)
    @root.right = build_tree(mid + 1, ends)
    
   return @root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  


end

t = Tree.new([1, 2, 3, 4, 5, 6, 7, 8])
pp t.build_tree
