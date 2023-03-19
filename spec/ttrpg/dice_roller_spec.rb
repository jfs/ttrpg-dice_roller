# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller do
  it "has a version number" do
    expect(TTRPG::DiceRoller::VERSION).not_to be nil
  end
  it "echos a single interger [11]" do
    expect(TTRPG::DiceRoller.roll('11')).to eq(11)
  end
  it "adds two intergers [11 + 11]" do
    expect(TTRPG::DiceRoller.roll('11 + 11')).to eq(22)
  end
  it "subtracts two intergers [11 - 11]" do
    expect(TTRPG::DiceRoller.roll('11 - 11')).to eq(0)
  end
  it "multiplies two intergers [11 * 11]" do
    expect(TTRPG::DiceRoller.roll('11 * 11')).to eq(121)
  end
  it "divides two intergers [11 / 11]" do
    expect(TTRPG::DiceRoller.roll('11 / 11')).to eq(1)
  end
  it "combines mixed operations [55 + 44 - 33 * 22 / 11]" do
    expect(TTRPG::DiceRoller.roll('55 + 44 - 33 * 22 / 11')).to eq(33)
  end
  it "supports operation precedence via parenthesis [((((55 + 44) - 33) * 22) / 11)]" do
    expect(TTRPG::DiceRoller.roll('((((55 + 44) - 33) * 22) / 11)')).to eq(132)
  end
  it "rolls a group of dice [10d10]" do
    expect(TTRPG::DiceRoller.roll('10d10')).to be_between(10,100)
  end
  it "rolls a group of dice as part of arithmatic" do
    expect(TTRPG::DiceRoller.roll('10 * 10d10')).to be_between(100,1000)
  end
  # it "rolls a single die [d10]" do
  #   expect(TTRPG::DiceRoller.roll('d10')).to be_between(1,10)
  # end
  # it "rolls a group of dice and drops the 2 higest" do
  #   expect(TTRPG::DiceRoller.roll('10 x 7d6')).to be_between(70,420)
  # end
end
