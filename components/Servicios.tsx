import React from 'react'
import { Icon } from '@mdi/react';
import { mdiInformation, mdiHandshake, mdiSnowflake, mdiCircle, mdiBacteria, mdiTestTube, mdiMagnify, mdiScaleBalance, mdiBaby, mdiToilet } from '@mdi/js';

const Servicios = () => {
  return (
    <section className="flex flex-col overflow-hidden pt-[96px] min-h-screen overflow-y-auto scroll-smooth" id='Servicios'>
      <div className="relative w-full flex flex-col">
        <div className="z-20 flex w-full flex-col">
          <div className='relative text-center items-center'>
            <h2 className="bold-40 lg:bold-64 text-[#2e569b] uppercase">
              Nuestros Servicios
            </h2>
            <h2 className="p-5 text-gray-30">
              La función principal del Laboratorio Clínico Landsteiner, es el analisis de las diferentes muestras de especímenes biológicos de origen humano, como:
            </h2>
          </div>
          <ul className="p-5 mt-10 grid gap-10 w-full md:grid-cols-2 lg:grid-cols-3 lg:gap-20">
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiInformation} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Quimica Sanguinea
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis químico de muestras de sangre para diagnosticar y monitorear varias condiciones de salud.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#88a4ce] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#2e569b]'>
                    <Icon path={mdiHandshake} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Inmunologia
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Estudio del sistema inmunológico para diagnosticar y tratar trastornos relacionados con la inmunidad.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiSnowflake} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Coagulacion
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis de factores de coagulación sanguínea para diagnosticar y monitorear trastornos de coagulación.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#88a4ce] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#2e569b]'>
                    <Icon path={mdiCircle} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Hematologia
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Estudio de la sangre y sus componentes para diagnosticar y tratar trastornos relacionados con la sangre.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiBacteria} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Microbiologia
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis de microorganismos para diagnosticar y tratar infecciones.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#88a4ce] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#2e569b]'>
                    <Icon path={mdiTestTube} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Serologia
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Estudio de la respuesta inmunológica a infecciones y enfermedades.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiMagnify} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Pruebas Especiales
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Pruebas especializadas para enfermedades o condiciones específicas, como trastornos genéticos.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#88a4ce] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#2e569b]'>
                    <Icon path={mdiScaleBalance} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Pruebas Hormonales
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis de niveles hormonales para diagnosticar y tratar desequilibrios hormonales.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiBaby} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Pruebas De Embarazo
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Pruebas para confirmar el embarazo y monitorear el desarrollo fetal.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#88a4ce] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#2e569b]'>
                    <Icon path={mdiToilet} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Orina
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis de muestras de orina para diagnosticar y monitorear trastornos renales y del tracto urinario.
                  </p>
                </div>
              </div>
            </li>
            <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
              <div className='bg-[#2e569b] rounded-tl-[2rem] rounded-br-[2rem] shadow-md'>
                <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
                  <div className='rounded-full p-4 lg:p-7 bg-[#88a4ce]'>
                    <Icon path={mdiToilet} size={1} color="#ffffff" />
                  </div>
                  <h2 className="bold-20 lg:bold-32 uppercase text-white">
                    Heces Y Mas
                  </h2>
                </div>
                <div className='p-5'>
                  <p className="border-[2px] border-gray-200 rounded-[1.5rem] p-5 text-start text-white lg:mt-[30px] lg:bg-none">
                    Análisis de muestras de heces para diagnosticar y monitorear trastornos gastrointestinales.
                  </p>
                </div>
              </div>
            </li>

          </ul>
        </div>
      </div>
    </section>
  )
}

export default Servicios
