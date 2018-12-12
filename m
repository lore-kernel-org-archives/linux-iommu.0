From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 10/21] memory: tegra: Read client ID on GART page fault
Date: Wed, 12 Dec 2018 11:05:23 +0100
Message-ID: <20181212100523.GG15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-11-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-11-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:39PM +0300, Dmitry Osipenko wrote:
> With the device tree binding changes, now Memory Controller has access to
> GART registers. Hence it is now possible to read client ID on GART page
> fault to get information about what memory client causes the fault.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3WMACgkQ3SOs138+
s6GZHg//RNajyeYT9wZ8n9fuo/qqiKODESwNpf2kYIYOSdXA2RwRouhml2L/q06D
A0cBf3VZcT45q+OPpEChx6NQ+z6YjTdaJlMABgXrZTqXu7mv3DJ2EzskcApa7gvu
IZAQPlOV9qTD8U94QeIaay362knEHbRP+cWOezOdQSaH7BTR64dufPoFyPDlHEEi
O/Ums8Q9vBnRWqzJxY6D0l0h00UZV2PfjSqg8qNB3EhwBrclRomhd5BFx0zUKEHW
PyctKwGmL4tGyaJwbKQDxVYeKnHx3OMFqv515KuWeXKzvFPbmrdabbA/yL4bRxQ3
yfKPDnERvlKdEmw63zcw7xN6DNloXyXtYn4mvYea2qdWi/LxZdyNc8MF8yxNv+8F
7iRkjP1+iBOineBJriwMK7HVlhimnuJJvTD1kb2MjglMgn0artOrHS/kyoQ8R3Js
tyDF1FEnNLKzvmG2SUSZLD52KWgwwLr9WQ5wDGC6akY86DnBiO3tBu8W7zCLw8h3
JFvbYhcjrSDQ58/jkaNThIJVk4eOwevMlfypG6TIH89owVMDnVL+xNvB2XExosrc
QU9VnjWn2tlz5IRoqUEkzDaQUs9xGO5+XUqA/ZkpG47hZsp9Bkv5tlKyUgh3x6+K
EgdwJUSrY4oXRoaAkidCcz7iwz84WXqzFSq+Tz3R4U5Wrmoadxc=
=6nNA
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
