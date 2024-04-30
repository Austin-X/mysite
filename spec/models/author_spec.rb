require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { create(:author) }

  it { is_expected.to have_many(:books)}

  it "has an author" do
    expect(author.name).to eq("TestName")
  end
end
