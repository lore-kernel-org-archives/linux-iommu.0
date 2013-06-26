From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/23] ARM: dt: tegra30: Register AHB/IOMMU device first
Date: Wed, 26 Jun 2013 12:45:14 +0200
Message-ID: <20130626104514.GJ27083@manwe>
References: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-5-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:07PM +0300, Hiroshi Doyu wrote:
> Move up AHB/IOMMU to register them earlier than others. IOMMU needs
> AHB, and IOMMU needs to register all platform devices as
> IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

This just happens to work because DTC keeps the order from the DTS in
the DTB and the Linux implementation sequentially instantiates devices
=66rom DT nodes. Neither should be assumed though when writing DTS files.
Other implementations (DTC or OS) could do things differently.

But if I understand correctly there is another solution which should
solve this issue properly.

Thierry

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysY5AAoJEN0jrNd/PrOhkXUP/0MvFa1dWQhyFY8Ba7d98jE0
79x8Teecw/u/qZTXFNKCa5ecvfNMhY2LD7KZ8LLV3FIcGPwkzPUQco93XCgGAkvw
WybP4Zo3+0rsDyn2BXUfISgZ6ZsYJqJx4t+xQnvoX1ks1MEGs44yQbyzEkMIJSXs
qMtCLQ6eMt3Fa/18l3L/jniKGrk8n7lUmC5B+PAqgUjwrZvngKZQcOpcz1VN2RIo
xjA5VyOgkphvda6p7Y+sKqPOWsmUqLxXLupr1uaCyFLHAml6VTNEvlcfKlIn3sYp
dv3qP+4QQEeOpSKUIPMj1YuhgHRa4jn4MAzE3cMmkDFNvLFw0I4nrAiTLbP8Qgiw
4oqfUgdAi/clI5D5BndHF2NHyFzNvbkWjiadX1uBhS+BXZZInHBr0fg3p0NHn38Y
bGpYMSVwktBxs7tsBCSXcX/XpfDPAkaWJikiz13XTaZ/bf6j+M7lLslSTf/IVv+v
WFdoGWUR5yN5otvJ690wbeZ+t8q9492FxFqT68nrc7pxRdc4xnbYINuWCtarbAgw
dJlNh/Evl7NvqagZ4NiP9v/kGQQ6nUawzkbcNqW16W/fL5VShPGuz4QuSjY7HC80
d2EKdrJYIukUGgsOj84mTeXSjkCYVA9aUunxCthDEj0jnWEcZkz/lmZCnuPFmjIf
thN06258dl9Yu3gD+V8c
=2xy1
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
