describe DataLoader::Calculator do
  subject(:result) { described_class.call(current:, future:) }

  context "for exact salary value" do
    let(:current) { [30_000] }
    let(:future) { [31_500] }

    it { is_expected.to have_values increase: 1500 }
    it { is_expected.to have_values increase_percentage: 5.0 }
    it { is_expected.to have_values type: :value }
    it { is_expected.to have_values current: 30_000 }
    it { is_expected.to have_values future: 31_500 }
  end

  context "for salary bands" do
    let(:current) { [30_000, 36_000] }
    let(:future) { [31_500, 37_500] }

    it { is_expected.to have_values increase: 1500..1500 }
    it { is_expected.to have_values increase_percentage: 4.2..5.0 }
    it { is_expected.to have_values type: :range }
    it { is_expected.to have_values current: 30_000..36_000 }
    it { is_expected.to have_values future: 31_500..37_500 }
  end

  # Built-in `include` matcher performs soft comparisons of range inclusions and yields false positives
  matcher :have_values do |opts|
    match do |subject|
      expect(subject.values_at(*opts.keys)).to eq opts.values
    end
  end
end
