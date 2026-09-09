# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph/KeyframedMovement }

<#>
    Placed on an entity to move it.
    Must be on the entity we wish to move (the one with the mesh, etc.)
simple_movement_component<public> := class<final_super>(component):

    @editable
    Keyframes:[]keyframed_movement_delta = array{}

    @editable
    PlaybackMode:keyframed_movement_playback_mode = pingpong_keyframed_movement_playback_mode{}

    @editable
    PlayOnSimulate:logic = true

    @editable
    OnlyPlaysOnce:logic = false

    var CanPlay:logic = true

    Play<public>():void=
        if (not CanPlay?). return

        if (KFMC := Entity.GetComponent[keyframed_movement_component]):
            KFMC.SetKeyframes(Keyframes, PlaybackMode)
            KFMC.Play()

            if (OnlyPlaysOnce?):
                set CanPlay = false

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        if (not Entity.GetComponent[keyframed_movement_component]):
            KFMC := keyframed_movement_component{ Entity := Entity }
            Entity.AddComponents(array{KFMC})

        if (PlayOnSimulate?):
            Play()




