From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Check whether page is already
	mapped
Date: Tue, 26 Sep 2017 13:06:36 +0200
Message-ID: <20170926110636.GA23108@ulmo>
References: <cover.1499270277.git.digetx@gmail.com>
	<a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0722265706265761397=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0722265706265761397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 07:29:46PM +0300, Dmitry Osipenko wrote:
> Due to a bug, multiple devices may try to map the same IOVA region. We can
> catch that case by checking that 'VALID' bit of the GART's page entry is
> unset prior to mapping of the page.

Due to what bug? Sounds to me like access to the GART should be
exclusive, so that only a single driver can ever access it.

Thierry

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnKNLkACgkQ3SOs138+
s6HJgRAAu5usJlokWcX2krlcm/Afn3LpCSM200cjMZ9rDWozN3+zhpQdbqtl2lym
b0KyPRVkyNHkxHrtWjsSfWuANZt8uzJVerwgedRpAa78Wm4WtYqziHFlfOQ69M0y
0aBUAZGWaam8vjt8OOMJwzJ/kOk7LxrStM41yi4jmQav8/z3hWWgD1lIzA7Br67n
dq4pgOfRcwXtfUdvXUvQXziximZzZojIY/ujAyA+YsYyQD0m4oeTRTVceZS3N8O9
9+x18W0bX+rAp2le4+YlfX7NvgSbV4Ffn708R0Ez2cVp2CUJrqpX4aSbw1HI5Pr5
goehjlmkGHZ8nDSOIwgfkOl+O8sQt2wQPbkN1IX4x4TuqY96dTmqWoV7OAsBttBu
tem6VWYlIo0OpTm5vbtafaghWwg4YFbaDW89FhrOR57ccAvbAYEmyHnB7cURpbFI
rt/si4zE04yD+jQ8OEWlF3Xinkm+RUc+Snu1t4UouACrERpGSlErXtQMXFN0U36R
tF4U3BGsZdh0kO/QNAXDfipEPNmrzWV1ICfiUEdESAHZJft6EpSLNH6siQWxTMtR
aOD89uLIEUsZJ8mHnQfs/i8vVlACaj84hddX3e1oB/UmyW/LI2iEnMQafMIArvDx
bnFQ9V8MYA11o7hiZc4ezMLmSUAbeEvyUTANKA6+jBMula49A/Y=
=3Bql
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--===============0722265706265761397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0722265706265761397==--
