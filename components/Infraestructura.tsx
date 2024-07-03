import Image from 'next/image';
import React from 'react';

const Infraestructura = () => {
  return (
    <section className='flexCenter flex-col'>
      <div className="flexCenter max-container">
        <Image
          src="/infra-2.jpeg"
          alt="infra"
          width={1440}
          height={580}
        />
      </div>
      <div className="padding-container max-container w-full pb-24">
        <div className="flex flex-wrap justify-between gap-5 lg:gap-10 flex-col-reverse lg:flex-row">
          <div className="flex-1">
            <h2 className="bold-40 lg:bold-64 xl:max-w-[390px] pt-10">
              Infraestructura
            </h2>
            <p className="regular-16 text-gray-30">
              Disponemos de un Laboratorio Clínico con un área locativa bastante confortable para la atención de los pacientes, con equipos necesarios para la realización de los diferentes exámenes de Laboratorio y un grupo de profesionales de muy alta calidad humana y técnica. Además contamos con numerosas tomas de muestras distribuidas estratégicamente por la ciudad para realizar pruebas de apoyo diagnóstico en las áreas de química sanguínea, hepatología y microbiología, inmunología y pruebas hormonales que nos permite brindar una rápida y oportuna atención.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}

export default Infraestructura;
