# frozen_string_literal: true

require_relative 'commit_diff'

module CodePraise
  module Mapper
    # Parge the file change and create commit entity
    class Commit
      def initialize(commit, empty_commit)
        @commit = commit
        @empty_commit = empty_commit
      end

      def build_entity
        Entity::Commit.new(
          committer: committer,
          sha: @commit.sha,
          date: @commit.author_date,
          message: @commit.message,
          size: @commit.size,
          file_changes: file_changes
        )
      end

      private

      def committer
        Entity::Contributor.new(
          username: @commit.author.name,
          email: @commit.author.email
        )
      end

      def file_changes
        file_change_array = CommitDiff.parser(commit_diff)
        file_change_array.each do |file_change|
          Entity::FileChange.new(
            path: file_change[:path],
            name: file_change[:name],
            addition: file_change[:addition],
            deletion: file_change[:deletion],
            modification: file_change[:modification]
          )
        end
      end

      def commit_diff
        if @commit.parent.nil?
          @empty_commit.diff(@commit)
        else
          @commit.parent.diff(@commit)
        end
      end
    end
  end
end
