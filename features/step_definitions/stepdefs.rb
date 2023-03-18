Then('the {channel} should be an integer between {string} and {string}') do |channel, min, max|
  expect(send("all_#{channel}").to_i).to be_between(min.to_i, max.to_i)
end
