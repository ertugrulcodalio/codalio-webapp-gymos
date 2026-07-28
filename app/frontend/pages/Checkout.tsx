import React from "react";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { RadioGroup, RadioGroupItem } from "../components/ui/radio-group";
import { Separator } from "../components/ui/separator";

import { CreditCard, ShieldCheck } from "lucide-react";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Checkout() {
    const [plan, setPlan] = useState("Flex");
    const [card, setCard] = useState("");
    const navigate = useNavigate();
    const submit = (event: React.FormEvent) => { event.preventDefault(); navigate("/dashboard/bookings"); };
  return (
   <div className="w-full min-w-0 bg-background text-foreground overflow-x-hidden">
      <div className="mx-auto w-full max-w-5xl py-4 min-w-0">
          <section className="grid gap-6 lg:grid-cols-[1.2fr_.8fr]"><Card><CardContent className="p-6"><div className="flex items-center gap-3"><CreditCard className="size-6 text-primary" /><div><h1 className="text-2xl font-bold text-foreground">Complete your membership</h1><p className="text-sm text-muted-foreground">Mock payment — no charge will be made.</p></div></div><form className="mt-6 grid gap-5" onSubmit={submit}><div className="grid gap-2"><Label>Plan</Label><RadioGroup value={plan} onValueChange={setPlan} className="grid gap-2"><Label className="flex items-center gap-3 rounded-lg border p-3"><RadioGroupItem value="Flex" />Flex · $69/mo</Label><Label className="flex items-center gap-3 rounded-lg border p-3"><RadioGroupItem value="Unlimited" />Unlimited · $109/mo</Label></RadioGroup></div><div className="grid gap-2"><Label htmlFor="card">Card number</Label><Input id="card" placeholder="4242 4242 4242 4242" value={card} onChange={(event) => setCard(event.target.value)} required /></div><Button type="submit">Activate membership</Button></form></CardContent></Card><Card><CardContent className="p-6"><h2 className="font-semibold text-foreground">Order summary</h2><Separator className="my-4" /><div className="flex justify-between text-sm"><span className="text-muted-foreground">{plan} membership</span><span className="font-medium text-foreground">{plan === "Flex" ? "$69" : "$109"}/mo</span></div><div className="mt-5 flex gap-2 text-sm text-muted-foreground"><ShieldCheck className="size-4 text-primary" />Secure demo checkout</div></CardContent></Card></section>
      </div>
    </div>
  );
}