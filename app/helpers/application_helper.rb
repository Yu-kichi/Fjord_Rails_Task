# frozen_string_literal: true

module ApplicationHelper
  require "html/pipeline"

  def auto_link_filter(text)
    filter = HTML::Pipeline::AutolinkFilter.new(text)
    filter.call.html_safe
  end
end
