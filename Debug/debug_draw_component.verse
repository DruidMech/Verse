using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /Verse.org/SpatialMath }

# This component will be used to draw debug shapes.
debug_draw_component<public> := class<final_super>(component):

    DebugDraw : debug_draw = debug_draw{}

    @editable
    DrawColor : color = color{}
  
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        Loc := Entity.GetGlobalTransform().Translation
        ElevatedLoc := vector3{ Left:=Loc.Left, Up:=Loc.Up + 100.0, Forward:=Loc.Forward }

        DebugDraw.DrawSphere(
            ElevatedLoc, 
            ?Radius := 50.0, 
            ?Color := DrawColor, 
            ?NumSegments := 12, 
            ?Thickness := 1.0, 
            ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration, 
            ?Duration := 600.0)



