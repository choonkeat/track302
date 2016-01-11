module Track302
  class Link < ActiveRecord::Base
    before_create :set_uuid

    def set_uuid
      loop while self.class.find_by(uuid: (self.uuid = SecureRandom.uuid))
    end
  end
end
