export interface Degree {
  id: string;
  code: string;
  label: string;
  level: number;
}

export interface DropOutReason {
  id: string;
  label: string;
}

export const CertificationStatus = {
  INACTIVE: "INACTIVE",
  SOON: "SOON",
  AVAILABLE: "AVAILABLE",
};

export type CertificationStatus =
  typeof CertificationStatus[keyof typeof CertificationStatus];

export interface Certification {
  id: string;
  label: string;
  summary: string | null;
  level: number;
  activities: string | null;
  activityArea: string | null;
  accessibleJobType: string | null;
  abilities: string | null;
  codeRncp: string;
  status: CertificationStatus;
}

export interface Region {
  id: string;
  code: string;
  label: string;
}

export interface Department {
  id: string;
  code: string;
  label: string;
}

export interface VulnerabilityIndicator {
  id: string;
  label: string;
}

export interface ReorientationReason {
  id: string;
  label: string;
  createdAt: Date;
  updatedAt: Date | null;
  disabled: boolean;
}
