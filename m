From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC v2 0/5] Add NVIDIA Tegra DRM support
Date: Wed, 25 Apr 2012 14:27:22 +0200
Message-ID: <20120425122722.GA24502@avionic-0098.adnet.avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335347102-14905-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thierry Reding wrote:
> This series adds a basic DRM driver for NVIDIA Tegra 2 processors. It
> currently only supports the RGB output and I've successfully tested it
> against the fbcon kernel module and the xf86-video-modesetting driver.
> The code uses the Tegra's IOMMU/GART to remap non-contiguous memory.
> This means that currently video memory is limited to 32 MB, the size of
> the GART aperture.
>=20
> Changes in v2:
> - split into several smaller source files
> - represent individual devices in DT
> - add drivers for individual devices
> - EDID probing support via "ddc" property
> - EDID support in DT using binary blobs
> - basic (non-working) HDMI support
> - support for carveout memory in DT
>=20
> A lot of the above are really just stub implementations. Most notably
> HDMI support is pretty much a copy of what NVIDIA has in their
> downstream kernels, though I wasn't able to make it work except for the
> EDID probing (I probably missed some pieces). Carveout memory also isn't
> used right now.
>=20
> Still this should now be in a state where other people (like Jon and
> Terje from NVIDIA) and Lucas can start contributing. This series is
> based on next-20120424.

I also just finished uploading this series to gitorious:

	https://gitorious.org/thierryreding/linux/commits/tegra/drm/next

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+X7aoACgkQZ+BJyKLjJp9ZkACggwHSSACQpOGKMLpMrBhbdhlD
lN8AoIWdzcPrUZA8nBHqCsgeUB+vpkna
=bbbA
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
