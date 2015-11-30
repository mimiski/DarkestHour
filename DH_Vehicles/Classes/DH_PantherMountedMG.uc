//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_PantherMountedMG extends DHVehicleMG;

defaultproperties
{
    NumMags=9
    TracerProjectileClass=class'DH_Weapons.DH_MG34TracerBullet'
    TracerFrequency=7
    hudAltAmmoIcon=texture'InterfaceArt_tex.HUD.mg42_ammo'
    YawBone="mg_yaw"
    PitchBone="mg_pitch"
    PitchUpLimit=15000
    PitchDownLimit=45000
    CustomPitchUpLimit=2730
    CustomPitchDownLimit=64000
    WeaponFireAttachmentBone="mg_yaw"
    WeaponFireOffset=20.0
    bInstantFire=false
    Spread=0.002
    FireInterval=0.07058
    FireSoundClass=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_loop'
    AmbientSoundScaling=2.0
    FireEndSound=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_end'
    ProjectileClass=class'DH_Weapons.DH_MG34Bullet'
    ShakeRotMag=(X=10.0,Y=10.0,Z=10.0)
    ShakeOffsetMag=(X=0.01,Y=0.01,Z=0.01)
    MaxPositiveYaw=4500
    MaxNegativeYaw=-4500
    bLimitYaw=true
    InitialPrimaryAmmo=150
    FireEffectOffset=(X=-50.0,Y=0.0,Z=30.0) // positions fire on co-driver's hatch
    Mesh=SkeletalMesh'DH_PanzerIV_anm.Panzer4_mg_ext'
}
