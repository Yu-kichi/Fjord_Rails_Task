# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :order_by_recent, -> { order(updated_at: :desc) }
  
  def editable?(current_user)
    if current_user
      user.id == current_user.id
    end
  end
  
end
