# frozen_string_literal: true


RSpec.describe TTRPG::DiceRoller do
  it "has a version number" do
    expect(TTRPG::DiceRoller::VERSION).not_to be nil
  end
end

RSpec.describe TTRPG::DiceRoller, :type => :aruba do
  let(:result) { '111' }
  before { run_command('roll 111') }
  it "echos a single interger" do
    expect(last_command_started).to have_output result
  end
end

RSpec.describe TTRPG::DiceRoller, :type => :aruba do
  let(:result) { '222' }
  before { run_command('roll 111 + 111') }
  it "adds two intergers" do
    expect(last_command_started).to have_output result
  end
end

RSpec.describe TTRPG::DiceRoller, :type => :aruba do
  let(:result) { '111' }
  before { run_command('roll 333 - 222') }
  it "subtracts two intergers" do
    expect(last_command_started).to have_output result
  end
end
