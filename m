From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
Date: Wed, 26 Jun 2013 12:52:17 +0200
Message-ID: <20130626105216.GL27083@manwe>
References: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jbyekxk18hnEXT0m"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-7-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--Jbyekxk18hnEXT0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:09PM +0300, Hiroshi Doyu wrote:
> This is a bitmap that indicates which HardWare Accelerators(HWA) are
> supported on Tegra114 SoC.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114=
=2Edtsi
> index 1f45cf5..715b5d6 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -323,7 +323,7 @@
>  		       0x70019228 0x074>;
>  		nvidia,#asids =3D <4>;
>  		dma-window =3D <0 0x40000000>;
> -		nvidia,swgroups =3D <0x18659fe>;
> +		nvidia,swgroups =3D <0x00000000 0x01b659fe>;
>  		nvidia,ahb =3D <&ahb>;
>  	};

It seems like an nvidia,tegra114-smmu.txt file is missing from the
Documentation/devicetree/bindings/iommu directory. And similarily to my
comment for the tegra30.dtsi update this could be a symbolic value such
as TEGRA114_SWGID_ALL.

Thierry

--Jbyekxk18hnEXT0m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysfgAAoJEN0jrNd/PrOhwH8P/1hJX4W5Wqxz/k9EcQ9alGsW
P4mTsPYfKLglvMLpRGd/U1ztEKgbiZkAXyj0W3x3Wh4u2aeCJMrKNmzm88BdEiV1
suV7GHrx3zVxeMaDR2IQ22UeCLTLJ15p3of7PsFfZRn2Q8tKjssIBCk6oeEx/NND
AM2aI5opV360OwplB9ETWtmjZtTwYG81cwFuomfyWxFI9zjIp1iyqwi7YCT479xA
gV3B3roRu1igbzWJLgn5cOuPf24cdUFCOGqdlkr7CR2cAQcgFNk7Qjzm6o8oqd/3
OLlg2PNt1ZBW9u4XbQh+dhYxOKQGkomuczjmm3a+5zxcCcgOH7hn6oO+3cze5A+R
sixvk23Njma6rHiO2i5nARXYtjS8R+FnGrB3q4EbYMK9hyPmvjYOYst7Sc+lqDk+
lrd8dzBIedi6dzHNboQYER8eosgRez+5+Ide/C4Fl+YYbRRjPWrNN7S7FPxI7CRj
0wDMoDptP4DtUh2iuk00ntjyXUEU7M4L4bMGkSA/m00vMj4yWIKD8s4ApXX/Iktt
u8ux0BiAbo5wKTjPVR2pbAAPxgqQOdrQj7e/d2iFtCTGXs3ONEtlzd5raupDhwBm
BcAGDyn794sCyGkYsqJpHQPg0BChkZMUG9L3aXI2UxKjK15Etx4pt4UL192sCCTq
QssJIn9tHWYkRPYx1rUs
=mEVu
-----END PGP SIGNATURE-----

--Jbyekxk18hnEXT0m--
