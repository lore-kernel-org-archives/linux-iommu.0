From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Tue, 14 Oct 2014 15:37:59 +0200
Message-ID: <20141014133757.GA2217@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<3765297.6j3Rv68iqn@wuerfel> <2650492.UcyhNye0aG@avalon>
	<4378271.6Q6s1JjOus@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3383736158745562627=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4378271.6Q6s1JjOus@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3383736158745562627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 03:20:46PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 October 2014 16:07:38 Laurent Pinchart wrote:
> > On Tuesday 23 September 2014 09:44:25 Arnd Bergmann wrote:
> > > On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
> > > > > I see two problems with using deferred probing here:
> > > > >=20
> > > > > - we don't actually need to defer the probing but the binding to =
the
> > > > >   driver when no dma ops are set, but it seems silly to even crea=
te the
> > > > >   device before we can find out which ops it should use.
> > > >=20
> > > > What does device creation have to do with anything? Surely a device
> > > > won't need IOMMU services before the device is bound to a driver.
> > >=20
> > > The problem is that the driver will start using the IOMMU as soon
> > > as it calls dma_map_*, but that happens at runtime, not necessarily
> > > during the probe function.
> > >=20
> > > So we can get into the weird situation that probe() returns success,
> > > but then you can't use the device yet because you don't know whether
> > > it is supposed to use an IOMMU or not.
> >=20
> > If we want IOMMU devices to be supported by common device drivers we ne=
ed to=20
> > defer probing of the master devices, there's no doubt about that. Earli=
er=20
> > approaches that hooked up into the device core code were rejected, but =
it=20
> > should be possible to use bus notifiers to achieve the same result (wit=
h the=20
> > drawback of having to register one notifier per bus). The=20
> > BUS_NOTIFY_BIND_DRIVER notifier can then just return -EPROBE_DEFER when=
 a=20
> > iommus property is available and points to an IOMMU not registered yet.=
 I'm=20
> > not saying we have to do this, but I believe that at least from a techn=
ical=20
> > point of view it could be done.
>=20
> I think that fundamentally speaking, relying on notifiers for something l=
ike
> this is very problematic, both in terms of maintainability and reliabilit=
y.
> We should really try to get the notifiers out of the iommu handling, not =
put
> more of them in.

Agreed. Also last time I checked the driver core simply ignored the
return value from notifiers, therefore this wouldn't work without
changing the core either.

Still, I agree with Laurent that we really should be relying on probe
deferral for probe ordering. And while it's true that earlier attempts
to put this into the core were rejected, I think there's still value in
proposing it again. The alternative proposed here is similarly close to
the core and needs to duplicated for every architecture. That itself is
to me a strong indication that this really does belong in the core.

I think initially this was proposed to become part of really_probe() and
I still think that's where it belongs. There's precedent for it with the
pinctrl_bind_pins() call, though it seems like Greg regrets allowing
that into the core. Perhaps if really_probe() is "too core", then
platform_drv_probe() would be a better candidate?

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUPSc1AAoJEN0jrNd/PrOhI1QP/jHFPIy43sF9c8M97Q15Emlj
GlsIzTg3x0yJaAGov/ckioorSvhj2AhSaF1NukzcAF5i9G38yWV9DbuL3L05kxmh
vu2nbDBt4uIxFjVHnzHWprXm0aZdIMmS76EWO6VtiK1CJt4zSLzkrYfV0IoYamyH
+ogKlBhE+2fB/+3W1WhVjXVR126S6+G1lLz/yzLXF+1rwm4iwsLHdCGuA/HQWGyr
NuSv+DYORBoiJygIsT4bVM9u0dxt7mXfDOAyZtSdWV00pdqdAuN/BkU3vG7BoG/h
/TZVnywHtFOYZt8PweNCmY8vBGSZ+xeDW3vkIHSwsmRmrWS37uEJZbbb+FyFzZKi
EK8EWFH0DwN/W9itUJ8jFbNDDbEeCfQtrrEfXfssa6DPnqRcLb3N0jCNV9iIT4ud
F66RED0Xelx0OycsOizCHiQCLlszjtYttcfrFuoT36yV46yXEpVABhgejgyh+U5y
ZY+etzvaiO3OqPn9SpfdfnqBzfRSpXyiy2t+rz1hQNEDQeslgm9R16yTLvY4j0Lp
NRsSDhslRb8plJbAIkwW+Fvh2HlehxaSgkCLja70/382JR4LSbdlrmZsEqbHAWEm
D6cTdB3uNcgXWytnlmQIaQYeiEyurhmnjQvTyDTj+7LOe7zY9txgJ8wpwBpWE+K0
JypfD45N9mAm/j6FPLHT
=9Rg2
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

--===============3383736158745562627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3383736158745562627==--
