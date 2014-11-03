From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
	support
Date: Mon, 3 Nov 2014 09:22:03 +0100
Message-ID: <20141103082201.GC21002@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
	<1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
	<CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
	<20141030150839.GG20072@ulmo.nvidia.com>
	<20141031132740.GA9371@ulmo.nvidia.com>
	<CAAVeFuKgMAF4LML5G=2k00No4AKDj7MTHB6ByXEvPzaSsAPUXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3239576218436896830=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAVeFuKgMAF4LML5G=2k00No4AKDj7MTHB6ByXEvPzaSsAPUXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3239576218436896830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2014 at 02:38:26PM +0900, Alexandre Courbot wrote:
> On Fri, Oct 31, 2014 at 10:27 PM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Thu, Oct 30, 2014 at 04:08:41PM +0100, Thierry Reding wrote:
> >> On Wed, Oct 15, 2014 at 03:09:30PM -0700, Olof Johansson wrote:
> >> > Hi,
> >> >
> >> > Oh, a few more comments:
> >> >
> >> > On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> >> > <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> >
> >> > > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> >> > > index c32d31981be3..1c932e7e7b8d 100644
> >> > > --- a/drivers/memory/Makefile
> >> > > +++ b/drivers/memory/Makefile
> >> > > @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  +=3D fsl-corenet-c=
f.o
> >> > >  obj-$(CONFIG_FSL_IFC)          +=3D fsl_ifc.o
> >> > >  obj-$(CONFIG_MVEBU_DEVBUS)     +=3D mvebu-devbus.o
> >> > >  obj-$(CONFIG_TEGRA20_MC)       +=3D tegra20-mc.o
> >> > > -obj-$(CONFIG_TEGRA30_MC)       +=3D tegra30-mc.o
> >> > > +
> >> > > +obj-$(CONFIG_ARCH_TEGRA)       +=3D tegra/
> >> > > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/=
Makefile
> >> > > new file mode 100644
> >> > > index 000000000000..51b9e8fcde1b
> >> > > --- /dev/null
> >> > > +++ b/drivers/memory/tegra/Makefile
> >> > > @@ -0,0 +1,5 @@
> >> > > +obj-y                                   =3D tegra-mc.o
> >> > > +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                +=3D tegra30-mc.o
> >> > > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       +=3D tegra114-mc.o
> >> > > +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       +=3D tegra124-mc.o
> >> > > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       +=3D tegra124-mc.o
> >> >
> >> > You'll need a Kconfig and not just a makefile -- there are definitely
> >> > dependencies on this driver (IOMMU in particular).
> >>
> >> This is handled within the tegra-mc driver by only setting up the IOMMU
> >> when TEGRA_IOMMU_SMMU is enabled. That config option remains in place.
> >>
> >> > Also, the problem of having a global enable bit that is only under
> >> > control of TrustZone FW is a big problem -- if the bit is not set, t=
he
> >> > driver will not work (and the machine will crash).
> >> >
> >> > I think you'll need to come up with a way to detect that in the
> >> > driver. I don't have a good idea of how it can be done though.
> >>
> >> I don't think I ever got back to you on this. We discussed this
> >> internally and it seems like there's no way to detect this properly, so
> >> the best suggestion so far was to make it a requirement on the secure
> >> firmware to enable IOMMU or not. Since there's no way for the kernel to
> >> detect whether IOMMU was enabled or not, I think the firmware would
> >> equally have to adjust the SMMU's device tree node's status property
> >> appropriately.
> >
> > The other option would be for the firmware not to touch the SMMU device
> > tree node and the kernel simply assuming that if it's running in non-
> > secure mode then there must be secure firmware and it has enabled the
> > SMMU. Enabling the SMMU would become part of the contract between
> > firmware and kernel, much like locking the VPR is required to get the
> > GPU to work.
> >
> > Those are really the only two choices we have.
>=20
> We got the exact same problem with GPU and VPR registers, and it seems
> like the approach we will be taking here is to have the
> firmware/bootloader do whatever is needed to get the GPU working and
> enable the DT node once it did. IOW, the kernel will never touch
> protected registers, and will not freeze if the hardware is not
> properly set up.

I think the situation is slightly different. For the SMMU we still have
the option to enable translations when running in secure mode with code
that's pretty trivial to have in the IOMMU driver (it's just a single
bit that gets written to a register). And when the IOMMU driver does
that everything will work just fine.

So I'm thinking that a workable alternative to what we've done for VPR
would be to just always enable translations in the SMMU driver (that
operation will simply be discarded in non-secure mode) and assume that
it'll work. So the contract would be that running in secure mode the
kernel sets everything up and when running in non-secure mode the kernel
will assume that firmware set everything up already.

Requiring firmware to change the device node's status to "okay" seems
rather restrictive since it would have to do that even if it boots the
kernel in secure mode.

> It would be nice for consistency if the same approach can be taken
> with the IOMMU. OTOH we will need to make sure that all these
> initialization contracts are clearly documented somewhere. Maybe a
> comment in the DTS to explain what is expected from the firmware to
> enable such nodes would be a good idea, too.

The device tree binding seems like a good place to document this.

Thierry

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUVzspAAoJEN0jrNd/PrOhKzgP/jx80ArA5uiNjTG+Mtc3LimD
UsrM5cYjAfyeh37KHU93XiMRaqZurDdJXJEvc/ubxk3KY5xK5cXs7dCv2Wht+18U
t4TyfvgYklPY6HHBXAbc0/FEXqYmSI2o2TY1LfcpkhxZ24MtR5Yv6uxHQ+/E/6QX
QpNOYgglMAAsHfTfA7fRg3xUAGbLdf6WrEQ9ZlGzZoQbAcltDfNZMmWurEQe1eRp
TWT6si/F4gzhI6SbX59V7JHjJz/W4UyRdd+SBJdu8EGAa3kB/qotSQZR/NOVxFO8
PbcR4NcyemVC6l9kFZk0P/Pk7/VRwNfxsZ+pkwHudgPvBOT5KnMrfgCYpIVL25bP
1E1p2YG8Symv2Oyo1m1lMiG7LZeH21OQPOr9jKw7FOhrArCqnk1cxhdqTDNv6s3n
gqmEbAyHosbJ+ncwvLqKlEE0IgCmojewT90XNt2g9+zuMH7S7qhQe2yGuPyvRhAj
HcyXWobjsZQtTo1qfb12BYIlSxrft120C8v/jj+9d3oUIZQsAq42Q/YKLtpweGHR
nQ17bwdATP8+3ONBJ0Ifp4hYNNpBJTww5U4gx2/0TNovirmr5RZM/fuHArPQadeH
6oEt5AG/KnMFQuCvGJNAZ8bWdygBckjxyZrLhET8kR9iz1euE/qgX503TXyd7FLb
GOtS7FzKYEwmz3YbYVaL
=FJ9V
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--

--===============3239576218436896830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3239576218436896830==--
