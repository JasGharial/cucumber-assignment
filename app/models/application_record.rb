class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.pluck_to_hash(*keys)
    # This method is used for 'pluck' and assign the values to the columns results
    pluck(*keys).map { |pa| Hash[keys.map(&:to_s).zip(pa.map(&:to_s))] }
  end

  def self.decimal_normalization(number)
    ->(number) { '%.2f' % number }
  end
end
