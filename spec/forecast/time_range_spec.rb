require_relative '../../lib/forecast'

module Forecast
  describe TimeRange do
    describe ".duration" do
      let(:thirty_mins_from_now) { Time.at (Time.now.to_i + 30 * 60) }

      it 'returns an Integer representing the number of minutes in the range' do
        thirty_mins = TimeRange.new(Time.now, thirty_mins_from_now)
        thirty_mins.duration.should be_within(1).of(30)
      end
    end
  end
end
