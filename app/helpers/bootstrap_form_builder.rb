class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  include FormValidationHelper
  include ActionView::Helpers::TagHelper

  # %w(text_field email_field password_field).each do |selector|
  #   class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
  #     def #{selector}(method, options = {})
  #       super(method, insert_class("form-control", options))
  #     end
  #   RUBY_EVAL
  # end

  def new_options(method, options)
    required_fields = presence_required_attrs(object.class, self.options[:context])
    is_invalid = object.errors.full_messages_for(method).count > 0
    new_options = options
    # new_options = insert_class("is-invalid", options) if is_invalid
    new_options = insert_class("form-control form-control-small", new_options)
    new_options = insert_required(new_options) if is_invalid || required_fields.include?(method)
    new_options
  end

  def new_options_default(method, options)
    required_fields = presence_required_attrs(object.class, self.options[:context])
    is_invalid = object.errors.full_messages_for(method).count > 0
    new_options = options
    # new_options = insert_class("is-invalid", options) if is_invalid
    new_options = insert_class("form-control", new_options)
    new_options = insert_required(new_options) if is_invalid || required_fields.include?(method)
    new_options
  end

  def association(association, choise = nil, options = {}, html_options = {}, &block)
    method = options[:foreign_key] || :"#{association}_id"
    select(method, choise, options, html_options, &block)
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    super(method, choices, options, new_options(method, html_options), &block)
  end

  def errors(method, invalid_class = 'invalid-feedback', options = {})
    if object.errors.full_messages_for(method).count > 0
      help_block(object.errors.full_messages_for(method).join('<br>'), invalid_class).html_safe
    else
      required_fields = presence_required_attrs(object.class, self.options[:context])
      if required_fields.include?(method) or options[:required]
        help_block(I18n.t('errors.messages.blank'), invalid_class)
      end
    end
    # object.errors.full_messages_for(method).map { |m| help_block(m, invalid_class) }.join.html_safe
  end

  def help_block(message, invalid_class)
    %Q(<div class="#{invalid_class}">#{message}</div>).html_safe
  end

  def text_field(method, options = {})
    super(method, new_options(method, options))
  end

  def number_field(method, options = {})
    super(method, new_options(method, options))
  end

  def text_area(method, options = {})
    super(method, new_options_default(method, options))
  end

  def label(method, text = nil, options = {}, &block)
    label_text = text
    label_text = object.class.human_attribute_name(method) if label_text.nil?
    if options[:class].present? and options[:class].include?('form-label')
      super(method, label_text, options, &block)
    else
      required_fields = presence_required_attrs(object.class, self.options[:context])
      if options[:required] and !required_fields.include?(method)
        required_fields << method
      end
      # inner_html = @template.capture(&block)
      inner_html = block
      if inner_html.nil? and (required_fields.include?(method) || object.errors.full_messages_for(method).count > 0)
        inner_html = Proc.new { %Q(#{label_text}<span class="ml-1 text-danger">*</span>).html_safe }
      end
      super(method, label_text, insert_class("form-label", options), &inner_html)
    end
  end

  def group(method, options = {}, &block)
    options[:class] ||= ''

    # if object.errors.full_messages_for(method).count > 0
    #   options[:class] += " form-group was-validated mb-1"
    # else
      options[:class] += " form-group mb-1"
    # end

    content = @template.capture(&block)

    content_tag :div, content, options
  end

  private

  def insert_class(class_name, options)
    output = options.dup
    output[:class] = ((output[:class] || "") + " #{class_name}").strip
    output
  end

  def insert_required(options)
    output = options.dup
    output[:required] = true
    output
  end

end