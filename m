From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 11:33:01 +0200
Message-ID: <20120412093301.GB23336@avionic-0098.mockup.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412092106.GU3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8054262657807754720=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120412092106.GU3852-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8054262657807754720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Sascha Hauer wrote:
> You might want to have a look at the sdrm patches I recently posted to
> dri-devel and arm Linux Kernel. Among other things they allow to
> register crtcs/connectors/encoders seperately so that each of them can
> have its own representation in the devicetree. I haven't looked into
> devicetree support for DRM, but with or without devicetree the problem
> that we do not have a single PCI card for registering all DRM components
> is the same.

I'll do that. One interesting use-case that's been on my mind for some time
is if it would be possible to provide a CRTC via DRM that isn't part of the
SoC or DRM "device" but which can display a framebuffer prepared by the DRM
framework.

In other words I would like to use the Tegra hardware to render content into
a framebuffer (using potentially the 3D engine or HW accelerated video
decoding blocks) but display that framebuffer with a CRTC registered by a
different driver (perhaps provided by a PCIe or USB device).

I think such a setup would be possible if the CRTC registration can be
decoupled from the DRM driver. Perhaps sdrm even supports that already?

Thierry

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+GoUwACgkQZ+BJyKLjJp96wQCeOgh2gZUmQUL1oddfmrCLpejW
nEUAn2upj9yAZjEmbirx6hhSnd3+6l9r
=8elq
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

--===============8054262657807754720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8054262657807754720==--
