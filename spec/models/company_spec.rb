require 'rails_helper'

RSpec.describe Company, type: :model do
  
  context "Company valid" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:token) }
  end

end
