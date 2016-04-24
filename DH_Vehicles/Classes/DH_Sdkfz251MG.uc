//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_Sdkfz251MG extends DHVehicleMG;

defaultproperties
{
    // MG mesh
    Mesh=SkeletalMesh'DH_Sdkfz251Halftrack_anm.halftrack_gun_ext'
    Skins(1)=texture'Weapons3rd_tex.German.mg34_world'
    bMatchSkinToVehicle=true
    CollisionStaticMesh=StaticMesh'DH_German_vehicles_stc.Halftrack.Halftrack_MG_coll'
    bForceSkelUpdate=true // necessary for new player hit detection system, as makes server update the MG mesh skeleton, which it wouldn't otherwise as server doesn't draw mesh
    GunnerAttachmentBone="com_attachment"

    // Collision (as has gun shield)
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    bBlockZeroExtentTraces=true
    bBlockNonZeroExtentTraces=true

    // Movement
    RotationsPerSecond=0.5
    YawBone="Gun_protection"
    MaxPositiveYaw=10000
    MaxNegativeYaw=-10000
    PitchBone="Gun"
    CustomPitchUpLimit=2000
    CustomPitchDownLimit=63000

    // Ammo
    ProjectileClass=class'DH_Weapons.DH_MG34Bullet'
    InitialPrimaryAmmo=50
    NumMGMags=15
    FireInterval=0.07059
    TracerProjectileClass=class'DH_Weapons.DH_MG34TracerBullet'
    TracerFrequency=7

    // Weapon fire
    WeaponFireAttachmentBone="Gun"
    WeaponFireOffset=40.0
    AmbientEffectEmitterClass=class'VehicleMGEmitter'
    FireSoundClass=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_loop'
    FireEndSound=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_end'
    AmbientSoundScaling=2.5
    ShakeOffsetMag=(X=0.5,Y=0.0,Z=0.2)
    ShakeOffsetRate=(X=500.0,Y=500.0,Z=500.0)
    ShakeRotMag=(X=25.0,Y=0.0,Z=10.0)
    ShakeRotRate=(X=5000.0,Y=5000.0,Z=5000.0)

    // Reload
    HUDOverlayReloadAnim="Bipod_Reload_s"
    ReloadStages(0)=(Sound=none,Duration=1.21) // no sounds because HUD overlay reload animation plays them (durations matched to anim notifies)
    ReloadStages(1)=(Sound=none,Duration=1.94)
    ReloadStages(2)=(Sound=none,Duration=2.12)
    ReloadStages(3)=(Sound=none,Duration=1.32)
}
