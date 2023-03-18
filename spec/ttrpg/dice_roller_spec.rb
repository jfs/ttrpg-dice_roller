# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller do
  it "has a version number" do
    expect(TTRPG::DiceRoller::VERSION).not_to be nil
  end
  it "echos a single interger" do
    expect(TTRPG::DiceRoller.roll('11')).to eq(11)
  end
  it "adds two intergers" do
    expect(TTRPG::DiceRoller.roll('11 + 11')).to eq(22)
  end
  it "subtracts two intergers" do
    expect(TTRPG::DiceRoller.roll('11 - 11')).to eq(0)
  end
  it "multiplies two intergers" do
    expect(TTRPG::DiceRoller.roll('11 * 11')).to eq(121)
  end
  it "divides two intergers" do
    expect(TTRPG::DiceRoller.roll('11 / 11')).to eq(1)
  end
end
