
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

using. Debug

debug_manager_component<public> := class<final_super>(component):

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for:
            Ent : Entity.FindDescendantEntitiesWithComponent(debug_draw_component)
            Comp := Ent.GetComponent[debug_draw_component]
        do:
            Comp.DrawShape()