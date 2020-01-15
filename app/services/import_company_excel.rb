require 'roo'

class ImportCompanyExcel
  attr_accessor :path, :capture_errors

  def initialize(path)
    @path = path
    @capture_errors = []
  end

  def execute
    create_records
  end

  def errors
    @capture_errors
  end

  private

  def parsed_data
    CompanyExcelParser.call(path)
  end

  def create_records
    Company.transaction do
      begin
        Company.create!(parsed_data)
      rescue ActiveRecord::RecordInvalid => e
        @capture_errors << e
        raise ActiveRecord::Rollback
      end
    end
  end
end