# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  first_name :string
#  last_name  :string
#  address1   :string
#  address2   :string
#  city       :string
#  state      :string
#  zip        :string
#  email      :string
#  phone      :string
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build :profile }

  it { is_expected.to be_valid }

  describe '#full_name' do
    it 'does something' do
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end
end
