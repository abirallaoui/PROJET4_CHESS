Class {
	#name : 'MyBotTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyBotTest >> signatureOf: aGame [

	^ aGame pieces collect: [ :p |
		  p ifNil: [ '-' ] ifNotNil: [ p id , p square name ] ]
]

{ #category : 'as yet unclassified' }
MyBotTest >> testFirstMoveStrategyPlaysTheSameMoveEveryTime [

	| game1 game2 |
	game1 := MyChessGame freshGame.
	game2 := MyChessGame freshGame.
	game1 whitePlayer strategy: MyFirstMoveStrategy new.
	game2 whitePlayer strategy: MyFirstMoveStrategy new.
	game1 play.
	game2 play.
	self
		assert: (self signatureOf: game1)
		equals: (self signatureOf: game2).
	self
		deny: (self signatureOf: game1)
		equals: (self signatureOf: MyChessGame freshGame)
]

{ #category : 'tests' }
MyBotTest >> testGreedyAgainstRandomPlaysSeveralMoves [

	| game count |
	game := MyChessGame freshGame.
	game whitePlayer strategy: MyGreedyStrategy new.
	game blackPlayer strategy: MyRandomStrategy new.
	count := (game pieces select: [ :p | p notNil ]) size.
	10 timesRepeat: [
		game play.
		self assert: (game pieces select: [ :p | p notNil ]) size <= count ]
]

{ #category : 'tests' }
MyBotTest >> testGreedyStrategyCapturesTheQueen [

	| game move |
	game := MyChessGame fromFENString: '3q3k/8/8/8/p2R4/8/8/4K3 w - - 0 1'.
	move := MyGreedyStrategy new chooseMoveFor: game whitePlayer.
	self assert: move key square name equals: 'd4'.
	self assert: move value name equals: 'd8'
]

{ #category : 'tests' }
MyBotTest >> testGreedyStrategyPlaysALegalMoveWhenNoCapture [

	| game move |
	game := MyChessGame freshGame.
	move := MyGreedyStrategy new chooseMoveFor: game whitePlayer.
	self assert: move notNil.
	self assert: (move key legalTargetSquares includes: move value)
]

{ #category : 'tests' }
MyBotTest >> testPlayChangesExactlyTwoSquares [

	| game before after changed |
	game := MyChessGame freshGame.
	before := game pieces copy.
	game play.
	after := game pieces.
	changed := (1 to: before size) count: [ :i |
		           (before at: i) ~~ (after at: i) ].
	self assert: changed equals: 2
]

{ #category : 'tests' }
MyBotTest >> testPlayingSeveralMovesNeverCreatesPieces [

	| game count |
	game := MyChessGame freshGame.
	count := (game pieces select: [ :p | p notNil ]) size.
	10 timesRepeat: [
		game play.
		self assert: (game pieces select: [ :p | p notNil ]) size <= count ]
]

{ #category : 'tests' }
MyBotTest >> testRandomStrategyFindsTheOnlyLegalMoveWhenInCheck [

	| game move |
	game := MyChessGame fromFENString: 'R7/7k/8/8/8/8/5PPP/r5K1 w - - 0 1'.
	move := MyRandomStrategy new chooseMoveFor: game whitePlayer.
	self assert: move notNil.
	self assert: move key square name equals: 'a8'.
	self assert: move value name equals: 'a1'
]
