From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 13:49:36 +0100
Message-ID: <20150119124934.GD7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<20150115082843.GB30799@ulmo> <20150115111211.GF23475@arm.com>
	<2804479.ZFl06ysk3j@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5483649910068276575=="
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


--===============5483649910068276575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
[...]
> The second way is to implement a mechanism to let drivers signal that the=
y=20
> want to handle DMA mappings themselves. As the mappings need in the gener=
al=20
> case to be created before the probe function is called we can't signal th=
is by=20
> calling a function in probe(). A new flag field for struct device_driver =
is a=20
> possible solution. This would however require delaying the creation of DM=
A=20
> mappings until right before probe time. Attaching to the IOMMU could be p=
ushed=20
> to right before probe() as well, which would have the added benefit of ma=
king=20
> IOMMU driver implementable as real platform drivers.

Right. This is a pretty important point, too. One of the things that
we've been working on is suspend/resume. Now if you don't have a struct
device you can't easily implement suspend/resume. You'd have to play
tricks like using syscore_ops, which then leads to potentially problems
with suspend/resume ordering. It also means we have to keep around
global variables for driver-private data because there's no struct
device to attach it to.

By properly encoding the dependencies via deferred probe we get the
proper ordering and we can use the regular driver model with all the
goodies that we've come up with over the years.

Thierry

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvP1eAAoJEN0jrNd/PrOhD7IQAIjGe06ULWFHNxxBlBFLoQXE
nWdSOEuAG6nsiPFSsMjuAep54bsTvNqLK1rTKZT1atFOhnIJhnsOyYPGN0ZBME4w
VDgI24dz+DT/xnvhYx473c9UGYJqehc/mjki8+xb1u3Rlj7g5HVvP/H+AK4l271d
r7t3xYSb03CqMLXtYUxyIaBRs5AqkPSMM5blZ2Fv6WIN9TEGh+3GTGb0g4Bf3hov
WoWVSHW2coJVbsi4XzCm7m5tdATREE0V61PO08bSynIbX754bCOm17632jZKJAkV
iIytPPgqqsU3TbkVXUYehQbq0X36DwTVB4cXSO/285t9fcKbqLILw7XkqHZimP0P
Kud0m3Wk6g96ZMD/Ux0QSjSZS6wcdxIJyCJ86QDFk7AcmlgC0nN5z0FTmkUAt2UA
hhHlYRpm4BAA8WmKQMX3P/aTFlkQzIswVvHIHpFBrhOy3qbs9J4tSbItgWe1TdxH
EuJK+Wsp2FAmDGp+jxJgg3aUcIEFrcQBYAplVcwPWJf6siSDYgY8ylOjiSrOGpjT
wCC02MKtXKAQqNx+sDDacrSeCKbHZxKLw7/aOL3Uz/1nGRnU4xZAwoCOsvbjrGbh
WkuEl5nzUEnU/yG5pqIFSej2SJ9giVScei5LKoV98iH4WguMHub3y92SEuN72RTj
Wkfd+T8Erg1W+cAhG05p
=jTQy
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============5483649910068276575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5483649910068276575==--
