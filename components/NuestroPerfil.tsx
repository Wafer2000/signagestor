import React from 'react';
import Image from 'next/image';

const NuestroPerfil = () => {
  return (
    <div className="overflow-y-auto scroll-smooth" id='NuestroPerfil'>
      <section className="flexCenter w-full flex-col">
        <div className="nuestroperfil xs:w-full xs:p-0 xs:m-0 lg:px-20">
          <div className="relative flex items-center">
            <div className="overflow-hidden">
              <img
                src="/FOTOS LABORATORIO-02.jpg"
                alt="phones"
                height={760}
                className="w-full h-full object-cover object-center"
              />
            </div>
          </div>
          <div className="z-20 flex w-full flex-col items-center justify-center text-center xs:p-10">
            <h2 className="bold-40 lg:bold-64 xl:max-w-[320px] text-[#2e569b] uppercase">
              ¿Nuestro Perfil?
            </h2>
            <p className="regular-16 text-[#000000] pt-5 lg:text-[20px]">
              En el Laboratorio Clínico Landsteiner IPS S.A.S somos consiente que el mejoramiento continuo podemos contribuir a una mejor calidad de vida a nuestros pacientes. Por eso el Laboratorio Clínico Landsteiner IPS S.A.S ofrece a sus pacientes yn servicio complejo e integral que va desde la recepción, toma de muestra, transporte y procesamiento de las muestras hasta su análisis e informe de los resultados de manera oportuna, eficiente y confiable. Todo esto basado en las capacitaciones contínuas de nuestro personal quienes apoyados en equipos de alta tecnología y en un estricto control interno garantizamos resultados confiables.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}

export default NuestroPerfil;
