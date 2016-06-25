class Task < ActiveRecord::Base
  has_many :task_comments, dependent: :destroy
  has_many :goodjobs, dependent: :destroy
  belongs_to :project
  belongs_to :user
  belongs_to :charge, class_name: 'User', foreign_key: 'charge_id'
  validates :title, presence: true
  validate :check_deadline
  validate :check_done
  
  #やっぱり、statusカラムはintegerなのでこれは使えない。
  def status_display_name
    self.status ? "未着手" : "対応開始済み"
  end
  
  def done_display_name
    self.done ? "完了" : "未完了"
  end
  
  def check_deadline
    if done == false && deadline.present?
      errors.add(:deadline, "デットライン期日過ぎています") if deadline < Time.now
    end
  end
  
  def check_done
      errors.add(:done, "未着手なのに完了ですか？") if status == 0 && done == true
  end
  
  
  #フォローしているユーザーIDを取得する
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT X.id FROM (SELECT users.* FROM users INNER JOIN relatioshops
    on users.id = relationships.followed_id WHERE relationships.follower_id = :user_id) X INNER JOIN
    (SELECT users.* FROM users INNER JOIN relationships ON users.id = reltionships.follower_id WHERE
    relationships.followed_id = :user_id) Y ON X.id = Y.id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
         user_id: user.id)
  end

  def self.each_other_follows(user)
    each_other_follows_ids = user.followers&user.followed_users
    where("user_id IN (#{each_other_follows_ids})", user_id: self.id)
  end
    
end
