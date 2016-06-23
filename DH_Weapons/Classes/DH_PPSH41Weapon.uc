//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2016
//==============================================================================

class DH_PPSh41Weapon extends DHFastAutoWeapon;

#exec OBJ LOAD FILE=..\Animations\Allies_Ppsh_1st.ukx

defaultproperties
{
     MagEmptyReloadAnim="reload_empty"
     MagPartialReloadAnim="reload_half"
     IronIdleAnim="Iron_idle"
     IronBringUp="iron_in"
     IronPutDown="iron_out"
     MaxNumPrimaryMags=2
     InitialNumPrimaryMags=2
     bPlusOneLoading=True
     CrawlForwardAnim="crawlF"
     CrawlBackwardAnim="crawlB"
     CrawlStartAnim="crawl_in"
     CrawlEndAnim="crawl_out"
     IronSightDisplayFOV=30.000000
     ZoomInTime=0.400000
     ZoomOutTime=0.200000
     FireModeClass(0)=Class'DH_Weapons.DH_PPSH41Fire'
     FireModeClass(1)=Class'DH_Weapons.DH_PPSH41MeleeFire'
     SelectAnim="Draw"
     PutDownAnim="Put_away"
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     DisplayFOV=70.000000
     bCanRestDeploy=True
     PickupClass=Class'DH_Weapons.DH_PPSH41Pickup'
     BobDamping=1.600000
     AttachmentClass=Class'DH_Weapons.DH_PPSH41Attachment'
     ItemName="PPSh41 SMG"
     Mesh=SkeletalMesh'Allies_Ppsh_1st.PPSH-41-mesh'
     HighDetailOverlay=Shader'Weapons1st_tex.SMG.PPSH41_S'
     bUseHighDetailOverlayIndex=True
     HighDetailOverlayIndex=2
}
