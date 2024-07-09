import Image from 'next/image'
import React from 'react'

const Seguridad = () => {
  return (
    <footer className="flexCenter w-full overflow-y-auto scroll-smooth">
      <div className="padding-container bg-[#ffff] flex w-full flex-col pt-5">
        <div className="border text-[#000000]"/>
        <div className="flex flex-col -center justify-center pt-5 items-center">
          <p className="text-[#000000] text-[11px] text-center">
            Como es de su conocimiento la secretaria de salud exige ciertos estándares para la prestación de servicio de salud, por tanto, es de vital importancia en nuestra entidad estar sujetos a ello, dando como resultado la satisfacción de nuestros usuarios. El LABORATORIO CLINICO LANDSTEINER IPS SAS. Se compromete en caso de una posible contrata- ción con su entidad, poner a su disposición toda la documentación exigida por la normatividad, insu- mos y/o equipos necesarios para la obtención de las muestras y el procesamiento de ellas.
          </p>
          <div className="overflow-hidden">
            <Image
              src="/logo.png" alt="logo"
              width={274}
              height={229}
            />
          </div>
        </div>
      </div>
    </footer>
  )
}

export default Seguridad