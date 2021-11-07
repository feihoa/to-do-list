class Project < ApplicationRecord
    has_many :tasks, -> { order("created_at desc") }
    validates :title, presence: true, uniqueness: true
end
