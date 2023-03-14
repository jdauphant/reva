import { Button } from "@codegouvfr/react-dsfr/Button";
import { TimelineElement } from "components/molecules/Timeline/Timeline";
import { useMainMachineContext } from "contexts/MainMachineContext/MainMachineContext";

export const TrainingProgramTimelineElement = () => {
  const { state, mainService } = useMainMachineContext();

  return (
    <TimelineElement
      title="Validation de parcours"
      description="Validez le nombre d’heures d’accompagnement et de formation défini par votre référent"
      status={
        state.context.candidacyStatus === "PROJET"
          ? "disabled"
          : ["VALIDATION", "PRISE_EN_CHARGE", "PARCOURS_ENVOYE"].includes(
              state.context.candidacyStatus
            )
          ? "active"
          : "readonly"
      }
    >
      {({ status }) =>
        status === "readonly" ? (
          <Button
            data-test="view-training-program-button"
            className="mt-2"
            priority="secondary"
            nativeButtonProps={{
              onClick: () => mainService.send("OPEN_TRAINING_PROGRAM_SUMMARY"),
            }}
          >
            Consulter mon parcours
          </Button>
        ) : (
          state.context.candidacyStatus === "PARCOURS_ENVOYE" && (
            <Button
              data-test="validate-training-program-button"
              className="mt-2"
              priority="secondary"
              nativeButtonProps={{
                onClick: () =>
                  mainService.send("OPEN_TRAINING_PROGRAM_SUMMARY"),
                disabled: status === "disabled",
              }}
            >
              Valider mon parcours
            </Button>
          )
        )
      }
    </TimelineElement>
  );
};
