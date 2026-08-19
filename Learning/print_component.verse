using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    var Parents : []?entity = array{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        MaybeParents := for (Anc : Entity.FindAncestorEntities(entity)):
            option{ Anc.GetParent[] }
        
        for (MaybeParent : MaybeParents):
            if (Parent := MaybeParent?):
                Print("Has Parent.")
            else:
                Print("No Parent.")