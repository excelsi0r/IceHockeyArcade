extends Node2D

var playing
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

var goalSound
var organMusic
var crowdSound

var countdown
const GAME_TIME = 300

func _ready():
	playing = true
	goal = 0
	scoreRed = 0
	scoreBlue = 0
	blueScoreLabel = get_node("GUI/ScoreBoard/BlueScoreBox/BlueScoreLabel")
	redScoreLabel = get_node("GUI/ScoreBoard/RedScoreBox/RedScoreLabel")
	goalInfo = get_node("GUI/GoalInfo")
	goalInfoLabel = get_node("GUI/GoalInfo/GoalBox/PlayerScoredLabel")
	timeLabel = get_node("GUI/ScoreBoard/Time/TimeLabel")
	goalSound = get_node("audio/goal")
	organMusic = get_node("audio/music")
	crowdSound = get_node("audio/crowd")
	crowdSound.play()
	
	gameStart()
	
	pass

func _process(delta):
	if goal >= 0:
		goal -= delta
		if goal < 0:
			playing = true
			goalInfo.visible = false
			
	if countdown > 0 && playing:
		timeLabel.text = format_time(countdown)
		countdown -= delta
	elif countdown <= 0 && playing:
		str("Gameover")
		playing = false
		
	pass

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
	
func gameStart():
	organMusic.play()
	scoreRed = 0
	scoreBlue = 0
	countdown = GAME_TIME
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
	