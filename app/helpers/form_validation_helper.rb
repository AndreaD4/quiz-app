module FormValidationHelper

  def presence_required_attrs(model, context = nil)
    # validators_on(:attribute)
    model.validators.select do |v|
      v.options[:if].nil? and
          v.is_a?(ActiveRecord::Validations::PresenceValidator) and
          (v.options[:on].nil? or v.options[:on] == context or
              (v.options[:on].is_a?(Array) and v.options[:on].include?(context)))
    end.map(&:attributes).flatten.uniq
  end

  def pattern_fields(model, context = nil)
    pattern_fields = {}
    model.validators.each do |v|
      if v.options[:on].nil? or v.options[:on] == context or
          (v.options[:on].is_a?(Array) and v.options[:on].include?(context))
        if v.kind == :format
          v.attributes.each do |attribute|
            pattern_fields[attribute] = v.options[:with]
          end
          # elsif v.kind == :numericality
        end
      end
    end
    pattern_fields
  end


end