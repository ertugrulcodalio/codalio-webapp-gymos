import { Link } from "react-router-dom";

export default function Footer() {
  return <footer className="border-t border-border bg-card px-4 py-8 text-sm text-muted-foreground sm:px-6"><div className="mx-auto flex w-full max-w-screen-2xl flex-col gap-4 sm:flex-row sm:items-center sm:justify-between"><p>© 2025 GymOS. Built for better training.</p><nav className="flex gap-5" aria-label="Footer navigation"><Link className="transition-colors hover:text-foreground" to="/">Privacy</Link><Link className="transition-colors hover:text-foreground" to="/">Terms</Link><Link className="transition-colors hover:text-foreground" to="/">Support</Link></nav></div></footer>;
}