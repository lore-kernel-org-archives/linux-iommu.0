From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 15:25:31 +0200
Message-ID: <20120412132531.GC5353@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412092106.GU3852@pengutronix.de>
	<20120412093301.GB23336@avionic-0098.mockup.avionic-design.de>
	<CADnq5_Oiez8zAHqFw-_qXk=3PnnEqgm3ir9M3KsWaQr-dLS5pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8544377842281880572=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CADnq5_Oiez8zAHqFw-_qXk=3PnnEqgm3ir9M3KsWaQr-dLS5pw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8544377842281880572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alex Deucher wrote:
> On Thu, Apr 12, 2012 at 5:33 AM, Thierry Reding
> <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > In other words I would like to use the Tegra hardware to render content=
 into
> > a framebuffer (using potentially the 3D engine or HW accelerated video
> > decoding blocks) but display that framebuffer with a CRTC registered by=
 a
> > different driver (perhaps provided by a PCIe or USB device).
> >
> > I think such a setup would be possible if the CRTC registration can be
> > decoupled from the DRM driver. Perhaps sdrm even supports that already?
>=20
> You should be able to do something like that already with dma_buf and
> the drm prime infrastructure.  There's even a drm driver for the udl
> USB framebuffer devices.

Using DRM PRIME requires user-space to be involved. I was thinking more alo=
ng
the lines of allowing a dumb DRM driver that only provides a CRTC to regist=
er
with another driver so that it shows up as an output for the latter DRM
device.

Then again, having user-space control this may be more flexible. Performanc=
e-
wise both should be about the same, right? What I don't quite understand yet
is how the DMABUF would be synchronized on both ends. Is there some infra-
structure to account for it or would I have to export two buffers and flip
them during the vblank of the "consumer"?

Thierry

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+G18sACgkQZ+BJyKLjJp9yUgCfedk1cyQsdy4+JdUG6HydNLZM
oToAniSdeVK4+piE/ghRhSQNk5zgSSHP
=zPOZ
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

--===============8544377842281880572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8544377842281880572==--
