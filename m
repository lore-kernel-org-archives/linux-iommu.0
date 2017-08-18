From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Fri, 18 Aug 2017 14:47:06 +0200
Message-ID: <20170818124706.GB4556@ulmo>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502317752-8792-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 12:29:11AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> Add a struct iommu_device to each tegra-smmu and register it
> with the iommu-core. Also link devices added to the driver
> to their respective hardware iommus.
>=20
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmW4coACgkQ3SOs138+
s6FArxAAnCAaC0KXS2Tdmdzq0AjNV2SNQboxlqlYfIFJaoTZtBFsUWZmp7pXs2NC
fv3ajV+ooKELPNI4qx40t35XlUDhHwaL3uAF9Og7IE8IqDJS3KiPuXymZ82DLDM1
sA3tN4+FNRtAvDXYrpz3PNsoOQDC6izIqeTOjAqCBCimi99nqY1rzPZip8iVIDV8
VvRCekyi8NIfJSUHIiLcuZA83nXZA05s3ZUb+sXxCPImgilpxEwrKmi0MZX7mOrt
N+v9G0hfxMhb4yN+vf/zKasNzt7V4cclfF0LGpJFsUWVZ3aIM4iYHkRKiaoG9wCZ
1eZqSNMdqrgJncoN4jyjZP5JO6FqtJsZhsKdfO0SYO8CkVIpjkUz2BF75OItIQQT
RhOAwudngz8pjvGoOSbvjYF3Kuxmjf/I1IgQaWcXMwdseWoWQwZA4G8gvDfubKY7
zu0L6NI2z64diKsqibzo2n1plgdIc/QsEc0eIB41FnER+c6zK6HTR87kuVK1Hqt1
JLkDrQ9IZvOeV0BEBREPKvdgYsCVCIqQ9wiwi/EGhZ6S67cDEtT2owKIzFO+e2or
PRljrcK0tFp1V055Vkb20OlKhzCFcEr3sMUtlzWMT1ZKEZ3ImpzXrx8OG5sSOINS
wl78j5ZTWF2dOJb+Glnu0X0X/oMioR8xZPoc9M/BpKtgjKl1j+M=
=YoBc
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
