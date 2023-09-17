#[cfg(test)]
mod tests {
    use web3mq_dojo::components::{follow_event, FollowEvent};
    use web3mq_dojo::components::{block_event, BlockEvent};
    use web3mq_dojo::components::{permission_changed_event, PermissionChangedEvent};
    use web3mq_dojo::systems::follow::follow;
    use web3mq_dojo::systems::block::block;
    use web3mq_dojo::systems::permission::permission;
    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::test_utils::spawn_test_world;
    use debug::PrintTrait;
    fn setup_world() -> IWorldDispatcher {
        // components
        let mut components = array![follow_event::TEST_CLASS_HASH, block_event::TEST_CLASS_HASH, permission_changed_event::TEST_CLASS_HASH];
        // systems
        let mut systems = array![follow::TEST_CLASS_HASH, block::TEST_CLASS_HASH, permission::TEST_CLASS_HASH];
        let world = spawn_test_world(components, systems);
        return world;
    }

    #[test]
    #[available_gas(3000000000000000)]
    fn test_all(){
        let world = setup_world();
        world.execute('follow', array![1_felt252, 2_felt252, 1_felt252]);
        let follow_event_1 = get !(world, (1_felt252, 2_felt252),FollowEvent);
        assert(follow_event_1.follow, 'follow error');
        world.execute('follow', array![1_felt252, 2_felt252, 0_felt252]);
        let follow_event_2 = get !(world, (1_felt252, 2_felt252),FollowEvent);
        assert(!follow_event_2.follow, 'unfollow error');

        world.execute('block', array![1_felt252, 2_felt252, 1_felt252]);
        let block_event_1 = get !(world, (1_felt252, 2_felt252),BlockEvent);
        assert(block_event_1.block, 'block error');
        world.execute('block', array![1_felt252, 2_felt252, 0_felt252]);
        let block_event_2 = get !(world, (1_felt252, 2_felt252),BlockEvent);
        assert(!block_event_2.block, 'unblock error');

        world.execute('permission', array![1_felt252, 0_felt252]);
        let permission_changed_event = get !(world, 1_felt252,PermissionChangedEvent);
        assert(permission_changed_event.permission == 0, 'permission error');
    }
}