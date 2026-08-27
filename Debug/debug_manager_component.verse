
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }

using. Debug

debug_manager_component<public> := class<final_super>(component):

    GetDebugDrawComp(InEntity:entity)<decides><reads>:debug_draw_component=
        InEntity.GetComponent[debug_draw_component]

    AddDrawCompToEntity(InEntity:entity):debug_draw_component=
        if (DrawComp := GetDebugDrawComp[InEntity]):
            return DrawComp
        
        NewDrawComp := debug_draw_component{ Entity := InEntity }
        set NewDrawComp.DrawColor = NamedColors.White
        InEntity.AddComponents(array{NewDrawComp})
        NewDrawComp

    DrawDescendantShapes():void=
        for (DrawComp : Entity.FindDescendantComponents(debug_draw_component)):
            DrawComp.DrawShape()

    OnBeginSimulation<override>():void=
        (super:)OnBeginSimulation()

        for (Ent : Entity.FindDescendantEntities(entity)):
            if (DrawComp := GetDebugDrawComp[Ent]):
                DrawComp.DrawShape()
            else:
                NewDrawComp := AddDrawCompToEntity(Ent)
                NewDrawComp.DrawShape()


    OnSimulate<override>()<suspends>:void=
        loop:
            DrawDescendantShapes()
            Sleep(2.0)

        



