class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#バリデーションの設定内容を記述
validates :name, presence: true, uniqueness: true, length: {minimum:2, maximum: 20}
validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy

has_one_attached :profile_image

# メソッドに対して引数を設定し、引数に設定した値に画像のサイズを変換するようにした
def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

# def get_profile_image
#     unless profile_image.attached?
#       file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
#       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
#     end
#     profile_image.variant(resize_to_limit: [100, 100]).processed
# end

end
