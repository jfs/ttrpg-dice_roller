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
  it "combines mixed operations" do
    expect(TTRPG::DiceRoller.roll('55 + 44 - 33 * 22 / 11')).to eq(33)
  end
  it "supports operation precedence via parenthesis" do
    expect(TTRPG::DiceRoller.roll('((((55 + 44) - 33) * 22) / 11)')).to eq(132)
  end
  # it "rolls a single die" do
  #   expect(TTRPG::DiceRoller.roll('d6')).to be_between(1,6)
  # end
  # it "rolls a group of dice" do
  #   expect(TTRPG::DiceRoller.roll('7d6')).to be_between(7,42)
  # end
  # it "rolls a group of dice as part of arithmatic" do
  #   expect(TTRPG::DiceRoller.roll('10 x 7d6')).to be_between(70,420)
  # end
  # it "rolls a group of dice and drops the 2 higest" do
  #   expect(TTRPG::DiceRoller.roll('10 x 7d6')).to be_between(70,420)
  # end
end
