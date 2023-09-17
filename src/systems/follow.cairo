#[system]
mod follow{
    use dojo::world::Context;
    use starknet::ContractAddress;
    use web3mq_dojo::components::{FollowEvent};
    fn execute(ctx: Context, sender_address:ContractAddress, target_address:ContractAddress, follow: bool){
        set !(ctx.world, FollowEvent{
            sender: sender_address,
            target: target_address,
            follow: follow
        });
    }
}