# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller do
  before(:each) do
    ENV['DICE_ROLLER_STRATEGY'] = TTRPG::DiceRoller::SEQUENCE
    ENV['DICE_ROLLER_SEQUENCE_COUNT'] = '0'
  end

  it "has a version number" do
    expect(TTRPG::DiceRoller::VERSION).not_to be nil
  end

  it "rolls: 1" do
    expect(TTRPG::DiceRoller.roll('1')).to eq(1)
  end

  it "rolls: 111" do
    expect(TTRPG::DiceRoller.roll('111')).to eq(111)
  end

  it "rolls: 2+2" do
    expect(TTRPG::DiceRoller.roll('2+2')).to eq(4)
  end

  it "rolls: 2+2+2" do
    expect(TTRPG::DiceRoller.roll('2+2+2')).to eq(6)
  end

  it "rolls: 2-2" do
    expect(TTRPG::DiceRoller.roll('2-2')).to eq(0)
  end

  it "rolls: 2-2-2" do
    expect(TTRPG::DiceRoller.roll('2-2-2')).to eq(2)
  end

  it "rolls: 2+2-2" do
    expect(TTRPG::DiceRoller.roll('2+2-2')).to eq(2)
  end

  it "rolls: 2*2" do
    expect(TTRPG::DiceRoller.roll('2*2')).to eq(4)
  end

  it "rolls: 2*2*2" do
    expect(TTRPG::DiceRoller.roll('2*2*2')).to eq(8)
  end

  it "rolls: 2+2-2*2" do
    expect(TTRPG::DiceRoller.roll('2+2-2*2')).to eq(0)
  end

  it "rolls: 2/2" do
    expect(TTRPG::DiceRoller.roll('2/2')).to eq(1)
  end

  it "rolls: 2/2/2" do
    expect(TTRPG::DiceRoller.roll('2/2/2')).to eq(2)
  end

  it "rolls: 2+2-2*2/2" do
    expect(TTRPG::DiceRoller.roll('2+2-2*2/2')).to eq(2)
  end

  it "rolls: ((((2+2)-2)*2)/2)" do
    expect(TTRPG::DiceRoller.roll('((((2+2)-2)*2)/2)')).to eq(2)
  end

  it "rolls: d10" do
    expect(TTRPG::DiceRoller.roll('d10')).to eq(1)
  end

  it "rolls: 10d10" do
    expect(TTRPG::DiceRoller.roll('10d10')).to eq(55)
  end

  it "rolls: 10*10d10" do
    expect(TTRPG::DiceRoller.roll('10*10d10')).to eq(550)
  end

  it "rolls: 10d10r" do
    expect(TTRPG::DiceRoller.roll('10d10r')).to eq(54)
  end

  it "rolls: 10d10rl" do
    expect(TTRPG::DiceRoller.roll('10d10rl')).to eq(54)
  end

  it "rolls: 10d10rl2" do
    expect(TTRPG::DiceRoller.roll('10d10rl2')).to eq(52)
  end

  it "rolls: 10d10rh" do
    expect(TTRPG::DiceRoller.roll('10d10rh')).to eq(45)
  end

  it "rolls: 10d10rh2" do
    expect(TTRPG::DiceRoller.roll('10d10rh2')).to eq(36)
  end

  it "rolls: 10d10rl2rh2" do
    expect(TTRPG::DiceRoller.roll('10d10rl2rh2')).to eq(33)
  end

  it "rolls: 10d10a8" do
    expect(TTRPG::DiceRoller.roll('10d10a8')).to eq(3)
  end

  it "rolls: 10d10b8" do
    expect(TTRPG::DiceRoller.roll('10d10b8')).to eq(8)
  end

  it "rolls: 10d10rl2rh2a8" do
    expect(TTRPG::DiceRoller.roll('10d10rl2rh2a8')).to eq(1)
  end

  it "rolls: (1d2)d10" do
    expect(TTRPG::DiceRoller.roll('(1d2)d10')).to eq(2)
  end

  it "rolls: 10d(3d6)" do
    expect(TTRPG::DiceRoller.roll('10d(3d6)')).to eq(37)
  end

  it "rolls: 10d10rl(1d2)" do
    expect(TTRPG::DiceRoller.roll('10d10rl(1d2)')).to eq(54)
  end

  it "rolls: 10d10a(2d2)" do
    expect(TTRPG::DiceRoller.roll('10d10a(2d2)')).to eq(8)
  end

  it "rolls: (10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)" do
    expect(TTRPG::DiceRoller.roll('(10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)')).to eq(48)
  end
end
