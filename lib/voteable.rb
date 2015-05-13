#using "concerns" (rails way)
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end
  
  def count_up_votes
    self.votes.where(vote: true).size
  end

  def count_down_votes
    self.votes.where(vote: false).size
  end

  def vote_total
    count_up_votes - count_down_votes
  end
end

#normal metaprogramming
# module Voteable
#   def self.included(base)
#     base.send(:include, InstanceMethods)
#     base.extend ClassMethods
#     base.class_eval do
#       votes
#     end
#   end

#   module InstanceMethods
#     def count_up_votes
#       self.votes.where(vote: true).size
#     end

#     def count_down_votes
#       self.votes.where(vote: false).size
#     end

#     def vote_total
#       count_up_votes - count_down_votes
#     end
#   end

#   module ClassMethods
#     def votes
#       has_many :votes, as: :voteable
#     end
#   end
# end