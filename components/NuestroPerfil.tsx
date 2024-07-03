import React from 'react';
import Image from 'next/image';

const NuestroPerfil = () => {
  return (
    <section className="flexCenter w-full flex-col">
      <div className="nuestroperfil">
        <div className="flex flex-1 items-center justify-end">
          <div className="lg:rounded-[50px] md:rounded-[20px] sm:rounded-[20px] xs:rounded-[20px] overflow-hidden">
            <Image
              src="/instalaciones.jpeg"
              alt="phones"
              width={550}
              height={870}
              className="w-full h-full object-cover object-center"
            />
          </div>
        </div>
        <div className="z-20 flex w-full flex-1 flex-col items-start justify-center gap-12">
          <h2 className="bold-40 lg:bold-64 xl:max-w-[320px]">
            ¿Nuestro Perfil?
          </h2>
          <p className="regular-16 text-[#000000]">
            En el Laboratorio Clínico Landsteiner IPS S.A.S somos consiente que el mejoramiento continuo podemos contribuir a una mejor calidad de vida a nuestros pacientes. Por eso el Laboratorio Clínico Landsteiner IPS S.A.S ofrece a sus pacientes yn servicio complejo e integral que va desde la recepción, toma de muestra, transporte y procesamiento de las muestras hasta su análisis e informe de los resultados de manera oportuna, eficiente y confiable. Todo esto basado en las vcapacitaciones contínuas de nuestro personal quienes apoyados en equipos de alta tecnología y en un estricto control interno garantizamos resultados confiables.
          </p>
        </div>
      </div>
    </section>
  );
}

export default NuestroPerfil;
