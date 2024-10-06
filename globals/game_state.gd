extends Node
const DEFAULT_PORT = 10567
const MAX_PEERS = 4
var peer: ENetMultiplayerPeer

# Names for remote players in id:name format.
var players := {}
var players_ready: Array[int] = []

# Signals to let lobby GUI know what's going on.
signal player_list_changed()
signal connection_failed()
signal connection_succeeded()
signal game_ended()
signal game_error(what: int)
