import { FOOTER_CONTACT_INFO, FOOTER_LINKS, SOCIALS } from '@/constants';
import Image from 'next/image';
import Link from 'next/link';
import React from 'react'

const Informacion = () => {
  return (
    <footer className="flexCenter w-full bg-[#2e569b] pb-5 overflow-y-auto scroll-smooth" id='Informacion'>
      <div className="padding-container flex w-full flex-col gap-14 pt-10 px-30 mx-10">
        <div className="flex flex-col items-start justify-center md:flex-row">

          <div className='flex flex-wrap gap-10 sm:justify-between md:flex-1 text-[#ffff]'>
            {FOOTER_LINKS.map((columns) => (
              <FooterColumn title={columns.title}>
                <div className="regular-14 flex flex-col">
                  {columns.links.map((link) => (
                    <Link href={link.href} key={link.key} className="text-white cursor-pointer pb-1.5 transition-all hover:font-bold text-start text-[14px]">
                      {link.label}
                    </Link>
                  ))}
                </div>
              </FooterColumn>
            ))}

            <div className="flex flex-col">
              <FooterColumn title={FOOTER_CONTACT_INFO.title}>
                {FOOTER_CONTACT_INFO.links.map((link) => (
                  <p className="medium-14 whitespace-nowrap">
                    {link.value}
                  </p>
                ))}
              </FooterColumn>
            </div>

            <div className="flex flex-col">
              <div className="flex flex-col gap-5">
                <h4 className="bold-18 whitespace-nowrap">Redes Sociales</h4>
                <Image
                  src='/facebook.svg'
                  alt="logo"
                  width={24}
                  height={24}
                  className="regular-14 flex gap-4"
                  style={{ filter: 'invert(1)' }}
                />
                <Image
                  src='/instagram.svg'
                  alt="logo"
                  width={24}
                  height={24}
                  className="regular-14 flex gap-4"
                  style={{ filter: 'invert(1)' }}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </footer>
  )
}

type FooterColumnProps = {
  title: string;
  children: React.ReactNode;
}

const FooterColumn = ({ title, children }: FooterColumnProps) => {
  return (
    <div className="flex flex-col gap-5">
      <h4 className="bold-18 whitespace-nowrap">{title}</h4>
      {children}
    </div>
  )
}

export default Informacion