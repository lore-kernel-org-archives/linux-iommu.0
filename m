From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Sun, 15 Apr 2012 10:39:05 +0200
Message-ID: <20120415083905.GA15207@avionic-0098.mockup.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <4F85C97E.50203@wwwdotorg.org>
 <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
 <4F86F97C.8010508@wwwdotorg.org>
 <20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
 <4F8753A0.6040907@wwwdotorg.org>
 <20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
 <4F887C54.6030306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F887C54.6030306-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/13/2012 03:14 AM, Thierry Reding wrote:
> > 		display-controllers =3D <&disp1 &disp2>;
> > 		outputs =3D <&lvds &hdmi &tvo &dsi>;
>=20
> I don't think you need both the child nodes and those two properties.
>=20
> In other words, I think you either want:
>=20
> 	graphics@54000000 {
> 		... a bunch of child nodes
> 	};
>=20
> or you want:
>=20
> 	disp1 : dc@54200000 {
> 		...
> 	};
> 	disp2 : dc@54240000 {
> 		...
> 	};
> 	... all the other graphics nodes
>=20
> 	graphics@54000000 {
> 		display-controllers =3D <&disp1 &disp2>;
> 		outputs =3D <&lvds &hdmi &tvo &dsi>;
> 	};
>=20
> In the former case, presumably the drivers for the child nodes would
> make some API call into the parent node and just register themselves
> directly as a certain type of driver, so avoiding the
> display-controllers/outputs properties.

I think I like the former better. The way I understand it the children of t=
he
graphics node will have to be registered explicitly by the DRM driver becau=
se
of_platform_populate() doesn't work recursively. That would ensure that the
DRM driver can setup the CRTC and output registries before the other devices
call back into the DRM to register themselves.

> > 		/* initial configuration */
> > 		configuration {
> > 			lvds {
> > 				display-controller =3D <&disp1>;
> > 				output =3D <&lvds>;
> > 			};
> >=20
> > 			hdmi {
> > 				display-controller =3D <&disp2>;
> > 				output =3D <&hdmi>;
> > 			};
> > 		};
> > 	};
> >=20
> > I added an additional node for the initial configuration so that the dr=
iver
> > knows which mapping to setup at boot.
>=20
> Isn't that kind of thing usually set up by the video=3D KMS-related kernel
> command-line option? See Documentation/fb/modedb.txt. Again here, I
> think the actual display controllers would be allocated to whichever
> outputs get used on a first-come first-serve based, so no need for the
> display-controller property above either way.

Boards should still be able to boot and display a console on the "standard"
output even if the user doesn't provide a video=3D option. Shouldn't there =
be a
way for a board DTS to specify what the default (or even allowed) connectio=
ns
are?

Evaluation hardware like the Harmony might have LVDS, HDMI and VGA connecto=
rs
to provide for a wide range of use cases. The Plutux for instance has only =
an
HDMI connector and the Medcom has only LVDS. For the Medcom it would be qui=
te
confusing for people to suddenly see an HDMI-1 connector pop up f.e. in
xrandr. It would be equally useless for the Plutux to show up as supporting
an LVDS or VGA connector.

> > What I don't quite see yet is where to
> > attach EDID data or pass the phandle to the I2C controller for DDC/EDID
> > probing.
>=20
> I think there's a third node type.
>=20
> 1) Nodes for the display controllers in Tegra (Also known as CRTCs I
> believe)
>=20
> 2) Nodes for the video outputs from the Tegra chips (what you have as
> outputs above)
>=20
> 3) Connectors, which aren't represented in your DT above yet.
>=20
> I think you need to add additional nodes for (3). These are where you'd
> represent all the EDID/I2C/... stuff. Then, the nodes for the outputs
> will point at the nodes for the connectors using phandles, or vice-versa.

I see. Maybe this could be used for board-specific configuration? For
example, the Plutux could have something like this:

	connectors {
		hdmi {
			output =3D <&hdmi>;
			ddc =3D <&i2c2>;
		};
	};

The Medcom could have:

	connectors {
		lvds {
			output =3D <&lvds>;
			edid =3D <&edid>;
		};
	};

While Harmony could be more generic and provide more outputs:

	connectors {
		lvds {
			output =3D <&lvds>;
			ddc =3D <&i2c1>;
		};

		vga {
			/* which output is used for VGA? */
			output =3D <...>;
			ddc =3D <&i2c2>;

		hdmi {
			output =3D <&hdmi>;
			ddc =3D <&i2c3>;
		};
	};

Has there been any discussion as to how EDID data would best be represented
in DT? Should it just be a binary blob or rather some textual representatio=
n?

> (IIRC, although I didn't look at them in detail, the sdrm patches
> recently mentioned something about splitting up the various object types
> in DRM and allowing them to be represented separately, and I vaguely
> recall something along the lines of the types I mention above. I might
> expect to have a 1:1 mapping between the DRM object types and DT nodes.)

I've looked at them in more detail and I'm not sure that they're very well
suited for the Tegra. I think they may be a bit too simple to support
advanced features that will be required for Tegra. For the current state it
may be enough, but people at NVIDIA and Nouveau seem to be eager to start
working on things like 2D acceleration and I wouldn't want to convert to SD=
RM
now just to convert it back when somebody needs a feature that can't be add=
ed
with SDRM.

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+KiSkACgkQZ+BJyKLjJp9gNQCglLpo9sJckugz/gqSJViFrgee
j5EAn1MatzsbEcv9vAyu6zev9bBybDIw
=QH6y
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
