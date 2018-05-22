class Image < ApplicationRecord
  belongs_to :album

  def small_link
    return '' if !self.link

    self.link.first(-4) + 'm' + self.link.last(4)
  end
end
