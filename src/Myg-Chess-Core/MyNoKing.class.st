Class {
	#name : 'MyNoKing',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyNoKing >> isInCheck [

	"Without a king there is nothing to protect"
	^ false
]
