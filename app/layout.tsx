import type { Metadata } from "next";
import "./globals.css";
import Navbar from "@/components/Navbar";

export const metadata: Metadata = {
  title: "Landsteiner",
  description: "Laboratorio Clinico IPS S.A.S.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  return (
    <html lang="es">
      <body className="overflow-y-auto scroll-smooth block">
        <Navbar />
        <main className="relative overflow-hidden overflow-y-auto scroll-smooth block">
          {children}
        </main>
      </body>
    </html>
  );
}
