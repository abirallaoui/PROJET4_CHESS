Class {
	#name : 'MyFirstMoveStrategy',
	#superclass : 'MyStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyFirstMoveStrategy >> chooseMoveFor: aPlayer [

	aPlayer pieces do: [ :piece |
		| moves |
		moves := piece legalTargetSquares.
		moves ifNotEmpty: [ ^ piece -> moves first ] ].
	^ nil
]
