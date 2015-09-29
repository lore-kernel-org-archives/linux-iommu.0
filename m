From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: Add support for out of band flushing
Date: Tue, 29 Sep 2015 11:32:57 +0200
Message-ID: <20150929093257.GE9460@ulmo.nvidia.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
	<1443504379-31841-2-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4247106907694648662=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443504379-31841-2-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============4247106907694648662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2015 at 02:25:24PM +0900, Tomasz Figa wrote:
> This patch adds a new "flush" callback to iommu_ops, which is supposed
> to perform any necessary flushes within given IOMMU domain to make any
> changes to mappings of given area [iova; iova + size) be reflected to
> IOMMU clients.
>=20
> The purpose is to let IOMMU drivers skip page-by-page flushes and
> replace it with one flush of full address range on devices which support
> it.
>=20
> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 33 ++++++++++++++++++++++++++++++---
>  include/linux/iommu.h |  2 ++
>  2 files changed, 32 insertions(+), 3 deletions(-)

I seem to remember that Rob Clark had proposed something like this back
before it was decided to introduce the ->map_sg() callback instead. I
can't find a reference to the discussion, so perhaps I'm misremembering
but adding Rob Clark in case he has any recollection of why the outcome
was what it was.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
[...]
> @@ -1389,6 +1410,7 @@ size_t iommu_unmap(struct iommu_domain *domain, uns=
igned long iova, size_t size)
>  		unmapped +=3D unmapped_page;
>  	}
> =20
> +	iommu_flush(domain, orig_iova, unmapped);
>  	trace_unmap(orig_iova, size, unmapped);
>  	return unmapped;
>  }
> @@ -1419,19 +1441,24 @@ size_t default_iommu_map_sg(struct iommu_domain *=
domain, unsigned long iova,
>  		if (!IS_ALIGNED(s->offset, min_pagesz))
>  			goto out_err;
> =20
> -		ret =3D iommu_map(domain, iova + mapped, phys, s->length, prot);
> +		ret =3D __iommu_map(domain, iova + mapped, phys, s->length, prot);
>  		if (ret)
>  			goto out_err;
> =20
>  		mapped +=3D s->length;
>  	}
> =20
> +	iommu_flush(domain, iova, mapped);
> +
>  	return mapped;
> =20
>  out_err:
>  	/* undo mappings already done */
>  	iommu_unmap(domain, iova, mapped);
> =20
> +	/* flush in case part of our mapping already got cached */
> +	iommu_flush(domain, iova, mapped);
> +
>  	return 0;
> =20
>  }

iommu_unmap() already does an iommu_flush(), so why flush again after
iommu_unmap()?

Thierry

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAABCAAGBQJWClrJAAoJEN0jrNd/PrOhabkP9jCTsJ9Qv6yPr5jIfAGCYiQZ
jH9J67OdZtEMA72gZQPax1yqcTezth2w+0W1VexYmmo45qAB/1ioGwIRPq0VswgZ
ThpCsJU4l4BeqivDMHnPcRhqGI69LMZ+KBRtqgNAuq6Clw0rTjip6bkwITjR7Q4O
NbimBtkg6swhDMAg0GOzWht7gXEU/K05U1mmQBv8MGVoZzuS8O5e2bb5cHZFRZzS
NN0scfqNttD2YIGCWY8jrSR5XoFSEfs0IcoppXEgdqxTM3BhXXP4kCagGtUN7ghd
8/07TPaN7gKnRZllIU7d28U1Y1vKACQF79QEMRKe3nhWsdhRdZwfuaYwXdJdI51r
N10AWp2nl257NrH4DeLBl/iI8yTaHTMzYPMXxBD2mlpbL6KJfqt6/zEcGhTJR41r
a0Ta1h/r9eUZwYk9wjcHbyvqZTRQQoaC6W1AkqlhknnuW31i4ZmR/NmG7iO5k+z5
LNIKiYc51Eew2+GwfFPs+DP9iyC4XqXl2h6ciUZvV8j9sfj+G8LedL26QRHcayPh
YenLfp7Jnsca149mcVkVBWvb1qk3weKIJncq4U+aUyb+pO0lcDveXvsoB6pdij9L
zzTFGjrwuiOxnszahDoOe5FLT4UzIbTCReadGS2QvYUuMuvtx0Dz1UXfPVpuqeo0
8XffSlUaY8DXvIe493s=
=l2tj
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--

--===============4247106907694648662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4247106907694648662==--
