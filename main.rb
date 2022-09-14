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
    if node.nil?
      nil
    elsif node.data == value
      node
    elsif node.data > value
      find(value, node.left)
    elsif node.data < value
      find(value, node.right)
    end
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
   
  def inorder(node = @root, inorder_arr = [])
    if node.nil?
      return
    elsif node.right == nil && node.left == nil
    inorder_arr.push(node)
    else
      if node.left != nil
        inorder(node.left)
      end
      if node.right != nil
        inorder(node.right)
      end
    end
    return inorder_arr
  end

  def height(value, node = find(value))
    if node.nil?
      return 0
    else
      left = height(value, node.left)
      right = height(value, node.right)
      if left > right
        1 + left
      else
        1 + right
      end
    end
  end

  def depth(value, count = 0, node = @root)
    if node.data == value 
      puts count
      return
    end
    if node.left != nil
      depth(value, count + 1, node.left)
    end
    if node.right != nil
     depth(value, count + 1, node.right)
    end
  end

  def is_balanced?(node = @root)
    if node.nil?
      return true
    end
    node.left == nil ? left_height = 0 : left_height = height(node.left.data)
    node.right == nil ? right_height = 0 : right_height = height(node.right.data)
    if (
    (left_height - right_height) < 2 &&
    (left_height - right_height) > -2 &&
    is_balanced?(node.left) &&
    is_balanced?(node.right)
    )
      return true
    end
    return false
 end 

  def rebalance(node = @root)
    if is_balance(node)
      return
    else 

  end
end




array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)

#puts t.pretty_print
 t.insert(9999)
 #t.insert(555)
 #t.insert(8)
 #t.insert(2)

puts t.pretty_print
#puts t.level_order_recursion
puts t.inorder
#puts t.height(1)

#pp t.find(9)
#puts t.depth(4)
#puts t.is_balanced?
