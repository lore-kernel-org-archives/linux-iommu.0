From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 10:26:11 +0200
Message-ID: <20140521082606.GB11068@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<8663464.40PHEumOar@wuerfel>
	<20140520152458.GB5041@e103592.cambridge.arm.com>
	<5612206.Fzsy1mf3q3@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2166582437805207172=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5612206.Fzsy1mf3q3@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2166582437805207172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 10:26:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 May 2014 16:24:59 Dave Martin wrote:
> > On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
[...]
> > > > Multiple-master IOMMU:
> > > > ----------------------
> > > >=20
> > > > 	iommu {
> > > > 		/* the specifier represents the ID of the master */
> > > > 		#address-cells =3D <1>;
> > > > 		#size-cells =3D <0>;
> >=20
> > How do we know the size of the input address to the IOMMU?  Do we
> > get cases for example where the IOMMU only accepts a 32-bit input
> > address, but some 64-bit capable masters are connected through it?
>=20
> I was stuck on this question for a while before, but then I realized
> that it doesn't matter at all: It's the IOMMU driver itself that
> manages the address space, and it doesn't matter if a slave can
> address a larger range than the IOMMU can accept. If the IOMMU
> needs to deal with the opposite case (64-bit input addresses
> but a 32-bit master), that limitation can be put into the specifier.

Isn't this what DMA masks are for? Couldn't the IOMMU simply use the
master device's DMA mask to do the right thing here?

As such I don't think this information needs to be in device tree at
all. The DMA mask should typically be set by the driver in the first
place because it has knowledge about the capabilities of the device.
A different way of saying that is that the DMA mask is implied by the
device's compatible string.

> > For determining dma masks, it is the output address that it
> > important.  Santosh's code can probably be taught to handle this,
> > if given an additional traversal rule for following "iommus"
> > properties.  However, deploying an IOMMU whose output address size
> > is smaller than the=20
>=20
> Something seems to be missing here. I don't think we want to handle
> the case where the IOMMU output cannot the entire memory address
> space. If necessary, that would mean using both an IOMMU driver
> and swiotlb, but I think it's a reasonable assumption that hardware
> isn't /that/ crazy.

Similarily, should the IOMMU not be treated like any other device here?
Its DMA mask should determine what address range it can access.

Thierry

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfGMeAAoJEN0jrNd/PrOhv5EQALfvr2lSx0S9k01y73YuWzan
TkcAR8wOwlZPBhLHLsqHNrnFLVHTPDMLPLL6P0YRH50xBuSfwB67ARPyLly+MmOZ
csxsw/sphzZnWtw+zMO72lOkYnM+Rehea0CJCo7Vb9vIzzQythdp13OZDUCR2R1G
zhDwEsyOCU86YbCo7pWH0LfBSgYNmsYmU4qrqGpxhUYTghCmapBDX04TMZkh0uHV
hBFIYQD540KWkdSLRrSK+l4muFPycDK0iqg/xSPjwNIuuSPC0o/ljH5anPtZ3dte
h8UiGbh2H+3nGvESLDL+CutryCEGuGWmKL+nT8zfeh1p+Y6snXMsshnpbt0C3ybY
mQuqIhwhumX0gjhfB4ln0XZssy19cf85IYFFgUULQrFtUoh3bTRKg4DPTyXCKf9P
Cv+mt2azJfZq5Oc5jnv3IjppN7Cg8cL1Ut/KG2DUSZmkhioFNYo7VbDgz7r3qsE8
1YkfzCVD+DFhhEwtxIbp0aaqhLdTSEZsZSMv5tkT0im5JzpAY1/ewEnAfQKuF0lv
7DDy2v5p5pE+yGp67koMihp7quYquh/cmtlCYrq9Dqbqrl1JKjSpp8MrUMZfXKNg
xanh0H9yYaSbgEh1jAPSdZVZlYnbEaEI/t6Y0dKcDeY93O/k7ltRurDir785CS81
IVgaDo38fmuNzNO1cwC4
=jyBu
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============2166582437805207172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2166582437805207172==--
