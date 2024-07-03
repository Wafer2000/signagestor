import Image from 'next/image'
import React from 'react'
import Button from './Button'

const Inicio = () => {
  return (
    <section className="max-container padding-container flex flex-col gap-20 py-10 pb-32 mb:gap-28 lg:py-20 xl:flex-row">
      <div className='inicio-map'></div>

      {/* LEFT */}
      <div className="relative z-20 flex flex-1 flex-col xl:w-1/2">
        <div className="container mx-auto px-4 py-8 flex flex-col items-start justify-content-end">
          <h1 className="text-[#2ca9c6] text-right font-bold uppercase lg:text-3xl md:text-2xl sm:text-1xl xs:text-1xl">
            LABORATORIO CLÍNICO
          </h1>
          <h1 className="text-[#2e569b] text-right font-bold uppercase lg:text-7xl md:text-5xl sm:text-4xl xs:text-3xl">
            LANDSTEINER
          </h1>
          <h2 className="text-[#2ca9c6] text-right font-bold uppercase lg:text-3xl md:text-2xl sm:text-1xl xs:text-1xl">
            IPS S.A.S.
          </h2>
        </div>

        <p className="text-[18px] mt-6 text-gray-30 xl:max-w-[520px]">
          Cuidar tu salud es nuestro compromiso
        </p>

        <div className="my-11 flex flex-wrap gap-5">
          <div className="flex items-center gap-2">
            {Array(5).fill(1).map((_, index) => (
              <Image
                src="/star.svg"
                key={index}
                alt="star"
                width={24}
                height={24}
              />
            ))}
          </div>

          <p className="bold-16 lg:bold-20 text-blue-70">
            198k
            <span className="regular-16 lg:regular-20 ml-1">
              Excelentes críticas
            </span>
          </p>
        </div>

        <div className="flex flex-col w-full gap-3 sm:flex-row">
          <Button
            type="button"
            title="Ver Resultados"
            variant='btn_st_tropaz'
          />
          <Button
            type='button'
            title='¿Como trabajamos?'
            icon='/play.svg'
            variant='btn_white_text'
          />
        </div>
      </div>

      {/*<div className='map'></div>*/}
    </section>
  )
}

export default Inicio