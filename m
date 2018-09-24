From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
	inactive domains
Date: Mon, 24 Sep 2018 13:00:47 +0200
Message-ID: <20180924110047.GO21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-19-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5030204495218449021=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-19-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============5030204495218449021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline


--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
> There could be unlimited number of allocated domains, but only one domain
> can be active at a time. Hence devices must be detached only from the
> active domain.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Do we have a mechanism of switching out different domains? I don't think
we do, so I'm wondering if perhaps a better solution to this would be to
just refuse to create more than one domain in the first place. That
would also allow us to get rid of the global variable gart_handle.

Thierry

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluow98ACgkQ3SOs138+
s6Fc1A//eebkcR6HVQf/WnOgbAuStAlJEk9PA600bzFQKyZOBrLVfshJnQRCGwNR
9ct+gem0WVMH623JFPWLxGjfkFOYRqugqA+FgbJ5qFV6fBsTNCDTPDd9ZBpFrMyX
QO+PhkFySYR6kDTheg2jamSOVutMWuioM+YE878kwiKw+qwo9HkUCTmKPHOoQ/QA
skckpJzteoYgqi3GGFevE9TgIYrcIfrPLFV1Gd4iZd091RPNQvBOYLwJCeFvo1M1
S1du/I5jTDd47KAhG2algLrHWq38NlbFekr9zK+bMWX2BA2jPU0cpYJKeUUCC9LM
UcKWkdAd3iyoSGxvN6JGdmIfb5noY8kGPMG+WO7+PZb9irgVYm2Dx34XuWA14pwz
YbZhh+XjRdgCx/r0ZhlUdpYZv87KuvM7iXBqXOwAEBl8Z8Ge34ZZgua2KBSClL0A
4YHJeOt+zE9o2Id+0y7G4v2JwLKjlCw+1bQtesCrCHLz40NUrcb0j1bggrvPkEWz
jwn44fN1688vLxcxVswewXYBmmiE0WnJn1zZwU4xeukj0EkKMMXLPFt+RcXAnsJc
toxTZeUYDQyogLV8fK2XFPgafumnhISHt8ZK4nnzRoss6UZIMEtVPkmY/lr5TESY
RwiiiSFOioiLkD4eTAGAnBltVHypova3LO6ukV8e/W1RfEPINbE=
=BT9I
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--

--===============5030204495218449021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5030204495218449021==--
