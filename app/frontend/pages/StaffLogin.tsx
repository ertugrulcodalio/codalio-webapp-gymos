import React from "react";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";

import { ShieldCheck } from "lucide-react";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function StaffLogin() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const navigate = useNavigate();
    const handleSubmit = (event: React.FormEvent) => { event.preventDefault(); navigate("/staff/dashboard"); };
  return (
   <div className="w-full min-w-0 bg-muted/40 overflow-x-hidden">
      <div className="mx-auto flex min-h-[60vh] w-full items-center justify-center px-4 py-10 min-w-0">
          <section className="mx-auto w-full max-w-md"><Card className="shadow-md"><CardContent className="p-6 sm:p-8"><ShieldCheck className="size-9 text-primary" /><h1 className="mt-5 text-2xl font-bold text-foreground">Staff access</h1><p className="mt-2 text-sm text-muted-foreground">Manage your gym with GymOS.</p><form className="mt-6 grid gap-4" onSubmit={handleSubmit}><div className="grid gap-2"><Label htmlFor="staff-email">Email</Label><Input id="staff-email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} required /></div><div className="grid gap-2"><Label htmlFor="staff-password">Password</Label><Input id="staff-password" type="password" value={password} onChange={(event) => setPassword(event.target.value)} required /></div><Button type="submit">Log In</Button></form></CardContent></Card></section>
      </div>
    </div>
  );
}