require 'spec_helper'
require_relative '../../lib/commands/signin_command'

RSpec.describe Commands::SigninCommand do
  describe "#execute" do
    it "returns nil if it can't get an authenticated contributor" do
      code = Faker::Number.number(digits: 10)
      authenticator = double('authenticator')
      allow(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_code).with(code).and_return(nil)

      expect(subject.execute(code)).to eq(nil)
    end

    it "returns a contributor from the code" do
      code = Faker::Number.number(digits: 10)
      contributor = {
        'username' => Faker::Name.name,
        'access_token' => Faker::Number.number(digits: 10)
      }
      authenticator = double('authenticator')
      allow(Authenticator).to receive(:new).and_return(authenticator)
      expect(authenticator).to receive(:signin_with_code).with(code).and_return(contributor)

      database = double('database')
      allow(Database).to receive(:new).and_return(database)
      expect(database).to receive(:update_access_token).with(contributor['username'], contributor['access_token']).and_return(contributor)

      expect(subject.execute(code)).to eq(contributor)
    end
  end
end
