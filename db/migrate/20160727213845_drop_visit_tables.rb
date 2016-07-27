class DropVisitTables < ActiveRecord::Migration
  def change
    drop_table  :visit_tables
  end
end
