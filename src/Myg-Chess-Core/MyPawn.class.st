Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyPawn >> canAdvanceTo: aSquare [

	^ aSquare isOnBoard and: [ aSquare hasPiece not ]
]

{ #category : 'rendering' }
MyPawn >> canCapture: aSquare [

	^ aSquare isOnBoard and: [
		  aSquare hasPiece and: [ aSquare contents color ~= color ] ]
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'as yet unclassified' }
MyPawn >> pointValue [

	^ 1
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| forward candidates startRank |
	forward := self isWhite
		           ifTrue: [ square up ]
		           ifFalse: [ square down ].
	candidates := OrderedCollection new.

	(self canAdvanceTo: forward) ifTrue: [
		| forward2 |
		candidates add: forward.
		startRank := self isWhite
			             ifTrue: [ $2 ]
			             ifFalse: [ $7 ].
		forward2 := self isWhite
			            ifTrue: [ forward up ]
			            ifFalse: [ forward down ].
		(square file = startRank and: [ self canAdvanceTo: forward2 ])
			ifTrue: [ candidates add: forward2 ] ].

	{ forward left. forward right } do: [ :diag |
		(self canCapture: diag) ifTrue: [ candidates add: diag ] ].

	^ candidates asArray
]
