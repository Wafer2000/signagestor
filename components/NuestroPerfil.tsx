import React from 'react';
import Image from 'next/image';

const NuestroPerfil = () => {
  return (
    <div className="overflow-y-auto scroll-smooth" id='NuestroPerfil'>
      <section className="flexCenter w-full flex-col">
        <div className="nuestroperfil">
          <div className="relative flex items-center">
            <div className="lg:rounded-[50px] md:rounded-[20px] sm:rounded-[20px] xs:rounded-[20px] overflow-hidden">
              <Image
                src="/instalaciones.jpeg"
                alt="phones"
                width={440}
                height={760}
                className="w-full h-full object-cover object-center"
              />
            </div>
          </div>
          <div className="z-20 flex w-full flex-col items-center justify-center gap-12 text-center">
            <h2 className="bold-40 lg:bold-64 xl:max-w-[320px] text-[#2e569b] uppercase">
              ¿Nuestro Perfil?
            </h2>
            <p className="regular-16 text-[#000000]">
              En el Laboratorio Clínico Landsteiner IPS S.A.S somos consiente que el mejoramiento continuo podemos contribuir a una mejor calidad de vida a nuestros pacientes. Por eso el Laboratorio Clínico Landsteiner IPS S.A.S ofrece a sus pacientes yn servicio complejo e integral que va desde la recepción, toma de muestra, transporte y procesamiento de las muestras hasta su análisis e informe de los resultados de manera oportuna, eficiente y confiable. Todo esto basado en las vcapacitaciones contínuas de nuestro personal quienes apoyados en equipos de alta tecnología y en un estricto control interno garantizamos resultados confiables.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}

export default NuestroPerfil;
