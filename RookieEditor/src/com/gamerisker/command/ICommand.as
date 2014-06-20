package com.gamerisker.command
{
	public interface ICommand
	{
		function isCheck() : String;
		
		function get name() : String;
		
		function destroy() : void
			
		function execute() : void
	}
}