//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_M3A1HalftrackMGPawn extends DHVehicleMGPawn;

// TODO: the specified Vhalftrack_X anims are missing from DHCharacters_anm file, so see if it can be imported from the RO version - until then these anims don't exist & can't play
defaultproperties
{
    bKeepDriverAuxCollision=true // necessary for new player hit detection system, which basically uses normal hit detection as for an infantry player pawn
    UnbuttonedPositionIndex=0
    RaisedPositionIndex=1
    RaisedPositionIdleAnim="com_open_idle"
//  RaisedPosDriverIdleAnim="Vhalftrack_com_idle_open"
    FirstPersonGunShakeScale=0.75
    WeaponFOV=60.0
    DriverPositions(0)=(ViewFOV=60.0,PositionMesh=SkeletalMesh'DH_M3A1Halftrack_anm.m3halftrack_gun_int',TransitionUpAnim="com_open",/*DriverTransitionAnim="Vhalftrack_com_close",*/ViewPitchUpLimit=5000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=12000,ViewNegativeYawLimit=-12000,bDrawOverlays=true,bExposed=true)
    DriverPositions(1)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_M3A1Halftrack_anm.m3halftrack_gun_int',TransitionDownAnim="com_close",/*DriverTransitionAnim="Vhalftrack_com_open",*/ViewPitchUpLimit=5000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=12000,ViewNegativeYawLimit=-12000,bDrawOverlays=true,bExposed=true)
    bMultiPosition=true
    bMustBeTankCrew=false
    GunClass=class'DH_Vehicles.DH_M3A1HalftrackMG'
    PositionInArray=0
    bHasAltFire=false
    CameraBone="Camera_com"
    FirstPersonGunRefBone="1stperson_wep"
    FirstPersonOffsetZScale=1.0
    bHideMuzzleFlashAboveSights=true
    DrivePos=(Y=-5.0,Z=14.0)
    DriveRot=(Yaw=16384)
    DriveAnim="VHalftrack_com_idle"
    EntryRadius=130.0
    HUDOverlayClass=class'DH_Vehicles.DH_VehHUDOverlay_30Cal'
    HUDOverlayOffset=(X=-2.0)
    HUDOverlayFOV=35.0
    PitchUpLimit=4000
    PitchDownLimit=60000
}
