class Node
  attr_accessor :data, :right, :left
  def initialize(data = nil)
    @data = data
  end
end


class Tree
  attr_accessor :root
  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree()
  end

  def build_tree(starts = 0, ends = @array.length - 1)
    if starts > ends  
      return nil 
    end
    
    mid = starts + (ends - starts) / 2
    root = Node.new(@array[mid])
    root.left = build_tree(starts, mid - 1)
    root.right = build_tree(mid + 1, ends)
    
    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root, starts = 0, ends = @array.length - 1)
    mid = starts + (ends - starts) / 2
    if node.right == nil && value > node.data
      node.right = Node.new(value)
      return
    elsif node.left == nil && value < node.data
      node.left = Node.new(value)
      return
    end
    if @array[mid] > value
      insert(value, node.left, starts, mid - 1)
    elsif @array[mid] < value
      insert(value, node.right, mid + 1, ends)
    end
  end
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)
puts t.pretty_print
 t.insert(9999)
 t.insert(555)
 t.insert(8)
 t.insert(2)

puts t.pretty_print