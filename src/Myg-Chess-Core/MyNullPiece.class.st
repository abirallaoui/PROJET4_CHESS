Class {
	#name : 'MyNullPiece',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyNullPiece >> isKing [

	^ false
]

{ #category : 'testing' }
MyNullPiece >> isPiece [

	^ false
]

{ #category : 'rendering' }
MyNullPiece >> moveIn: aGame to: aSquare [

	"There is nothing to move on an empty square"
	^ self
]

{ #category : 'testing' }
MyNullPiece >> renderPieceOn: aSquare [

	^ aSquare renderEmpty
]

{ #category : 'rendering' }
MyNullPiece >> targetSquares [

	^ #()
]
