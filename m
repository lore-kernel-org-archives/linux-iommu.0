From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/18] Clean up exposure of arch-internal code
Date: Mon, 27 Jul 2015 16:31:42 +0200
Message-ID: <20150727143141.GA4774@ulmo.nvidia.com>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
	<20150727140905.GA16858@ulmo.nvidia.com>
	<20150727141654.GI7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1811414586692238647=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150727141654.GI7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1811414586692238647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 03:16:54PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 27, 2015 at 04:09:06PM +0200, Thierry Reding wrote:
> > On Mon, Jul 27, 2015 at 01:28:24PM +0100, Russell King - ARM Linux wrot=
e:
> > > This series of patches attempts to clean up the use of architecture
> > > internal functions in drivers, and removes some functions from view
> > > in the asm/ headers.  I'm also considering whether we need to add
> > > some linker magic to hide symbols when building the built-in.o files.
> > >=20
> > > This was triggered by 3rd party drivers "going under the covers" of
> > > the DMA API and calling the dmac_*() functions directly, a practice
> > > which I have always refused to allow.  This also breaks module
> > > building (which is the big hint that they're doing something wrong.)
> > >=20
> > > However, it also came to light that various drivers are using
> > > __cpuc_* functions directly, which are non-portable, and is another
> > > instance of "going under the covers" and tinkering with what should
> > > be kept as architecture implementation details.
> > >=20
> > > This series addresses some of these points.  It:
> > >=20
> > > (a) moves dmac_map_area() and dmac_unmap_area() prototypes out of
> > >     asm/cacheflush.h and into arch/arm/mm.
> > > (b) provide a secure_flush() call for the Qualcomm secure monitor
> > >     code.
> > > (c) stop tegra smmu driver(s) from using __cpuc_flush_dcache_area,
> > >     something which necessitates additional complexity to deal with
> > >     the ARM vs ARM64 differences.  It should be using the DMA API.
> > >     However, the Tegra SMMU driver is in really bad shape, and this
> > >     isn't a simple conversion - it requires a lot of additional
> > >     fixes to bring the code up to scratch.
> >=20
> > Out of curiosity, did you have any hardware to test this on?
>=20
> Nope - it only got build-tested, and it's partly why there's soo many
> incremental small patches.

All the more impressive. =3D)

> > > It leaves the Rockchip IOMMU driver for the time being, but that is a=
lso
> > > something which needs cleaning up in the same way as the Tegra SMMU
> > > driver.
> >=20
> > From a cursory look, MSM, OMAP and Exynos are in the same boat as well.
>=20
> Yes.  There is a question here though:
>=20
> Is it a good idea to use normal cacheable memory for the IOMMU page table
> entries, or would DMA coherent memory be better?

Currently I think coherent memory would do just as well as cacheable
memory, maybe even better given that we wouldn't need the cache
maintenance. However, I think cacheable memory might come in handy if
ever the ->map_sg() callback gets implemented, because it would allow us
to batch up a bunch of PTE writes and flush whole pages in one go.

Unfortunately I don't have the tools handy to provide any numbers, so
the above is really just guesswork. Cc'ing Rob Clark who, I think, did
performance measurements a while ago. Not sure if those included
coherent vs. cacheable memory, though.

Thierry

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVtkDKAAoJEN0jrNd/PrOhBvoP/08HSrJiAlRWKKA1OJ8BgP9v
5xz8Lqars37TFyqlyzBP0VyX28T+5mGfDaxJnVr7mFqzo/DqTrUCDFn+6B7PGhpU
sJucXqxSn8xeM+oRRF3LqI5vJKluiGaIOziFhbadt2dpEVxWO55tIxDyrkmDspu5
p0m+9gpHpnX6FXAt6sDIFIAhEWlhQ0oDZzw8kH61mayAKN7CWxWC8oeECFZPVvBp
YpNS4oZoGZIVtNJBTiiFzbKxdtlCBauA66yPEaQ4312bwRZnMrIg3B//uGSHB4pi
8xMSCXN1XxSShlDxi/tRNuC1M5SIlFIrg4QxXebddGRfctQMVUBpQ7HzAV+rUQST
6Uxjh4+w3rtRiPFrwZKoRt/aiirHl5OFxePy8DWziN6AoLxXnfhFbJjyTADNMmuF
C6JfcR9DFnCDLvTdLlIuNUJQgnsoGbSe0j0BHduBfqF7muh+wPysaaq+6gKpNcZo
lkF3uDPuxtBcwquVOSOzV0avmTvTVIcIYznRUXmInKBdgcsblosBmUOWw80TNiQg
H65r2Gwg+ay0cemvIzjPtcTXlN3qEFqpr55nEhVkkaLytqqmZYWnCBghWkxr2Brm
Y6wNPvAp2175Rc6PEan9JruAWOBvHnI3yaNiaHz7iMmskDD+QW9LbWgwgtRCZgdX
HAQbbsbhfSOklqIPdWUE
=60cj
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--===============1811414586692238647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1811414586692238647==--
