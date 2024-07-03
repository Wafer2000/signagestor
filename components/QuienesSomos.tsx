import React from 'react'
import Button from './Button'
import Image from 'next/image'

const QuienesSomos = () => {
  return (
    <section className="flexCenter w-full flex-col">
      <div className="QuienesSomos">
        <div className="z-20 flex w-full flex-1 flex-col items-start justify-center gap-12">
          <h2 className="bold-40 lg:bold-64 xl:max-w-[320px]">
            ¿Quienes Somos?
          </h2>
          <p className="regular-16 text-[#000000]">
          El laboratorio clínico LANDSTEINER IPS S.A.S. es una empresa solida de la ciudad de Barranquilla con más de 20 años de experiencia en el sector salud, dedicado a ofrecer soluciones confiables que impactan positivamente en el bienestar de nuestros clientes, a través de formación y entrenamiento de nuestro capital humano , estableciendo alianzas estratégicas con proveedores de calidad, cumpliendo con las normas y requisitos legales exigidos por nuestros entes vigilantes y administrativos. Somos una empresa de trabajo con una vocación de servicio permanente, comprometidos en brindar a todas las partes interesadas en el servicio una muestra de calidad científica y humana que genere relaciones de confianza, crecimiento de nuestras unidades de servicio y sostenibilidad en el tiempo. Somos una institución con altos estándares de calidad, innovadora, emprendedora y progresista.
          </p>
        </div>
      </div>
    </section>
  )
}

export default QuienesSomos