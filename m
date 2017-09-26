From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Correct number of unmapped
 bytes
Date: Tue, 26 Sep 2017 13:09:59 +0200
Message-ID: <20170926110959.GC23108@ulmo>
References: <cover.1499270277.git.digetx@gmail.com>
 <f30500403195b029ee236fff3b3c6f0b4dc60cbb.1499270277.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f30500403195b029ee236fff3b3c6f0b4dc60cbb.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:29:48PM +0300, Dmitry Osipenko wrote:
> The iommu_unmap() treats zero bytes number returned by an IOMMU driver as
> an indicator that unmapping should be stopped. As a result, GART driver
> unmaps only the first page entry of the whole range, which is incorrect.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Is this perhaps the bug that you were referring to in an earlier patch?
Looks to me like you'd run into that bug everytime you try mapping an
IOVA that wasn't properly unmapped before.

Anyway, this looks like the right thing to do:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnKNYcACgkQ3SOs138+
s6H2KA/4utjwiUY7oHqb2jFI/C55oTZpRMz0orY3J8CtHEI8UZlmLKw19T4Cn7DW
wu4l9a9y6h/uzQE94rKqcAAvoQAO/mKGz5P7iJ5Rr17sH/6C5K3vHjnZ1k5I+KGV
084Ui/4etEuiUEhueYSLVAvzjIsAZRMcZ/vRZkSqBIJbIVeQyBFecmc+/pZ3yefF
fz3XNmc74Hk+wQ7bZl2QXYT2BGhkMiT7XGWX9yjQcDz7108e05jx9av/zIULIU8w
4/1Gfjmrcj2VY0YEZrIBLLWcVRLpZ41B6T5TptZGG4+HkDlhkL+28Xi/oSY1h1r2
q2NCYwXmYC5ax/o4ygC0L/hLxHVbN2sf+FVCxXKaS9gyKxoPXn8S1vZXk6R2DdZ8
SJp74YWJWEHkQxjBKTw/ORLHHevoWspi1PLp4vv8OVAi1EmuYhRWmLRmWLbn+/Ps
5X7Cu/noIcEK3P5garSQr2t7LY6L8OidJfgBxbbkt6L43olqNycuOjhZP4ntBL0B
G8wX9VZj/sCVqlMXcstd+st+6IPDrveHn8xazDj++S/syZyIHpOoNeBvWIEk4FNJ
So5QAX6tIVtloXtHFBQENqVOBOqUfokNNeFL36f+M1KYn+nRMiPZr3u8OxV+Ko2j
ha0CvgZxyAHZa5OGKacjUX+oOsocy6MSfSTJDc3HiBiHgwWEhg==
=W7fk
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
