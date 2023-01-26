use handle_errors::Error;
use std::collections::HashMap;

#[derive(Default, Debug)]
pub struct Pagination {
    pub limit: Option<u32>,
    pub offset: u32,
}

pub fn extract_pagination(params: HashMap<String, String>) -> Result<Pagination, Error> {
    // Could be improved in the future
    if params.contains_key("start") && params.contains_key("end") {
        return Ok(Pagination {
            // Takes the "start" parameter in the query
            // and tries to convert it to a number
            limit: Some(
                params
                    .get("limit")
                    .unwrap()
                    .parse::<u32>()
                    .map_err(Error::Parse)?,
            ),
            // Takes the "end" parameter in the query
            // and tries to convert it to a number
            offset: params
                .get("offset")
                .unwrap()
                .parse::<u32>()
                .map_err(Error::Parse)?,
        });
    }

    Err(Error::MissingParameters)
}
