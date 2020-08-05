# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  profits = []

  prices.each_with_index do |price, i|
    following = prices[(i+1)...prices.size]
    max_price = following.max

    if max_price && max_price > price
      profits << max_price - price
    end
  end

  profits.max || 0
end

max_profit([7,1,5,3,6,4])
# max_profit([7,6,4,3,1])
