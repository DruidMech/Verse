# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph/KeyframedMovement }

<#>
    Placed on an entity to move it.
    Must be on the entity we wish to move (the one with the mesh, etc.)
    Owning entity must have a keyframed_movement_component
simple_movement_component<public> := class<final_super>(component):

    @editable
    Keyframe:keyframed_movement_delta = keyframed_movement_delta{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        if (KFMC := Entity.GetComponent[keyframed_movement_component]):
            KFMC.SetKeyframes(array{ Keyframe }, pingpong_keyframed_movement_playback_mode{})
            KFMC.Play()




