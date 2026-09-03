import { useState } from "react";
import { Avatar, AvatarFallback } from "./ui/avatar";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "./ui/dropdown-menu";
import { Sheet, SheetContent, SheetTrigger } from "./ui/sheet";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { Bell, Building2, CalendarDays, LogOut, Menu, User } from "lucide-react";

export default function Header() {
  const [open, setOpen] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();
  const handleLogout = () => { setOpen(false); if (location.pathname !== "/") navigate("/"); };

  return <header className="sticky top-0 z-30 border-b border-border bg-background/95 backdrop-blur"><div className="flex min-h-16 items-center justify-between gap-3 px-4 sm:px-6"><Link to="/" className="flex items-center gap-2 font-semibold text-foreground"><span className="grid size-8 place-items-center rounded-lg bg-primary text-primary-foreground"><CalendarDays className="size-4" /></span>GymOS</Link><nav className="hidden items-center gap-1 md:flex" aria-label="Primary navigation"><Button variant="ghost" asChild><Link to="/">Schedule</Link></Button><Button variant="ghost" asChild><Link to="/tenant-root">Tenant portal</Link></Button></nav><div className="flex items-center gap-2"><Badge variant="secondary" className="hidden gap-1 sm:flex"><Building2 className="size-3" />Ironworks</Badge><Button variant="ghost" size="icon" className="min-h-12 min-w-12" aria-label="Notifications"><Bell className="size-4" /></Button><DropdownMenu><DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="rounded-full" aria-label="Open user menu"><Avatar className="size-8"><AvatarFallback className="bg-primary text-xs text-primary-foreground">IM</AvatarFallback></Avatar></Button></DropdownMenuTrigger><DropdownMenuContent align="end"><DropdownMenuLabel>Ironworks Member</DropdownMenuLabel><DropdownMenuSeparator /><DropdownMenuItem asChild><Link to="/dashboard/profile"><User className="mr-2 size-4" />Profile</Link></DropdownMenuItem><DropdownMenuItem onClick={handleLogout}><LogOut className="mr-2 size-4" />Log out</DropdownMenuItem></DropdownMenuContent></DropdownMenu><Sheet open={open} onOpenChange={setOpen}><SheetTrigger asChild><Button variant="outline" size="icon" className="min-h-12 min-w-12 md:hidden" aria-label="Open menu"><Menu className="size-4" /></Button></SheetTrigger><SheetContent side="right"><nav className="mt-8 grid gap-2"><Button variant="ghost" asChild onClick={() => setOpen(false)}><Link to="/">Schedule</Link></Button><Button variant="ghost" asChild onClick={() => setOpen(false)}><Link to="/tenant-root">Tenant portal</Link></Button><Button variant="ghost" asChild onClick={() => setOpen(false)}><Link to="/plans">Plans</Link></Button></nav></SheetContent></Sheet></div></div></header>;
}