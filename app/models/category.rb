class Category

  attr_reader :name
  def initialize(name)
    @name = name
  end

  def this_month_total
    Expense.sum_up(Expense.this_month.where(:category => name))
  end

  def self.list
    ["Food", "Rent", "Phone", "Gas", "Big Purchases", "Medical", "Necessities", "Entertainment"]
  end

  def self.all
    self.list.map {|n| Category.new(n) }
  end

end