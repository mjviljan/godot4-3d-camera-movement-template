enum Direction {
	NONE = 0,
	FORWARD = 1 << 0,
	BACKWARD = 1 << 1,
	RIGHT = 1 << 2,
	LEFT = 1 << 3
}

enum Rotation {
	NONE = 0,
	CLOCKWISE = -1,
	COUNTER_CLOCKWISE = 1
}
