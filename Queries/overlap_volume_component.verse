# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

using. KontTags.Gameplay
using. Movement

<#>
    Detects an overlap, then finds all activatables on descendants,
    calling their Activate() function.
overlap_volume_component<public> := class<final_super>(component):

    FindDescendantActivatables()<transacts>:[]activatable=
        for:
            Comp : Entity.FindDescendantComponents(component)
            Activatable := activatable[Comp]
        do:
            Activatable

    OnEntityEntered(InEntity:entity):void=
        for (Activatable : FindDescendantActivatables()):
            Activatable.Activate()
        
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for:
            Ent : Entity.FindDescendantEntitiesWithTag(overlap_volume)
            MeshComp := Ent.GetComponent[mesh_component]
        do:
            MeshComp.EntityEnteredEvent.Subscribe(OnEntityEntered)




