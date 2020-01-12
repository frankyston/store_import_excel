require 'rails_helper'

RSpec.describe ImportCompanyExcel do

  describe "#execute" do
    it "should success import" do
      # sucesso
      path = Rails.root.join('spec', 'fixtures', 'empresas-sucesso.xlsx')
      import_excel = ImportCompanyExcel.new(path)

      import_excel.execute
      expect(import_excel.errors.count).to eq(0)
      expect(Company.count).to eq(5)
    end

    it "should error import" do
      # falha
      path = Rails.root.join('spec', 'fixtures', 'empresas-erro.xlsx')
      import_excel = ImportCompanyExcel.new(path)

      import_excel.execute
      expect(import_excel.errors.count).to_not eq(0)
      expect(Company.count).to eq(0)
    end
  end

end