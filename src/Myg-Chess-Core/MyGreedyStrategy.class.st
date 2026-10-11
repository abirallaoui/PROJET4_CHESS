Class {
	#name : 'MyGreedyStrategy',
	#superclass : 'MyStrategy',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyGreedyStrategy >> chooseMoveFor: aPlayer [

	| moves bestGain best |
	moves := OrderedCollection new.
	aPlayer pieces do: [ :piece |
		piece legalTargetSquares do: [ :target |
			moves add: piece -> target ] ].
	moves ifEmpty: [ ^ nil ].
	bestGain := (moves collect: [ :m | self gainOf: m ]) max.
	best := moves select: [ :m | (self gainOf: m) = bestGain ].
	^ best atRandom
]

{ #category : 'as yet unclassified' }
MyGreedyStrategy >> gainOf: aMove [

	^ aMove value hasPiece
		  ifTrue: [ aMove value contents pointValue ]
		  ifFalse: [ 0 ]
]
