import React from "react";
import { Button } from "../components/ui/button";
import { Card, CardContent } from "../components/ui/card";
import { Checkbox } from "../components/ui/checkbox";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";

import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

export default function Login() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [remember, setRemember] = useState(false);
    const navigate = useNavigate();
    const handleSubmit = (event: React.FormEvent) => { event.preventDefault(); navigate("/tenant-root"); };
  return (
   <div className="w-full min-w-0 bg-muted/40 overflow-x-hidden">
      <div className="mx-auto flex min-h-[60vh] w-full items-center justify-center px-4 py-10 min-w-0">
          <section className="mx-auto w-full max-w-md"><Card className="shadow-md"><CardContent className="p-6 sm:p-8"><h1 className="text-2xl font-bold text-foreground">Welcome back</h1><p className="mt-2 text-sm text-muted-foreground">Sign in to manage your training.</p><form className="mt-6 grid gap-4" onSubmit={handleSubmit}><div className="grid gap-2"><Label htmlFor="member-email">Email</Label><Input id="member-email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} required /></div><div className="grid gap-2"><Label htmlFor="member-password">Password</Label><Input id="member-password" type="password" value={password} onChange={(event) => setPassword(event.target.value)} required /></div><Label className="flex items-center gap-2 text-sm font-normal"><Checkbox checked={remember} onCheckedChange={(value) => setRemember(value === true)} />Keep me signed in</Label><Button type="submit">Log In</Button></form><p className="mt-5 text-center text-sm text-muted-foreground">Need an account? <Link to="/signup" className="font-medium text-primary hover:underline">Sign Up</Link></p></CardContent></Card></section>
      </div>
    </div>
  );
}