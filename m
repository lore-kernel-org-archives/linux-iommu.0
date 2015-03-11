From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
	struct iommu_domain
Date: Wed, 11 Mar 2015 09:38:47 +0100
Message-ID: <20150311083846.GB19391@ulmo.nvidia.com>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
	<1425641688-26438-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4166994023478026313=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425641688-26438-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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


--===============4166994023478026313==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 11:34:47AM +0000, Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
>=20
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
>=20
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
[...]
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  3 +--

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJU//8WAAoJEN0jrNd/PrOhtToQAI+jzM7bxWTR0BszeWd6NDlQ
EGd7OacX/XiSdFh2yVRJfsE+tNDDaRIiinjIS0z8sJV6INJSnndgb6dqFiIq8kPN
odz1EOibpq5yGREmvDO4FYo0o9F5BSFTm25ZoixRZC7W3vf17AZk/1UKXO7VxgIP
1r7skjAwgMkLwhzLvWJ+SSzy66SxYH95slODLh4ogiwGZ20AS1rv6+E+sQPBcdj0
mcp7nO8bLWHPeOiHuG+5fbkN8F68YbZGoRRY7S+pOFvgYZafjlSGX63Bl7j8WMI4
5L+Mt6SU+V341e+6YMPljoEDLPN7VI6jeRTkZxwzVEk4GdyUk3/YZolUyYHymmOr
OPdAomeUmIPfcjqIB5JFt9UB2dkLBsdq7yKLS9kH3NOjWbOkMDIHfyKm+v+OMzWe
IAvyL/ZPyzVvW1whnsvhgaPcm/rmCz9hOAPIoKNvQX3dGE90yJxe+HFjhuzjDe0V
fQp3v8QknNZaAXYYCxwRg0jLwkrP8p18wcr9ePK3rWptma4v1fPQh9Kl/vN4Vc2I
Saj6LLpPxufLCYiW8w18l9VXtM2KLt3O9HPd7T+JqES5uHtuemueuQcVKtKvR7n9
w46vpAxU5SOaQvAkHma4X1EE11QUJrI5GICiF+Vyvb9I9cnlGWaLuxg1MkVcnGhQ
VMdaiB4Y5/coHYjtyXQU
=SvQN
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============4166994023478026313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4166994023478026313==--
