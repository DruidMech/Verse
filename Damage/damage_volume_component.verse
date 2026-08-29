# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }

# Designed to cause damage to players when they enter the volume
damage_volume_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    var EnteredEntity : ?entity = false

    OnEntityEntered(InEntity:entity):void=
        set EnteredEntity = option{InEntity}

    OnEntityExited(InEntity:entity):void=
        set EnteredEntity = false

    OnSimulate<override>()<suspends>:void=
        loop:
            if (Ent := EnteredEntity?):
                DebugDraw.DrawSphere(
                    Ent.GetGlobalTransform().Translation,
                    ?Color := NamedColors.Red,
                    ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                    ?Duration := 5.0,
                    ?Radius := 50.0)

            Sleep(0.5)
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Comp : Entity.FindDescendantComponents(mesh_component)):
            Comp.EntityEnteredEvent.Subscribe(OnEntityEntered)
            Comp.EntityExitedEvent.Subscribe(OnEntityExited)
