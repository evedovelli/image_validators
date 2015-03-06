require 'spec_helper'

class TestModel
  include ActiveModel::Validations
  def initialize(attributes = {})
    @attributes = attributes
  end
  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class Photo1 < TestModel
  validates :picture, :dimensions => {:greater_than_or_equal_to => {width: 620, height: 620}}
end
class Photo2 < TestModel
  validates :picture, :dimensions => {:greater_than_or_equal_to => {width: 620}}
end
class Photo3 < TestModel
  validates :picture, :dimensions => {:greater_than_or_equal_to => {height: 620}}
end
class Photo4 < TestModel
  validates :picture, :dimensions => {:greater_than_or_equal_to => {width: 619, height: 619}}
end
class Photo5 < TestModel
  validates :picture, :dimensions => {:less_than => {width: 619, height: 619}}
end
class Photo6 < TestModel
  validates :picture, :dimensions => {:less_than => {width: 620}}
end
class Photo7 < TestModel
  validates :picture, :dimensions => {:less_than => {height: 620}}
end
class Photo8 < TestModel
  validates :picture, :dimensions => {:less_than => {width: 620, height: 620}}
end
class Photo9 < TestModel
  validates :picture, :dimensions => {:less_than_or_equal_to => {width: 619, height: 619}}
end
class Photo10 < TestModel
  validates :picture, :dimensions => {:less_than_or_equal_to => {width: 619}}
end
class Photo11 < TestModel
  validates :picture, :dimensions => {:less_than_or_equal_to => {height: 619}}
end
class Photo12 < TestModel
  validates :picture, :dimensions => {:less_than_or_equal_to => {width: 620, height: 620}}
end
class Photo13 < TestModel
  validates :picture, :dimensions => {:greater_than => {width: 620, height: 620}}
end
class Photo14 < TestModel
  validates :picture, :dimensions => {:greater_than => {width: 619}}
end
class Photo15 < TestModel
  validates :picture, :dimensions => {:greater_than => {height: 619}}
end
class Photo16 < TestModel
  validates :picture, :dimensions => {:greater_than => {width: 619, height: 619}}
end
class Photo17 < TestModel
  validates :picture, :dimensions => {:equal_to => {width: 619, height: 619}}
end
class Photo18 < TestModel
  validates :picture, :dimensions => {:equal_to => {width: 619}}
end
class Photo19 < TestModel
  validates :picture, :dimensions => {:equal_to => {height: 620}}
end
class Photo20 < TestModel
  validates :picture, :dimensions => {:equal_to => {width: 620, height: 620}}
end
class Photo21 < TestModel
  validates :picture, :dimensions => {:equal_to => {width: 620, height: 620}, :message => "Invalid image dimensions"}
end


describe DimensionsValidator do
  def stubs_image_file(width, height)
    file = mock()
    path = mock()
    path.stubs(:path).returns(ROOT + "spec/fixtures/images/bad_wolf_#{width}x#{height}.png")
    file.stubs(:queued_for_write).returns({:original => path})
    return file
  end

  describe 'validation of dimensions' do
    describe 'with greater_than_or_equal_to' do
      it 'should fails for images with both width and height less than thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo1.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with width less than thresholds' do
        file = stubs_image_file(619, 620)
        photo = Photo2.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with height less than thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo3.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should not fail for images with both width and height equal to the thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo1.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
      it 'should not fail for images with both width and height greater than thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo4.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
    end

    describe 'with less_than' do
      it 'should fails for images with both width and height equal to the thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo5.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with both width and height greater to the thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo5.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with width equal to the thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo6.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with height equal to the thresholds' do
        file = stubs_image_file(619, 620)
        photo = Photo7.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should not fail for images with both width and height less than thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo8.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
    end

    describe 'with less_than_or_equal_to' do
      it 'should fails for images with both width and height greater than thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo9.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with width greater than thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo10.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with height greater than thresholds' do
        file = stubs_image_file(619, 620)
        photo = Photo11.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should not fail for images with both width and height less than thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo12.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
      it 'should not fail for images with both width and height equal to the thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo12.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
    end

    describe 'with greater_than' do
      it 'should fails for images with both width and height equal to the thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo13.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with both width and height less than thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo13.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with width equal to the thresholds' do
        file = stubs_image_file(619, 620)
        photo = Photo14.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with height equal to the thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo15.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should not fail for images with both width and height greater than thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo16.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
    end

    describe 'with equal_to' do
      it 'should fails for images with both width and height greater than thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo17.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with both width and height less than thresholds' do
        file = stubs_image_file(619, 619)
        photo = Photo20.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with width greater than thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo18.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should fails for images with height less than thresholds' do
        file = stubs_image_file(620, 619)
        photo = Photo19.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).not_to be_valid
      end
      it 'should not fail for images with both width and height equal to the thresholds' do
        file = stubs_image_file(620, 620)
        photo = Photo20.new({:picture => file})
        photo.stubs(:picture?).returns(true)
        expect(photo).to be_valid
      end
    end
  end

  describe 'error messages' do
    it 'should be default when the message is not defined' do
      file = stubs_image_file(619, 619)
      photo = Photo20.new({:picture => file})
      photo.stubs(:picture?).returns(true)
      photo.valid?
      expect(photo.errors.messages).to match({:picture=>["width must be equal to 620px", "height must be equal to 620px"]})
    end
    it 'should be the provided message when it is defined' do
      file = stubs_image_file(619, 619)
      photo = Photo21.new({:picture => file})
      photo.stubs(:picture?).returns(true)
      photo.valid?
      expect(photo.errors.messages).to match({:picture=>["Invalid image dimensions", "Invalid image dimensions"]})
    end
  end

  describe 'invalid operations' do
    it 'should raise ArgumentError' do
    expect {
      class PhotoError < TestModel
        validates :picture, :dimensions => {:different_from => {width: 620, height: 620}}
      end
    }.to raise_error
    end
  end

end




