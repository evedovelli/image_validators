require "image_validators/version"

class DimensionsValidator < ActiveModel::EachValidator
  AVAILABLE_CHECKS = [:less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to, :equal_to]

  def meet_constraints(operation, image_dimension, threshold)
    return true unless threshold

    case operation
    when :less_than
      return image_dimension < threshold
    when :less_than_or_equal_to
      return image_dimension <= threshold
    when :greater_than
      return image_dimension > threshold
    when :greater_than_or_equal_to
      return image_dimension >= threshold
    when :equal_to
      return image_dimension == threshold
    else
      raise ArgumentError, "You must pass either :less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to, or :equal_to to the validator"
    end
  end

  def validate_each(record, attribute, value)
    if record.send("#{attribute}?".to_sym) and value.queued_for_write[:original]
      dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)

      options.slice(*AVAILABLE_CHECKS).each do |operation, params|
        width = params[:width]
        height = params[:height]

        # Width
        if (not meet_constraints(operation, dimensions.width.to_i, width))
          record.errors[attribute] <<
              (options[:message] || I18n.t('image_validators.errors.' + operation.to_s + '.width',
                                           default: "width must be "  + operation.to_s.humanize.downcase + " %{width}px",
                                           width:  width))
        end

        # Height
        if (not meet_constraints(operation, dimensions.height.to_i, height))
          record.errors[attribute] <<
              (options[:message] || I18n.t('image_validators.errors.' + operation.to_s + '.height',
                                           default: "height must be " + operation.to_s.humanize.downcase + " %{height}px",
                                           height: height))
        end

      end
    end
  end

  def check_validity!
    unless (AVAILABLE_CHECKS).any? { |argument| options.has_key?(argument) }
      raise ArgumentError, "You must pass either :less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to, or :equal_to to the validator"
    end
  end
end
