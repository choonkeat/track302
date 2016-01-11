module Track302
  class Click < ActiveRecord::Base
    belongs_to :link

    begin
      case coltype = column_for_attribute(:data).type
      when :text, :string, :binary
        serialize :data, JSON
      end
    rescue Exception
      # pgsql!
    end

  end
end
