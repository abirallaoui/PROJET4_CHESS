Class {
	#name : 'MyStrategy',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyStrategy >> chooseMoveFor: aPlayer [

	^ self subclassResponsibility
]
