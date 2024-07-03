import { SERVICIOS } from '@/constants'
import React from 'react'
import { Icon } from '@mdi/react';
import { mdiInformation, mdiHandshake, mdiSnowflake, mdiCircle, mdiBacteria, mdiTestTube, mdiMagnify, mdiScaleBalance, mdiBaby, mdiToilet } from '@mdi/js';

const Servicios = () => {
  return (
    <section className="flex flex-col overflow-hidden py-24 min-h-screen">
      <div className="relative w-full flex flex-col">
        <div className="z-20 flex w-full flex-col">
          <div className='relative text-center'>
            <h2 className="bold-40 lg:bold-64">Nuestros Servicios</h2>
            <h2 className="p-4 text-gray-30 text-left lg:text-2xl md:text-2xl sm:text-1xl xs:text-1xl">
              La función principal del Laboratorio Clínico Landsteiner, es el analisis de las diferentes muestras de especímenes biológicos de origen humano, como:
            </h2>
          </div>
          <ul className="mt-10 grid gap-10 w-full md:grid-cols-2 lg:grid-cols-3 lg:gap-20">
            {SERVICIOS.map((feature) => (
              <FeatureItem
                key={feature.title}
                title={feature.title}
                icon={feature.icon}
                description={feature.description}
              />
            ))}
          </ul>
        </div>
      </div>
    </section>
  )
}

type FeatureItemProps = {
  title: string;
  icon: string;
  description: string;
}

const FeatureItem = ({ title, icon, description }: FeatureItemProps) => {
  let iconName;
  switch (icon) {
    case 'mdi-information':
      iconName = mdiInformation;
      break;
    case 'mdi-fist-bump':
      iconName = mdiHandshake;
      break;
    case 'mdi-snowflake':
      iconName = mdiSnowflake;
      break;
    case 'mdi-circle':
      iconName = mdiCircle;
      break;
    case 'mdi-bacteria':
      iconName = mdiBacteria;
      break;
    case 'mdi-test-tube':
      iconName = mdiTestTube;
      break;
    case 'mdi-magnify':
      iconName = mdiMagnify;
      break;
    case 'mdi-scale-balance':
      iconName = mdiScaleBalance;
      break;
    case 'mdi-baby':
      iconName = mdiBaby;
      break;
    case 'mdi-toilet':
      iconName = mdiToilet;
      break;
    case 'mdi-toilet-paper':
      iconName = mdiToilet;
      break;
    default:
      iconName = mdiInformation; // Icono por defecto
  }

  return (
    <li className="flex flex-1 flex-col items-start lg:items-center lg:text-center">
      <div className="p-4 flex items-center space-x-4 lg:flex-col lg:space-x-0 lg:space-y-4">
        <div className="rounded-full p-4 lg:p-7 bg-[#2e569b]">
          <Icon path={iconName} size={1} color="#ffffff" />
        </div>
        <h2 className="bold-20 lg:bold-32 capitalize">
          {title}
        </h2>
      </div>
      <p className="text-start p-4 regular-16 mt-5 bg-white/80 text-gray-30 lg:mt-[30px] lg:bg-none">
        {description}
      </p>
    </li>
  )
}

export default Servicios
