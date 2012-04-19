From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Thu, 19 Apr 2012 19:35:37 +0200
Message-ID: <20120419173537.GA7692@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334146230-1795-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before posting the next round of patches I wanted to clarify whether we need
to take the Tegra driver through staging. Lucas brought this up referring to
previous experience with Nouveau where Linus used to complain that userspace
ABI was broken for non-staging drivers. I don't know how relevant that is
for Tegra. We could also keep it in drivers/gpu/drm and only add userspace
interfaces that we are sure are not going to change. Currently there isn't
isn't anything that could be easily broken as only some of the standard DRM
interfaces are supported anyway.

Alternatively we could keep the driver in a separate tree until it becomes
mature enough.

Any thoughts?

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+QTOkACgkQZ+BJyKLjJp8RqwCfagy34Wczuu+pXByuXxvkxInp
Ts0An1rDZbM40nsA5jgtdfH9X6iyH2Xw
=c02p
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
