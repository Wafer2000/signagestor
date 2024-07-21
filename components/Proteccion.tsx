import Image from 'next/image';
import React from 'react';

const Proteccion = () => {
  return (
    <section className='flexCenter flex-col relative px-10 overflow-y-auto scroll-smooth pt-10' id='Proteccion'>
      <div className="proteccion">
        <div className="flex flex-1 items-center justify-end">
          <div className="overflow-hidden top-0">
            <Image
              src="/LABORATIO CLINICO.png"
              alt="phones"
              width={550}
              height={870}
              className="w-full h-full object-cover object-center"
            />
          </div>
        </div>
        <div className="flex w-full flex-1 flex-col text-center items-center justify-center gap-3">
          Realizate tus examenes desde la comodidad de tu hogar u oficina
          <h1 className="text-[#000000] font-bold">
            ¡TOMA DE MUESTRAS A DOMICILIO!
          </h1>
          <div className="flex flex-col w-full sm:flex-row items-center justify-center pb-10">
            <a href="https://wa.me/573226637825" target="_blank">
              <button
                className={`flexCenter gap-3 rounded-full border btn_st_tropaz`}
                type='button'
              >
                <label className="bold-16 whitespace-nowrap">Agenda Aqui</label>
              </button>
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}

export default Proteccion;
