//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_CromwellMountedMGPawn extends DHMountedTankMGPawn;

defaultproperties
{
    MGOverlay=texture'DH_VehicleOptics_tex.Allied.BesaMG_sight'
    WeaponFOV=38.0
    GunClass=class'DH_Vehicles.DH_CromwellMountedMG'
    bHasAltFire=false
    CameraBone="mg_yaw"
    bDrawDriverInTP=false
    EntryRadius=130.0
    FPCamViewOffset=(X=5.0,Y=-8.0,Z=-1.0)
    PitchUpLimit=4500
    PitchDownLimit=64000
}
