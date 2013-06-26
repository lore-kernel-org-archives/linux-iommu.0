From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/23] ARM: tegra: Create a DT header defining swgroups ID
Date: Wed, 26 Jun 2013 12:06:49 +0200
Message-ID: <20130626100648.GC27083@manwe>
References: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 12:28:04PM +0300, Hiroshi Doyu wrote:
[...]
> +#define SWGID_AFI 0
> +#define SWGID_AVPC 1
> +#define SWGID_DC 2
> +#define SWGID_DCB 3
> +#define SWGID_EPP 4
> +#define SWGID_G2 5
> +#define SWGID_HC 6
> +#define SWGID_HDA 7
> +#define SWGID_ISP 8
> +#define SWGID_ISP2 SWGID_ISP
> +/* UNUSED: 9 */
> +/* UNUSED: 10 */
> +#define SWGID_MPE 11
> +#define SWGID_MSENC SWGID_MPE
> +#define SWGID_NV 12
> +#define SWGID_NV2 13
> +#define SWGID_PPCS 14
> +#define SWGID_SATA2 15
> +#define SWGID_SATA 16
> +#define SWGID_VDE 17
> +#define SWGID_VI 18
> +#define SWGID_VIC 19
> +#define SWGID_XUSB_HOST 20
> +#define SWGID_XUSB_DEV 21
> +#define SWGID_A9AVP 22
> +#define SWGID_TSEC 23
> +#define SWGID_PPCS1 24
> +/* UNUSED: 25 */
> +/* UNUSED: 26 */
> +/* UNUSED: 27 */
> +/* UNUSED: 28 */
> +/* UNUSED: 29 */
> +/* UNUSED: 30 */
> +/* UNUSED: 31 */
> +
> +/* Reserved: 32-63 */
> +
> +#define SWGID(x)	(1ULL << SWGID_##x)

I'm not entirely sure where to find these mappings in the TRM. I see
that there's a list of the groups in 15.10.11, but where do the numbers
come from? And why are some of the names aliased? If it's for
readability only maybe we could add some more for SWGID_HC ->
SWGID_HOST1X and perhaps SWGID_NV -> SWGID_GR3D.

Thierry

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyr04AAoJEN0jrNd/PrOhHSYP/R3r1tDhi/Xbu1rX1dYcSOkn
dhxuyjHB/miBYDGj2Wov0yXKz3qgW98P3Vf7wSoU1bXYnhZSGN7oxWzFuZowHwYO
tO+D4vF9SUQ4NGNLhSHnpMQ3ginvWzbbU8xl8keA0I2y1U1MMw6RwjaFbSFu4xqN
Uf2DdxMSLZjby+ibY1XOvFdX+EVsJc06ld8cyy5lOTeM88fS01/4eoKVDXOX8IVX
yqBXDcXeJ6+CPUti6+g3ctmU+C2rHpgG3XK4i2iIR/9boOv/1OSmcwwg0f5N1S1N
nuSs4TisA527hriT9TYjCqErbESRe7umR/PetG6iPZt2MShUYEwaDD/ljh2rdqNw
UiUnbhKU5vXzwxCyIsIx4LtOcVRMQYn1A7xJL709x/XCQCvIET+NdnyJltRsmPq0
nafviv747KrhAreyK4OIiNH4sstq4zvQML3Zmpd28wyvxDfWEif0m1ksvZV1DHQz
DFNl7FiyjXGuUd+7snSDmHsK6lL0WCXy5bnNjsvLO5DTJ5BRlHRI71WZp+kDGd5/
RbJZWUHayOoevzIb7K2gVcs74Qq/1l1UhURE8c7qpkm1lGjWCs67EYhQ+WhMjdjP
bq23MFfUCBBXRM44QFACPcUv1SwOZUWWVeJOAdsROewUPaJ4ta7nzqp+7yVl1/9h
wnUnW38ZSZXITMACoU1E
=zR+2
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
