import React from "react";
import { Badge } from "../components/ui/badge";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";

import { CalendarDays, Check } from "lucide-react";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Plans() {
    const [selected, setSelected] = useState("Flex");
    const navigate = useNavigate();
    const plans = [{ name: "Starter", price: 39, credits: 1, popular: false }, { name: "Flex", price: 69, credits: 2, popular: true }, { name: "Unlimited", price: 109, credits: 5, popular: false }];
  return (
   <div className="w-full min-w-0 bg-background text-foreground overflow-x-hidden">
      <div className="mx-auto flex w-full max-w-6xl flex-col gap-10 min-w-0">
          <section className="max-w-2xl"><Badge variant="secondary">Ironworks memberships</Badge><h1 className="mt-4 text-3xl font-bold tracking-tight text-foreground">Choose the membership that fits your routine</h1><p className="mt-3 text-muted-foreground">Clear weekly class credits, no booking surprises.</p></section>
  <section className="grid gap-5 md:grid-cols-3">{plans.map((plan) => <Card key={plan.name} className={selected === plan.name ? "border-primary shadow-md" : ""}><CardContent className="p-6">{plan.popular && <Badge className="mb-4">Best value</Badge>}<h2 className="text-xl font-semibold text-foreground">{plan.name}</h2><p className="mt-3 text-4xl font-bold text-foreground">${plan.price}<span className="text-sm font-normal text-muted-foreground">/month</span></p><p className="mt-4 flex gap-2 text-sm text-muted-foreground"><CalendarDays className="size-4 text-primary" />{plan.credits} classes each week</p><p className="mt-2 flex gap-2 text-sm text-muted-foreground"><Check className="size-4 text-primary" />Flexible booking</p><Button className="mt-6 w-full" variant={selected === plan.name ? "default" : "outline"} onClick={() => { setSelected(plan.name); navigate("/checkout"); }}>Choose plan</Button></CardContent></Card>)}</section>
      </div>
    </div>
  );
}