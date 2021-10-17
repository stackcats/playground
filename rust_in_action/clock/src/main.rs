use chrono::{DateTime, Local};

struct Clock {}

impl Clock {
    fn get() -> DateTime<Local> {
        Local::now()
    }

    fn set() -> ! {
        unimplemented!()
    }
}
fn main() {
    let now = Local::new();

    Local::println!("Hello, world!");
}
