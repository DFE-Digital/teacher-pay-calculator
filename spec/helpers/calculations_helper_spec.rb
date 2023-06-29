require 'rails_helper'

RSpec.describe CalculationsHelper, type: :helper do
  describe '.paybands_and_spine_points_options' do
    subject { helper.paybands_and_spine_points_options }

    let(:expected_results) do
      [
        described_class::Option.new('unq1', 'Unqualified Pay Range 1 (UnQ1)'),
        described_class::Option.new('unq2', 'Unqualified Pay Range 2 (UnQ2)'),
        described_class::Option.new('unq3', 'Unqualified Pay Range 3 (UnQ3)'),
        described_class::Option.new('unq4', 'Unqualified Pay Range 4 (UnQ4)'),
        described_class::Option.new('unq5', 'Unqualified Pay Range 5 (UnQ5)'),
        described_class::Option.new('unq6', 'Unqualified Pay Range 6 (UnQ6)'),
        described_class::Option.new('m1', 'Main Pay Range 1 (M1)'),
        described_class::Option.new('m2', 'Main Pay Range 2 (M2)'),
        described_class::Option.new('m3', 'Main Pay Range 3 (M3)'),
        described_class::Option.new('m4', 'Main Pay Range 4 (M4)'),
        described_class::Option.new('m5', 'Main Pay Range 5 (M5)'),
        described_class::Option.new('m6', 'Main Pay Range 6 (M6)'),
        described_class::Option.new('u1', 'Upper Pay Range (U1)'),
        described_class::Option.new('u2', 'Upper Pay Range (U2)'),
        described_class::Option.new('u3', 'Upper Pay Range (U3)'),
        described_class::Option.new('leading_practitioner', 'Leading Practitioner'),
        described_class::Option.new('leadership', 'Leadership')
      ]
    end

    it { is_expected.to eq(expected_results) }
  end

  describe '.paybands_and_spine_points_including_no_option' do
    subject { helper.paybands_and_spine_points_including_no_option }

    let(:expected_results) do
      [
        described_class::Option.new('no_option', I18n.t('questions.no_option.label')),
        described_class::Option.new('unq1', 'Unqualified Pay Range 1 (UnQ1)'),
        described_class::Option.new('unq2', 'Unqualified Pay Range 2 (UnQ2)'),
        described_class::Option.new('unq3', 'Unqualified Pay Range 3 (UnQ3)'),
        described_class::Option.new('unq4', 'Unqualified Pay Range 4 (UnQ4)'),
        described_class::Option.new('unq5', 'Unqualified Pay Range 5 (UnQ5)'),
        described_class::Option.new('unq6', 'Unqualified Pay Range 6 (UnQ6)'),
        described_class::Option.new('m1', 'Main Pay Range 1 (M1)'),
        described_class::Option.new('m2', 'Main Pay Range 2 (M2)'),
        described_class::Option.new('m3', 'Main Pay Range 3 (M3)'),
        described_class::Option.new('m4', 'Main Pay Range 4 (M4)'),
        described_class::Option.new('m5', 'Main Pay Range 5 (M5)'),
        described_class::Option.new('m6', 'Main Pay Range 6 (M6)'),
        described_class::Option.new('u1', 'Upper Pay Range (U1)'),
        described_class::Option.new('u2', 'Upper Pay Range (U2)'),
        described_class::Option.new('u3', 'Upper Pay Range (U3)'),
        described_class::Option.new('leading_practitioner', 'Leading Practitioner'),
        described_class::Option.new('leadership', 'Leadership')
      ]
    end

    it { is_expected.to eq(expected_results) }
  end

  describe '.area_options_london' do
    subject { helper.area_options_london }

    let(:expected_results) do
      [
        described_class::Option.new('inner_london', 'Inner London'),
        described_class::Option.new('outer_london', 'Outer London'),
        described_class::Option.new('london_fringe', 'Fringe of London')
      ]
    end

    it { is_expected.to eq(expected_results) }
  end

  describe '.area_option_rest_of_england' do
    subject { helper.area_option_rest_of_england }

    let(:expected_results) do
        described_class::Option.new('rest_of_england', 'Rest of England')
    end

    it { is_expected.to eq(expected_results) }
  end
end
