require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belongs_to(:invoice) }
  end
end
