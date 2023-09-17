#[system]
mod block{
    use dojo::world::Context;
    use starknet::ContractAddress;
    use web3mq_dojo::components::{BlockEvent};
    fn execute(ctx: Context, sender_address:ContractAddress, target_address:ContractAddress, block: bool){
        set !(ctx.world, BlockEvent{
            sender: sender_address,
            target: target_address,
            block: block
        });
    }
}