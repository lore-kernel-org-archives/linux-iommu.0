From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
Date: Thu, 30 Oct 2014 16:08:41 +0100
Message-ID: <20141030150839.GG20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 03:09:30PM -0700, Olof Johansson wrote:
> Hi,
>=20
> Oh, a few more comments:
>=20
> On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>=20
> > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> > index c32d31981be3..1c932e7e7b8d 100644
> > --- a/drivers/memory/Makefile
> > +++ b/drivers/memory/Makefile
> > @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  +=3D fsl-corenet-cf.o
> >  obj-$(CONFIG_FSL_IFC)          +=3D fsl_ifc.o
> >  obj-$(CONFIG_MVEBU_DEVBUS)     +=3D mvebu-devbus.o
> >  obj-$(CONFIG_TEGRA20_MC)       +=3D tegra20-mc.o
> > -obj-$(CONFIG_TEGRA30_MC)       +=3D tegra30-mc.o
> > +
> > +obj-$(CONFIG_ARCH_TEGRA)       +=3D tegra/
> > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makef=
ile
> > new file mode 100644
> > index 000000000000..51b9e8fcde1b
> > --- /dev/null
> > +++ b/drivers/memory/tegra/Makefile
> > @@ -0,0 +1,5 @@
> > +obj-y                                   =3D tegra-mc.o
> > +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                +=3D tegra30-mc.o
> > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       +=3D tegra114-mc.o
> > +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       +=3D tegra124-mc.o
> > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       +=3D tegra124-mc.o
>=20
> You'll need a Kconfig and not just a makefile -- there are definitely
> dependencies on this driver (IOMMU in particular).

This is handled within the tegra-mc driver by only setting up the IOMMU
when TEGRA_IOMMU_SMMU is enabled. That config option remains in place.

> Also, the problem of having a global enable bit that is only under
> control of TrustZone FW is a big problem -- if the bit is not set, the
> driver will not work (and the machine will crash).
>=20
> I think you'll need to come up with a way to detect that in the
> driver. I don't have a good idea of how it can be done though.

I don't think I ever got back to you on this. We discussed this
internally and it seems like there's no way to detect this properly, so
the best suggestion so far was to make it a requirement on the secure
firmware to enable IOMMU or not. Since there's no way for the kernel to
detect whether IOMMU was enabled or not, I think the firmware would
equally have to adjust the SMMU's device tree node's status property
appropriately.

Stephen, does that accurately reflect what we had discussed?

Thierry

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUlR3AAoJEN0jrNd/PrOhAkgP+wfranyCuZK7HMw+Uat4sk8C
1yhka30LTZ46yDkbPIiz8fOOkarydSWs6KDe/4wGBjwzM56a9tVUfUm0o9jV/643
TJEQCzKt8ZS8DZEL4AJ/bnL1ZSYY4Ja16yT+PeAwJ5iYKiIj8QoUgE/O6a9wg1XJ
5yDx0U1c3+QFDlnwU4PKOLMkvdEiAN55KgFyH2SU+JGiNPw0e7PotRlhr1GV9P2H
85rW1VRE6iwsn5ILWYhumfKO+R+/wszexL+8uKNWxP7ySkW0Kml0pyrRZM6apcRt
U6Nq6HThBhNNOqs1S+oxmm2NoRku2mTKJp3lyXB5uLA/s1yryBQT/HQer+ftqBIR
UhdyXgQLyyUlmr9EhDQN+thvmHvwaYT83KjFX/wFIkr71fZuL1yrYSBFsETZpRIM
JRA98iIIlUQgyPGG9i9uieeCokvHZoDzsLsnKcABhDWYr9CbnciEh/tqXXUS9v3F
W+G+tIMItHcfYKJKtwtxYRLmqH2jelyMceSyQHMapELOKX5NvqF1Ix70LdEUZtvD
gRqkt3z5P3nOfn63ZbNSGmQykS+whKM6T1Y/GsXSxE2IODkzqvPqixupNl7Jost1
TA9HZzFHmObUSpxOBGKk20CKOmRY2XgRC1eScdxBJqrawLzKucHZ62LOnA9JSzYm
Haz5TFu5kIspdDJUVPCL
=Z/0M
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
