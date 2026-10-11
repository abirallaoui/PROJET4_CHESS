Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

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

	(forward notNil and: [ forward hasPiece not ]) ifTrue: [
		candidates add: forward.
		startRank := self isWhite ifTrue: [ $2 ] ifFalse: [ $7 ].
		(square file = startRank) ifTrue: [
			| forward2 |
			forward2 := self isWhite
				ifTrue: [ forward up ]
				ifFalse: [ forward down ].
			(forward2 notNil and: [ forward2 hasPiece not ])
				ifTrue: [ candidates add: forward2 ] ] ].

	({ forward } collect: [ :f | f ifNotNil: [ f left ] ]),
	({ forward } collect: [ :f | f ifNotNil: [ f right ] ])
		do: [ :diag |
			(diag notNil and: [
				diag hasPiece and: [ diag contents color ~= color ] ])
				ifTrue: [ candidates add: diag ] ].

	^ candidates asArray
]
