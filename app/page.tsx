import SaludOcupacional from "@/components/SaludOcupacional";
import Inicio from "@/components/Inicio";
import Servicios from "@/components/Servicios";
import QuienesSomos from "@/components/QuienesSomos";
import NuestroPerfil from "@/components/NuestroPerfil";
import Infraestructura from "@/components/Infraestructura";
import Proteccion from "@/components/Proteccion";
import Informacion from "@/components/Informacion";

export default function App() {
  return (
    <>
      <Inicio />
      <Servicios />
      <SaludOcupacional />
      <QuienesSomos />
      <NuestroPerfil />
      <Infraestructura />
      <Proteccion />
      <Informacion />
    </>
  );
}
