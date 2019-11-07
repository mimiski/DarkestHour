//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHConstruction_ATGun_Light extends DHConstruction_Vehicle;

function static class<DHVehicle> GetVehicleClass(DHActorProxy.Context Context)
{
    if (Context.LevelInfo == none)
    {
        return none;
    }

    switch (Context.TeamIndex)
    {
        /*
        case AXIS_TEAM_INDEX: // Need the Pak38 from MN
            switch (Context.LevelInfo.Season)
            {
                case SEASON_Autumn:
                    return class'DH_Guns.DH_Pak40ATGun_CamoOne';
                default:
                    return class'DH_Guns.DH_Pak40ATGun';
            }
        */
        case ALLIES_TEAM_INDEX:
            switch (Context.LevelInfo.AlliedNation)
            {

                //case NATION_Britain:
                //case NATION_Canada:
                    //return class'DH_Guns.DH_6PounderGun'; // Need the 2 Pounder from MN
                case NATION_USSR:
                    switch (Context.LevelInfo.Weather)
                    {
                        case WEATHER_Snowy:
                            return class'DH_Guns.DH_45mmM1942Gun_Snow';
                        default:
                            return class'DH_Guns.DH_45mmM1942Gun';
                    }
                default:
                    break; //return class'DH_Guns.DH_AT57Gun';
            }
    }

    return none;
}

defaultproperties
{
    MenuIcon=Texture'DH_InterfaceArt2_tex.Icons.at_small'
    Stages(0)=(Progress=0)
    ProgressMax=10
}
