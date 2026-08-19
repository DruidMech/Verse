using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# This component is for learning how to print messages to the log.
print_component<public> := class<final_super>(component):

    var AncestorMap : [entity]?entity = map{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        for:
            Anc : Entity.FindAncestorEntities of entity
            set AncestorMap[Anc] = option{Anc.GetParent[]}

        for (Ent->MaybeParent : AncestorMap):
            if (Parent is MaybeParent?):
                Print of "Ancestor has parent."
            else:
                Print of "Ancestor has no parent."


        
        