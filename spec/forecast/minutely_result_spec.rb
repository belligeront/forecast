require_relative '../../lib/forecast'

module Forecast
  describe MinutelyResult do
    describe "#least_precip_range" do
      it "returns the range of lowest precip intensity for a given duration" do
        min_start = 1377802200
        data = [ {:time=>1377801960, :precipIntensity=>0.3, :precipProbability=>0},
                 {:time=>1377802020, :precipIntensity=>0.3, :precipProbability=>0},
                 {:time=>1377802080, :precipIntensity=>0.3, :precipProbability=>0},
                 {:time=>1377802140, :precipIntensity=>0.2, :precipProbability=>0},
                 {:time=> min_start, :precipIntensity=>0.1, :precipProbability=>0},
                 {:time=>1377802260, :precipIntensity=>0.1, :precipProbability=>0},
                 {:time=>1377802320, :precipIntensity=>0.2, :precipProbability=>0},
                 {:time=>1377802380, :precipIntensity=>0.2, :precipProbability=>0} ]
        duration = 2
        least_precip = MinutelyResult.new(data).least_precip_range(duration)
        expect(least_precip).to be_kind_of TimeRange
        expect(least_precip.start_time.to_i).to eq Time.at(min_start).to_i
      end
    end
  end
end
