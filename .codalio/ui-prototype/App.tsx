import "./styles.css";
import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Layout from "./components/Layout";
import Landing from "./pages/Landing";
import TenantRoot from "./pages/TenantRoot";
import StaffLogin from "./pages/StaffLogin";
import Signup from "./pages/Signup";
import Plans from "./pages/Plans";
import Checkout from "./pages/Checkout";
import DashboardBookings from "./pages/DashboardBookings";
import DashboardProfile from "./pages/DashboardProfile";
import Login from "./pages/Login";
import StaffDashboard from "./pages/StaffDashboard";
import StaffClasses from "./pages/StaffClasses";
import StaffPlans from "./pages/StaffPlans";
import StaffTrainers from "./pages/StaffTrainers";
import StaffBookings from "./pages/StaffBookings";

function App() {
  return (
    <BrowserRouter>

      <Layout>
        <Routes>
                <Route path="/" element={<Landing />} />
      <Route path="/tenant-root" element={<TenantRoot />} />
      <Route path="/staff/login" element={<StaffLogin />} />
      <Route path="/signup" element={<Signup />} />
      <Route path="/plans" element={<Plans />} />
      <Route path="/checkout" element={<Checkout />} />
      <Route path="/dashboard/bookings" element={<DashboardBookings />} />
      <Route path="/dashboard/profile" element={<DashboardProfile />} />
      <Route path="/login" element={<Login />} />
      <Route path="/staff/dashboard" element={<StaffDashboard />} />
      <Route path="/staff/classes" element={<StaffClasses />} />
      <Route path="/staff/plans" element={<StaffPlans />} />
      <Route path="/staff/trainers" element={<StaffTrainers />} />
      <Route path="/staff/bookings" element={<StaffBookings />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;