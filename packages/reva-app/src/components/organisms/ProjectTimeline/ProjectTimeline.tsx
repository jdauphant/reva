import { Timeline } from "components/molecules/Timeline/Timeline";
import { AccompanimentTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/AccompanimentTimelineElement/AccompanimentTimelineElement";
import { ProjectEndedTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/ProjectEndedTimelineElement/ProjectEndedTimelineElement";
import { ProjectSubmissionTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/ProjectSubmissionTimelineElement/ProjectSubmissionTimelineElement";
import { TrainingProgramTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/TrainingProgramTimelineElement/TrainingProgramTimelineElement";

import { CertificationTimelineElement } from "./TimelineElements/CertificationTimelineElement/CertificationTimelineElement";
import { ContactTimelineElement } from "./TimelineElements/ContactTimelineElement/ContactTimelineElement";
import { ExperiencesTimelineElement } from "./TimelineElements/ExperiencesTimelineElement/ExperiencesTimelineElement";
import { GoalsTimelineElement } from "./TimelineElements/GoalsTimelineElement/GoalsTimelineElement";
import { OrganismTimelineElement } from "./TimelineElements/OrganismTimelineElement/OrganismTimelineElement";

export const ProjectTimeline = ({
  className,
  "data-test": dataTest,
}: {
  className?: string;
  "data-test"?: string;
}) => {
  return (
    <Timeline className={className} data-test={dataTest}>
      <ContactTimelineElement />
      <CertificationTimelineElement />
      <GoalsTimelineElement />
      <ExperiencesTimelineElement />
      <OrganismTimelineElement />
      <ProjectSubmissionTimelineElement />
      <TrainingProgramTimelineElement />
      <AccompanimentTimelineElement />
      <ProjectEndedTimelineElement />
    </Timeline>
  );
};
