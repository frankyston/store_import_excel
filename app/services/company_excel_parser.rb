class CompanyExcelParser
  attr_accessor :path, :file

  def self.call(*args)
    new(*args).call
  end

  def initialize(path)
    @path = path
  end

  def call
    @file = Roo::Spreadsheet.open(@path.to_s, extension: :xlsx)
    rows = @file.sheet(@file.sheets.first).to_a
    rows.shift

    rows.map do |row|
      {
        name: row[0],
        code: row[1],
        token: row[2]
      }
    end
  end
end
