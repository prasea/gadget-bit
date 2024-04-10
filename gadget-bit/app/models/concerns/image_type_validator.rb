# app/models/concerns/image_type_validator.rb
class ImageTypeValidator < ActiveModel::Validator
  def validate(record)
    if record.images.none?
      record.errors.add(:images, 'of product must be present')
    else
      record.images.each do |image|
        unless image.content_type.in?(%w(image/jpeg image/png))
          record.errors.add(:images, 'of product must be a JPEG or PNG')
          break
        end
      end
    end
  end
end
