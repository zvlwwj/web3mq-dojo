#[system]
mod permission{
    use dojo::world::Context;
    use starknet::ContractAddress;
    use web3mq_dojo::components::{PermissionChangedEvent};
    fn execute(ctx: Context, sender_address:ContractAddress, permission:u32){
        set !(ctx.world, PermissionChangedEvent{
            sender: sender_address,
            permission: permission
        });
    }
}