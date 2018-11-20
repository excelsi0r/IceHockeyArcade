extends Node2D

var playing
var paused
var gameoverState

var gametype

var goal
const GOAL_TIME = 2

var scoreRed
var scoreBlue

var blueScoreLabel
var redScoreLabel
var goalInfo
var goalInfoLabel
var timeLabel
var gameOverPlayerInfo
var disk

var menu
var game
var pause
var gameover

var goalSound
var organMusic
var crowdSound

var countdown
const TIME_02 = 10
const TIME_05 = 300
const TIME_10 = 600

var newGameButton
var exitGameButton
var timeGameButton
var modeGameButton
var pauseContinueButton
var pauseMainMenuButton
var gameOverRematch
var gameOverMainMenu

func _ready():
	game = get_node("Game")
	blueScoreLabel = get_node("Game/ScoreBoard/BlueScoreBox/BlueScoreLabel")
	redScoreLabel = get_node("Game/ScoreBoard/RedScoreBox/RedScoreLabel")
	timeLabel = get_node("Game/ScoreBoard/Time/TimeLabel")
	disk = get_node("Game/Disk")
	
	menu = get_node("GUI/NewGamePanel")
	
	pause = get_node("GUI/PausePanel")
	pauseContinueButton = get_node("GUI/PausePanel/VBoxContainer/continue")
	pauseMainMenuButton = get_node("GUI/PausePanel/VBoxContainer/mainMenu")
	pauseContinueButton.connect("pressed", self, "pause_continue")
	pauseMainMenuButton.connect("pressed", self, "pause_mainMenu")
	
	gameover = get_node("GUI/GameOverPanel")
	gameOverPlayerInfo = get_node("GUI/GameOverPanel/VBoxContainer/PlayerInfo")
	gameOverRematch = get_node("GUI/GameOverPanel/VBoxContainer2/Rematch")
	gameOverRematch.connect("pressed",self, "gameOver_rematch")
	gameOverMainMenu = get_node("GUI/GameOverPanel/VBoxContainer2/Main Menu")
	gameOverMainMenu.connect("pressed",self, "gameOver_mainMenu")
	
	goalInfo = get_node("GUI/GoalInfo")
	goalInfoLabel = get_node("GUI/GoalInfo/GoalBox/PlayerScoredLabel")

	newGameButton = get_node("GUI/NewGamePanel/NewGamePanel/NewGame")
	newGameButton.connect("pressed", self, "new_game_button_pressed")
	
	exitGameButton = get_node("GUI/NewGamePanel/NewGamePanel/Exit")
	exitGameButton.connect("pressed",self,"exit_button_pressed")
	
	timeGameButton = get_node("GUI/NewGamePanel/NewGamePanel/TimeButton")
	timeGameButton.add_item("02:00")
	timeGameButton.add_item("05:00")
	timeGameButton.add_item("10:00")
	
	modeGameButton = get_node("GUI/NewGamePanel/NewGamePanel/ModeButon")
	modeGameButton.add_item("AI")
	modeGameButton.add_item("Loner")
	modeGameButton.add_item("Multi")
	
	goalSound = get_node("audio/goal")
	organMusic = get_node("audio/music")
	crowdSound = get_node("audio/crowd")
	
	menu.visible = true
	game.visible = false
	pause.visible = false
	gameover.visible = false
	
	reset_game()
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel") && playing && !paused:	
		pause_game(true)
	elif Input.is_action_just_pressed("ui_cancel") && !playing && paused:	
		pause_game(false)
		
		
	
	if goal >= 0:
		goal -= delta
		if goal < 0:
			playing = true
			goalInfo.visible = false
			
	if countdown > 0 && playing:
		timeLabel.text = format_time(countdown)
		countdown -= delta
	elif countdown <= 0 && playing:
		str("hello")
		gameover_game(true)
		
	pass
	
func reset_game():
	countdown = 0
	playing = false
	goal = -1
	scoreRed = 0
	scoreBlue = 0
	blueScoreLabel.text = "0"
	redScoreLabel.text = "0"
	timeLabel.text = format_time(0)
	paused = false
	gameoverState = false
	disk.reset()
	pass
	
func start_game():
	playing = true
	gameover.visible = false
	menu.visible = false
	pause.visible = false
	game.visible = true
	pass

func gameover_game(toGameOver):
	if toGameOver:
		playing = false
		gameoverState = true
		gameover.visible = true
		if scoreRed > scoreBlue:
			gameOverPlayerInfo.text = "Red Wins!"
		elif scoreRed == scoreBlue:
			gameOverPlayerInfo.text = "Draw!"
		else:
			gameOverPlayerInfo.text = "Blue Wins!"
	pass	
		
		
func pause_game(toPause):
	if toPause:
		paused = true
		playing = false
		pause.visible = true
	elif !toPause:
		paused = false
		playing = true
		pause.visible = false
	
	
func redScore():
	goalSound.play()
	scoreRed += 1
	goal = GOAL_TIME
	redScoreLabel.text = str(scoreRed)
	goalInfoLabel.text = "Red Scores!"
	goalInfo.visible = true
	playing = false
	pass
	
func blueScore():
	goalSound.play()
	scoreBlue += 1
	goal = GOAL_TIME
	blueScoreLabel.text = str(scoreBlue)
	goalInfoLabel.text = "Blue Scores!"
	goalInfo.visible = true
	playing = false
	pass
	
func format_time(time):
	var string = ""
	var minutes = int(time / 60)
	var seconds = int(time - (minutes * 60))
	if seconds < 10:
		string = str("0", minutes, ":0", seconds)
	else:
		string = str("0", minutes, ":", seconds)
	return string
	
func new_game_button_pressed():
	
	gametype = modeGameButton.selected

	var gameTimeStr = timeGameButton.selected	
	if gameTimeStr == 0:
		countdown = TIME_02
	elif gameTimeStr == 1:
		countdown = TIME_05
	elif gameTimeStr == 2:
		countdown = TIME_10
	
	start_game()
	pass

func exit_button_pressed():
	get_tree().quit()
	pass
	
	
func pause_continue():
	pause_game(false)
	pass
	
func pause_mainMenu():
	reset_game()
	game.visible = false
	pause.visible = false
	gameover.visible = false
	menu.visible = true
	pass
	
func gameOver_rematch():
	reset_game()
	new_game_button_pressed()
	pass
	
func gameOver_mainMenu():
	pause_mainMenu()
	pass