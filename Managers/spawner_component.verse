using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

using. KontUtils.Activatables
using. KontTags.Gameplay

<#>
    Spawns an entity based on the selected type. Spawns:
        * On Activate
    Owning entity should only have one spawn location entity (with spawn_location tag)
spawner_component<public> := class<final_super>(component, activatable):

    @editable
    EntityType : concrete_subtype(entity) = false

    Activate<override>():void=
        SpawnEntity()

    SpawnEntity():void=
        for (SpawnLocEnt : Entity.FindDescendantEntitiesWithTag(spawn_location)):
            SpawnedEntity := EntityType{}
            Entity.AddEntities(array{ SpawnedEntity })
            SpawnedEntity.SetGlobalTransform(SpawnLocEnt.GetGlobalTransform())
            


