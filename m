From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
	inactive domains
Date: Tue, 25 Sep 2018 12:04:24 +0200
Message-ID: <20180925100424.GG7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-19-digetx@gmail.com>
	<20180924110047.GO21032@ulmo>
	<8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7981440858561931730=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8be80297-3b13-ece6-a5bf-873cc7877989-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============7981440858561931730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:05:48PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 2:00 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
> >> There could be unlimited number of allocated domains, but only one dom=
ain
> >> can be active at a time. Hence devices must be detached only from the
> >> active domain.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > Do we have a mechanism of switching out different domains? I don't think
> > we do, so I'm wondering if perhaps a better solution to this would be to
> > just refuse to create more than one domain in the first place. That
> > would also allow us to get rid of the global variable gart_handle.
>=20
> That's what was done in v1, Robin Murphy suggested that it will be
> better not to restrict allocation of unpopulated domains. It is
> mentioned in the changelog, see comment to v2 changes.

Okay, fine.

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqCCcACgkQ3SOs138+
s6EcWRAAi1a6EdXZRPBtfZIPPFrJWw0mFbyhRhoBMtgV6Un7CUmgM6G8GBHgMfUk
1ZOEZeXCAQPBL7UonpE3DgOqE27JmX8UuevI7ZiyEQH/7ZHaNN3F35GGbN5R8oSZ
vIFFKGrdx6gWWCfGzDy9vsJ4BasUt28weT6/dHDKLiW7Og8RWICssRmo71oUMyJb
cwA09L4Yf99YbwYcB+YhsYLmcdolfWWoeh7fZO/6xsBnZg6n1YlKsXLKPqzOCl4u
GJ68y6RrwdqRoi7EjxQQvN7RALttAJTEQFctlWijqYlZw73lymgQeDBgWoLJmrzn
tabDCEw5Ut7HsF33lfsPuONHYLUdHy4OnGfjvXrVfHEsRdmUxYtlx/tMAgyr+/N1
hLTk0lVEFr70qXLLXHKy1CvzDj7SwHKnbVjFdIGtW0+2VddBfPT5KCeDyctnQoW9
osyz22j64i+QQDfXRRLqk+ov8S1meF+cFZi6X5RUuJAsC3Ix9HVQKc2A0ep1NPlN
8CMU5xysmcg6a0QHFDPP95G25bYOTTNOSi4bZNjLmqnt5xbtQCqfiwvocJ0f2pyV
kiI+IPyJb3kb+fl4/7RU0MEZho/rS+uPXVkNJkWNHe+Px37dJe4PhSOG8DEZCwKO
vq4tEQsrwuDw8BMQLjczDykDmNL/M0xbhXe7Jvn8FOpD9iZkSAo=
=ph6I
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

--===============7981440858561931730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7981440858561931730==--
