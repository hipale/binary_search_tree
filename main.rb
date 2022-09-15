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

  def delete(value, node = find(value))
    if node.nil?
      return
    elsif node.right != nil && node.left != nil
      current = node.right
      until current.left == nil
        current = current.left
      end
      node.data = current.data
      if current.right != nil
        current.data = current.right.data
        current.right = nil
      end
    elsif node.right == nil && node.left == nil
      arr = inorder
      x = 0
      until x == arr.length - 1
         if height(arr[x]) == height(node.data) + 1
          previous_node = find(arr[x])
          if previous_node.right == node
            return previous_node.right = nil
          elsif previous_node.left == node
            return previous_node.left = nil
          end
        end
        x += 1
     end
    else
      if node.right != nil
        node.data = node.right.data
        node.right.left != nil ? node.left = node.right.left : node.left = nil
        node.right.right != nil ? node.right = node.right.right : node.right = nil
      elsif node.left != nil 
        node.data = node.left.data
        node.left.right != nil ? node.left = node.left.right : node.right = nil
        node.left.left != nil ? node.left = node.left.left : node.left = nil
      end
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
    else
      if node.left != nil
        inorder(node.left, inorder_arr)
      end
      inorder_arr.push(node.data)
      if node.right != nil
        inorder(node.right, inorder_arr)
      end
    end
    return inorder_arr
  end

  def preorder(node = @root, preorder_arr = [])
    if node.nil?
      return
    else
      preorder_arr.push(node.data)
      if node.left != nil
        preorder(node.left, preorder_arr)
      end
      if node.right != nil
        preorder(node.right, preorder_arr)
      end
    end
    return preorder_arr
  end

  def postorder(node = @root, postorder_arr = [])
    if node.nil?
      return
    else
      if node.left != nil
        postorder(node.left, postorder_arr)
      end
      if node.right != nil
        postorder(node.right, postorder_arr)
      end
      postorder_arr.push(node.data)
    end
    return postorder_arr
  end

  def height(value, node = find(value))
    if node.nil?
      return -1
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

  def depth(value, count = 0, node = @root, score = [])
    if node.nil?
      return
    elsif node.data == value
      score.push(count)
    end
      depth(value, count + 1, node.left, score)
      depth(value, count + 1, node.right, score)
      return score
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
    if is_balanced?(node)
      return
    else 
      inorder_arr = inorder()
      tree = Tree.new(inorder_arr)
      puts tree.pretty_print
    end
  end

  def min_value(node = @root)
    if node.nil?
      return true
    else 
      min_arr = inorder()
      return find(min_arr.min)
    end
  end

  def max_value(node = @root)
    if node.nil?
      return true
    else 
      max_arr = inorder()
      return find(max_arr.max)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  
end




array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)

puts t.pretty_print
 #t.insert(9999)
 #t.insert(555)
 #t.insert(-2)
 #t.insert(2)
t.delete(9)
puts t.pretty_print
#puts t.level_order_recursion
#puts t.inorder
#puts t.preorder
#puts t.postorder
#puts t.height(9)
#puts t.depth(5)
#pp t.find(9)
#puts t.is_balanced?
#puts t.rebalance
#puts t.min_value