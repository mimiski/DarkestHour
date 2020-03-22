//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHMapMarker extends Object
    abstract;

// EScopeType replaces DHMapMarker.bIsSquadSpecific and DHMapMarker.bIsVisibleToTeam.
enum EScopeType
{
    PERSONAL,                                   // marker is coupled with a player (saved in DHPlayer.PersonalMapMarkers)
    SQUAD,                                      // marker is coupled with a squad
    TEAM                                        // marker is 
};
var EScopeType          Scope;

// EOverwritingRule replaces DHMapMarker.bIsUnique and DHMapMarker.bShouldOverwriteGroup.
enum EOverwritingRule
{
    UNIQUE_PER_GROUP,                           // there will always be exactly one or zero markers that have the given GroupIndex
    UNIQUE,                                     // there will always be exactly one or zero such marker
    OFF                                        // this marker can be drawn in any number on the map
};
var EOverwritingRule    OverwritingRule;        // 

var localized string    MarkerName;
var Material            IconMaterial;
var IntBox              IconCoords;
var color               IconColor;
var int                 LifetimeSeconds;        // Lifetime, in seconds, of the marker, or -1 for infinite
var int                 GroupIndex;             // Used for grouping map markers (e.g. in the context menu when placing them).
var bool                bShouldShowOnCompass;   // Whether or not this marker is displayed on the compass
var bool                bShouldDrawBeeLine;     // If true, draw a line from the player to this marker on the situation map.

// Override this function to determine if this map marker can be used. This
// function is evaluated once at the beginning of the map.
static function bool CanBeUsed(DHGameReplicationInfo GRI)
{
    return true;
}

// Override this function to determine if this map marker can be placed by
// the provided player.
static function bool CanPlaceMarker(DHPlayerReplicationInfo PRI)
{
    return false;
}

// Override this function to determine if this map marker can be removed by
// the provided player.
static function bool CanRemoveMarker(DHPlayerReplicationInfo PRI, DHGameReplicationInfo.MapMarker Marker)
{
    return false;
}
    
// Override this function to determine if this map marker can be displayed on the map by
// the provided player.
static function bool CanSeeMarker(DHPlayerReplicationInfo PRI, DHGameReplicationInfo.MapMarker Marker)
{
    return false;
}

static function color GetBeeLineColor()
{
    return default.IconColor;
}

// Override to run specific logic when this marker is placed.
static function OnMapMarkerPlaced(DHPlayer PC, DHGameReplicationInfo.MapMarker Marker);

// Override these 2 functions to determine how the marker should be handled when
// added/removed.
static function AddMarker(DHPlayer PC, float MapLocationX, float MapLocationY)
{
    if (default.Scope == PERSONAL)
    {
        PC.AddPersonalMarker(default.Class, MapLocationX, MapLocationY);
    }
    else
    {
        PC.ServerAddMapMarker(default.Class, MapLocationX, MapLocationY);
    }
}

static function RemoveMarker(DHPlayer PC, optional int Index)
{
    if (Index < 0)
    {
        return;
    }

    if (default.Scope == PERSONAL)
    {
        PC.RemovePersonalMarker(Index);
    }
    else
    {
        PC.ServerRemoveMapMarker(Index);
    }
}

// Override this to have a caption accompany the marker.
static function string GetCaptionString(DHPlayer PC, DHGameReplicationInfo.MapMarker Marker)
{
    return "";
}

defaultproperties
{
    IconCoords=(X1=0,Y1=0,X2=31,Y2=31)
    LifetimeSeconds=-1
    GroupIndex=-1
    Scope=TEAM
    OverwritingRule=NONE
    bShouldShowOnCompass=false
}
