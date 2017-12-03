module ApplicationHelper
  def bootstrap_class_for(flash_type)
    if flash_type == 'alert'
      'alert-error'
    else
      'alert-info'
    end
  end

  def field_class_name(obj, field)
    if obj.errors.messages[field].empty?
      'form-control'
    else
      'form-control is-invalid'
    end
  end

  def field_errors(obj, field)
    tag.div obj.errors.messages[field].join, class: 'invalid-feedback'
  end
end
