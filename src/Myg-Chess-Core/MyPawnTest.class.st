Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'tests' }
MyPawnTest >> testBlackPawnBlockedByPieceInFront [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	blackPawn := MyPawn black.
	whitePawn := MyPawn white.
	board at: 'd7' put: blackPawn.
	board at: 'd6' put: whitePawn.

	self assert: blackPawn legalTargetSquares isEmpty
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCanCaptureDiagonally [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	blackPawn := MyPawn black.
	whitePawn := MyPawn white.
	board at: 'd7' put: blackPawn.
	board at: 'e6' put: whitePawn.

	self assert: (blackPawn legalTargetSquares includes: (board at: 'e6' ))
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCannotMoveDiagonallyToEmptySquare [

	| board blackPawn |
	board := MyChessBoard empty.
	blackPawn := MyPawn black.
	board at: 'd7' put: blackPawn.

	self assert: (blackPawn legalTargetSquares includes: (board at: 'e6' )) not
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnHasTwoMovesAtStart [

	| game pawn |
	game := MyChessGame freshGame.
	pawn := (game board at: 'd7' ) contents.

	self assert: pawn legalTargetSquares size equals: 2
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnLosesDoubleStepAfterMoving [

	| board blackPawn targetSquare |
	board := MyChessBoard empty.
	blackPawn := MyPawn black.
	board at: 'd7' put: blackPawn.

	targetSquare := board at: 'd6' .
	blackPawn moveTo: targetSquare.

	self assert: blackPawn legalTargetSquares size equals: 1
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnBlockedByPieceInFront [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	blackPawn := MyPawn black.
	board at: 'd2' put: whitePawn.
	board at: 'd3' put: blackPawn.

	self assert: whitePawn legalTargetSquares isEmpty
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCanCaptureDiagonally [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	blackPawn := MyPawn black.
	board at: 'd2' put: whitePawn.
	board at: 'e3' put: blackPawn.

	self assert: (whitePawn legalTargetSquares includes: (board at: 'e3'))
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotMoveDiagonallyToEmptySquare [

	| board whitePawn |
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	board at: 'd2' put: whitePawn.

	self assert: (whitePawn legalTargetSquares includes: (board at: 'e3' )) not
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnHasTwoMovesAtStart [

	| game board pawn |
	game := MyChessGame freshGame.
	board := game board.
	pawn := (board at: 'd2' ) contents.

	self assert: pawn legalTargetSquares size equals: 2
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnLosesDoubleStepAfterMoving [

	| board whitePawn targetSquare |
	board := MyChessBoard empty.
	whitePawn := MyPawn white.
	board at: 'd2' put: whitePawn.

	targetSquare := board at: 'd3' .
	whitePawn moveTo: targetSquare.

	self assert: whitePawn legalTargetSquares size equals: 1
]
