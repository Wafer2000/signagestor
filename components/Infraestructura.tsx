import Image from 'next/image';
import React from 'react';

const Infraestructura = () => {
  return (
    <section className='flexCenter flex-col overflow-y-auto scroll-smooth' id='Infraestructura'>
      <div className="flexCenter relative w-full">
        <Image
          src="/infra-2.jpeg"
          alt="infra"
          width={1440}
          height={580}
          className='w-full object-cover object-center'
        />
      </div>
      <div className="padding-container  w-full pb-24 pt-10">
        <div className='relative text-center items-center'>
          <h2 className="text-[30px] font-bold lg:bold-64 text-[#2e569b] uppercase">
            Infraestructura
          </h2>
          <h2 className="p-10 text-gray-30">
            Disponemos de un Laboratorio Clínico con un área locativa bastante confortable para la atención de los pacientes, con equipos necesarios para la realización de los diferentes exámenes de Laboratorio y un grupo de profesionales de muy alta calidad humana y técnica. Además contamos con numerosas tomas de muestras distribuidas estratégicamente por la ciudad para realizar pruebas de apoyo diagnóstico en las áreas de química sanguínea, hepatología y microbiología, inmunología y pruebas hormonales que nos permite brindar una rápida y oportuna atención.
          </h2>
        </div>
      </div>
    </section>
  );
}

export default Infraestructura;
