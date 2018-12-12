From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 21/21] iommu/tegra: gart: Perform code refactoring
Date: Wed, 12 Dec 2018 11:20:27 +0100
Message-ID: <20181212102027.GK15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-22-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SCOJXUq1iwCn05li"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-22-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--SCOJXUq1iwCn05li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:50PM +0300, Dmitry Osipenko wrote:
> Removed redundant safety-checks in the code and some debug code that
> isn't actually very useful for debugging, like enormous pagetable dump
> on each fault. The majority of the changes are code reshuffling,
> variables/whitespaces clean up and removal of debug messages that
> duplicate messages of the IOMMU-core.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 244 +++++++++++++++----------------------
>  1 file changed, 96 insertions(+), 148 deletions(-)

This is a little over the top in some places, but there are enough good
changes to gloss that over:

Acked-by: Thierry Reding <treding@nvidia.com>

--SCOJXUq1iwCn05li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4OsACgkQ3SOs138+
s6EGoQ/+OhpqPKQ5u8xJGxhe0MrI4exbUAh+zAC1y5Tmq+PbSTKpsf33/E0jao7Z
3e3oVbeN0Fi7o5c5boHynwaXTea+C4KC4uwLhtBZ/FjWyQp68sJTSM88NaBJK7mq
rQVUQ2ayUT5/pOGVT2V71WOwodL1g3SukQaM5owcgUwq2SVCfUe5QvzH1x2Gztor
q/iM50vHYU8wtezVeSCB6Fm4951TAN8uHaRYeGiMyQ/OB5VDpD3kYzPzCt03kC/f
yocv/dKZu56IFBnWQPJtVR0KzjL41ZyJxqm2/sa0pp1aYUVrmsXReyHsv1gBCMIs
JAY5IoSe231YT4/98HH10NH4iqm/SE10aNpJSbuc00WIt8LvZSWVrqpm8LMYboLV
odPOy/yPsdOEUISQYdBZpMrBWNc9bkLAwsMlbNlcB+4dItKU8tG2b2kpj4H/66D8
5AfIAJbd9715R/iP3ff3YdBakLpVvDENvkI2v3t/TcThUoEyDjWVRUNU1TjNoScS
xM5FkjRqvWZBQ1wgfuYyl97RHL3mkJDRpiw9gtGVlev4F7lq9z6RSsyhhnq27gzL
kwZESih+tDiCfwoQq0ZC6eMz3Uz6AXvNrzd/OL9epicyFtnBPTzxI0I661BF4v4b
2+qUFq2j597+RhSfvNsU3vhYvQcXqitqT8+rfGA85Ihsfe3n6Sc=
=T0tQ
-----END PGP SIGNATURE-----

--SCOJXUq1iwCn05li--
