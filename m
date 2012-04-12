From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 19:44:29 +0200
Message-ID: <20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
	<4F86F97C.8010508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6564821225448135939=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F86F97C.8010508-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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


--===============6564821225448135939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/12/2012 12:50 AM, Thierry Reding wrote:
> > 	drm {
> > 		compatible =3D "nvidia,tegra20-drm";
>=20
> I'm don't think having an explicit "drm" node is the right approach; drm
> is after all a SW term and the DT should be describing HW. Having some
> kind of top-level node almost certainly makes sense, but naming it
> something related to "tegra display" than "drm" would be appropriate.

In this case there really isn't a HW device that can be represented. But in
the end it's still the DRM driver that needs to bind to the device. However
the other graphics devices (MPE, VI/CSI, EPP, GR2D and GR3D) probably need
to be bound against.

Would it be possible for someone at NVIDIA to provide some more details abo=
ut
what those other devices are? GR2D and GR3D seem obvious, MPE might be video
decoding, VI/CSI video input and camera interface? As to EPP I have no idea.

Maybe one solution would be to have a top-level DRM device with a register
map from 0x54000000 to 0x547fffff, which the TRM designates as "host
registers". Then subnodes could be used for the subdevices.

> > 		lvds {
> > 			compatible =3D "...";
> > 			dc =3D <&disp1>;
> > 		};
>=20
> Aren't the outputs separate HW blocks too, such that they would have
> their own compatible/reg properties and their own drivers, and be
> outside the top-level drm/display node?

The RGB output is programmed via the display controller registers. For HDMI,
TVO and DSI there are indeed separate sets of registers in addition to the
display controller's. So perhaps for those more nodes would be required:

	hdmi : hdmi@54280000 {
		compatible =3D "nvidia,tegra20-hdmi";
		reg =3D <0x54280000 0x00040000>;
	};

And hook that up with the HDMI output node of the "DRM" node:

	drm {
		hdmi {
			compatible =3D "...";
			connector =3D <&hdmi>;
			dc =3D <&disp2>;
		};
	};

Maybe with this setup we no longer need the "compatible" property since it
will already be inherent in the "connector" property. There will have to be
special handling for the RGB output, which could be the default if the
"connector" property is missing.

> I believe the mapping between the output this node represents and the
> display controller ("dc" above) that it uses is not static; the
> connectivity should be set up at runtime, and possibly dynamically
> alterable via xrandr or equivalent.

I think the mapping is always static for a given board. There is no way to
switch an HDMI port to LVDS at runtime. But maybe I misunderstand what you'=
re
saying.

> >> Instead, the active platform data should probably be stored in a
> >> tegra_drm struct that's stored in the dev's private data.
> >> tegra_drm_probe() might then look more like:
> >>
> >> struct tegra_drm *tdev;
> >>
> >> tdev =3D devm_kzalloc();
> >> tdev->pdata =3D pdev->dev.platform_data;
> >> if (!tdev->pdata)
> >>     tdev->pdata =3D tegra_drm_parse_dt();
> >> if (!tdev->pdata)
> >>     return -EINVAL;
> >>
> >> dev_set_drvdata(dev, tdev);
> >>
> >> This is safe, since probe() will never assume that dev_get_drvdata()
> >> might contain something valid before probe() sets it.
> >=20
> > I prefer my approach over storing the data in an extra field because the
> > device platform_data field is where everybody would expect it. Furtherm=
ore
> > this wouldn't be relevant if we decided not to support non-DT setups.
>=20
> Drivers are expected to use pre-existing platform data, if provided.
> This might happen in order to work around bugs in device tree content.

Okay I see. I'll have to store it in a separate field in the private
structure then.

Thierry

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+HFH0ACgkQZ+BJyKLjJp+elgCeOItcZ9Fx48IbnklsQt/rYdQV
nuEAn2W2W7D3tTWzkF4hXBFBNJ0etdYm
=D1SR
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

--===============6564821225448135939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6564821225448135939==--
