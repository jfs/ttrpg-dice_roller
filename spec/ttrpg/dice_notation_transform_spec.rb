# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller::DiceNotationTransform do
  it 'single digit integer literal evaluates to itself [1 = 1]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('1')).eval
    expect(result).to eql(1)
  end

  it 'multi digit integer literal evaluates to itself [111 = 111]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('111')).eval
    expect(result).to eql(111)
  end

  it 'performs simple addition [2+2 = 4]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2')).eval
    expect(result).to eql(4)
  end

  it 'performs compund addition [2+2+2 = 6]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2+2+2')).eval
    expect(result).to eql(6)
  end

  it 'performs simple subtraction [2-2 = 0]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2-2')).eval
    expect(result).to eql(0)
  end

  it 'performs compound subtraction [4-2-2 = 0]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('4-2-2')).eval
    expect(result).to eql(4)
  end

  it 'performs simple multiplication [2*2 = 4]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2*2')).eval
    expect(result).to eql(4)
  end

  it 'performs compound multiplication [2*2*2 = 8]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2*2*2')).eval
    expect(result).to eql(8)
  end

  it 'performs simple division [2/2 = 1]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('2/2')).eval
    expect(result).to eql(1)
  end

  it 'performs compound division [4/2/2 = 4]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('4/2/2')).eval
    expect(result).to eql(4)
  end

  it 'performs performs mixed arithmetic [32+16-4*4/2 = 40]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('32+16-4*4/2')).eval
    expect(result).to eql(40)
  end

  it 'performs performs mixed arithmetic with precedent grouping [((((32+16)-4)*4)/2) = 88]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('((((32+16)-4)*4)/2)')).eval
    expect(result).to eql(88)
  end

  it 'evaluates a dice pool [10d10]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10d10')).eval
    expect(result).to be_between(10,100)
  end

  it 'evaluates a statement that includes a dice pool [10*10d10]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('10*10d10')).eval
    expect(result).to be_between(100,1000)
  end

  it 'evaluates a dice pool with an implied dice count of 1 [d10]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    transform = TTRPG::DiceRoller::DiceNotationTransform.new
    result = transform.apply(parser.parse('d10')).eval
    expect(result).to be_between(1,10)
  end
end
