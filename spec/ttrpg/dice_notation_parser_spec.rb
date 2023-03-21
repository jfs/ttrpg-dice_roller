# frozen_string_literal: true

require 'parslet/convenience'

RSpec.describe TTRPG::DiceRoller::DiceNotationParser do

  it 'parses: 1' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('1')
    expect(result).to include({int:'1'})
  end

  it 'parses: 111' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('111')
    expect(result).to include({int:'111'})
  end

  it 'parses: 2+2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2+2')
    expect(result).to include({left:{int:'2'},plus:'+',right:{int:'2'}})
  end

  it 'parses: 2+2+2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2+2+2')
    expect(result).to include({
      left:{int:'2'},plus:'+',right:{left:{int:'2'},plus:'+',right:{int:'2'}}
    })
  end

  it 'parses: 2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2-2')
    expect(result).to include({left:{int:'2'},minus:'-',right:{int:'2'}})
  end

  it 'parses: 2-2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2-2-2')
    expect(result).to include({
      left:{int:'2'},minus:'-',right:{left:{int:'2'},minus:'-',right:{int:'2'}}
    })
  end

  it 'parses: 2+2-2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2+2-2')
    expect(result).to include({
      left:{int:'2'},plus:'+',right:{left:{int:'2'},minus:'-',right:{int:'2'}}
    })
  end

  it 'parses: 2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2*2')
    expect(result).to include({left:{int:'2'},times:'*',right:{int:'2'}})
  end

  it 'parses: 2*2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2*2*2')
    expect(result).to include({
      left:{int:'2'},times:'*',right:{left:{int:'2'},times:'*',right:{int:'2'}}
    })
  end

  it 'parses: 2+2-2*2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2+2-2*2')
    expect(result).to include({
      left:{int:'2'},plus:'+',right:{left:{int:'2'},minus:'-',right:{
        left:{int:'2'},times:'*',right:{int:'2'}
      }}
    })
  end
  
  it 'parses: 2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2/2')
    expect(result).to include({left:{int:'2'},divided_by:'/',right:{int:'2'}})
  end
  
  it 'parses: 2/2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2/2/2')
    expect(result).to include({left:{int:'2'},divided_by:'/',right:{left:{int:'2'},divided_by:'/',
      right:{int:'2'}}})
  end
  
  it 'parses: 2+2-2*2/2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('2+2-2*2/2')
    expect(result).to include({left:{int:'2'},plus:'+',right:{left:{int:'2'},minus:'-',
      right:{left:{int:'2'},times:'*',right:{left:{int:'2'},divided_by:'/',right:{int:'2'}}}}})
  end

  it 'parses: ((((2+2)-2)*2)/2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('((((2+2)-2)*2)/2)')
    expect(result).to include({group:{left:{group:{left:{group:{left:{group:{left:{int:'2'},
      plus:'+',right:{int:'2'}}},minus:'-',right:{int:'2'}}},times:'*',right:{int:'2'}}},
      divided_by:'/',right:{int:'2'}}})
  end

  it 'parses: d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('d10')
    expect(result).to include({pool:{count:nil,die:'d',sides:{int:'10'}},reduce:[],target:nil})
  end

  it 'parses: 10d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10')
    expect(result).to include({pool:{count:{int:'10'},die:'d',sides:{int:'10'}},reduce:[],
      target:nil})
  end

  it 'parses: 10*10d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10*10d10')
    expect(result).to include({left:{int:'10'},times:'*',right:{pool:{count:{int:'10'},die:'d',
      sides:{int:'10'}},reduce:[],target:nil}})
  end

  it 'parses: 10d10r' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10r')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:nil,count:nil}],target:nil})
  end

  it 'parses: 10d10rl' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rl')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'l',count:nil}],target:nil})
  end

  it 'parses: 10d10rl2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rl2')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'l',count:{int:'2'}}],target:nil})
  end

  it 'parses: 10d10rh' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rh')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'h',count:nil}],target:nil})
  end

  it 'parses: 10d10rh2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rh2')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'h',count:{int:'2'}}],target:nil})
  end

  it 'parses: 10d10rl2rh2' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rl2rh2')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'l',count:{int:'2'}},{reduce:'r',from:'h',count:{int:'2'}}],
      target:nil})
  end

  it 'parses: 10d10a8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10a8')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},reduce:[],
      target:{compare:'a',threshold:{int:'8'}}})
  end

  it 'parses: 10d10b8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10b8')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},reduce:[],
      target:{compare:'b',threshold:{int:'8'}}})
  end

  it 'parses: 10d10rl2rh2a8' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rl2rh2a8')
    expect(result).to include({pool:{count:{int:'10'},die: "d",sides:{int:'10'}},
      reduce:[{reduce:'r',from:'l',count:{int:'2'}},{reduce:'r',from:'h',count:{int:'2'}}],
      target:{compare:'a',threshold:{int:'8'}}})
  end

  it 'parses: (1d2)d10' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('(1d2)d10')
    expect(result).to include({pool:{count:{group:{pool:{count:{int:"1"},die:"d",sides:{int:"2"}},
      reduce:[],target:nil}},die:"d",sides:{int:"10"}},reduce:[],target:nil})
  end

  it 'parses: 10d(3d6)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d(3d6)')
    expect(result).to include({pool:{count:{int:"10"},die:"d",sides:{group:{pool:{count:{int:"3"},
      die:"d",sides:{int:"6"}},reduce:[],target:nil}}},reduce:[],target:nil})
  end

  it 'parses: 10d10rl(1d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10rl(1d2)')
    expect(result).to include({pool:{count:{int:"10"},die:"d",sides:{int:"10"}},reduce:[{reduce:"r",
      from:"l",count:{group:{pool:{count:{int:"1"},die:"d",sides:{int:"2"}},reduce:[],
      target:nil}}}],target:nil})
  end

  it 'parses: 10d10a(1d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('10d10a(1d2)')
    expect(result).to include({pool:{count:{int:"10"},die:"d",sides:{int:"10"}},reduce:[],
      target:{compare:"a",threshold:{group:{pool:{count:{int:"1"},die:"d",sides:{int:"2"}},
      reduce:[],target:nil}}}})
  end

  it 'parses: (10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse_with_debug('(10d10)d(10d10)rl(2*1d2)rh(2*1d2)a(2*2d2)')
    expect(result).to include({pool:{count:{group:{pool:{count:{int:"10"},die:"d",sides:{int:"10"}},
      reduce:[],target:nil}},die:"d",sides:{group:{pool:{count:{int:"10"},die:"d",sides:{int:"10"}},
      reduce:[],target:nil}}},reduce:[{reduce:"r",from:"l",count:{group:{left:{int:"2"},times:"*",
        right:{pool:{count:{int:"1"},die:"d",sides:{int:"2"}},reduce:[],target:nil}}}},{reduce:"r",
          from:"h",count:{group:{left:{int:"2"},times:"*",right:{pool:{count:{int:"1"},die:"d",
          sides:{int:"2"}},reduce:[],target:nil}}}}],target:{compare:"a",
            threshold:{group:{left:{int:"2"},times:"*",right:{pool:{count:{int:"2"},die:"d",
            sides:{int:"2"}},reduce:[],target:nil}}}}})
  end

end
