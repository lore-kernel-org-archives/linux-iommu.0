From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: of: enforce const-ness of struct iommu_ops
Date: Wed, 11 Mar 2015 09:43:49 +0100
Message-ID: <20150311084347.GC19391@ulmo.nvidia.com>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
	<1425641688-26438-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3173735964719412848=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425641688-26438-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3173735964719412848==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 11:34:48AM +0000, Will Deacon wrote:
> From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
>=20
> With the pgsize_bitmap removed, there is no compelling reason for
> the remaining callbacks in struct iommu_ops to be mutable, so enforce
> const-ness throughout the core code.
>=20
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm/include/asm/dma-mapping.h   |  2 +-
>  arch/arm/mm/dma-mapping.c            |  6 +++---
>  arch/arm64/include/asm/dma-mapping.h |  3 ++-
>  drivers/iommu/of_iommu.c             | 12 ++++++------
>  drivers/of/platform.c                |  2 +-
>  include/linux/dma-mapping.h          |  2 +-
>  include/linux/of_iommu.h             |  8 ++++----
>  7 files changed, 18 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAABDAAoJEN0jrNd/PrOhMHIQAJLz8k/cQ39q85ABbgGOSjZi
Dz8Z23PbPf13WAeC3mygUt7E81AW/jXMq77IQWKETsQrwPPY8AfNY1Zfo144Ny+V
wa7GyQjavo9jJ2CQFD5f9pfaslByGON20QWQl1smoy7qaDObWIJIh6hbvzVSqs1r
zV+6ZQv0IU9WhM4PK8kswY+cvdhYj4y8oOo+yRqHTDRkVR/vZBL9PKNuG/EKDFwW
mdO7mg6HWCZyHnhuvUWz/eroa90+UZZEFK63VmgdF+KFFflGqUYoqHWAv3EYNuh3
LxEWfVWEEaRbAbsSWX3Bf8DfSrxg7h+4GH9pNNpCNlxdDPwnofSOCT/h4ljpA+Xr
JUFd12FmijHyAuc1WvEv2elbhXeynoepaXVMeG9YLJB786FET66K/jQp5ZanjMwH
CDM6KBuB9my6ap9vC2vHV8JYgvCjMgbCGpoLTybor4S855JD9M2QzhDuv/UdShyt
XtSIddit/F991cHZtMWnsKLgOg8ghHlC+5nR3Oi6VS7+lBC95B1scxWkSw/h761b
jk/tmsPDvuId5G92kLC5K0wdI7cCJRif0Z48kSzHWE/R5NFXbK3+XrLbOQ7UXMCL
iIJ8bhAVaZLWe2HzZsf29V5jZW6dVRB1bMMkC2psh5IpyW8JeMVLh390LY1WkJM4
ePb88fIk7MfPewML8cPQ
=daDb
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

--===============3173735964719412848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3173735964719412848==--
