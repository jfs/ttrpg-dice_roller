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

  it "rolls a dice pool [10d1]" do
    expect(TTRPG::DiceRoller.roll('10d1')).to eq(10)
  end

  it "rolls a dice pool as part of arithmatic [10 * 10d1]" do
    expect(TTRPG::DiceRoller.roll('10 * 10d1')).to eq(100)
  end

  it "rolls a dice pool with implied count of 1 [d1]" do
    expect(TTRPG::DiceRoller.roll('d1')).to eq(1)
  end

  it "rolls a dice pool that removes the 2 highest values [10d1r2h]" do
    expect(TTRPG::DiceRoller.roll('10d1r2h')).to eq(8)
  end

  it "rolls a dice pool that removes an implied 1 highest values [10d1rh]" do
    expect(TTRPG::DiceRoller.roll('10d1rh')).to eq(9)
  end

  it "rolls a dice pool that removes the 2 lowest values [10d1r2l]" do
    expect(TTRPG::DiceRoller.roll('10d1r2l')).to eq(8)
  end

  it "rolls a dice pool that removes an implied 1 lowest value [10d1rl]" do
    expect(TTRPG::DiceRoller.roll('10d1rl')).to eq(9)
  end
end
