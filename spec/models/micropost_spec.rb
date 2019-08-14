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

  context 'with validations' do
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

  context 'show most recent post created' do
    before do
      Micropost.create(
        content: 'foo bar',
        user_id: user.id,
        created_at: Time.zone.now
      )

      Micropost.create(
        content: 'go to bar',
        user_id: user.id,
        created_at: Time.zone.now + 5.minutes
      )
    end

    let(:most_recent_post) { Micropost.first }

    it 'should return the most recent post created' do
      expect(most_recent_post.content).to eq 'go to bar'
    end
  end
end
