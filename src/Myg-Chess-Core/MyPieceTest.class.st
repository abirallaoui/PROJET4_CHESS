Class {
	#name : 'MyPieceTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'tests' }
MyPieceTest >> testPieceCanCaptureAttackerToSaveKing [

	| board whiteKing blackRook whiteBishop |
	board := MyChessBoard empty.
	whiteKing := MyKing white.
	blackRook := MyRook black.
	whiteBishop := MyBishop white.

	board at: 'e1' put: whiteKing.
	board at: 'e5' put: blackRook.
	board at: 'd4' put: whiteBishop.

	self assert: (whiteBishop legalTargetSquares includes: (board at: 'e5' ))
]

{ #category : 'tests' }
MyPieceTest >> testPinnedPieceCannotExposeKing [

	| board whiteKing whiteBishop blackRook |
	board := MyChessBoard empty.
	whiteKing := MyKing white.
	whiteBishop := MyBishop white.
	blackRook := MyRook black.

	board at: 'e1' put: whiteKing.
	board at: 'e2' put: whiteBishop.
	board at: 'e8' put: blackRook.

	self assert: whiteBishop legalTargetSquares isEmpty
]
