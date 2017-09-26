From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Check whether page is already
 mapped
Date: Tue, 26 Sep 2017 18:07:27 +0200
Message-ID: <20170926160727.GB12426@ulmo>
References: <cover.1499270277.git.digetx@gmail.com>
 <a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx@gmail.com>
 <20170926110636.GA23108@ulmo>
 <e59eb818-4edf-f3a2-947a-bc21507b0b85@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e59eb818-4edf-f3a2-947a-bc21507b0b85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 04:49:52PM +0300, Dmitry Osipenko wrote:
> On 26.09.2017 14:06, Thierry Reding wrote:
> > On Wed, Jul 05, 2017 at 07:29:46PM +0300, Dmitry Osipenko wrote:
> >> Due to a bug, multiple devices may try to map the same IOVA region. We=
 can
> >> catch that case by checking that 'VALID' bit of the GART's page entry =
is
> >> unset prior to mapping of the page.
> >=20
> > Due to what bug? Sounds to me like access to the GART should be
> > exclusive, so that only a single driver can ever access it.
> >=20
>=20
> Actually, there are a lot of peripherals behind the GART. But yes, probab=
ly we
> would use it exclusively for the GPU allocations.
>=20
> In a case of the GPU allocations there could be a bug in the allocation c=
ode
> (drm_mm_scan) that would cause re-mapping of the already mapped pages, we=
 would
> be able to catch such a bug.

Sounds to me like something that should be opt-in. Given that we could
potentially map a lot of memory, the additional read seems like it could
incur a significant performance penalty.

How about protecting this by some Kconfig symbol (or debug module
parameter) and adding a WARN instead of failing the mapping operation?

The reason is that we really should be using the GART from a single
driver because it is a shared memory region. To avoid drivers from
treading on each others' feet the allocations must be managed by some
central entity. So either something like DMA API should manage it, or
we hardwire it to Tegra DRM explicitly.

And if a central allocator is responsible for all mappings through the
GART, then we should assume that it isn't buggy, and therefore the extra
check of the PTEs should not be needed in most cases, hence we can get a
performance boost by disabling the check by default.

Of course if there is not much performance impact, maybe it is okay to
keep it always enabled.

Thierry

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnKezwACgkQ3SOs138+
s6HxwBAAtUGzudH2ZB8j7pdl2dq5Nd/criu3B5AUMTkJIwL4ZFKYfxfvdAAjmeAW
SUsXIDwsozrKZP51V4+M9cFgqqqxqkzVPWh2iLJ5CaOMxIdnNhJ8gsi4ZckXSolL
Qn+bOdSj2/FeedCFG6AX3v7bRbfnHbNmgdemQbjEJEZHVBqemT/+mZlN0iB91TPs
geXrgv9ndhN9P7fbwM5tDrEnyjovPy2q1V1nckGoAxfzOtDL8neyhGQNR59bbxgF
Bo7Ogh2HFYTGXzbCZuP0h0ecU5MVUR5eQ65GBs2fi1u4oA7KqFxVrwR7hIMpv4nq
tfnb/BHY88Rs2d+C8qNLa7dmlhUWbNMaZ0qWTjej5JuRRzqYEyUatbE5CtDOP39B
R5nEjTxWyWTFJPRRcBylhnoHr1PjF+sL5ATKddITCHrs3ULdr7+gYr3c8SXq62U2
9GJTRxy9Nm+sLj5H7DcdGaRYTCdRxIpTocoBKk3q2nuuCwrsaDK5VTczCvRjYXg/
ljYqeVFjsIYl98leUKADwC3BFji6ifuDuIlytrao8KguilSxenm1eAWL2WH45uoI
ATq8n6uZhtjmBiocjVwBvp9jxRZcb9ypQ0xmSYaAPWzWr8pJZugIRHGBhgPZcDgU
93Gzc8NEjbn8v3l/YK6o+WGf3tWZ17b7BkvA1NRkMaSDaiGEQVc=
=K6kp
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
