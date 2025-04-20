module ReportHelper
  def filter_label(report_filters)
    filters = []

    if report_filters.present?
      report_filters.keys.each do |key|
        label = report_filters["#{key}"].split("|")[0]
        description = report_filters["#{key}"].split("|")[1]
        filters << "#{label}: <strong>#{description}</strong>"
      end
    end

    filters
  end

  def report_state_icon(export, options = {})
    case export.aasm_state
    when 'created'
      icon_class = 'circle'
      color_class = 'dark'
    when 'started'
      icon_class = 'circle'
      color_class = 'orange'
    when 'exported'
      icon_class = 'check'
      color_class = 'green'
    when 'blocked'
      icon_class = 'x'
      color_class = 'red'
    else
      icon_class = ''
      color_class = ''
    end
    options.merge!(title: export.aasm.human_state, class: [options.try(:fetch, :class, ''), color_class].join(' '), data: {feather: icon_class})

    content_tag(:i, nil, options)
  end
end