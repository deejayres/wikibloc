class Wiki < ActiveRecord::Base
  belongs_to :user
  resourcify
end
