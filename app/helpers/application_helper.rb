module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-error'
    when 'alert'
      'alert-info'
    when 'notice'
      'alert-info'
    else
      flash_type
    end
  end

  def field_class_name(obj, field)
    obj.errors.messages[field].empty? ? 'form-control' : 'form-control is-invalid'
  end

  def field_errors(obj, field)
    tag.div obj.errors.messages[field].join(), class: 'invalid-feedback'
  end
end
