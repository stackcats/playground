use crate::profanity::check_profanity;
use crate::store::Store;
use crate::types::pagination::*;
use crate::types::question::*;
use std::collections::HashMap;
use tracing::{event, instrument, Level};
use warp::http::StatusCode;

#[instrument]
pub async fn get_questions(
    qs: HashMap<String, String>,
    store: Store,
) -> Result<impl warp::Reply, warp::Rejection> {
    event!(target: "rust_web_dev", Level::INFO, "query questions");
    let mut pagination = Pagination::default();

    if !qs.is_empty() {
        event!(Level::INFO, pagination = true);
        pagination = extract_pagination(qs)?;
    }

    let res: Vec<Question> = match store
        .get_questions(pagination.limit, pagination.offset)
        .await
    {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    Ok(warp::reply::json(&res))
}

pub async fn add_question(
    store: Store,
    new_question: NewQuestion,
) -> Result<impl warp::Reply, warp::Rejection> {
    let title = match check_profanity(new_question.title).await {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    let content = match check_profanity(new_question.content).await {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    let question = NewQuestion {
        title,
        content,
        tags: new_question.tags,
    };

    if let Err(e) = store.add_question(question).await {
        Err(warp::reject::custom(e))
    } else {
        Ok(warp::reply::with_status("Question added", StatusCode::OK))
    }
}

pub async fn update_question(
    id: i32,
    store: Store,
    question: Question,
) -> Result<impl warp::Reply, warp::Rejection> {
    let title = match check_profanity(question.title).await {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    let content = match check_profanity(question.content).await {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    let question = Question {
        id: question.id,
        title,
        content,
        tags: question.tags,
    };

    let res = match store.update_question(id, question).await {
        Err(e) => return Err(warp::reject::custom(e)),
        Ok(res) => res,
    };

    Ok(warp::reply::json(&res))
}

pub async fn delete_question(id: i32, store: Store) -> Result<impl warp::Reply, warp::Rejection> {
    match store.delete_question(id).await {
        Err(e) => Err(warp::reject::custom(e)),
        _ => Ok(warp::reply::with_status("Question deleted", StatusCode::OK)),
    }
}
