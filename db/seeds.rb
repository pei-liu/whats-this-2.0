gamemaker = User.create(username: 'pei', password: 'yolo', password_confirmation: 'yolo')
player = User.create(username: 'stephen', password: 'yolo', password_confirmation: 'yolo')

game = Game.create(user_id: gamemaker.id)

Round.create(game_id: game.id, user_id: player.id, content: "2 Monkeys tossing a ball", content_type: "description")
