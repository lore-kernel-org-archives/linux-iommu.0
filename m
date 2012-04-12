From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 09:18:16 +0200
Message-ID: <20120412071816.GA18252@avionic-0098.mockup.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <20120411133512.GL4296@phenom.ffwll.local>
 <20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
 <201204111518.41968.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204111518.41968.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Arnd Bergmann wrote:
> On Wednesday 11 April 2012, Thierry Reding wrote:
> > Daniel Vetter wrote:
> > > Well, you use the iommu api to map/unmap memory into the iommu for te=
gra,
> > > whereas usually device drivers just use the dma api to do that. The u=
sual
> > > interface is dma_map_sg/dma_unmap_sg, but there are quite a few varia=
nts
> > > around. I'm just wondering why this you've choosen this.
> >=20
> > I don't think this works on ARM. Maybe I'm not seeing the whole picture=
 but
> > judging by a quick look through the kernel tree there aren't any users =
that
> > map DMA memory through an IOMMU.
>=20
> dma_map_sg is certainly the right interface to use, and Marek Szyprowski =
has
> patches to make that work on ARM, hopefully going into v3.5, so you could
> use those.

I've looked at Marek's patches but I don't think they'll work for Tegra 2 or
Tegra 3. The corresponding iommu_map() functions only set one PTE, regardle=
ss
of the number of bytes passed to them. However, the Tegra TRM indicates that
mapping needs to be done on a per-page basis so contiguous regions cannot be
combined. I suppose the IOMMU driver would have to be fixed to program more
than a single page in that case.

Also this doesn't yet solve the vmap() problem that is needed for the kernel
virtual mapping. I did try using dma_alloc_writecombine(), but that only
works for chunks of 2 MB or smaller, unless I use init_consistent_dma_size()
during board setup, which isn't provided for in a DT setup. I couldn't find
a better alternative, but I admit I'm not very familiar with all the VM API=
s.
Do you have any suggestions on how to solve this? Otherwise I'll try and dig
in some more.

Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+GgbgACgkQZ+BJyKLjJp8bzgCghcjjm0gZyWbH01Tiamc317cM
//4AnjcfTol8KZPD7iZ/G2VorcX+A1Az
=Tjoh
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
