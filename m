From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 18:32:23 +0200
Message-ID: <20120412163223.GA10042@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412092106.GU3852@pengutronix.de>
	<20120412093301.GB23336@avionic-0098.mockup.avionic-design.de>
	<CADnq5_Oiez8zAHqFw-_qXk=3PnnEqgm3ir9M3KsWaQr-dLS5pw@mail.gmail.com>
	<20120412132531.GC5353@avionic-0098.adnet.avionic-design.de>
	<CADnq5_P-iGtCxtW+1Y2N34Q6WA5dUUC7ZxZNT29BXTAV0+VfpQ@mail.gmail.com>
	<CADnq5_OLaKPLktd8DkQvwrmZPpaQP4zA1a4+742mQCGvRXfD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2296385221642195643=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CADnq5_OLaKPLktd8DkQvwrmZPpaQP4zA1a4+742mQCGvRXfD7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============2296385221642195643==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alex Deucher wrote:
> On Thu, Apr 12, 2012 at 10:09 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> > On Thu, Apr 12, 2012 at 9:25 AM, Thierry Reding
> >> Then again, having user-space control this may be more flexible. Perfo=
rmance-
> >> wise both should be about the same, right? What I don't quite understa=
nd yet
> >> is how the DMABUF would be synchronized on both ends. Is there some in=
fra-
> >> structure to account for it or would I have to export two buffers and =
flip
> >> them during the vblank of the "consumer"?
> >
> > Performance should be about the same. =C2=A0The tricky part is
> > synchronization. =C2=A0dma_buf is for sharing. =C2=A0There are ideas to=
 make
> > generic sync objects, but for now, it's up to the userspace components
> > to handle it.
>=20
> Some example code:
> http://lists.freedesktop.org/archives/dri-devel/2012-April/021182.html

I saw that post too and it looks really nice. From what you're saying there
really doesn't seem to be any advantage to making the connection in the DRM
framework. Using DRM PRIME seems like a promising option and it seems to ha=
ve
quite a lot of momentum. Of course I'll need to get the DRM driver up and
running properly first.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+HA5cACgkQZ+BJyKLjJp+wxwCffPXyjC4hoz/eKdQ39U6376hF
LbYAoIYrCMop3Tfc5/RdDb5n3TTr72Jn
=IdLc
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============2296385221642195643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2296385221642195643==--
