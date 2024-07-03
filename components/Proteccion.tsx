import Image from 'next/image';
import React from 'react';

const Proteccion = () => {
  return (
    <section className='flexCenter flex-col relative pb-28'>
      <div className="proteccion">
        <div className="flex flex-1 items-center justify-end">
          <div className="overflow-hidden top-0">
            <Image
              src="/LABORATIO CLINICO.png"
              alt="phones"
              width={550}
              height={870}
              className="w-full h-full object-cover object-center"
            />
          </div>
        </div>
        <div className="z-20 flex w-full flex-1 flex-col items-start justify-center gap-12">
          <p className="text-[#000000] text-[11px]">
            Como es de su conocimiento la secretaria de salud exige ciertos estándares para la prestación de servicio de salud, por tanto, es de vital importancia en nuestra entidad estar sujetos a ello, dando como resultado la satisfacción de nuestros usuarios. El LABORATORIO CLINICO LANDSTEINER IPS SAS. Se compromete en caso de una posible contrata- ción con su entidad, poner a su disposición toda la documentación exigida por la normatividad, insu- mos y/o equipos necesarios para la obtención de las muestras y el procesamiento de ellas.
          </p>
        </div>
      </div>
    </section>
  );
}

export default Proteccion;
