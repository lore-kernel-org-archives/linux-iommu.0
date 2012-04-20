From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Fri, 20 Apr 2012 07:02:31 +0200
Message-ID: <20120420050231.GA15313@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<20120419173537.GA7692@avionic-0098.adnet.avionic-design.de>
	<CAPM=9tzK83yYS33eNruvFDwb62ycZxJMC31davVRN=yaZD53YA@mail.gmail.com>
	<20120419204016.GA8954@avionic-0098.mockup.avionic-design.de>
	<4F907CBB.4080705@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2483856366916987309=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F907CBB.4080705-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2483856366916987309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jon Mayo wrote:
> On 04/19/2012 01:40 PM, Thierry Reding wrote:
[...]
> >So would it be possible to get a basic dumb KMS driver into mainline
> >(non-staging) and phase in acceleration later on, with ABI guarantees? I
> >guess development can go on in separate trees until the ABI is stable an=
d can
> >subsequently be ported to the mainline driver.
> >
> >Is that an acceptable approach?
>=20
> That certainly seems like the most reasonable approach to me. Get
> KMS only in first. It's a useful driver as-is, and has the lowest
> barrier to entry into upstream.
>=20
> Then later we can phase in enhancements. We certainly have plenty of
> places internally and externally to hash out acceleration
> interfaces, and come to some consensus at at later date (either on
> linux-tegra or direct email).

Okay. Let's do that then.

> We have a lot of concerns here. What is best for X11, what is best
> for Android, how do we keep healthy open source implementations, and
> how does NVIDIA move forward with supporting new Tegra on an open
> source implementation.

I think by supporting the DRM we can get pretty far for X11. Writing a Tegr=
a-
specific driver based off xf86-video-modesetting can be done to use advanced
features if they can't be abstracted away properly. DRM also paves the way
for Wayland support.

What I see as somewhat of a problem is how to get NVIDIA and the community =
to
work together (and work together well). We'll have to see how this works ou=
t,
but I'd hate to see more resources wasted because everybody starts doing
their own thing.

> (My vote is NVIDIA starts using this DRM in-house and builds new
> extensions on top of it, sharing patches on LKML when the hardware is
> released)

That sounds like a good plan. Ideally you should even share the patches as
soon as they're ready. That'll give viewers some head start and you can fix
the code even before the hardware is released.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+Q7ecACgkQZ+BJyKLjJp+yGACfc+pluzXF7/marg7P8YedrlLy
8dYAoKyn3JAVq0J8aU+uNfYhS0hEqQO0
=xOfu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============2483856366916987309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2483856366916987309==--
