# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

using. KontTags.Gameplay
using. Movement

<#>
    Detects an overlap, finds a simple_movement_component 
    on a descendant entity, then calls Play() on it.
        * Later we will decouple this class from simple_movement_component
    Must have a descendant with a mesh_component
        * Owner of the mesh_component needs the overlap_volume tag
    Must have a descendant with a simple_movement_component *(subject to change)
overlap_volume_component<public> := class<final_super>(component):

    OnEntityEntered(InEntity:entity):void=
        for (Comp : Entity.FindDescendantComponents(simple_movement_component)):
            Comp.Play()
        
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for:
            Ent : Entity.FindDescendantEntitiesWithTag(overlap_volume)
            MeshComp := Ent.GetComponent[mesh_component]
        do:
            MeshComp.EntityEnteredEvent.Subscribe(OnEntityEntered)




