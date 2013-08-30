require_relative '../../lib/forecast'

module Forecast
  describe TimeRange do
    describe "initialization" do
      it "converts numerics to Time" do
        range =TimeRange.new(1377801960, 1377801961)
        expect(range.start_time).to be_kind_of Time
        expect(range.end_time).to be_kind_of Time
      end
    end

    let(:thirty_mins_from_now) { Time.at(Time.now.to_i + 30 * 60) }

    describe "#duration" do
      it 'returns an Integer representing the number of minutes in the range' do
        thirty_mins = TimeRange.new(Time.now, thirty_mins_from_now)
        thirty_mins.duration.should be_within(1).of(30)
      end
    end
  end
end
