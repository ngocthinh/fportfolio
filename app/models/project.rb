class Project < ApplicationRecord
  belongs_to :category
  has_many :feedbacks, dependent: :destroy
  has_many :participates, dependent: :destroy
  has_many :users, through: :participates
  has_many :messages, dependent: :destroy
  has_many :likes, as: :target
  has_many :images, as: :target
  has_many :targettechniques, as: :target
  has_many :comments, as: :target

  scope :order_by_newest, ->{order created_at: :desc}

  accepts_nested_attributes_for :images, allow_destroy: true

  #validate :check_max_files
  validates :name, presence: true,
   length: {maximum: Settings.project.name_length}
  validates :url, presence: true,
   length: {maximum: Settings.project.url_length}
  validates :description, presence: true,
   length: {maximum: Settings.project.description_length}
  validates :realease_note, presence: true,
   length: {maximum: Settings.project.realease_note_length}
  validates :git_repository, presence: true,
   length: {maximum: Settings.project.git_repository_length}
  validates :server_information, presence: true,
   length: {maximum: Settings.project.server_information_length}
  validates :platform, presence: true,
   length: {maximum: Settings.project.platform_length}
  validates :core_features, presence: true,
   length: {maximum: Settings.project.core_features_length}
  validates :pm_url, presence: true,
   length: {maximum: Settings.project.pm_url_length}

  ratyrate_rateable :rating

  PRIVATE_ATTRIBUTES = {server_information: "server_information",
    git_repository: "git_repository", pm_url: "pm_url"}

  BRANCH = [[Settings.branch.hanoi, 0],[Settings.branch.danang, 1]]
  private

  def check_max_files
    if images.blank? || images.size > Settings.project.max_image_files
      errors.add(:dagger, I18n.t("projects.check_max_files"))
    end
  end

  def self.show_for_rating
    Project.all.sort_by {|u| [u.average(:rating) ? u.average(:rating).avg : 0, u.average(:rating)]}.reverse
  end
end
