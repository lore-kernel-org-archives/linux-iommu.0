From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/12] ARM: tegra: Add memory controller support for
 Tegra20
Date: Thu, 30 Oct 2014 15:45:27 +0100
Message-ID: <20141030144525.GC20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-6-git-send-email-thierry.reding@gmail.com>
 <CAASgrz3Z2vW0L+u5kju9bAh-R4PnreMnhoGaKY_UwSTGFcBshA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAASgrz3Z2vW0L+u5kju9bAh-R4PnreMnhoGaKY_UwSTGFcBshA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 10:43:56AM -0700, David Riley wrote:
> Hi Thierry,
>=20
> On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >
> > Collapses the old memory-controller and IOMMU device tree nodes into a
> > single node to more accurately describe the hardware.
> >
> > Note that this is an incompatible change, but while a GART driver has
> > existed for a few years it has never been used to do any translations.
> >
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/tegra20.dtsi | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20=
=2Edtsi
> > index 3b374c49d04d..a195c1975f3c 100644
> > --- a/arch/arm/boot/dts/tegra20.dtsi
> > +++ b/arch/arm/boot/dts/tegra20.dtsi
> > @@ -538,15 +538,14 @@
> >
> >         memory-controller@7000f000 {
> >                 compatible =3D "nvidia,tegra20-mc";
> > -               reg =3D <0x7000f000 0x024
> > -                      0x7000f03c 0x3c4>;
> > +               reg =3D <0x7000f000 0x00000400   /* controller register=
s */
> > +                      0x58000000 0x02000000>; /* GART aperture */
>=20
> Aren't these bindings supposed to be stable?  The tegra20-mc driver
> isn't modified.

You're right in that this particular patch should be deferred until the
Tegra20 driver has been updated.

Thierry

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUk8FAAoJEN0jrNd/PrOhRYEP/jBcIUytqYJxuSZQhWQ0MVnC
nPDNkMXBP+CQJ88NHH/u3T9xAd8CLwxFA1IAfh31AyGipLhrUF/7jahoCTwl3pus
OBkAZM8oRpCu2nZet5wklf0H2b4FCTq8lo5/y6HX/oDqt5qVkX9qBkS8Pa85X312
i0JJ0vAT4W6HwYh5WBLaWZSWuUohukhYRMhn5VUeRmwrbwypsfC44iv/2Kihy1ty
Gi3kW0Nm9IKVFY8tfEluP9xQjysBXM0O6Iql+ST+cgH7nwHaKq5n47SX3FoupQvQ
3Fj8qaKjnOs4NjKMyUSHoWbR3Hd5P58T7cRsAV8Tyb0o4OmQ6My9yZN1s4kX54It
vV1O54enShnCNPiaLodTg4OU9dKvj/X0X9yNse5uz1BRr9TF5bcXyruguDRIlCd2
YczIrEd/lhDUwJEdy+bgVm+cv6whA5LxmiDljKhUTDtVbocTSS73dHXEuY4jJkBX
lh9d0ygxeoL/pV8DAKT7ufpW0CNLKCrWTeKhREXGX2B3e5SWQhOEorbksrVosBnb
Vsz4XdRgrfMIHn1dP3OzV60OVJ4c/g4ssGTIxlxwNifoFlEsILUI2T8gPfmDSzBW
L1s9+ZtLRFIo1cSSlcObSC0ZEs/PMtDWhzMnYAsdt/tuv6klJ7q7xmoW6FLj+e4M
gKJ+29s07heyKWdXosf6
=UdFQ
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
