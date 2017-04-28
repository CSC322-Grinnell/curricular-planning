class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :offering
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_format_of :email, with: /\@grinnell\.edu/, message: 'You should have an email from grinnell.edu'
         
  cattr_accessor :current_user
end
