# frozen_string_literal: true


RSpec.describe 'Dice Box', :type => :aruba do
  it "has a version number" do
    expect(TTRPG::DiceBox::VERSION).not_to be nil
  end

  let(:content) { '111' }
  before { run_command('dice-box roll 111') }
  it "echos a single interger" do
    expect(last_command_started).to have_output content
  end
end
