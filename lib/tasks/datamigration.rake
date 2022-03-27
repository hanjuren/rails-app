namespace :data_migration do
  task createPost: :environment do
    pp "start"
    user = User.first
    data = [
      {title: 'Ruby on Rails 시작해보기', content: '루비온 레일스는 루비 언어를 기반으로 만들어진 프레임워크이다', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
      {title: 'Ruby Hello World', content: '프로그래밍의 기본 Hello World 출력해보기', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
      {title: '객체지향 프로그래밍이란?', content: '객체지향 프로그래밍이란...대충 이런거다.', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
      {title: '도커란', content: '나중에 알아보자', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
      {title: '기모띠', content: '귀찮다', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
      {title: '너는 누구냐', content: '나는 한주련이다.', user_id: user.id, thumb_nail_image_src: 'https://ifh.cc/g/NLQhtc.png'},
    ]

    data.each do |d|
      Post.create(d)
    end
    pp "done"
  end
end