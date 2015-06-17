//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_Sdkfz251MGPawn extends DHVehicleMGPawn;

// TODO: the specified Vhalftrack_X anims are missing from DHCharacters_anm file, so see if it can be imported from the RO version - until then these anims don't exist & can't play
defaultproperties
{
    bKeepDriverAuxCollision=true // necessary for new player hit detection system, which basically uses normal hit detection as for an infantry player pawn
    UnbuttonedPositionIndex=0
    RaisedPositionIndex=1
    RaisedPositionIdleAnim="com_idle_open"
//  RaisedPosDriverIdleAnim="VHalftrack_com_idle_open"
    FirstPersonGunShakeScale=2.0
    WeaponFOV=72.0
    DriverPositions(0)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_Sdkfz251Halftrack_anm.halftrack_gun_int',TransitionUpAnim="com_open",/*DriverTransitionAnim="Vhalftrack_com_close",*/ViewPitchUpLimit=2000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)
    DriverPositions(1)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_Sdkfz251Halftrack_anm.halftrack_gun_int',TransitionDownAnim="com_close",/*DriverTransitionAnim="Vhalftrack_com_open",*/ViewPitchUpLimit=2000,ViewPitchDownLimit=63000,ViewPositiveYawLimit=10000,ViewNegativeYawLimit=-10000,bDrawOverlays=true,bExposed=true)
    bMultiPosition=true
    bMustBeTankCrew=false
    GunClass=class'DH_Vehicles.DH_Sdkfz251MG'
    PositionInArray=0
    bHasAltFire=false
    CameraBone="Camera_com"
    FirstPersonGunRefBone="1stperson_wep"
    FirstPersonOffsetZScale=3.0
    bHideMuzzleFlashAboveSights=true
    DriveRot=(Yaw=16384)
    DriveAnim="VHalftrack_com_idle"
    EntryRadius=130.0
    HUDOverlayClass=class'ROVehicles.ROVehMG34Overlay'
    HUDOverlayFOV=45.0
    PitchUpLimit=4000
    PitchDownLimit=61000
}
