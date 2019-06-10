require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:subject) do
    described_class.new(
      name: 'Birner',
      email: 'birner@gmail.com',
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  context 'with validations' do
    it 'should be valid with correct data' do
      expect(subject).to be_valid
    end

    it 'name should be present' do
      subject.name = ''

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Name can't be blank"]
      )
    end

    it 'name should not be too long' do
      subject.name = "a" * 51

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Name is too long (maximum is 50 characters)"]
      )
    end

    it 'email should be present' do
      subject.email = ''

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Email can't be blank", "Email is invalid"]
      )
    end

    it 'email should not be too long' do
      subject.email = "a" * 244 + "@example.com.br"

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Email is too long (maximum is 255 characters)"]
      )
    end

    it 'email should reject invalid addresses' do
      subject.email = "umemailnaovalido"

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Email is invalid"]
      )
    end

    it 'email address should be unique' do
      duplicate_user = subject.dup
      duplicate_user.email = subject.email.upcase
      subject.save

      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to match_array(
        ["Email has already been taken"]
      )
    end

    it 'email should be saved in lower case' do
      mixed_case_email = 'FoO@eXaMpLe.com.br'
      subject.email = mixed_case_email

      expect{ subject.save }.to change{ User.count }.by(1)
      expect(subject.email).to eq mixed_case_email.downcase
    end

    it 'password should be present' do
      subject.password = nil

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Password can't be blank"]
      )
    end

    it 'password should have minimum length' do
      subject.password = 'foo'
      subject.password_confirmation = 'foo'

      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to match_array(
        ["Password is too short (minimum is 6 characters)"]
      )
    end

    it 'password confirmation must match' do
      subject.password_confirmation = 'barfoo'
      subject.save

      expect(subject.errors.full_messages).to match_array(
        ["Password confirmation doesn't match Password"]
      )
    end
  end
end
