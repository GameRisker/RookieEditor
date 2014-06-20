package com.gamerisker.core
{
	import com.gamerisker.editor.Editor;
	import com.gamerisker.scene.EditScene;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Timer;
	
	import starling.display.Sprite;
	import starling.display.Stage;

	public class Define
	{
		public static const UPDATE : String = "http://blog.gamerisker.com/version.xml"
			
		public static const DOWNVERSION : String = "http://blog.gamerisker.com/?p=203";
		
		public static const RegExp_SVN : RegExp = /\.svn/gi;
		public static const RegExp_Thumbsdb : RegExp = /Thumbs\.db$/gi;
		public static const RegExp_Path : RegExp = /.*\\+|.*\/+/g;
		public static const RegExp_Extend : RegExp = /\.+.*$/g;
		
		public static const Scene_Edit : EditScene = new EditScene;
		
		public static var stageWidth : Number;
		
		public static var stageHeight : Number;
		
		public static var stg : flash.display.Stage;
		
		public static var starlingStg : starling.display.Stage;
		
		public static var editorContainer : starling.display.Sprite;
		
		public static var fullScreenWidth : Number;
		
		public static var fullScreenHeight : Number;
		
		/**
		 *	剪切板 
		 */		
		public static var copyEditor : Editor;
		
		public static const MOVE_UP 		: int = 1;
		public static const MOVE_DOWN 	: int = 2;
		public static const MOVE_LEFE 	: int = 3;
		public static const MOVE_RIGHT	: int = 4;
	}
}