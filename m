From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Fri, 13 Apr 2012 11:14:57 +0200
Message-ID: <20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
	<4F86F97C.8010508@wwwdotorg.org>
	<20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
	<4F8753A0.6040907@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2535987165988261582=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F8753A0.6040907-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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


--===============2535987165988261582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/12/2012 11:44 AM, Thierry Reding wrote:
[...]
> And given that, I don't think we should name the node after some
> OS-specific software concept. Device tree is intended to model hardware.
[...]
> > Maybe one solution would be to have a top-level DRM device with a regis=
ter
> > map from 0x54000000 to 0x547fffff, which the TRM designates as "host
> > registers". Then subnodes could be used for the subdevices.
>=20
> Ah yes, just what I was thinking above:-)

I came up with the following:

	/* host1x */
	host1x : host1x@50000000 {
		reg =3D <0x50000000 0x00024000>;
		interrupts =3D <0 64 0x04   /* cop syncpt */
			      0 65 0x04   /* mpcore syncpt */
			      0 66 0x04   /* cop general */
			      0 67 0x04>; /* mpcore general */
	};

	/* graphics host */
	graphics@54000000 {
		compatible =3D "nvidia,tegra20-graphics";

		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges =3D <0 0x54000000 0x08000000>;

		host1x =3D <&host1x>;

		/* video-encoding/decoding */
		mpe@54040000 {
			reg =3D <0x54040000 0x00040000>;
			interrupts =3D <0 68 0x04>;
		};

		/* video input */
		vi@54080000 {
			reg =3D <0x54080000 0x00040000>;
			interrupts =3D <0 69 0x04>;
		};

		/* EPP */
		epp@540c0000 {
			reg =3D <0x540c0000 0x00040000>;
			interrupts =3D <0 70 0x04>;
		}

		/* ISP */
		isp@54100000 {
			reg =3D <0x54100000 0x00040000>;
			interrupts =3D <0 71 0x04>;
		};

		/* 2D engine */
		gr2d@54140000 {
			reg =3D <0x54140000 0x00040000>;
			interrupts =3D <0 72 0x04>;
		};

		/* 3D engine */
		gr3d@54180000 {
			reg =3D <0x54180000 0x00040000>;
		};

		/* display controllers */
		disp1 : dc@54200000 {
			compatible =3D "nvidia,tegra20-dc";
			reg =3D <0x54200000 0x00040000>;
			interrupts =3D <0 73 0x04>;
		};

		disp2 : dc@54240000 {
			compatible =3D "nvidia,tegra20-dc";
			reg =3D <0x54240000 0x00040000>;
			interrupts =3D <0 74 0x04>;
		};

		/* outputs */
		lvds : rgb {
			compatible =3D "nvidia,tegra20-rgb";
		};

		hdmi : hdmi@54280000 {
			compatible =3D "nvidia,tegra20-hdmi";
			reg =3D <0x54280000 0x00040000>;
			interrupts =3D <0 75 0x04>;
		};

		tvo : tvo@542c0000 {
			compatible =3D "nvidia,tegra20-tvo";
			reg =3D <0x542c0000 0x00040000>;
			interrupts =3D <0 76 0x04>;
		};

		dsi : dsi@54300000 {
			compatible =3D "nvidia,tegra20-dsi";
			reg =3D <0x54300000 0x00040000>;
		};

		display-controllers =3D <&disp1 &disp2>;
		outputs =3D <&lvds &hdmi &tvo &dsi>;

		/* initial configuration */
		configuration {
			lvds {
				display-controller =3D <&disp1>;
				output =3D <&lvds>;
			};

			hdmi {
				display-controller =3D <&disp2>;
				output =3D <&hdmi>;
			};
		};
	};

I added an additional node for the initial configuration so that the driver
knows which mapping to setup at boot. What I don't quite see yet is where to
attach EDID data or pass the phandle to the I2C controller for DDC/EDID
probing. The initial configuration is certainly not the right place. Perhaps
the outputs property should be made a node instead:

	outputs {
		lvds_out {
			output =3D <&lvds>;
			edid =3D <&edid>;
		};

		hdmi_out {
			output =3D <&hdmi>;
			ddc =3D <&i2c2>;
		};
	};

But then "outputs" should probably become something like "connectors"
instead and the initial configuration refers to the "_out" phandles.

Thierry

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+H7pEACgkQZ+BJyKLjJp8OBQCcCD6trEVwkhaZKuM4dqATW0i/
fkIAn3mcfAwt3BnyXdGROE9qzBjErDRS
=M+wI
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

--===============2535987165988261582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2535987165988261582==--
