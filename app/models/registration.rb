class Registration < ApplicationRecord
  belongs_to :event

  belongs_to :user

  # validates :name, presence: true

  # validates :email, format: { with: /\S+@\S+/ }
  
  HOW_HEARD_OPTIONS=['news letter','blog post','twitter','friend','web server','instagram','other']

  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }

end
