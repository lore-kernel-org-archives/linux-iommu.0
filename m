From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/20] iommu/tegra: gart: Optimize mapping / unmapping
	performance
Date: Mon, 24 Sep 2018 12:07:22 +0200
Message-ID: <20180924100722.GG21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-6-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5086462325038407650=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-6-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5086462325038407650==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:38AM +0300, Dmitry Osipenko wrote:
> Currently GART writes one page entry at a time. More optimal would be to
> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
> 10-40% performance boost (depending on size of mapping) in comparison to
> flushing after each page entry update.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

10-40% sounds really nice, great stuff:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluot1kACgkQ3SOs138+
s6GV3RAAp1rhOAm6sQZ32r7t5gQnDun3nb584/yANQ1Tkk/+d6uI4aQOwy09ittA
NYLbF6UPJLyVA/U2JpOSPu7ZK1trJ3+8gWWdq+33KQv4mb/2xI1wGSEq2OpIs+3D
hnj5iMP6AHB+EafsNUccvebGmkN1LvAVvK2oPSTDKVtH//0fFdMQqqlWMWKqxtlD
WtTYKGeMnBwdezhtfS63+83og03QnTb4HLLh8RHZNyJZT7/HpUY5llOQnYy1bae0
Q/L1jN/NQxekxbe2GtW5pmg6eZa0tW0nnzW2o7yfbB459cxyk8CYta+5JCfd0EEj
6hBz3akItwNZDQwmLqumDBuaz02LlKDMgan/HWz0ZRxRa2kYqJCKdw10ReU15JWy
AEWkzzqBVJzVvb1lIXfwl2hpNA2Z+ipkCZ5Atl+ND7C1wPfQQV8ddNblLwgfDYkv
weopJzt8UwTWhO6TJ7t0HjSNEYpH0mxp7eWh0sYQ2UJaWY+Q25whHJU6tWQu4XWT
LDHP83dFmjiJ4qkPZvkAjEJUMq7HlEfkDoAzNKM5ps8gjOYrvfaAW7dUy4bPDf6X
N74+6M9DkgEwSp4yA4+J4/8ZOATDmkPu0MMlJDJe26rFTKLLOcsjr9M7yYrXIeu/
13FfhXSNXC2V823XNJhLVoP8nQNM1ZRWjlmRqrV4Ka7er+kYwSs=
=bqRd
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--

--===============5086462325038407650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5086462325038407650==--
