function AddToPathIfExists ($path){
	if ((Test-Path $path) -eq 1){
		$env:Path += ";$path"
	}
}

AddToPathIfExists "C:\Program Files (x86)\Notepad++\"
AddToPathIfExists "$env:appdata\..\Code\app-0.1.0\"

function Show-GitGraph { git log --oneline --abbrev-commit --all --graph --decorate --color }
Set-Alias gg Show-GitGraph

$script:__directoryStack  = @()
function Push-Directory { 
	$__path = (resolve-path ".").Path
	$script:__directoryStack += $__path
}
function Pop-Directory {
	$__path = $script:__directoryStack[($script:__directoryStack.count -1)]
	$script:__directoryStack = $script:__directoryStack[0..($script:__directoryStack.count-2)]
	cd $__path
}
function Swap-Directory {
	$__currentPath = (resolve-path ".").Path
	
	$__path = $script:__directoryStack[($script:__directoryStack.count -1)]
	$script:__directoryStack = $script:__directoryStack[0..($script:__directoryStack.count-2)]
	$script:__directoryStack += $__currentPath
	
	cd $__path
}
Set-Alias cdpush Push-Directory
Set-Alias cdpop Pop-Directory
Set-Alias cdswap Swap-Directory