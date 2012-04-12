From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 15:42:16 +0200
Message-ID: <20120412134216.GB15701@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <20120411133512.GL4296@phenom.ffwll.local>
 <20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
 <201204111518.41968.arnd@arndb.de>
 <20120412071816.GA18252@avionic-0098.mockup.avionic-design.de>
 <025f01cd1887$da56b6e0$8f0424a0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <025f01cd1887$da56b6e0$8f0424a0$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Joerg Roedel' <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, 'Jon Mayo' <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Colin Cross' <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Hiroshi Doyu' <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomasz Stanislawski <t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Marek Szyprowski wrote:
> Hi Thierry,
>=20
> On Thursday, April 12, 2012 9:18 AM Thierry Reding wrote:
> > Also this doesn't yet solve the vmap() problem that is needed for the k=
ernel
> > virtual mapping. I did try using dma_alloc_writecombine(), but that only
> > works for chunks of 2 MB or smaller, unless I use init_consistent_dma_s=
ize()
> > during board setup, which isn't provided for in a DT setup. I couldn't =
find
> > a better alternative, but I admit I'm not very familiar with all the VM=
 APIs.
> > Do you have any suggestions on how to solve this? Otherwise I'll try an=
d dig
> > in some more.
>=20
> Yes, I'm aware of this issue I'm currently working on solving it. I hope =
to use=20
> standard vmalloc range for all coherent/writecombine allocations and get =
rid of
> the custom 'consistent_dma' region at all.

Does your work aim at removing the 2 MB limitation or at remapping non-
contiguous memory to a virtually linear buffer? I have some trouble
understanding how removing the 2 MB limit would help, because if all buffers
can be allocated contiguously then there wouldn't be any need for the IOMMU,
right?

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+G27gACgkQZ+BJyKLjJp998ACdFuA0NERIMlxCc1SHhNhFmTxU
cs4An2uoQh8SglkZlHbV/B4MZ7rF8QKW
=+dKM
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
