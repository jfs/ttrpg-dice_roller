# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller::DiceNotationTransform do
  before(:each) do
    ENV['DICE_ROLLER_STRATEGY'] = TTRPG::DiceRoller::SEQUENCE
    ENV['DICE_ROLLER_SEQUENCE_COUNT'] = '0'
  end

  it 'evaluates: 1' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('1')).eval
    expect(result).to eq(1)
  end
  
  it 'evaluates: 111' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('111')).eval
    expect(result).to eq(111)
  end
  
  it 'evaluates: 2+2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2')).eval
    expect(result).to eq(4)
  end
  
  it 'evaluates: 2+2+2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2+2')).eval
    expect(result).to eq(6)
  end
  
  it 'evaluates: 2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2-2')).eval
    expect(result).to eq(0)
  end
  
  it 'evaluates: 2-2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2-2-2')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: 2+2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2-2')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: 2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2*2')).eval
    expect(result).to eq(4)
  end
  
  it 'evaluates: 2*2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2*2*2')).eval
    expect(result).to eq(8)
  end
  
  it 'evaluates: 2+2-2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2-2*2')).eval
    expect(result).to eq(0)
  end
  
  it 'evaluates: 2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2/2')).eval
    expect(result).to eq(1)
  end
  
  it 'evaluates: 2/2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2/2/2')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: 2+2-2*2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2-2*2/2')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: ((((2+2)-2)*2)/2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('((((2+2)-2)*2)/2)')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('d10')).eval
    expect(result).to eq(1)
  end
  
  it 'evaluates: 10d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10')).eval
    expect(result).to eq(55)
  end
  
  it 'evaluates: 10*10d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10*10d10')).eval
    expect(result).to eq(550)
  end
  
  it 'evaluates: 10d10r' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10r')).eval
    expect(result).to eq(54)
  end
  
  it 'evaluates: 10d10rl' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rl')).eval
    expect(result).to eq(54)
  end
  
  it 'evaluates: 10d10rl2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rl2')).eval
    expect(result).to eq(52)
  end
  
  it 'evaluates: 10d10rh' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rh')).eval
    expect(result).to eq(45)
  end
  
  it 'evaluates: 10d10rh2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rh2')).eval
    expect(result).to eq(36)
  end
  
  it 'evaluates: 10d10rl2rh2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rl2rh2')).eval
    expect(result).to eq(33)
  end
  
  it 'evaluates: 10d10a8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10a8')).eval
    expect(result).to eq(3)
  end
  
  it 'evaluates: 10d10b8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10b8')).eval
    expect(result).to eq(8)
  end
  
  it 'evaluates: 10d10rl2rh2a8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rl2rh2a8')).eval
    expect(result).to eq(1)
  end
  
  it 'evaluates: (1d2)d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('(1d2)d10')).eval
    expect(result).to eq(2)
  end
  
  it 'evaluates: 10d(3d6)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d(3d6)')).eval
    expect(result).to eq(37)
  end
  
  it 'evaluates: 10d10rl(1d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10rl(1d2)')).eval
    expect(result).to eq(54)
  end
  
  it 'evaluates: 10d10a(2d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10a(2d2)')).eval
    expect(result).to eq(8)
  end
  
  it 'evaluates: (10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('(10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)')).eval
    expect(result).to eq(48)
  end
end
