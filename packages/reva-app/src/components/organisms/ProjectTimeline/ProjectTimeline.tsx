import { Timeline } from "components/molecules/Timeline/Timeline";
import { ProjectSubmissionTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/ProjectSubmissionTimelineElement/ProjectSubmissionTimelineElement";
import { TrainingProgramTimelineElement } from "components/organisms/ProjectTimeline/TimelineElements/TrainingProgramTimelineElement/TrainingProgramTimelineElement";

import { CertificationTimelineElement } from "./TimelineElements/CertificationTimelineElement/CertificationTimelineElement";
import { ContactTimelineElement } from "./TimelineElements/ContactTimelineElement/ContactTimelineElement";
import { ExperiencesTimelineElement } from "./TimelineElements/ExperiencesTimelineElement/ExperiencesTimelineElement";
import { GoalsTimelineElement } from "./TimelineElements/GoalsTimelineElement/GoalsTimelineElement";
import { OrganismTimelineElement } from "./TimelineElements/OrganismTimelineElement/OrganismTimelineElement";

export const ProjectTimeline = ({
  className,
  dataTest,
}: {
  className?: string;
  dataTest?: string;
}) => {
  return (
    <Timeline className={className} dataTest={dataTest}>
      <ContactTimelineElement />
      <CertificationTimelineElement />
      <GoalsTimelineElement />
      <ExperiencesTimelineElement />
      <OrganismTimelineElement />
      <ProjectSubmissionTimelineElement />
      <TrainingProgramTimelineElement />
    </Timeline>
  );
};
