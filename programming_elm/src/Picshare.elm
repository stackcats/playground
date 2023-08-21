module Picshare exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, disabled, placeholder, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Json.Decode exposing (Decoder, bool, int, list, string, succeed)
import Json.Decode.Pipeline exposing (hardcoded, required)


type alias Id =
    Int


type alias Photo =
    { id : Id
    , url : String
    , caption : String
    , liked : Bool
    , comments : List String
    , newComment : String
    }


photoDecoder : Decoder Photo
photoDecoder =
    succeed Photo
        |> required "id" int
        |> required "url" string
        |> required "caption" string
        |> required "liked" bool
        |> required "comments" (list string)
        |> hardcoded ""


type alias Model =
    { photo : Maybe Photo
    }


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


initialModel : Model
initialModel =
    { photo = Nothing }


fetchFeed : Cmd Msg
fetchFeed =
    Http.get
        { url = baseUrl ++ "feed/1"
        , expect = Http.expectJson LoadFeed photoDecoder
        }


view : Model -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewFeed model.photo ]
        ]


type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment
    | LoadFeed (Result Http.Error Photo)


viewLoveButtion : Photo -> Html Msg
viewLoveButtion { liked } =
    let
        buttonClass =
            if liked then
                "fa-heart"

            else
                "fa-heart-o"
    in
    div [ class "like-button" ]
        [ i
            [ class "fa fa-2x"
            , class buttonClass
            , onClick ToggleLike
            ]
            []
        ]


viewDetailedPhoto : Photo -> Html Msg
viewDetailedPhoto model =
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ viewLoveButtion model
            , h2 [ class "caption" ] [ text model.caption ]
            , viewComments model
            ]
        ]


viewComment : String -> Html Msg
viewComment comment =
    li []
        [ strong [] [ text "Comment: " ]
        , text comment
        ]


viewCommentList : List String -> Html Msg
viewCommentList comments =
    case comments of
        [] ->
            text ""

        _ ->
            div [ class "comments" ]
                [ ul [] (List.map viewComment comments) ]


viewComments : Photo -> Html Msg
viewComments photo =
    div []
        [ viewCommentList photo.comments
        , form [ class "new-comment", onSubmit SaveComment ]
            [ input
                [ type_ "text"
                , placeholder "Add a comment..."
                , value photo.newComment
                , onInput UpdateComment
                ]
                []
            , button [ disabled (String.isEmpty photo.newComment) ] [ text "Save" ]
            ]
        ]


viewFeed : Maybe Photo -> Html Msg
viewFeed maybePhoto =
    case maybePhoto of
        Just photo ->
            viewDetailedPhoto photo

        Nothing ->
            div [ class "loading-feed" ]
                [ text "Loading Feed..." ]


toggleLike : Photo -> Photo
toggleLike photo =
    { photo | liked = not photo.liked }


updateComment : String -> Photo -> Photo
updateComment comment photo =
    { photo | newComment = comment }


updateFeed : (Photo -> Photo) -> Maybe Photo -> Maybe Photo
updateFeed fn photo =
    Maybe.map fn photo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLike ->
            ( { model | photo = updateFeed toggleLike model.photo }, Cmd.none )

        SaveComment ->
            ( { model | photo = updateFeed saveComment model.photo }, Cmd.none )

        UpdateComment comment ->
            ( { model | photo = updateFeed (updateComment comment) model.photo }, Cmd.none )

        LoadFeed (Ok photo) ->
            ( { model | photo = Just photo }, Cmd.none )

        LoadFeed (Err _) ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


saveComment : Photo -> Photo
saveComment photo =
    let
        newComment =
            String.trim photo.newComment
    in
    if newComment == "" then
        photo

    else
        { photo | comments = photo.comments ++ [ newComment ], newComment = "" }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, fetchFeed )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
