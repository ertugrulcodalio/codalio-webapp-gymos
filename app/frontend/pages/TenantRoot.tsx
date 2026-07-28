import React from "react";
import { Badge } from "../components/ui/badge";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Progress } from "../components/ui/progress";

import { CalendarDays, Clock, Dumbbell, List, Search, Users } from "lucide-react";
import { useState } from "react";

export default function TenantRoot() {
    const [query, setQuery] = useState("");
    const [view, setView] = useState("list");
    const [booked, setBooked] = useState<string[]>([]);
    const classes = [{ id: "strength", name: "Strength Foundations", type: "Strength", time: "Today · 6:00 PM", trainer: "Maya Chen", booked: 10, capacity: 14 }, { id: "hiit", name: "HIIT Circuit", type: "Conditioning", time: "Tomorrow · 7:00 AM", trainer: "Sam Wilson", booked: 14, capacity: 16 }, { id: "yoga", name: "Recovery Yoga", type: "Mobility", time: "Saturday · 9:00 AM", trainer: "Elena Torres", booked: 8, capacity: 12 }];
  return (
   <div className="w-full min-w-0 bg-background text-foreground overflow-x-hidden">
      <div className="mx-auto flex w-full max-w-screen-2xl flex-col gap-6 min-w-0">
          <section className="flex flex-col gap-4 rounded-xl border border-border bg-card p-4 lg:flex-row lg:items-center lg:justify-between"><div><div className="flex items-center gap-3"><h1 className="text-2xl font-bold text-foreground">Class schedule</h1><Badge variant="secondary">1 of 2 booked</Badge></div><p className="mt-1 text-sm text-muted-foreground">Find your next session at Ironworks.</p></div><div className="flex flex-col gap-2 sm:flex-row"><div className="relative"><Search className="absolute left-3 top-3 size-4 text-muted-foreground" /><Input value={query} onChange={(event) => setQuery(event.target.value)} className="pl-9" placeholder="Search classes" /></div><Button variant={view === "list" ? "secondary" : "outline"} onClick={() => setView("list")}><List className="size-4" />List</Button><Button variant={view === "calendar" ? "secondary" : "outline"} onClick={() => setView("calendar")}><CalendarDays className="size-4" />Calendar</Button></div></section>
          <section><div className="mb-5"><h2 className="text-xl font-semibold text-foreground">Available classes</h2></div><div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">{classes.map((item) => <Card key={item.id}><CardContent className="p-5"><div className="flex items-start justify-between gap-3"><div><Badge variant="secondary">{item.type}</Badge><h3 className="mt-3 font-semibold text-foreground">{item.name}</h3></div><Dumbbell className="size-5 text-primary" /></div><div className="mt-4 grid gap-2 text-sm text-muted-foreground"><span className="flex items-center gap-2"><Clock className="size-4" />{item.time}</span><span className="flex items-center gap-2"><Users className="size-4" />{item.trainer}</span></div><div className="mt-4"><div className="mb-2 flex justify-between text-xs text-muted-foreground"><span>{item.booked}/{item.capacity} booked</span><span>{item.capacity - item.booked} spots</span></div><Progress value={(item.booked / item.capacity) * 100} /></div><Button className="mt-5 w-full" disabled={item.booked >= item.capacity || booked.includes(item.id)} onClick={() => setBooked([...booked, item.id])}>{booked.includes(item.id) ? "Booked" : "Book class"}</Button></CardContent></Card>)}</div></section>
      </div>
    </div>
  );
}