class Enumerable
  def select(&block)
    result = []
    each { |e| result << e if block.call(e) }
    result
  end
end