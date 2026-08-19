using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        AncestorsAndParents : []tuple(entity, ?entity) = for (Anc : Entity.FindAncestorEntities(entity)):
            MaybeParent := option{Anc.GetParent[]}
            (Anc, MaybeParent)

        for (Pair : AncestorsAndParents):
            if (Parent := Pair(1)?):
                Print("Ancestor: " + ToDiagnostic(Pair(0)) + "Parent: " + ToDiagnostic(Parent))
            else:
                Print("Ancestor: " + ToDiagnostic(Pair(0)))
