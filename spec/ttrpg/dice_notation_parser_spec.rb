# frozen_string_literal: true

RSpec.describe TTRPG::DiceRoller::DiceNotationParser do

  it 'parses single digit integers [1]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('1')
    expect(result).to include({
      integer: '1'
    })
  end

  it 'parses multi digit integers [111]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('111')
    expect(result).to include({
      integer: '111'
    })
  end

  it 'does not parse negative integers [-111]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    expect { parser.parse('-111') }.to raise_error(Parslet::ParseFailed)
  end

  it 'does not parse decimals [111.1]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    expect { parser.parse('111.1') }.to raise_error(Parslet::ParseFailed)
  end

  it 'parses addition operators [+]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.op_addition.parse('+')
    expect(result).to include({
      plus: '+'
    })
  end

  it 'parses simple addition statements [2+2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2+2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses simple addition statements that include whitespace [2 + 2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2 + 2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses compound addition statements from right to left [2+2+2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2+2+2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        left: {
          integer: '2'
        },
        plus: '+',
        right: {
          integer: '2'
        }
      }
    })
  end

  it 'parses subtraction operators [-]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.op_subtraction.parse('-')
    expect(result).to include({
      minus: '-'
    })
  end

  it 'parses simple subtraction statements [2-2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2-2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      minus: '-',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses simple subtraction statements that include whitespace [2 - 2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2 - 2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      minus: '-',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses compound subtraction statements from right to left [2-2-2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2-2-2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      minus: '-',
      right: {
        left: {
          integer: '2'
        },
        minus: '-',
        right: {
          integer: '2'
        }
      }
    })
  end

  it 'parses compound mixed statements from right to left [2+2-2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2+2-2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        left: {
          integer: '2'
        },
        minus: '-',
        right: {
          integer: '2'
        }
      }
    })
  end

  it 'parses multiplication operators [*]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.op_multiplication.parse('*')
    expect(result).to include({
      times: '*'
    })
  end

  it 'parses simple multiplication statements [2*2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2*2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      times: '*',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses simple multiplication statements that include whitespace [2 * 2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2 * 2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      times: '*',
      right: {
        integer: '2'
      }
    })
  end

  it 'parses compound multiplication statements from right to left [2*2*2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2*2*2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      times: '*',
      right: {
        left: {
          integer: '2'
        },
        times: '*',
        right: {
          integer: '2'
        }
      }
    })
  end

  it 'parses compound mixed statements from right to left [2+2-2*2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2+2-2*2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        left: {
          integer: '2'
        },
        minus: '-',
        right: {
          left: {
            integer: '2'
          },
          times: '*',
          right: {
            integer: '2'
          }
        }
      }
    })
  end

  it 'parses division operators [/]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.op_division.parse('/')
    expect(result).to include({
      divided_by: '/'
    })
  end
  
  it 'parses simple division statements [2/2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2/2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      divided_by: '/',
      right: {
        integer: '2'
      }
    })
  end
  
  it 'parses simple division statements that include whitespace [2 / 2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2 / 2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      divided_by: '/',
      right: {
        integer: '2'
      }
    })
  end
  
  it 'parses compound division statements from right to left [2/2/2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2/2/2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      divided_by: '/',
      right: {
        left: {
          integer: '2'
        },
        divided_by: '/',
        right: {
          integer: '2'
        }
      }
    })
  end
  
  it 'parses compound mixed statements from right to left [2+2-2*2/2]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('2+2-2*2/2')
    expect(result).to include({
      left: {
        integer: '2'
      },
      plus: '+',
      right: {
        left: {
          integer: '2'
        },
        minus: '-',
        right: {
          left: {
            integer: '2'
          },
          times: '*',
          right: {
            left: {
              integer: '2'
            },
            divided_by: '/',
            right: {
              integer: '2'
            }
          }
        }
      }
    })
  end

  it 'parses groups of integers and statements using parenthesis [((((2+2)-2)*2)/2)]' do
    parser = TTRPG::DiceRoller::DiceNotationParser.new
    result = parser.parse('((((2+2)-2)*2)/2)')
    expect(result).to include({
      group: {
        left: {
          group: {
            left: {
              group: {
                left: {
                  group: {
                    left:  {
                      integer: '2'
                    },
                    plus: '+',
                    right: {
                      integer: '2'
                    }
                  }
                },
                minus: '-',
                right: {
                  integer: '2'
                }
              }
            },
            times: '*',
            right: {
              integer: '2'
            }
          }
        },
        divided_by: '/',
        right: {
          integer: '2'
        }
      }
    })
  end
  
end
