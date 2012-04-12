From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 08:50:38 +0200
Message-ID: <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3950159397233427918=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F85C97E.50203-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3950159397233427918==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/11/2012 06:10 AM, Thierry Reding wrote:
> > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> > currently has rudimentary GEM support and can run a console on the
> > framebuffer as well as X using the xf86-video-modesetting driver.
> > Only the RGB output is supported. Quite a lot of things still need
> > to be worked out and there is a lot of room for cleanup.
>=20
> I'll let Jon Mayo comment on the actual driver implementation, since
> he's a lot more familiar with Tegra's display hardware. However, I have
> some general comments below.
>=20
> >  .../devicetree/bindings/gpu/drm/tegra.txt          |   24 +
> >  arch/arm/mach-tegra/board-dt-tegra20.c             |    3 +
> >  arch/arm/mach-tegra/tegra2_clocks.c                |    8 +-
> >  drivers/gpu/drm/Kconfig                            |    2 +
> >  drivers/gpu/drm/Makefile                           |    1 +
> >  drivers/gpu/drm/tegra/Kconfig                      |   10 +
> >  drivers/gpu/drm/tegra/Makefile                     |    5 +
> >  drivers/gpu/drm/tegra/tegra_drv.c                  | 2241 ++++++++++++=
++++++++
> >  drivers/gpu/drm/tegra/tegra_drv.h                  |  184 ++
> >  include/drm/tegra_drm.h                            |   44 +
>=20
> Splitting this patch into two, between arch/arm and drivers/gpu would be
> a good idea.

I can certainly do that.

> > diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Docu=
mentation/devicetree/bindings/gpu/drm/tegra.txt
>=20
> > +	drm@54200000 {
> > +		compatible =3D "nvidia,tegra20-drm";
>=20
> This doesn't seem right; there isn't a "DRM" hardware module on Tegra,
> since "DRM" is a Linux/software-specific term.
>=20
> I'd at least expect to see this compatible flag be renamed to something
> more like "nvidia,tegra20-dc" (dc=3D=3Ddisplay controller).
>=20
> Since Tegra has two display controller modules (I believe identical?),
> and numerous other independent(?) blocks, I'd expect to see multiple
> nodes in device tree, one per hardware block, such that each block gets
> its own device and driver. That said, I'm not familiar enough with
> Tegra's display and graphics HW to know if this makes sense. Jon, what's
> your take here? The clock change below, and in particular the original
> code there that we use downstream, lends weight to my argument.
>=20
> > +		reg =3D < 0x54200000 0x00040000    /* display A */
> > +		        0x54240000 0x00040000    /* display B */
> > +		        0x58000000 0x02000000 >; /* GART aperture */
> > +		interrupts =3D < 0 73 0x04    /* display A */
> > +		               0 74 0x04 >; /* display B */
> > +
> > +		lvds {
> > +			type =3D "rgb";
>=20
> These sub-nodes probably want a "compatible" property rather than a
> "type" property.

"compatible" suggests that a driver would bind to it. However the data real=
ly
is only passed to the DC driver for configuration.

> > +			size =3D <345 194>;
> > +
> > +			default-mode {
> > +				pixel-clock =3D <61715000>;
> > +				vertical-refresh =3D <50>;
> > +				resolution =3D <1366 768>;
> > +				bits-per-pixel =3D <16>;
> > +				horizontal-timings =3D <4 136 2 36>;
> > +				vertical-timings =3D <2 4 21 10>;
> > +			};
> > +		};
>=20
> I imagine that quite a bit of thought needs to be put into the output
> part of the binding in order to:
>=20
> * Model the outputs/connectors separately from display controllers.
> * Make sure that the basic infra-structure for representing an output is
> general enough to be extensible to all the kinds of outputs we support,
> not just the LVDS output.

I haven't played around with HDMI at all yet, so I don't know of the
requirements. I'm pretty sure the above isn't anywhere near complete
though.

> * We were wondering about putting an EDID into the DT to represent the
> display modes, so that all outputs had EDIDs rather than "real" monitors
> having EDIDs, and fixed internal displays having some other
> representation of capabilities.

That's an interesting approach. I like it.

> I'm hoping that Jon will drive this.
>=20
> > diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/=
tegra2_clocks.c
>=20
> > -	PERIPH_CLK("disp1",	"tegradc.0",		NULL,	27,	0x138,	600000000, mux_pll=
p_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> > -	PERIPH_CLK("disp2",	"tegradc.1",		NULL,	26,	0x13c,	600000000, mux_pll=
p_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> > +	PERIPH_CLK("disp1",	"tegra-drm",		NULL,	27,	0x138,	600000000, mux_pll=
p_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
> > +	PERIPH_CLK("disp2",	"tegra-drm",		NULL,	26,	0x13c,	600000000, mux_pll=
p_plld_pllc_clkm,	MUX), /* scales with voltage and process_id */
>=20
> This doesn't seem right, and couples back to my assertion above that the
> two display controller modules probably deserve separate device objects,
> named e.g. tegradc.*.

I think I understand where you're going with this. Does the following look
more correct?

	disp1 : dc@54200000 {
		compatible =3D "nvidia,tegra20-dc";
		reg =3D <0x54200000, 0x00040000>;
		interrupts =3D <0 73 0x04>;
	};

	disp2 : dc@54240000 {
		compatible =3D "nvidia,tegra20-dc";
		reg =3D <0x54240000, 0x00040000>;
		interrupts =3D <0 74 0x04>;
	};

	drm {
		compatible =3D "nvidia,tegra20-drm";

		lvds {
			compatible =3D "...";
			dc =3D <&disp1>;
		};

		hdmi {
			compatible =3D "...";
			dc =3D <&disp2>;
		};
	};

> > +static int tegra_drm_parse_dt_mode(struct device *dev,
> ...
> > +	err =3D of_property_read_u32(node, "pixel-clock", &value);
> > +	if (err < 0)
> > +		return err;
>=20
> Is it useful to call dev_err() when the DT is present but can't be
> parsed, to give some clue what the problem is?

Yes, that might be a good idea.

> > +static int tegra_drm_parse_dt(struct platform_device *pdev)
> > +{
> ...
> > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> ...
> > +	dev->platform_data =3D pdata;
>=20
> I don't think you should assign to dev->platform_data. If you do, then I
> think the following could happen:
>=20
> * During first probe, the assignment above happens
> * Module is removed, hence device removed, hence dev->platform_data
> freed, but not zero'd out

Actually the code does zero out platform_data in tegra_drm_remove(). In fact
I did test module unloading and reloading and it works properly. But it
should probably be zeroed in case drm_platform_init() fails as well.

> * Module is re-inserted, finds that dev->platform_data!=3DNULL and
> proceeds to use it.
>=20
> Instead, the active platform data should probably be stored in a
> tegra_drm struct that's stored in the dev's private data.
> tegra_drm_probe() might then look more like:
>=20
> struct tegra_drm *tdev;
>=20
> tdev =3D devm_kzalloc();
> tdev->pdata =3D pdev->dev.platform_data;
> if (!tdev->pdata)
>     tdev->pdata =3D tegra_drm_parse_dt();
> if (!tdev->pdata)
>     return -EINVAL;
>=20
> dev_set_drvdata(dev, tdev);
>=20
> This is safe, since probe() will never assume that dev_get_drvdata()
> might contain something valid before probe() sets it.

I prefer my approach over storing the data in an extra field because the
device platform_data field is where everybody would expect it. Furthermore
this wouldn't be relevant if we decided not to support non-DT setups.

Thierry

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+Gez4ACgkQZ+BJyKLjJp/ozgCgjuqxTaZZTT4oQVVSmnCSZSyy
7EAAnRFMRrOt9pz8FOewsrGCQZ2ZT1GZ
=ljHO
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

--===============3950159397233427918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3950159397233427918==--
