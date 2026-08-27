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
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Ent : Entity.FindDescendantEntitiesWithComponent(mesh_component)):
            DebugDraw.DrawSphere(
                Ent.GetGlobalTransform().Translation,
                ?Color := NamedColors.Red,
                ?DrawDurationPolicy := debug_draw_duration_policy.Persistent,
                ?Radius := 50.0)


