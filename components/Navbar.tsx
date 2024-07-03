import { NAV_LINKS } from "@/constants"
import Image from "next/image"
import Link from "next/link"
import Button from "./Button"

const Navbar = () => {
  return (
    <nav className="flexBetween max-container padding-container relative z-30 py-5">
      <Link href="/">
        <Image src="/logo.png" alt="logo" width={154} height={109} />
      </Link>
      <ul className="hidden h-full gap-12 lg:flex px-10">
        {NAV_LINKS.map((link) => (
          <Link href={link.href} key={link.key} className="regular-1 text-gray-50 flexCenter cursor-pointer pb-1.5 transition-all hover:font-bold text-center">
            {link.label}
          </Link>
        ))}
      </ul>
      <div className="lg:flexCenter hidden">
        <Button type="button" title="Resultados" icon="/user.svg" variant="btn_dark_st_tropaz" />
      </div>
      <Image
        src="menu.svg"
        alt="menu"
        width={32}
        height={32}
        className="inline-block cursor-pointer lg:hidden"
      />
    </nav>
  )
}

export default Navbar