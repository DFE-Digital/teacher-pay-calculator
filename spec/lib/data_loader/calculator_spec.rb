describe DataLoader::Calculator do
  subject(:result) { described_class.call(current:, first_year_future:, second_year_future:) }

  let(:second_year_future) { nil }

  context "for exact salary value" do
    let(:current) { [30_000] }
    let(:first_year_future) { [31_500] }

    it { is_expected.to have_values first_year_increase: 1500 }
    it { is_expected.to have_values increase_percentage: 5.0 }
    it { is_expected.to have_values type: :value }
    it { is_expected.to have_values current: 30_000 }
    it { is_expected.to have_values first_year_future: 31_500 }
  end

  context "for salary bands" do
    let(:current) { [30_000, 36_000] }
    let(:first_year_future) { [31_500, 37_500] }

    it { is_expected.to have_values first_year_increase: 1500..1500 }
    it { is_expected.to have_values increase_percentage: 4.2..5.0 }
    it { is_expected.to have_values type: :range }
    it { is_expected.to have_values current: 30_000..36_000 }
    it { is_expected.to have_values first_year_future: 31_500..37_500 }
  end

  context "when explicit second year values are provided" do
    let(:current) { [30_000] }
    let(:first_year_future) { [31_500] }
    let(:second_year_future) { [33_075] }

    it { is_expected.to have_values second_year_future: 33_075 }
    it { is_expected.to have_values second_year_increase: 1575 }
    it { is_expected.to have_values second_year_increase_percentage: 5.0 }
  end

  # Built-in `include` matcher performs soft comparisons of range inclusions and yields false positives
  matcher :have_values do |opts|
    match do |subject|
      expect(subject.values_at(*opts.keys)).to eq opts.values
    end
  end
end
