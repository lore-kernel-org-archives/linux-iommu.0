From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/4] iommu/tegra: gart: Don't unnecessarily allocate
 registers context
Date: Tue, 26 Sep 2017 13:19:50 +0200
Message-ID: <20170926111950.GD23108@ulmo>
References: <cover.1499270277.git.digetx@gmail.com>
 <df570fb6649da6bc3b5f2a68afcb5471e6148269.1499270277.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <df570fb6649da6bc3b5f2a68afcb5471e6148269.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:29:45PM +0300, Dmitry Osipenko wrote:
> GART looses it's state only in case of a deepest suspend level. Let's not
> waste memory if machine doesn't support that suspend level.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)

I'm not sure about this. The savedata region uses 32 KiB of memory,
which is really not a whole lot.

In addition, the suspend mode can be set in different places during the
boot process, some of which fairly late. I'm concerned that this boot
order dependency is going to come back to bite us eventually.

Thierry

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnKN9YACgkQ3SOs138+
s6EwsQ//StsCAcWDixdFjp+jR5Uj2xHzYGvkEmCNpEpWsArojbDfJBbb5QVP0X9c
UZAQhH3NKODYZQasP76+exbrOov4PtyK4H1JMu2WV9QfOTNywhoRRrzF7bEJPQsf
im9YhmlcIb04uChSpvyFM+JXe5kWS4VRgy3LPtdEPmCrMHCQOYZ+JMwOlhLmziDH
oM7uQA2ke4A6GmK4EndcFxKP8xou/+pZgj5RkRm7lM3fRnPQ4KuFWZ696Q+NuCQc
aBOigj2ciWsJ/l9aMdnF9ucNvn6ojIuhYVzZiic48vkJJSFxYZIgDc/d17Q+GB2F
QKfpQhpRC1O6L3x+GIZtYIHCElVgfHc69j6VhE03rs1m4nSUpPEqrCDkO2nx1wPU
G806/nWD/uYhED1v63pZt3tdz3zgoevpm+jht+SuYjowddDmDCu4+2soiJrugr60
S+2NT2kmqHyilDCNVYI9BdqQVbTRDs1SmoHREBWc1Mky7sysLpUsve7T6aUJ2pBT
tQ7kLBwbEGh2UZLc/CF/W6bOAnURoivdr0QPCTbMbALhQzTVhFsz7cvHHG5v4PjB
awQJXhvN4LTUo3EJG3XwKJf8/ffLG3zdOsXPRNGE5HLdas/O9WPePKNvDhbVwo61
C1GR9XbmYgLznAjTks4BU3o7so2dhR7LT71W89GXKfVJwAo2uFY=
=R0FK
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
