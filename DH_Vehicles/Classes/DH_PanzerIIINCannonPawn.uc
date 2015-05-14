//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_PanzerIIINCannonPawn extends DHGermanTankCannonPawn;

defaultproperties
{
    ScopeCenterScale=0.635
    ScopeCenterRotator=TexRotator'DH_VehicleOptics_tex.German.PZ4_sight_Center'
    CenterRotationFactor=985
    OverlayCenterSize=0.78
    DestroyedScopeOverlay=texture'DH_VehicleOpticsDestroyed_tex.German.PZ4_sight_destroyed'
    bManualTraverseOnly=true
    CannonScopeCenter=texture'DH_VehicleOptics_tex.German.PZ3_sight_graticule'
    ScopePositionX=0.237
    ScopePositionY=0.15
    WeaponFOV=30.0
    AmmoShellTexture=texture'DH_InterfaceArt_tex.Tank_Hud.Panzer3shell'
    AmmoShellReloadTexture=texture'DH_InterfaceArt_tex.Tank_Hud.Panzer3shell_reload'
    DriverPositions(0)=(ViewLocation=(X=12.0,Y=-27.0,Z=3.0),ViewFOV=30.0,PositionMesh=SkeletalMesh'DH_Panzer3_anm.Panzer3n_turret_int',ViewPitchUpLimit=3641,ViewPitchDownLimit=64080,ViewPositiveYawLimit=19000,ViewNegativeYawLimit=-20000,bDrawOverlays=true)
    DriverPositions(1)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_Panzer3_anm.Panzer3n_turret_int',TransitionUpAnim="com_open",DriverTransitionAnim="VKV1_com_close",ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=6000,ViewNegativeYawLimit=-10000)
    DriverPositions(2)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_Panzer3_anm.Panzer3n_turret_int',TransitionDownAnim="com_close",DriverTransitionAnim="VKV1_com_open",ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bExposed=true)
    DriverPositions(3)=(ViewFOV=12.0,PositionMesh=SkeletalMesh'DH_Panzer3_anm.Panzer3n_turret_int',ViewPitchUpLimit=5000,ViewPitchDownLimit=63500,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)
    GunClass=class'DH_Vehicles.DH_PanzerIIINCannon'
    CameraBone="Gun"
    DrivePos=(Z=-6.0)
    DriveAnim="VKV1_com_idle_close"
    EntryRadius=130.0
    FPCamPos=(X=50.0,Y=-30.0,Z=11.0)
    PitchUpLimit=6000
    PitchDownLimit=64000
    SoundVolume=130
}
