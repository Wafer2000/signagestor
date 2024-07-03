import Image from 'next/image'
import React from 'react'

const SaludOcupacional = () => {
  return (
    <section className='flexCenter flex-col'>
      <div className="padding-container max-container w-full pb-24">
        <div className="flex flex-wrap justify-between gap-5 lg:gap-10">
          <h2 className="bold-40 lg:bold-64 xl:max-w-[390px]">
            Servicios de Salud Ocupacional
          </h2>
          <p className="regular-16 text-gray-30 xl:max-w-[520px]">
            Monitoreo y evaluación de estado de salud del personal de la intitución a través de pruebas de Laboratorio Clínico con el fin de prevenir o detectar de manera temprana enfermedades de diferentes tipos según perfil de los empleados, generando bienestar al interior de la empresa lo que conlleva a un óptimo desempeño laboral y un ambiente organizacional sano y estable
          </p>
        </div>
      </div>

      <div className="flexCenter max-container relative w-full">
        <Image
          src="/salud_ocupacional.jpeg"
          alt="salud_ocupacional"
          width={1440}
          height={580}
          className="w-full object-cover object-center rounded-t-lg"
        />
      </div>
    </section>
  )
}

export default SaludOcupacional