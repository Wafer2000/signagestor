"use client";

import { NAV_LINKS } from "@/constants"
import Image from "next/image"
import Link from "next/link"
import Button from "./Button"
import { useState } from "react"

const Navbar = () => {
  const [menuOpen, setMenuOpen] = useState(false);

  const handleMenuClick = () => {
    setMenuOpen(!menuOpen);
  };

  const handleCloseMenu = () => {
    setMenuOpen(false);
  };

  return (
    <nav className="flexBetween  padding-container relative z-30 py-5">
      <Link href="/">
        <Image src="/logo.png" alt="logo" width={154} height={109} />
      </Link>
      <ul className={`hidden h-full gap-12 lg:flex px-10 ${menuOpen ? 'block' : 'hidden'}`}>
        {NAV_LINKS.map((link) => (
          <Link href={link.href} key={link.key} className="text-gray-50 flexCenter cursor-pointer pb-1.5 transition-all hover:font-bold text-center text-[14px]">
            {link.label}
          </Link>
        ))}
      </ul>
      <Image
        src="menu.svg"
        alt="menu"
        width={32}
        height={32}
        className="inline-block cursor-pointer lg:hidden"
        onClick={handleMenuClick}
      />
      {menuOpen && (
        <div className="absolute top-0 left-0 w-full h-screen bg-white z-40 p-4">
          <button
            className="absolute top-0 right-0 pr-4 text-[#2e569b] text-[50px] font-bold"
            onClick={handleCloseMenu}
          >
            ×
          </button>
          <ul className="flex flex-col gap-6 pt-20">
            {NAV_LINKS.map((link) => (
              <Link href={link.href} key={link.key} className="text-[20px] text-[#2e569b] flexCenter cursor-pointer transition-all font-bold">
                {link.label}
              </Link>
            ))}
          </ul>
          <div className="lg:flexCenter hidden">
            <a href="https://gold-mole-609706.hostingersite.com/search-report" target="_blank" rel="noopener noreferrer">
              <button
                className='flexCenter gap-3 rounded-full border btn_dark_st_tropaz'
                type='button'
              >
                <label className="bold-16 whitespace-nowrap">Ver Resultados</label>
              </button>
            </a>
          </div>
        </div>
      )}
    </nav>
  )
}

export default Navbar