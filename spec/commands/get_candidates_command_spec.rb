require 'spec_helper'
require_relative '../../lib/commands/get_candidates_command'

RSpec.describe Commands::GetCandidatesCommand do
  describe "#execute" do
    it "returns all the contributors registered as candidates" do
      contributor_username = Faker::Name.name
      candidate_username = Faker::Name.name
      contributors = [
        {
          'username' => contributor_username,
          'is_candidate' => false
        },
        {
          'username' => candidate_username,
          'is_candidate' => true
        }
      ]

      database = double('database')
      allow(Database).to receive(:new).and_return(database)
      expect(database).to receive(:get_contributors).and_return(contributors)

      candidates = subject.execute
      expect(candidates.last['username']).to eq(candidate_username)
    end

    it "removed the voted_for field to protect voter privacy" do
      candidate_username = Faker::Name.name
      contributors = [
        {
          'username' => candidate_username,
          'is_candidate' => true,
          'voted_for' => candidate_username
        }
      ]

      database = double('database')
      allow(Database).to receive(:new).and_return(database)
      expect(database).to receive(:get_contributors).and_return(contributors)

      candidates = subject.execute
      expect(candidates.last['voted_for']).to eq(nil)
    end
  end
end
