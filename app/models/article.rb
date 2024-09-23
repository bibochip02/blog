class Article < ApplicationRecord
  def odd?
    Time.current.to_i.odd?
  end

  def even?
    Time.current.to_i.even?
  end
end
