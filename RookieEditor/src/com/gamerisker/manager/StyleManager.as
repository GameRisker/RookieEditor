package com.gamerisker.manager
{
	import com.gamerisker.containers.SkinFrame;
	import com.gamerisker.containers.SkinImage;
	import com.gamerisker.containers.TitleWindow;
	import com.gamerisker.controls.Button;
	import com.gamerisker.controls.CheckBox;
	import com.gamerisker.controls.ImageButton;
	import com.gamerisker.controls.ImageNumber;
	import com.gamerisker.controls.Label;
	import com.gamerisker.controls.List;
	import com.gamerisker.controls.RadioButton;
	import com.gamerisker.controls.ScrollText;
	import com.gamerisker.controls.Slider;
	import com.gamerisker.controls.Tile;
	import com.gamerisker.controls.TileGroup;
	import com.gamerisker.core.Component;
	
	import flash.utils.getQualifiedClassName;

	/**
	 *	保存组件的默认设置 
	 * @author YangDan
	 * 
	 */	
	public class StyleManager
	{
		private static function getButtonStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"		,value:"button"});
			list.push({name:"label"	,value:"Button"});
			list.push({name:"skin"		,value:"ButtonDefault"});
			list.push({name:"x"			,value:0});
			list.push({name:"y"			,value:0});
			list.push({name:"width"	,value:100});
			list.push({name:"height"	,value:50});
			list.push({name:"enabled"	,value:true});
			list.push({name:"alpha"	,value:1});
			return list;
		}
		
		private static function getCheckBoxStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"		,value:"checkBox"});
			list.push({name:"label"	,value:"CheckBox"});
			list.push({name:"skin"		,value:"default_yinxiao"});
			list.push({name:"x"			,value:0});
			list.push({name:"y"			,value:0});
			list.push({name:"width"	,value:100});
			list.push({name:"height"	,value:25});
			list.push({name:"enabled"	,value:true});
			list.push({name:"alpha"	,value:1});
			list.push({name:"group"	,value:"checkboxGroup"});
			return list;
		}
		
		private static function getImageButtonStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"		,value:"imageButton"});
			list.push({name:"skin"		,value:"ImageButtonDefault"});
			list.push({name:"x"			,value:0});
			list.push({name:"y"			,value:0});
			list.push({name:"enabled"	,value:true});
			list.push({name:"alpha"	,value:1});
			list.push({name:"toggle"	,value:false});
			return list;
		}
		
		private static function getImageNumberStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"		,value:"imageLoadGrid"});
			list.push({name:"skin"		,value:"num_"});
			list.push({name:"x"			,value:0});
			list.push({name:"y"			,value:0});
			list.push({name:"value"	,value:100});
			list.push({name:"alpha"	,value:1});
			list.push({name:"digit"	,value:3});
			list.push({name:"distance"	,value:5});
			list.push({name:"enabled"	,value:false});
			list.push({name:"isShow"	,value:false});
			return list;
		}
		
		private static function getLabelStyle() : Array
		{			
			var list : Array = new Array;
			list.push({name:"id"		,value:"label"});
			list.push({name:"label"	,value:"Label"});
			list.push({name:"x"			,value:0});
			list.push({name:"y"			,value:0});
			list.push({name:"width"	,value:150});
			list.push({name:"height"	,value:20});
			list.push({name:"color"	,value:0x000000});
			list.push({name:"fontSize"	,value:12});
			list.push({name:"enabled"	,value:true});
			list.push({name:"alpha"	,value:1});
			return list;
		}
		
		private static function getListStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"list"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:100});
			list.push({name:"height"		,value:100});
			list.push({name:"rowHeight"	,value:20});
			list.push({name:"alpha"		,value:1});
			return list;
		}
		
		private static function getRadioButtonStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"list"});
			list.push({name:"label"		,value:"RadioButton"});
			list.push({name:"skin"			,value:"RadioButtonDefault"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:60});
			list.push({name:"height"		,value:20});
			list.push({name:"enabled"		,value:true});
			list.push({name:"alpha"		,value:1});
			list.push({name:"group"		,value:"RadioButtonGroup"});
			return list;
		}
		
		private static function getScrollTextStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"scrollText"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:100});
			list.push({name:"height"		,value:100});
			list.push({name:"alpha"		,value:1});
			list.push({name:"text"			,value:""});
			list.push({name:"fontBold"		,value:0});
			list.push({name:"fontColor"	,value:0});
			list.push({name:"align"		,value:0});
			list.push({name:"fontName"		,value:0});
			list.push({name:"fontSize"		,value:0});
			return list;
		}
		
		private static function getSkinFrameStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"SkinFrame"});
			list.push({name:"skin"			,value:"chat_liaotiankuang"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:100});
			list.push({name:"height"		,value:100});
			list.push({name:"alpha"		,value:1});
			list.push({name:"enabled"		,value:true});
			return list;
		}
		
		private static function getSkinImageStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"SkinImage"});
			list.push({name:"skin"			,value:"UIImageDefault"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"alpha"		,value:1});
			list.push({name:"enabled"		,value:true});
			return list;
		}
		
		private static function getSliderStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"SkinFrame"});
			list.push({name:"skin"			,value:"chat_liaotiankuang"});
			list.push({name:"minimum"		,value:0});
			list.push({name:"maximum"		,value:100});
			list.push({name:"value"		,value:0});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:400});
			list.push({name:"height"		,value:10});
			list.push({name:"alpha"		,value:1});
			return list;
		}
		
		private static function getTileStyle() : Array
		{
			var list : Array = new Array;
			list.push({name:"id"			,value:"Tile"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:64});
			list.push({name:"height"		,value:64});
			list.push({name:"alpha"		,value:1});
			list.push({name:"enabled"		,value:true});
			return list;
		}
		
		private static function getTileGroupStyle() : Array
		{			
			var list : Array = new Array;
			list.push({name:"id"			,value:"TileGroup"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"alpha"		,value:1});
			list.push({name:"count"		,value:16});
			list.push({name:"row"			,value:4});
			list.push({name:"col"			,value:4});
			list.push({name:"rowSpacing"	,value:2});
			list.push({name:"colSpacing"	,value:2});
			list.push({name:"boxWidth"		,value:64});
			list.push({name:"boxHeight"	,value:64});
			list.push({name:"enabled"		,value:true});
			return list;
		}
		
		private static function getTitleWindowStyle() : Array
		{			
			var list : Array = new Array;
			list.push({name:"id"			,value:"TileGroup"});
			list.push({name:"title"		,value:"TitleWindow"});
			list.push({name:"skin"			,value:"default_beijing"});
			list.push({name:"x"				,value:0});
			list.push({name:"y"				,value:0});
			list.push({name:"width"		,value:600});
			list.push({name:"height"		,value:270});
			list.push({name:"alpha"		,value:1});
			list.push({name:"fontSize"		,value:12});
			list.push({name:"textWidth"	,value:100});
			list.push({name:"textHeight"	,value:20});
			list.push({name:"textX"		,value:10});
			list.push({name:"textY"		,value:10});
			list.push({name:"enabled"		,value:true});
			return list;
		}
		
		/**
		 *	根据组件获取组件的属性 
		 * @param component
		 * @return 
		 * 
		 */		
		public static function getStyle(component : Component) : Array
		{
			switch(getQualifiedClassName(component))
			{
				case getQualifiedClassName(SkinFrame) :
					return getSkinFrameStyle();
				case getQualifiedClassName(SkinImage) :
					return getSkinImageStyle();
				case getQualifiedClassName(TitleWindow) :
					return getTitleWindowStyle();
				case getQualifiedClassName(Button) :
					return getButtonStyle();
				case getQualifiedClassName(CheckBox) :
					return getCheckBoxStyle();
				case getQualifiedClassName(ImageButton) :
					return getImageButtonStyle();
				case getQualifiedClassName(ImageNumber) :
					return getImageNumberStyle();
				case getQualifiedClassName(Label) :
					return getLabelStyle();
				case getQualifiedClassName(List) :
					return getListStyle();
				case getQualifiedClassName(RadioButton) :
					return getRadioButtonStyle();
				case getQualifiedClassName(ScrollText) :
					return getScrollTextStyle();
				case getQualifiedClassName(Slider) :
					return getSliderStyle();
				case getQualifiedClassName(Tile) :
					return getTileStyle();
				case getQualifiedClassName(TileGroup) :
					return getTileGroupStyle();
			}
		}
	}
}