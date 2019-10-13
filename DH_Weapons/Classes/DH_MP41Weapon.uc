//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_MP41Weapon extends DHAutoWeapon;

defaultproperties
{
    ItemName="Maschinenpistole 41"
    FireModeClass(0)=class'DH_Weapons.DH_MP41Fire'
    FireModeClass(1)=class'DH_Weapons.DH_MP41MeleeFire'
    PickupClass=class'DH_Weapons.DH_MP41Pickup'
    AttachmentClass=class'DH_Weapons.DH_MP41Attachment'

    Mesh=SkeletalMesh'Axis_Mp40_1st.mp41_Mesh'
    HighDetailOverlay=shader'Weapons1st_tex.SMG.MP41_S'
    bUseHighDetailOverlayIndex=true
    HighDetailOverlayIndex=2

    PlayerIronsightFOV=65.0
    IronSightDisplayFOV=35.0
    FreeAimRotationSpeed=7.5
    ZoomOutTime=0.15

    MaxNumPrimaryMags=9
    InitialNumPrimaryMags=9
    
    bHasSelectFire=true
    SelectFireAnim="select_fire"
    SelectFireIronAnim="Iron_select_fire"
}
