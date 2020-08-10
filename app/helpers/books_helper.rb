# frozen_string_literal: true

module BooksHelper
  def translate_attribute(attribute)
    Book.human_attribute_name(attribute)
  end
end
