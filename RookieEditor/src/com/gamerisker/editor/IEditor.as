package com.gamerisker.editor
{
	import com.gamerisker.core.Component;
	
	import mx.collections.ArrayList;

	public interface IEditor
	{
		
		function toXMLString() : String
			
		function destroy() : void
			
		function getComponent() : Component
			
		function setStyleName(name : String , value : *) : void
			
		function toCopy() : Editor
			
		function xmlToComponent(value : XML) : Editor
			
		function toArrayList() : ArrayList
			
		function get type() : String
			
		function create() : void
	}
}