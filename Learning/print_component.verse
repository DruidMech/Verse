using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    Spacer : string = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
    Print30(Message:string):void=
        Print(Spacer + Message, ?Duration := 30.0)

    PrintColor(Message:string, ?Duration :float= 30.0, ?Color :color= NamedColors.Red):void=
        Print(Spacer + Message, ?Duration := Duration, ?Color := Color)

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        Print30("Printing some colored messages:")
        PrintColor("Blue", ?Color := NamedColors.Blue)
        PrintColor("Red", ?Color := NamedColors.Red)
        PrintColor("Aquamarine", ?Color := NamedColors.Aquamarine)
        PrintColor("Pink", ?Color := NamedColors.Pink, ?Duration := 60.0)
