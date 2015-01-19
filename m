From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 13:36:24 +0100
Message-ID: <20150119123623.GB7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<20150115082843.GB30799@ulmo> <20150115111211.GF23475@arm.com>
	<2804479.ZFl06ysk3j@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2947273236337402678=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2804479.ZFl06ysk3j@avalon>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2947273236337402678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> > On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> > > On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> > > > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > > [...]
> > >=20
> > >>> 2) Say you want to use the IOMMU API in your driver, and have an io=
mmu
> > >>> property in your device's DT node. If by chance your IOMMU is
> > >>> registered early, you will already have a mapping automatically
> > >>> created even before your probe function is called. Can this be
> > >>> avoided? Is it even safe?
> > >>=20
> > >> Currently, I think you have to either teardown the ops manually or
> > >> return an error from of_xlate. Thierry was also looking at this sort=
 of
> > >> thing, so it might be worth talking to him.
> > >=20
> > > I already explained in earlier threads why I think this is a bad idea.
> > > It's completely unnatural for any driver to manually tear down someth=
ing
> > > that it didn't want set up in the first place. It also means that you
> > > have to carefully audit any users of these IOMMU APIs to make sure th=
at
> > > they do tear down. That doesn't sound like a good incremental approac=
h,
> > > as evidenced by the breakage that Alex and Heiko have encountered.
> >=20
> > Well, perhaps we hide that behind a get_iommu API or something. We *do*
> > need this manual teardown step to support things like VFIO, so it makes
> > sense to reuse it for other users too imo.
> >=20
> > > The solution for me has been to completely side-step the issue and not
> > > register the IOMMU with the new mechanism at all. That is, there's no
> > > .of_xlate() implementation, which means that the ARM DMA API glue won=
't
> > > try to be smart and use the IOMMU in ways it's not meant to be used.
>=20
> That will break when someone will want to use the same IOMMU type for dev=
ices=20
> that use the DMA mapping API to hide the IOMMU. That might not be the cas=
e for=20
> your IOMMU today, but it's pretty fragile, we need to fix it.

No, there's absolutely no issue here. It simply means that you can't do
this on Tegra. So far I'm not sure I even see an advantage in using the
IOMMU for devices that don't care about it anyway. Consider the example
of the SD/MMC or HDA. They typically allocate fairly small buffers, the
order of a single page typically. They can simply use memory handed out
by the CMA.

So as long as we don't add a .of_xlate() implementation or instantiate
via the IOMMU_OF_DECLARE() mechanism we simply don't support IOMMU-over-
DMA on Tegra.

Thierry

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvPpHAAoJEN0jrNd/PrOh6isP/jTtP5sLbCIHvmcbpqzoqcjg
wvBdM1Zd4WleZFb7toIZ8zF6M8uL8Rvdiz+E0OM4rhrc32Y9HHJTcDS9LAlKOlBP
2jwO3xQkggZicr2wyklDUBJJjzID/GDgwmivjMjxFfdgEdUL3gv/OgpqAcjfi2i+
xKFDsjzRDYa4D/7LGNqzMxmZ9yOVBec1eqQ5gaETNirHT7TsLXeOcN4vB+jY4nuS
mYKM4L5qHzTCiLcKyaj1nCWAMIXHRX7ld/UjvwfSTaM+f3gVLfdCkZY2MgKc/Sqo
fBkc7VVJ/yGIXyKWwvrarIbojq058Z5pEPLlkOGOyPE936inxoOFRtaxhJRsMk7I
N7C7CUSKJwaYyoScOowF32qGu3k+jF5FCq8pHS/rx/iKTJp6XHTaqEVewDXxW+Az
eZEAPhCv9PPbeyxhNB2dF74/MZKhglNks1h6oqbj7+YEPmMDp970/gztbtR2digQ
l3p4zNzgj27sapNYJ4C/+4ckWr8rh25PQNMfxQQWj2lv+80JkvHU1g5X1DfpX6Mn
aLgHq5f4ObIb4ioCXnJyXeeG0kIW/6wfu6X8iIHDOfMh69MWdVBVD+meKux4IjJh
OA6/btfn9sa7/gzPn9XHlDzU83+W86KFXeUd3RFdkfMSBHayBDL6FC9/683HGso4
HgTKBEnrAkN4/lnmYRB/
=HB0X
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--===============2947273236337402678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2947273236337402678==--
