require_relative '../spec_helper'

RSpec.describe Micropost, type: :model do
  before do
    User.create(
      name:  "Andersonson",
      email: "a@foo.com",
      password: "123123",
      password_confirmation: "123123",
      admin: false,
      activated: true,
      activated_at: Time.zone.now
    )
  end

  let(:user) { User.first }
  
  let(:micropost) do
    user.microposts.build(content: 'Lorem Ipsum', user_id: User.first.id)
  end

  context "with validations" do
    it { expect(micropost).to be_valid }

    it 'user id should be present' do
      micropost.user_id = nil
      expect(micropost).not_to be_valid
    end

    it 'content should be present' do
      micropost.content = nil
      expect(micropost).not_to be_valid
    end

    it 'content should be at most 140 characters' do
      micropost.content = 'a' * 141
      expect(micropost).not_to be_valid
    end
  end
end
