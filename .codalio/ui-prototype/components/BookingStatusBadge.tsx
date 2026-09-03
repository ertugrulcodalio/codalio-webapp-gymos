
import { CircleCheck, CircleX, Clock3 } from "lucide-react";
import { Badge } from "./ui/badge";
const labels = { confirmed: "Confirmed", waitlisted: "Waitlisted", cancelled: "Cancelled" };
const statusClasses = { confirmed: "gap-1 bg-accent text-accent-foreground", waitlisted: "gap-1 bg-secondary text-secondary-foreground", cancelled: "gap-1 bg-destructive text-destructive-foreground" };

export default function BookingStatusBadge({ status = "confirmed" }: { status?: "confirmed" | "waitlisted" | "cancelled" }) {
  return <Badge className={statusClasses[status]}>{status === "confirmed" ? <CircleCheck className="size-3.5" /> : status === "waitlisted" ? <Clock3 className="size-3.5" /> : <CircleX className="size-3.5" />}{labels[status]}</Badge>;
}