use crate::profanity::check_profanity;
use crate::store::Store;
use crate::types::answer::*;
use warp::http::StatusCode;

pub async fn add_answer(
    store: Store,
    new_answer: NewAnswer,
) -> Result<impl warp::Reply, warp::Rejection> {
    let content = match check_profanity(new_answer.content).await {
        Ok(res) => res,
        Err(e) => return Err(warp::reject::custom(e)),
    };
    let answer = NewAnswer {
        content,
        question_id: new_answer.question_id,
    };
    match store.add_answer(answer).await {
        Err(e) => Err(warp::reject::custom(e)),
        Ok(_) => Ok(warp::reply::with_status("answer added", StatusCode::OK)),
    }
}
