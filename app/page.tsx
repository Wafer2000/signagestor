import SaludOcupacional from "@/components/SaludOcupacional";
import Inicio from "@/components/Inicio";
import Servicios from "@/components/Servicios";
import QuienesSomos from "@/components/QuienesSomos";
import NuestroPerfil from "@/components/NuestroPerfil";
import Infraestructura from "@/components/Infraestructura";
import Proteccion from "@/components/Proteccion";
import Informacion from "@/components/Informacion";
import Seguridad from "@/components/Seguridad";
import Paquetes from "@/components/Paquetes";
import Proyeccion from "@/components/Proyeccion";

export default function App() {
  return (
    <>
      <Inicio />
      <Servicios />
      <Paquetes />
      <SaludOcupacional />
      <QuienesSomos />
      <Proyeccion />
      <NuestroPerfil />
      <Infraestructura />
      <Proteccion />
      <Informacion />
      <Seguridad />
    </>
  );
}
