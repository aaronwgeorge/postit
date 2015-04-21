class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true

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