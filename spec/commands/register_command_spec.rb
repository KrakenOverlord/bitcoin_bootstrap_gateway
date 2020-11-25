require 'spec_helper'
require_relative '../../lib/commands/register_command'

RSpec.describe Commands::RegisterCommand do
  describe "#execute" do
    it "returns nil if there is no authenticated contributor" do
      access_token = Faker::Number.number(digits: 10)
      description = Faker::Number.number(digits: 10)
      authenticator = double('authenticator')
      expect(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_access_token).with(access_token).and_return(nil)

      expect(subject.execute(access_token, description)).to eq(nil)
    end

    it "returns nil if the description too long" do
      access_token = Faker::Number.number(digits: 10)
      description = "1"
      Commands::RegisterCommand::MAX_DESCRIPTION_SIZE.times do
        description << "1"
      end
      authenticator = double('authenticator')
      expect(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_access_token).with(access_token).and_return({})

      expect(subject.execute(access_token, description)).to eq(nil)
    end

    it "returns nil if the contributor is already registered" do
      access_token = Faker::Number.number(digits: 10)
      contributor = {
        'is_candidate' => true
      }
      authenticator = double('authenticator')
      expect(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_access_token).with(access_token).and_return(contributor)

      expect(subject.execute(access_token, nil)).to eq(nil)
    end

    it "returns the updated contributor" do
      access_token = Faker::Number.number(digits: 10)
      description = Faker::Number.number(digits: 10)
      contributor = {
        'username' => Faker::Name.name,
        'is_candidate' => false
      }
      authenticator = double('authenticator')
      expect(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_access_token).with(access_token).and_return(contributor)

      database = double('database')
      allow(Database).to receive(:new).and_return(database)
      expect(database).to receive(:register).with(contributor['username'], description).and_return(contributor)

      expect(subject.execute(access_token, description)).to eq(contributor)
    end
  end
end
