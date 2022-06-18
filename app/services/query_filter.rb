class QueryFilter
  def self.filter_relation(relation, params, limit = nil, offset = nil)
    sql = relation
    params.each do |table, values|
      values.each do |field, values2|
        values2.each do |type, value|
          value = treat_string(value)

          case type.to_s
          when 'search'
            value = ["%#{value}%"]
            condition = "#{table}.#{field} ILIKE ?"
          when 'is_null'
            condition = "#{table}.#{field} IS NULL"
          when 'is_not_null'
            condition = "#{table}.#{field} IS NOT NULL"
          when 'boolean'
            if value == 'true'
              condition = "#{table}.#{field} = #{value}"
            else
              condition = "#{table}.#{field} = #{value} OR #{table}.#{field} IS NULL"
            end
          else
            if value.kind_of?(Array)
              condition = "#{table}.#{field} IN('#{value.join("','")}')"
            else
              condition = "#{table}.#{field} = ?"
            end
          end
          if ['is_null', 'is_not_null'].include?(type)
            sql = sql.where(condition)
          else
            sql = sql.where(condition, *value) unless value.blank?
          end
        end
      end
    end

    sql = sql.limit(limit) unless limit.nil?
    sql = sql.offset(offset) unless offset.nil?

    sql
  end

  def self.treat_string(value)
    if value.kind_of?(Array)
      value.map { |item| (item.kind_of?(String) && (item.include? "'")) ? item.insert(item.index("'"), "'") : item }
    else
      (value.kind_of?(String) && (value.include? "'")) ? value.insert(value.index("'"), "'") : value
    end
  end
end
