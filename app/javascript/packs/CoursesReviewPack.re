open CoursesReview__Types;

let decodeProps = json =>
  Json.Decode.(
    json |> field("levels", array(Level.decode)),
    json |> field("pendingSubmissions", array(IndexSubmission.decode)),
    json |> field("courseId", string),
    json |> field("teamCoaches", array(Coach.decode)),
    json |> field("currentCoach", Coach.decode),
  );

let (levels, pendingSubmissions, courseId, teamCoaches, currentCoach) =
  DomUtils.parseJsonAttribute() |> decodeProps;

ReactDOMRe.renderToElementWithId(
  <CoursesReview__Root
    levels
    pendingSubmissions
    courseId
    teamCoaches
    currentCoach
  />,
  "react-root",
);
