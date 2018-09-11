From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 0/2] dma-mapping: introduce helper for setting
 dma_parms
Date: Wed, 12 Sep 2018 01:39:33 +0200
Message-ID: <20180911233933.GA1402@kunai>
References: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
 <a9478a05-5908-e693-7eeb-3673b2facda7@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a9478a05-5908-e693-7eeb-3673b2facda7@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robin,

> > 	od =3D devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
> > 	if (!od)
> > 		return -ENOMEM;
> >=20
> > 	pdev->dev.dma_parms =3D &od->dma_parms;
> > 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
> >=20
> > And that's all about handling dma_parms. So, on unbind, the memory for
> > 'od' gets freed and dma_params is a dangling pointer.
>=20
> That's the typical case - the dma_parms structure is simply embedded in s=
ome
> other private data which tends to have the appropriate lifetime anyway. I
> can't see that the dangling pointer is an issue when it's set
> unconditionally on probe and valid until remove, because anyone
> dereferencing dev->dma_parms when dev has no driver bound is doing someth=
ing
> very very wrong anyway. I suppose we could zero it in
> __device_release_driver() for good measure though - shame we've found
> something dma_deconfigure() could have been useful for just after we kill=
ed
> it ;)

I see. Yes, I was aware that the misuse of this dangling pointer is
somewhat academical. Yet, it was easy to fix and clearing this pointer
is good programming practice, I'd say. I agree that clearing the pointer
in __device_release_driver is a good option, too, if documentation about
its expected life cycle (=3D=3D get's cleared on unbind) is clear about
that. Probably that life cycle confusion led to the more complicated
code in the exynos_drm driver. I will look into all of that tomorrow.

> Note that ultimately we'd like to have a single structure to hold all the
> masks and other gubbins (per the very original intent of dma_parms), so

I was wondering about that, yes.

> there's a fair chance of this getting fundamentally rejigged at some point
> anyway.

Makes sense. Yet, as this change is gonna be small, I think it's still
nice to have.

Thanks for the input!

   Wolfram


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluYUjAACgkQFA3kzBSg
KbYMPg//Zfi+Hz+7x50SPmdAwCyPvJ+GIPolfb9bnY4HJd2+bTBp4dHh8c0NDkxT
HzIqv8AEjMuO+WqsnBqQGHxHD0tWif5t2JHgcrxplRGSh/Ten/PcFtb0tngLLxu+
NaYBEvLW2TjXqoyoNuJ8NXXo3p9+Y+anN5iTnN1u+hLPezNlf+ksQZGJbNcWpsnU
ZQr3Of/2wmsOtamRhJvdZ0N8ywqXZrxGqPaQzrEYnY0kX4CcVWfLC0GjOQ5qq60+
acWYcPoXp0qBAV1KNGaIaqyCdPxwG6D6wafbh47wF9YdlZ7qXe7nrkXwbBEg6teE
cmf0norWDL1pqriwtXO9s/PBY7HMbzfSpSQtrPzHlgaVIaaOqDfWMepi1UaAjiKJ
Y/EO9AC+QdT/CYOhV4nMWqGkUacjmgxFmTQkiHaUVvbYEk9SWl3hxjT2Z/U3ah5b
QJZu5KFvXpZLjEOawHhHhiLzw4DA7Uuq5rmG8UqRisYhtSOGJv+LmOuiICSI0SQL
rtEIEl6HNWtssBRbwRY49fmsFZ8cvcZn+dtk28bX4PIItA82OtPY1/b+uwlMiVdp
PpPPtLMcfpb7klzmVfTlziw2k9I/NCtrrx+NrDILL2PLAf39TQb6aHmobAKk9Y35
C0f/YanJSh/ELEjRxpRZp0dAHDrZ28DdKcabrLtnNSVYbIOlFEs=
=5tYY
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
