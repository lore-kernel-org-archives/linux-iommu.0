From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
Date: Fri, 31 Oct 2014 14:27:42 +0100
Message-ID: <20141031132740.GA9371@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
 <20141030150839.GG20072@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141030150839.GG20072-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 04:08:41PM +0100, Thierry Reding wrote:
> On Wed, Oct 15, 2014 at 03:09:30PM -0700, Olof Johansson wrote:
> > Hi,
> >=20
> > Oh, a few more comments:
> >=20
> > On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> > <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >=20
> > > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> > > index c32d31981be3..1c932e7e7b8d 100644
> > > --- a/drivers/memory/Makefile
> > > +++ b/drivers/memory/Makefile
> > > @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  +=3D fsl-corenet-cf.o
> > >  obj-$(CONFIG_FSL_IFC)          +=3D fsl_ifc.o
> > >  obj-$(CONFIG_MVEBU_DEVBUS)     +=3D mvebu-devbus.o
> > >  obj-$(CONFIG_TEGRA20_MC)       +=3D tegra20-mc.o
> > > -obj-$(CONFIG_TEGRA30_MC)       +=3D tegra30-mc.o
> > > +
> > > +obj-$(CONFIG_ARCH_TEGRA)       +=3D tegra/
> > > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Mak=
efile
> > > new file mode 100644
> > > index 000000000000..51b9e8fcde1b
> > > --- /dev/null
> > > +++ b/drivers/memory/tegra/Makefile
> > > @@ -0,0 +1,5 @@
> > > +obj-y                                   =3D tegra-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                +=3D tegra30-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       +=3D tegra114-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       +=3D tegra124-mc.o
> > > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       +=3D tegra124-mc.o
> >=20
> > You'll need a Kconfig and not just a makefile -- there are definitely
> > dependencies on this driver (IOMMU in particular).
>=20
> This is handled within the tegra-mc driver by only setting up the IOMMU
> when TEGRA_IOMMU_SMMU is enabled. That config option remains in place.
>=20
> > Also, the problem of having a global enable bit that is only under
> > control of TrustZone FW is a big problem -- if the bit is not set, the
> > driver will not work (and the machine will crash).
> >=20
> > I think you'll need to come up with a way to detect that in the
> > driver. I don't have a good idea of how it can be done though.
>=20
> I don't think I ever got back to you on this. We discussed this
> internally and it seems like there's no way to detect this properly, so
> the best suggestion so far was to make it a requirement on the secure
> firmware to enable IOMMU or not. Since there's no way for the kernel to
> detect whether IOMMU was enabled or not, I think the firmware would
> equally have to adjust the SMMU's device tree node's status property
> appropriately.

The other option would be for the firmware not to touch the SMMU device
tree node and the kernel simply assuming that if it's running in non-
secure mode then there must be secure firmware and it has enabled the
SMMU. Enabling the SMMU would become part of the contract between
firmware and kernel, much like locking the VPR is required to get the
GPU to work.

Those are really the only two choices we have.

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUU45MAAoJEN0jrNd/PrOhNisP/R0zrGlIsP8WfNOyA99NL5Yf
GTJjjvXqW/LacIty1tNF0yyK28t/cP+qrlOhbHcLSPX8GGBtU8ztSi6eu7Y+EnTU
q8ifekChUDoUytIxkM30HrFGhWb0AQDEBGXfzFpzU1ZJ1tZ2wtfYu5SLPO3533dv
Xgj1Aa0qbg0AdNu6ILVDp2hUPw0ZXpt/AcIEpYKULhTIpVt9qwUiz11oHqyPc9WM
unHKhNl8QqDlm0zVZCMz9oSnyNN04SrES1cw9aqeOE/NI1hYeAUz9He0/5POMJEc
yIdVzhyofxnOVdcZmdIzJVcjCF5lnnPcXeiYeTq0slMsi3nwrCNe19C7UsxN/cd+
PKto6hKIJweBSi3wjSFNyF2FQhYvJxJKP1Wp6MGBl9AxRUPZJS5by7jO5qUuNhWv
+CKDS4rOafb1qlvA6k6T1dwq/1FYTTRm41jft/loXDGtzcjbCaqIWD86MfPc/TSU
Hsp/nCh9tFUAEZoKEr/SLC6AOFjKGdSaUG84hqEsE3K6YhaUqAuuDTihn/5RWPEh
5CE+/iNyg3IploHNnmYQEJ3rBzu7rRILnDvLyYUF1NM01Fx7DzlfLwZqkRsoZ57n
+XsliPj4/qqV29N9CS4D6izSL+iGCmzeiJsgE9C1m8O+W6gkGrHQcnn3ADsYeNqw
pulkteMMoCmLTg5O8Ydx
=Gxjd
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
