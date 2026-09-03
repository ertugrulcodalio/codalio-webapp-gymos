import React from "react";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";
import { Checkbox } from "../components/ui/checkbox";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";

import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

export default function Signup() {
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [terms, setTerms] = useState(false);
    const navigate = useNavigate();
    const handleSubmit = (event: React.FormEvent) => { event.preventDefault(); navigate("/plans"); };
  return (
   <div className="w-full min-w-0 bg-muted/40 overflow-x-hidden">
      <div className="mx-auto flex min-h-[60vh] w-full items-center justify-center px-4 py-10 min-w-0">
          <section className="mx-auto w-full max-w-md"><Card className="shadow-md"><CardContent className="p-6 sm:p-8"><h1 className="text-2xl font-bold text-foreground">Join Ironworks</h1><p className="mt-2 text-sm text-muted-foreground">Set up your member account in a minute.</p><form className="mt-6 grid gap-4" onSubmit={handleSubmit}><div className="grid gap-2"><Label htmlFor="name">Full name</Label><Input id="name" value={name} onChange={(event) => setName(event.target.value)} required /></div><div className="grid gap-2"><Label htmlFor="email">Email</Label><Input id="email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} required /></div><div className="grid gap-2"><Label htmlFor="password">Password</Label><Input id="password" type="password" value={password} onChange={(event) => setPassword(event.target.value)} required /></div><Label className="flex items-center gap-2 text-sm font-normal"><Checkbox checked={terms} onCheckedChange={(value) => setTerms(value === true)} />I agree to the member terms</Label><Button type="submit" disabled={!terms}>Create account</Button></form><p className="mt-5 text-center text-sm text-muted-foreground">Already a member? <Link to="/login" className="font-medium text-primary hover:underline">Log In</Link></p></CardContent></Card></section>
      </div>
    </div>
  );
}