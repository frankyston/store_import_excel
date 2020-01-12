require 'roo'

class ImportCompanyExcel
  attr_accessor :file, :path, :capture_errors

  def initialize(path)
    @path = path
    @capture_errors = []
  end

  def execute
    prepare_objects
    create_records
  end

  def errors
    @capture_errors
  end

  private

  def prepare_objects
    @file = Roo::Spreadsheet.open(@path.to_s, extension: :xlsx)
    rows = @file.sheet(@file.sheets.first).to_a
    rows.shift

    @parsed_data = rows.map do |row|
      {
        name: row[0],
        code: row[1],
        token: row[2]
      }
    end
  end

  def create_records
    Company.transaction do
      begin
        Company.create!(@parsed_data)
      rescue ActiveRecord::RecordInvalid => e
        @capture_errors << e
        raise ActiveRecord::Rollback
      end
    end
  end
end