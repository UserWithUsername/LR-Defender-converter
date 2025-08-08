<#
.SYNOPSIS
    This script let you parse your original script to be able to run via msdefparser in Microsoft Defender Live Response.

.DESCRIPTION
    More on GitHub read me for this project.

.AUTHOR
    @usrwithusername
    https://x.com/usrwithusername
    https://github.com/UserWithUsername

.VERSION
    0.0.1

#>

function Convert-ToDefenderSafeString {
    [CmdletBinding(DefaultParameterSetName = 'String')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'String')]
        [string]$CommandString,

        [Parameter(Mandatory = $true, ParameterSetName = 'File')]
        [string]$InputFile
    )

    $mapping = @{
        '$' = '#D#'
        '(' = '#LP#'
        ')' = '#RP#'
        ';' = '#S#'
        '!' = '#B#'
        '|' = '#P#'
        '"' = '#Q#'
        "'" = "''"
    }

    if ($PSCmdlet.ParameterSetName -eq 'File') {
        if (-Not (Test-Path $InputFile)) {
            throw "Input file not found: $InputFile"
        }

        $CommandString = Get-Content -Path $InputFile -Raw
    }

    $CommandString = $CommandString -replace "(\{)\s*`r?`n", '$1 '
    $CommandString = $CommandString -replace "`r?`n\s*(\})", ' $1'
    $CommandString = $CommandString -replace "`r?`n", '; '


    foreach ($char in $mapping.Keys) {
        $CommandString = $CommandString -replace [regex]::Escape($char), $mapping[$char]
    }


    $CommandString = $CommandString -replace '\s*#S#\s*(#S#\s*)+', '#S# '


    return $CommandString
}
