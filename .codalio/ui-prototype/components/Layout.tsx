import type { ReactNode } from "react";
import { Breadcrumb, BreadcrumbItem, BreadcrumbList, BreadcrumbPage } from "./ui/breadcrumb";
import { Sidebar, SidebarContent, SidebarGroup, SidebarGroupContent, SidebarGroupLabel, SidebarInset, SidebarMenu, SidebarMenuButton, SidebarMenuItem, SidebarProvider, SidebarTrigger } from "./ui/sidebar";
import { Link, useLocation } from "react-router-dom";
import { Building2, CalendarDays, LayoutDashboard } from "lucide-react";
import Header from "./Header";
import Footer from "./Footer";

export default function Layout({ children }: { children: ReactNode }) {
  const location = useLocation();
  return <SidebarProvider><Sidebar collapsible="icon" className="border-r border-sidebar-border bg-sidebar"><SidebarContent><SidebarGroup><SidebarGroupLabel>GymOS workspace</SidebarGroupLabel><SidebarGroupContent><SidebarMenu><SidebarMenuItem><SidebarMenuButton asChild isActive={location.pathname === "/"} tooltip="Schedule"><Link to="/"><CalendarDays /><span>Schedule</span></Link></SidebarMenuButton></SidebarMenuItem><SidebarMenuItem><SidebarMenuButton asChild isActive={location.pathname === "/tenant-root"} tooltip="Tenant Portal"><Link to="/tenant-root"><Building2 /><span>Tenant Portal</span></Link></SidebarMenuButton></SidebarMenuItem><SidebarMenuItem><SidebarMenuButton asChild tooltip="Staff dashboard"><Link to="/staff/dashboard"><LayoutDashboard /><span>Staff dashboard</span></Link></SidebarMenuButton></SidebarMenuItem></SidebarMenu></SidebarGroupContent></SidebarGroup></SidebarContent></Sidebar><SidebarInset className="min-w-0 bg-background"><Header /><main className="w-full min-w-0 flex-1 p-4 sm:p-6 lg:p-8"><div className="mb-6 flex items-center gap-3"><SidebarTrigger aria-label="Toggle sidebar" /><Breadcrumb><BreadcrumbList><BreadcrumbItem><BreadcrumbPage>GymOS</BreadcrumbPage></BreadcrumbItem></BreadcrumbList></Breadcrumb></div>{children}</main><Footer /></SidebarInset></SidebarProvider>;
}