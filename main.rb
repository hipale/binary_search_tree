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

  def insert(value, node = @root)
    if node.right == nil && value > node.data
      node.right = Node.new(value)
      return
    elsif node.left == nil && value < node.data
      node.left = Node.new(value)
      return
    end
    if value < node.data 
      insert(value, node.left) 
    elsif value > node.data 
      insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    if node == nil
      return false
    end
    if node.right.data == value
      node.right = nil
      return
    elsif node.left.data == value
      node.left = nil
      return 
    end
    value < node.data ? delete(value, node.left) : delete(value, node.right)
  end

  def find(value, node = @root)
    if node == nil
      return false
    end
    if value == node.data
      return node
    end
    value < node.data ? find(value, node.left) : find(value, node.right)
  end
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)

#puts t.pretty_print
 #t.insert(9999)
 #t.insert(555)
 #t.insert(8)
 #t.insert(2)

puts t.pretty_print

t.delete(6345)
puts t.pretty_print
#pp t.find(6345)
