module ActiveRecord
  module FindInBatchesWithOrder

    def find_each
      sql = self.to_sql.downcase
      if sql.present?
        plucks = [sql.split('from ')[1].split(" ")[0].gsub('"', '') + '.id']

        if sql.include?('order by')
          plucks = plucks + sql.split('order by ')[1].gsub(" asc", "").gsub(" desc", "").split(',')
        end

        records_ids = self.pluck(plucks.join(','))
        records_ids = records_ids.uniq if plucks.count == 1
        records_ids = records_ids.uniq { |m| m.first } if plucks.count > 1

        records_ids.in_groups_of(1000, false).each do |ids|
          list_ids = ids

          if plucks.count > 1
            list_ids = ids.map { |a| a.first }
          end
          # ANY (VALUES (15368196), -- 11,000 other keys --)
          self.where("#{plucks.first} IN (?)", list_ids).each do |record|
            yield record
          end
        end
      end
    end

  end

  class Relation
    include FindInBatchesWithOrder
  end
end