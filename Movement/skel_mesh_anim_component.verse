# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Game }

# Plays a skeletal mesh animation on the owning entity's mesh_component
skel_mesh_anim_component<public> := class<final_super>(component):

    @editable
    SkeletalAnimation:?skeletal_animation = false

    StartLoop()<suspends>:void=
        loop:
            Sleep(2.0)
            if:
                SkelMesh := Entity.GetComponent[mesh_component]
                SkelAnim := SkeletalAnimation?
            then:
                EaseInOut := easing_window{ Duration := 0.0, Offset := 0.0 }
                Entity.PlaySkeletalAnimation[SkelAnim, ?EaseInWindow:=EaseInOut, ?EaseOutWindow:=EaseInOut] or false

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        if (RoundMgr := Entity.GetFortRoundManager[]):
            RoundMgr.SubscribeRoundStarted(StartLoop)



