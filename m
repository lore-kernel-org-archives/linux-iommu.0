From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Wed, 11 Apr 2012 15:35:52 +0200
Message-ID: <20120411133552.GF27337@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <20120411132548.7d738b42@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120411132548.7d738b42-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alan Cox wrote:
> On Wed, 11 Apr 2012 14:10:26 +0200
> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
>=20
> > This series adds a basic DRM driver for NVIDIA Tegra 2 processors. It
> > currently only supports the RGB output and I've successfully tested it
> > against the fbcon kernel module and the xf86-video-modesetting driver.
> > The code uses the Tegra's IOMMU/GART to remap non-contiguous memory.
> > This means that currently video memory is limited to 32 MB, the size of
> > the GART aperture.
>=20
> You should only need continguous memory with GEM for the framebuffer /
> console bits via /dev/fb. In theory the fb layer can be taught to hanndle
> non linear framebuffers but nobody has yet done so. (Now there's a GSOC
> project ... ;))
>=20
> What we do on GMA500 is to allocate the kernel framebuffer from linearly
> mapped memory but the normal GEM objects from anywhere as the GEM mapping
> into userspace will deal with presenting it to user space as a virtually
> linear buffer.

That's actually what the driver does as well. It uses the shmfs-backed memo=
ry
provided by GEM and only maps it through the GART to provide a linear view
for the display controller which cannot do scatter-gather I/O. Neither the
kernel nor the user-space mapping go through the GART.

You are right that for anything but the framebuffer objects it probably
doesn't matter. It's a little hard to tell because I don't have any
documentation for either the 2D nor 3D engines. Eventually a better option
might be to use stolen memory instead of remapping it through the GART.

Thierry

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+FiLgACgkQZ+BJyKLjJp9pbgCfQjB6FCLCA5TtN6IRDZSBpgda
CekAoKF56HCCWkhf5IERiOIiiPfyUZ3K
=uwHV
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
