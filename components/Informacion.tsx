import { FOOTER_CONTACT_INFO, FOOTER_LINKS, SOCIALS } from '@/constants';
import Image from 'next/image';
import Link from 'next/link';
import React from 'react'

const Informacion = () => {
  return (
    <footer className="flexCenter bg-[#ffffff]">
      <div className="padding-container max-container flex w-full flex-col gap-14">
        <div className="flex flex-col items-start justify-center gap-[10%] md:flex-row">

          <div className='flex flex-wrap gap-10 sm:justify-between md:flex-1'>
            {FOOTER_LINKS.map((columns) => (
              <FooterColumn title={columns.title}>
                <div className="regular-14 flex flex-col gap-4 text-[#535353]">
                  {columns.links.map((link) => (
                    <Link href={`/` + link.href} key={link.key}>
                      {link.label}
                    </Link>
                  ))}
                </div>
              </FooterColumn>
            ))}

            <div className="flex flex-col gap-5">
              <FooterColumn title={FOOTER_CONTACT_INFO.title}>
                {FOOTER_CONTACT_INFO.links.map((link) => (
                  <p className="medium-14 whitespace-nowrap text-[#535353]">
                    {link.value}
                  </p>
                ))}
              </FooterColumn>
            </div>

            <div className="flex flex-col gap-5">
              <FooterColumn title={SOCIALS.title}>
                {SOCIALS.links.map((link) => (
                  <Image
                    src={link}
                    alt="logo"
                    width={24}
                    height={24}
                    className="regular-14 flex gap-4 text-[#535353]"
                  />
                ))}
              </FooterColumn>
            </div>
          </div>
        </div>
        <div className="border text-[#000000]" />
        <div className="flex items-center justify-center">
          <div className="overflow-hidden">
            <Image
              src="/logo.png" alt="logo"
              width={274}
              height={229}
            />
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