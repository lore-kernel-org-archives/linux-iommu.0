From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/23] ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
Date: Wed, 26 Jun 2013 12:24:29 +0200
Message-ID: <20130626102428.GF27083@manwe>
References: <1372238906-9346-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:05PM +0300, Hiroshi Doyu wrote:
> This is a bitmap that indicates which HardWare Accelerators(HWA) are
> supported on Tegra30 SoC.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt | 6 ++++=
+-
>  arch/arm/boot/dts/tegra30.dtsi                                  | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.=
txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..6be51f6 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,14 +8,18 @@ Required properties:
>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- nvidia,swgroups: A bit map of supported HardWare Accelerators(HWA).

Nit: you use the spelling "bitmap" in the subject but "bit map" here.
Both are correct but perhaps we should stick to one.

> +  Each bit represents one sgroup. The assignments may be found in header

Nit: "swgroup"

> -	smmu {
> +	iommu {

This change isn't really related, but given that the tegra30.dtsi
already uses it I guess we can keep it as part of this patch.

>  		compatible =3D "nvidia,tegra30-smmu";
>  		reg =3D <0x7000f010 0x02c
>  		       0x7000f1f0 0x010
>  		       0x7000f228 0x05c>;
>  		nvidia,#asids =3D <4>;		/* # of ASIDs */
>  		dma-window =3D <0 0x40000000>;	/* IOVA start & length */
> +		nvidia,swgroups =3D <0x00000000 0x000779ff>;

Perhaps this should be a symbolic name too? Perhaps something like
TEGRA30_SWGID_ALL?

Thierry

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysFcAAoJEN0jrNd/PrOhFdkQAI7tZpTPjW5Afm/9ETziP12t
6oGoLDqAZCiRlNOgbhUmTffMERHyP3ZvjM4K+Cu6hJIl0NfzAMCRz2oQnOk/RVww
cMjbfTlHboqxirMddUcgnsZOR9TtCxrlE8tz7zZjZ9hdXpcFqvI2C+Eg7lYj+gjW
E6LSXWdE4jPr2b7WzrSKG+Ut2TCwH6I3GrL/nPN+GXfbb2Fl7JgBfJ3gohZAZhns
Pij8RKSuRXyiRsC3/MdK/pneoKPjyJt3YCx0tH873WlRn/2f2VupBOwVYLAgFwc6
l5K1fWsj4/i7MXo/qo5vR4iqCrSWVWcJ9Gw226kZJGs4psPGngIx0oLqnETKHmEm
JJqej1IwTKWmfLo6hk97prFmuRfr6RuSLMnrv26aPy15Wj1KdINCwRjTF8aJo7/o
RQGeXLvY0aJThxW7UsPJghbLoGgn1ad1cyEj30phDsRgQNctmarGK8ulwTwVyx2z
6bqL43Ak6z2ZqEkW0jelrmDJ9EutpSkQju9QVKdo2CQ8EHKk8KMJCmuJXBj1ND36
oPc1EXvWedBRnyClr/65vud9Lx3rrjSFEBI9WYE23/XKCAXX+2q0k1K+pMmTk0LI
zAXHuY5wT+gtM8VqzkY9IwtTfLTOuZsWMyx3Qx2rElfm7xJq4Se8wGCJY5ticbzU
mFAu7wU4N8nxT4+sZdKD
=nD1U
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
