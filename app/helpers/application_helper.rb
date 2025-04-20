module ApplicationHelper
  def boolean_to_check_or_times value
    value ? content_tag(:span, '', class: 'fas fa-check') : content_tag(:span, '', class: 'fas fa-times')
  end

  def human_boolean(boolean)
    boolean ? t('simple_form.yes') : t('simple_form.no')
  end

  def sortable(column, title = nil, url_method = nil, options = {})
    title ||= column.titleize
    icon = if column == sort_column
             if sort_direction == 'asc'
               "<i class='pl-1 fa fa-sort-down'></i>"
             else
               "<i class='pl-1 fa fa-sort-up'></i>"
             end
           else
             "<i class='pl-1 fa fa-sort'></i>"
           end
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    if url_method.present?
      url = send(url_method, { sort: column, direction: direction })
    else
      url = request.params.merge(sort: column, direction: direction)
    end

    link_to "#{title}#{icon}".html_safe, url, options
  end


  def aria_expanded_if_current_page(entry:)
    selected = is_current_page?(entry)
    aria = 'false'
    unless current_page?(entry[:href])
      aria = 'true'
    end
    aria if selected
  end

  def collapse_show_if_current_page(entry:)
    selected = is_current_page?(entry)
    collapse = ''
    unless current_page?(entry[:href])
      collapse = 'show'
    end
    collapse if selected
  end

  def class_if_current_page(entry:)
    selected = is_current_page?(entry)

    class_name = 'font-semibold active'

    class_name if selected
  end

  def filter_tags_from_title(title)
    title.downcase
  end

  def i18n_from_title(prefix:, title:)
    "#{prefix}#{title.downcase.gsub(' ', '_')}"
  end

  def params_count(params)
    unless params.present?
      return 0
    end

    return params.to_enum.to_h.count { |key, value| !value.blank? }
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end


  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize, :f => builder)
    end
    #link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def random_password(length=8)
    chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    chars.sort_by { rand }.join[0...length]
  end

  private

  def is_current_page?(entry)
    if current_page?(entry[:href])
      true
    elsif entry[:children]
      entry[:children].any?(&method(:is_current_page?))
    else
      false
    end
  end
end
