Class {
	#name : 'MyRandomStrategy',
	#superclass : 'MyStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyRandomStrategy >> chooseMoveFor: aPlayer [

	| moves |
	moves := OrderedCollection new.
	aPlayer pieces do: [ :piece |
		piece legalTargetSquares do: [ :target |
			moves add: piece -> target ] ].
	moves ifEmpty: [ ^ nil ].
	^ moves atRandom
]
