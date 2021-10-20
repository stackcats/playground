use crate::prelude::*;

#[system]
#[read_component(Point)]
#[read_component(Render)]
pub fn entity_render(esc: &SubWorld, #[resource] camera: &Camera) {}
