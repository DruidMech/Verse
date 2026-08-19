using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for (Anc : Entity.FindAncestorEntities(entity)):
            if (Parent := Anc.GetParent[]):
                Print("Ancestor: " + ToDiagnostic(Anc) + ", Parent: " + ToDiagnostic(Parent))
            else:
                Print("Ancestor: " + ToDiagnostic(Anc))