From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 22 Sep 2014 11:29:10 +0200
Message-ID: <20140922092909.GJ1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-6-git-send-email-will.deacon@arm.com>
	<4252161.sBJZLIS2WH@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5095381001274049224=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4252161.sBJZLIS2WH@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============5095381001274049224==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 02:17:33PM +0300, Laurent Pinchart wrote:
> Hi Will,
>=20
> Thank you for the patch.
>=20
> On Friday 12 September 2014 17:34:53 Will Deacon wrote:
> > This patch extends of_dma_configure so that it sets up the IOMMU for a
> > device, as well as the coherent/non-coherent DMA mapping ops.
> >=20
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  arch/arm/include/asm/dma-mapping.h |  4 +++-
> >  drivers/of/platform.c              | 24 +++++++++++++++++-------
> >  include/linux/dma-mapping.h        |  8 +++++++-
> >  3 files changed, 27 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/arm/include/asm/dma-mapping.h
> > b/arch/arm/include/asm/dma-mapping.h index 7e9ac4f604c3..a8bb0c494bb3
> > 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct devi=
ce
> > *dev) }
> >  #define dma_max_pfn(dev) dma_max_pfn(dev)
> >=20
> > -static inline void arch_setup_dma_ops(struct device *dev, bool coheren=
t)
> > +static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
> > +				      u64 size, struct iommu_dma_mapping *iommu,
> > +				      bool coherent)
> >  {
> >  	if (coherent)
> >  		set_dma_ops(dev, &arm_coherent_dma_ops);
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 946dd7ae0394..95ebd38db545 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_iommu.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > @@ -166,6 +167,7 @@ static void of_dma_configure(struct platform_device
> > *pdev) int ret;
> >  	bool coherent;
> >  	unsigned long offset;
> > +	struct iommu_dma_mapping *iommu;
> >  	struct device *dev =3D &pdev->dev;
> >=20
> >  	/*
> > @@ -195,7 +197,19 @@ static void of_dma_configure(struct platform_device
> > *pdev) dev_dbg(dev, "device is%sdma coherent\n",
> >  		coherent ? " " : " not ");
> >=20
> > -	arch_setup_dma_ops(dev, coherent);
> > +	iommu =3D of_iommu_configure(dev);
> > +	dev_dbg(dev, "device is%sbehind an iommu\n",
> > +		iommu ? " " : " not ");
> > +
> > +	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> > +
> > +	if (iommu)
> > +		kref_put(&iommu->kref, of_iommu_deconfigure);
>=20
> What's the expected life cycle of the iommu_dma_mapping structure ? It ge=
ts=20
> created by of_iommu_configure() and the initial reference gets dropped he=
re. I=20
> suppose you expect arch code to need to keep a reference to the structure=
, but=20
> your implementation in patch 7/7 doesn't. As far as I can see, you don't =
even=20
> use the contents of the structure in the ARM arch_setup_dma_ops()=20
> implementation. Do you expect that to change later, or other architecture=
s to=20
> need it ?
>=20
> By the way, now that I think about it, I find struct iommu_dma_mapping an=
d=20
> struct dma_iommu_mapping very confusing.

Agreed. I wonder how useful it is to know the set of IOMMU instances
that each device can master through. Wouldn't it be more useful to keep
a list of master interfaces for each device? The set of IOMMU instances
can trivially be derived from that.

Thierry

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUH+vlAAoJEN0jrNd/PrOhrqYP/jJ4YbiwTxOQTInVn7MBEr8G
AdxkJ3QEBHZy7GahPd+yaY+55UctvUgNhxdX3aGNvDsEJfHWocAdSujEJAn4+xec
oIr26RNFNt9R7GZdwvCCJL1KmMmtX7+1XP26o4oH8+Qsg7bnlxGv7IhAqH1yfTrN
A4HVgMaZhgKn7OM18Qf4gbTGZ/jrLuZzkUP6KHw6SRp6E9V+9m62ULNdPHvaugLx
1egqJlE81y3NszYXvtym9OGlFOeELUhCAQzOGgbYT2xUDpSt9ZCT6hePgfronXAL
rE9nzSz/t7exwksUHiR7ITj0cujCdxYibLBtx0ihME4+TYNidcJvAF05nHWaXnSW
1miGMQis2lGdPGdacJFdoMZl0ZXb60tnPRNEOTGpGFa6/5DMbGPKngSaapzyep5b
ZX1WTuaQnzTkWnqVPXaJgI5SxY+bLz80hT5IZePrx1/NmzuNNwsU4CzA3XBd8gd3
0SgwC7ekyL8fP/AxvXA5mo4/pV505p9pGgPPEe1nJdyVHSF9D1OiV/pqzyQnrcxh
n60ZvCd8p6Vh1NB91bZZycKBOy3oIWI/lFt/XCsCVmwIiHQdBzYVo6WCsqhW52WV
tFF6rJmmHJqfmPu6aPaCXmSRmWUOd1EFVa5kV0btE/gvzLFzP9AcbjqKzaPDTZFh
015ZXpYoI9dtYGTUmt6G
=ABzl
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--

--===============5095381001274049224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5095381001274049224==--
