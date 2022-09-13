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
      return node.right = Node.new(value)
    elsif node.left == nil && value < node.data
      return node.left = Node.new(value)
    end
    if value < node.data 
      insert(value, node.left) 
    elsif value > node.data 
      insert(value, node.right)
    end
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

  def level_order_iteration(node = @root)
    if node == nil 
      return 
    end
    queue = [node]
    while queue.length > 0
      current = queue[0]
      if current.left != nil
        queue.push(current.left)
      end
      if current.right != nil
        queue.push(current.right)
      end
      puts queue[0].data
      queue.shift
    end
  end

  def level_order_recursion(node = @root, queue = [node])
    if node == nil 
      return 
    end
    if node.left != nil
      queue.push(node.left)
    end
    if node.right != nil
      queue.push(node.right)
    end
    puts queue[0].data
    queue.shift
    level_order_recursion(queue[0], queue)
  end

  def height(value, count = 0, node = @root)
    if node == nil
      return 
    end
    if node.data == value
      return count
      count = 0
    end
    if node.left != nil
      height(value, count + 1, node.left)
    end
    if node.right != nil
     height(value, count + 1, node.right)
    end
  end

  def depth(value, count = 0, node = @root)
    if node == nil
      return 
    end
    if node.data == value
      return count
    end
    if node.left != nil
      height(value, count + 1, node.left)
    end
    if node.right != nil
     height(value, count + 1, node.right)
    end
  end
end




array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)

#puts t.pretty_print
 #t.insert(9999)
 #t.insert(555)
 #t.insert(8)
 t.insert(2)

puts t.pretty_print
#puts t.level_order_recursion
puts t.height(67)
#pp t.find(6345)