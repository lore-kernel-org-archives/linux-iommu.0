From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Mon, 16 Apr 2012 20:48:19 +0200
Message-ID: <20120416184819.GA21043@avionic-0098.mockup.avionic-design.de>
References: <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <4F85C97E.50203@wwwdotorg.org>
 <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
 <4F86F97C.8010508@wwwdotorg.org>
 <20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
 <4F8753A0.6040907@wwwdotorg.org>
 <20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
 <4F887C54.6030306@wwwdotorg.org>
 <20120415083905.GA15207@avionic-0098.mockup.avionic-design.de>
 <4F8C423B.8050609@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F8C423B.8050609-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/15/2012 02:39 AM, Thierry Reding wrote:
> > I think I like the former better. The way I understand it the children =
of the
> > graphics node will have to be registered explicitly by the DRM driver b=
ecause
> > of_platform_populate() doesn't work recursively. That would ensure that=
 the
> > DRM driver can setup the CRTC and output registries before the other de=
vices
> > call back into the DRM to register themselves.
>=20
> Yes, with the first way, the DRM driver will have to call
> of_platform_populate() recursively to make this work.
>=20
> The thing here is that the device tree should model hardware, not be
> designed purely to match the device registration needs of the DRM
> driver. I'm not sure that it's correct to model all those devices as
> children of the top-level graphics object; I /think/ all the devices are
> flat on a single bus, and hence not children of each-other. That all
> said, I guess having the nodes as children isn't too far off how the HW
> is designed (even if the register accesses aren't on a child bus, the
> modules at least logically are grouped together in an umbrella
> situation), so I wouldn't push back on the first option above that you
> prefer.

After trying to implement this I'm not so sure anymore that this is the best
approach. I think I'll have to play around with this some more to see what
fits best.

> > Boards should still be able to boot and display a console on the "stand=
ard"
> > output even if the user doesn't provide a video=3D option. Shouldn't th=
ere be a
> > way for a board DTS to specify what the default (or even allowed) conne=
ctions
> > are?
>=20
> Why wouldn't the default be to light up all outputs that have an
> attached display, or an algorithm something like:
>=20
> * If internal LCD is present, use that
> * Else, if HDMI display plugged in, use that
> ...

That sounds doable.

> > Evaluation hardware like the Harmony might have LVDS, HDMI and VGA conn=
ectors
> > to provide for a wide range of use cases. The Plutux for instance has o=
nly an
> > HDMI connector and the Medcom has only LVDS. For the Medcom it would be=
 quite
> > confusing for people to suddenly see an HDMI-1 connector pop up f.e. in
> > xrandr. It would be equally useless for the Plutux to show up as suppor=
ting
> > an LVDS or VGA connector.
>=20
> So the device tree for those devices would disable (or not include) the
> connectors that were not present on the board.

Okay, makes sense.

> > Has there been any discussion as to how EDID data would best be represe=
nted
> > in DT? Should it just be a binary blob or rather some textual represent=
ation?
>=20
> I think a binary blob makes sense - that's the exact same format it'd
> have if read over the DDC I2C bus.

DTC has /incbin/ for that. Is arch/arm/boot/dts still the correct place for
EDID blobs? I could add tegra-medcom.edid if that's okay.

Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+MaXMACgkQZ+BJyKLjJp9k0wCgq32QdsTzWNh5jq8omXbMqH+J
lQAAnA6oyCCIGHzWzp9Mt9o9xxSZQkjO
=daNL
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
