From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Mon, 21 May 2012 12:55:12 +0200
Message-ID: <20120521105512.GB27686@avionic-0098.mockup.avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
 <1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
 <4FA2F702.6040701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA2F702.6040701-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/25/2012 03:45 AM, Thierry Reding wrote:
> > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> > currently has rudimentary GEM support and can run a console on the
> > framebuffer as well as X using the xf86-video-modesetting driver. Only
> > the RGB output is supported.
> >=20
> > HDMI support was taken from NVIDIA's Linux kernel tree but it doesn't
> > quite work. EDID data can be retrieved but the output doesn't properly
> > activate the connected TV.
> >=20
> > The DSI and TVO outputs and the HOST1X driver are just stubs that setup
> > the corresponding resources but don't do anything useful yet.
>=20
> I'm mainly going to comment on the device tree bindings here; hopefully
> Jon and Terje can chime in on the code itself.
>=20
> > diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Docu=
mentation/devicetree/bindings/gpu/drm/tegra.txt
>=20
> > +Example:
> > +
> > +/memreserve/ 0x0e000000 0x02000000;
> > +
> > +...
> > +
> > +/ {
> > +	...
> > +
> > +	/* host1x */
> > +	host1x: host1x@50000000 {
> > +		compatible =3D "nvidia,tegra20-host1x";
> > +		reg =3D <0x50000000 0x00024000>;
> > +		interrupts =3D <0 64 0x04   /* cop syncpt */
> > +			      0 65 0x04   /* mpcore syncpt */
> > +			      0 66 0x04   /* cop general */
> > +			      0 67 0x04>; /* mpcore general */
> > +	};
>=20
> The host1x module is apparently a register bus, behind which all the
> other modules sit. According to the address map in the TRM, "all the
> other modules" appears to include all of MPE, VI, CSI, EPP, ISP, GR2D,
> GR3D, DISPLAY A/B, HDMI, TVO, DSI, plus VG, VS, VCI, DSIB on Tegra30.
>=20
> That said, I believe Terje wasn't convinced that all those modules are
> really host1x children, just some. Can you check please, Terje?
>=20
> Also, I wonder if host1x is really the parent of these modules,
> register-bus-access-wise, or whether the bus covers the "graphic host
> registers" at 0x50000000-0x50023fff?
>=20
> As such, I think the DT nodes for all those modules should be within the
> host1x node (or perhaps graphics host node, pending above discussion):
>=20
>     host1x: host1x@50000000 {
>         mpe@54040000 { ... };
>         vi@54080000 { ... };
>         ...
>     };
>=20
> host1x can easily instantiate all the child nodes simply by calling
> of_platform_populate() at the end of its probe; see
> sound/soc/tegra/tegra30_ahub.c for an example.

I actually had an implementation at some point that did exactly that. The
problem was that there is no equivalent to of_platform_populate() to call at
module removal, so that when the tegra-drm module was unloaded and reloaded,
it would try to create duplicate devices.

Something ugly can probably be done with device_for_each_child(), but maybe=
 a
better option would be to add a helper to the DT code to explicitly undo the
effects of of_platform_populate() (of_platform_desolate()?).

> > +	/* video-encoding/decoding */
> > +	mpe@54040000 {
> > +		reg =3D <0x54040000 0x00040000>;
> > +		interrupts =3D <0 68 0x04>;
> > +	};
>=20
> We'll probably end up needing a phandle from each of these nodes to
> host1x, and a channel ID, so the drivers for these nodes can register
> themselves with host1x. However, I it's probably OK to defer the DT
> binding for this until we actually start working on command-channels.

I suppose these should now also drop the unit addresses to follow your
cleanup patches of the DTS files.

> > +	/* graphics host */
> > +	graphics@54000000 {
> > +		compatible =3D "nvidia,tegra20-graphics";
> > +
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges;
>=20
> I don't think those 3 properties are needed, unless there are child
> nodes with registers.

Right, those are relics from the earlier version I mentioned above, where t=
he
other nodes were children of the graphics node.

> > +		display-controllers =3D <&disp1 &disp2>;
> > +		carveout =3D <0x0e000000 0x02000000>;
> > +		host1x =3D <&host1x>;
> > +		gart =3D <&gart>;
> > +
> > +		connectors {
>=20
> I'm not sure that it makes sense to put the connectors nodes underneath
> the graphics host node; the connectors aren't objects with registers
> that are accessed through a bus managed by the graphics node. Equally,
> the connectors could be useful outside of the graphics driver - e.g. the
> audio driver might need to refer to an HDMI connector.
>=20
> Instead, I'd probably put the connector nodes at the top level of the
> device tree, and have graphics contain a property that lists the
> phandles of all available connectors.

That makes a lot of sense.

> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			connector@0 {
> > +				reg =3D <0>;
> > +				edid =3D /incbin/("machine.edid");
> > +				output =3D <&lvds>;
> > +			};
>=20
> I think each of these needs some kind of compatible value to indicate
> their type. Also, the ability to represent both HDMI video and audio
> streams so that a sound card binding could use the HDMI connector too. I
> see that drivers/extcon/ has appeared recently, and I wonder if the
> connector nodes in DT shouldn't be handled by that subsystem?

I just took a brief look at it. I'll have to play around with it a bit to s=
ee
how it fits.

> > +			connector@1 {
> > +				reg =3D <1>;
> > +				output =3D <&hdmi>;
> > +				ddc =3D <&i2c2>;
> > +
> > +				hpd-gpio =3D <&gpio 111 0>; /* PN7 */
> > +			};
> > +		};
> > +	};
> > +};
>=20
> > diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-teg=
ra/board-dt-tegra20.c
>=20
> > +	{ "host1x",     "pll_c",        144000000,      true },
> > +	{ "disp1",      "pll_p",        600000000,      true },
> > +	{ "disp2",      "pll_p",        600000000,      true },
>=20
> Can we use these tables /just/ to set up the clock parent relationships,
> and rely on the drivers to enable/disable the clocks as needed? I'm
> hoping to replace these tables with DT once Tegra support common clock
> and bindings, but I don't want to see the ability to turn clocks on
> there, just set the parenting relationships, and perhaps initial rates.

I did try setting the enabled field to false, but that broke RGB output. I
didn't have much time to investigate why. Once Tegra moves to the common
clock bindings this should definitely be fixed properly.

> > diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-t=
egra/include/mach/iomap.h
> > index 7e76da7..3e80f3f 100644
> > --- a/arch/arm/mach-tegra/include/mach/iomap.h
> > +++ b/arch/arm/mach-tegra/include/mach/iomap.h
> > @@ -56,6 +56,12 @@
> >  #define TEGRA_HDMI_BASE			0x54280000
> >  #define TEGRA_HDMI_SIZE			SZ_256K
> > =20
> > +#define TEGRA_TVO_BASE			0x542c0000
> > +#define TEGRA_TVO_SIZE			SZ_256K
> > +
> > +#define TEGRA_DSI_BASE			0x54300000
> > +#define TEGRA_DSI_SIZE			SZ_256K
>=20
> Perhaps we can just hard-code the addresses into the AUXDATA in
> board-dt-tegra20.c to save defining more entries in this file. Hopefully
> this file is going away ASAP when we get rid of board files.

Okay, I can do that.

Thierry

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+6HxAACgkQZ+BJyKLjJp+iVACfWgTbiq8a9lAd8VzRaQKgKs/l
EPcAoJOBoPdJQLFDBRHwQxaTPlhaR57z
=/E9I
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
