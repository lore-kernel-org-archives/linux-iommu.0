From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/16] iommu/tegra-gart: Make use of domain_alloc and
	domain_free
Date: Fri, 27 Mar 2015 12:00:03 +0100
Message-ID: <20150327110002.GB5440@ulmo.nvidia.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
	<1427373799-18662-11-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4433924136772586255=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427373799-18662-11-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4433924136772586255==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 01:43:13PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> Implement domain_alloc and domain_free iommu-ops as a
> replacement for domain_init/domain_destroy.
>=20
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 67 +++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 46 insertions(+), 21 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFTgyAAoJEN0jrNd/PrOhpKgQAK2SZy1EcgzClwawBAzTCHpY
gJPTKPTfKoLEqTgLMM4LYtjip6HpX4yLJz5QZyS1zglXlC21yZ3+sEDktCZXREa2
9L9NrEe754TimgoIuJs9aaeU7oZ9NGz/ERVDXvfCbvMFrQhmAkIyllYYE1Vom+in
kYdouTrlALN/RnCRAH/ofvOedmuAXIggHRDrJSZbP6jbYk6kcVcedPXBTAdgoq6f
CwMDoS/LCGmCHGngfNiLGpy6FnGD3gcuxvXmFZV0p5NrCsGF205H9hYDmjT8XbW4
+vw9qszZLOD11FKepmEdOoQZBOS6HYRkMbnjhuEAerBN/fMxzeg/0SiS2e7EHlfI
vinVahzSNBq/1Ptw8p15Ggyugmjkj5Sm29zLzn9ow98WxRnaWDg19J5f8rrvXUPQ
a9iwgMIed6S7im1/tRhXMTx/dXc5138sO3vuffvr5dSw0cusZQMcT+LeCkqsKjUL
19dAoZs4kZdLy2dddosb/B3oh7O2FPTz8iHnZgY5ZAONEKWoYy5i+gKs+mLNAbAX
SzS5DdIExM9EVTTP4OC/JGX7E2mE2iiX0n+j/9iSlmxZONJgVYFxnze+5JPInL5A
rZVRfUz6+n5S0UiE4wkCfzLa5Riacak250unyims5FeLn2Eg+tCEtUfewHhGlvqL
uT8HWBgZeMDk0liVTNjJ
=luI4
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

--===============4433924136772586255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4433924136772586255==--
