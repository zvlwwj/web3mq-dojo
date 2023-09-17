use starknet::ContractAddress;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct FollowEvent{
    #[key]
    sender: ContractAddress,
		#[key]
    target: ContractAddress,
		follow: bool
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct BlockEvent{
    #[key]
    sender: ContractAddress,
		#[key]
    target: ContractAddress,
		block: bool
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct PermissionChangedEvent{
    #[key]
    sender: ContractAddress,
    permission: u32
}