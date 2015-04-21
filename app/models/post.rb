class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

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