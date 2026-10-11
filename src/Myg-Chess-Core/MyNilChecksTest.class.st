Class {
	#name : 'MyNilChecksTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'tests' }
MyNilChecksTest >> testBishopInCornerHasSevenMoves [

	| board bishop |
	board := MyChessBoard empty.
	bishop := MyBishop white.
	board at: 'a1' put: bishop.
	self assert: bishop legalTargetSquares size equals: 7
]

{ #category : 'tests' }
MyNilChecksTest >> testEmptyBoardHasNoPieces [

	self assert: MyChessBoard empty pieces isEmpty
]

{ #category : 'tests' }
MyNilChecksTest >> testEmptySquareHasNoPiece [

	| board |
	board := MyChessBoard empty.
	self deny: (board at: 'e4') hasPiece
]

{ #category : 'tests' }
MyNilChecksTest >> testFreshGameHasThirtyTwoPieces [

	self assert: MyChessGame freshGame pieces size equals: 32
]

{ #category : 'tests' }
MyNilChecksTest >> testKingInCornerHasThreeMoves [

	| board king |
	board := MyChessBoard empty.
	king := MyKing white.
	board at: 'a1' put: king.
	self assert: king legalTargetSquares size equals: 3
]

{ #category : 'tests' }
MyNilChecksTest >> testKnightInCornerHasTwoMoves [

	| board knight |
	board := MyChessBoard empty.
	knight := MyKnight white.
	board at: 'a1' put: knight.
	self assert: knight legalTargetSquares size equals: 2
]

{ #category : 'tests' }
MyNilChecksTest >> testKnightInTheMiddleHasEightMoves [

	| board knight |
	board := MyChessBoard empty.
	knight := MyKnight white.
	board at: 'd4' put: knight.
	self assert: knight legalTargetSquares size equals: 8
]

{ #category : 'tests' }
MyNilChecksTest >> testNoKingIsNeverInCheck [

	self deny: MyNoKing new isInCheck
]

{ #category : 'tests' }
MyNilChecksTest >> testNullPieceIsNotAPiece [

	| nullPiece |
	nullPiece := MyNullPiece new.
	self deny: nullPiece isPiece.
	self deny: nullPiece isKing
]

{ #category : 'tests' }
MyNilChecksTest >> testNullPieceRendersAsEmptySquare [

	| board |
	board := MyChessBoard empty.
	self
		assert: (MyNullPiece new renderPieceOn: (board at: 'a1'))
		equals: 'x'.
	self
		assert: (MyNullPiece new renderPieceOn: (board at: 'a8'))
		equals: 'z'
]

{ #category : 'tests' }
MyNilChecksTest >> testOutOfBoardSquareStaysOutOfBoard [

	| square |
	square := MyOutOfBoardSquare new.
	self deny: square isOnBoard.
	self deny: square hasPiece.
	self assert: square up equals: square.
	self assert: square left down right equals: square.
	self assert: square + (1 @ 2) equals: square
]

{ #category : 'tests' }
MyNilChecksTest >> testRookInCornerHasFourteenMoves [

	| board rook |
	board := MyChessBoard empty.
	rook := MyRook white.
	board at: 'a1' put: rook.
	self assert: rook legalTargetSquares size equals: 14
]

{ #category : 'tests' }
MyNilChecksTest >> testSquareOnBoardIsOnBoard [

	| board |
	board := MyChessBoard empty.
	self assert: (board at: 'e4') isOnBoard
]

{ #category : 'tests' }
MyNilChecksTest >> testWhitePawnOnLastRankHasNoMove [

	| board pawn |
	board := MyChessBoard empty.
	pawn := MyPawn white.
	board at: 'a8' put: pawn.
	self assert: pawn legalTargetSquares isEmpty
]
