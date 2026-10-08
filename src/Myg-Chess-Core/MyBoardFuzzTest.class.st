Class {
	#name : 'MyBoardFuzzTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> place: aPiece on: aBoard [

	| name |
	[ name := 'abcdefgh' atRandom asString , (1 to: 8) atRandom asString.
	(aBoard at: name ifAbsent: [ nil ]) hasPiece ] whileTrue.
	aBoard at: name put: aPiece
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> raisesError: aBlock [

	aBlock on: Error do: [ ^ true ].
	^ false
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> randomBoard [

	| board |
	board := MyChessBoard empty.
	self place: MyKing white on: board.
	self place: MyKing black on: board.
	(3 to: 10) atRandom timesRepeat: [
		| class |
		class := { MyRook. MyKnight. MyBishop. MyQueen. MyPawn } atRandom.
		self
			place: (class perform: { #white. #black } atRandom)
			on: board ].
	^ board
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> randomFENBoardString [

	^ String streamContents: [ :s |
		1 to: 8 do: [ :rank |
			| empty |
			empty := 0.
			1 to: 8 do: [ :file |
				(0 to: 3) atRandom = 0
					ifTrue: [
						empty > 0 ifTrue: [
							s nextPutAll: empty asString.
							empty := 0 ].
						s nextPut: 'rnbqkpRNBQKP' atRandom ]
					ifFalse: [ empty := empty + 1 ] ].
			empty > 0 ifTrue: [ s nextPutAll: empty asString ].
			rank < 8 ifTrue: [ s nextPut: $/ ] ] ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testBoardFromRandomFENHasExpectedNumberOfPieces [

	20 timesRepeat: [
		| placement board expected |
		placement := self randomFENBoardString.
		expected := (placement select: [ :c | c isLetter ]) size.
		board := MyChessBoard fromFENBoard:
			         (MyFENParser parse: placement , ' w KQkq - 0 1') board.
		self
			assert: (board pieces select: [ :p | p notNil ]) size
			equals: expected ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testComputingLegalMovesDoesNotChangeTheBoard [

	20 timesRepeat: [
		| board before |
		board := self randomBoard.
		before := board pieces copy.
		board pieces do: [ :p | p ifNotNil: [ p legalTargetSquares ] ].
		self assert: board pieces equals: before ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testLegalMoveNeverLeavesOwnKingInCheck [

	20 timesRepeat: [
		| board movable piece king |
		board := self randomBoard.
		movable := board pieces select: [ :p |
			           p notNil and: [ p legalTargetSquares notEmpty ] ].
		movable ifNotEmpty: [
			piece := movable atRandom.
			piece moveTo: piece legalTargetSquares atRandom.
			king := piece myKing.
			self deny: king isInCheck ] ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testLegalMovesNeverTargetOwnPieces [

	20 timesRepeat: [
		| board |
		board := self randomBoard.
		board pieces do: [ :p |
			p ifNotNil: [
				p legalTargetSquares do: [ :s |
					self assert: s notNil.
					self assert: (s hasPiece and: [ s contents color = p color ]) not ] ] ] ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserAcceptsEnPassantSquare [

	self
		shouldnt: [ MyFENParser parse: 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' ]
		raise: Error
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserAcceptsNoCastlingRights [

	self
		shouldnt: [ MyFENParser parse: '8/8/8/8/8/8/8/8 w - - 0 1' ]
		raise: Error
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserAcceptsPartialCastlingRights [

	self
		shouldnt: [ MyFENParser parse: '8/8/8/8/8/8/8/8 w Kq - 0 1' ]
		raise: Error
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserAcceptsRandomValidFEN [

	50 timesRepeat: [
		| fen |
		fen := self randomFENBoardString , ' w KQkq - 0 1'.
		self shouldnt: [ MyFENParser parse: fen ] raise: Error ]
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserAcceptsRankWithPiecesAndEmptySquares [

	self
		shouldnt: [
			(MyFENParser parse: 'rN6/8/8/8/8/8/8/8 w KQkq - 0 1') board ]
		raise: Error
]

{ #category : 'as yet unclassified' }
MyBoardFuzzTest >> testParserRejectsInvalidFEN [

	#( '' 'abc' '8/8/8' '9/8/8/8/8/8/8/8 w KQkq - 0 1' 'xxxxxxxx/8/8/8/8/8/8/8 w - - 0 1' '8/8/8/8/8/8/8/8' ) do: [ :fen |
		self
			assert: (self raisesError: [ MyFENParser parse: fen ])
			description: 'No error for invalid FEN: ' , fen ]
]
