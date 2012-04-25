From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC v2 2/5] tps6586x: Add device tree support
Date: Wed, 25 Apr 2012 13:14:21 +0200
Message-ID: <20120425111420.GA6029@avionic-0098.mockup.avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
	<1335347102-14905-3-git-send-email-thierry.reding@avionic-design.de>
	<20120425101031.GH3195@opensource.wolfsonmicro.com>
	<20120425101429.GA5085@avionic-0098.mockup.avionic-design.de>
	<20120425104147.GB5085@avionic-0098.mockup.avionic-design.de>
	<20120425104742.GA20492@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0161822986768355671=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120425104742.GA20492-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0161822986768355671==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> On Wed, Apr 25, 2012 at 12:41:47PM +0200, Thierry Reding wrote:
>=20
> > After taking a closer look I don't think Rhyland's patch is very useful=
 for
> > this driver. I need to lookup the platform ID by regulator name anyway =
so
> > using the new code is actually more work and requires a second table th=
at
> > lists the regulator names only.
>=20
> Why do you need the plaform ID, and if it is needed could we work out a
> way to make the generic code do that lookup for you (since presumably
> other drivers will have the same requirement)?  If you can't use the
> generic code it seems like the fix is to enhance the generic code and
> I'd expect that something not requiring the platform ID would just be
> able to igore that information if the generic code could look it up.

Basically the platform ID is used by the regulator driver to differentiate
between the different types of regulators. I could imagine a more advanced
setup to do the matching, along the lines of OF device matching and platform
device matching, where an entry in the table has both a name and an
associated "driver data" field.

For instance we could have a new structure:

	struct regulator_lookup_data {
		const char *name;
		unsigned long driver_data;
		struct regulator_init_data *init_data;
		struct device_node *of_node;
	};

	static struct regulator_lookup_data tps6586x_lookup[] =3D {
		{ .name =3D "sm0", .driver_data =3D TPS6586X_ID_SM_0 },
		{ .name =3D "sm1", .driver_data =3D TPS6586X_ID_SM_1 },
		...
	};

And pass that into of_find_regulator_init_data_from_device():

	of_find_regulator_init_data_from_device(&client->dev, regulators,
						tps6586x_lookup,
						ARRAY_SIZE(tps6586x_lookup));

Upon return, the tps6586x_lookup table will have the init_data and of_node
fields filled with the data parsed from the DT. Then we can simply iterate
over all entries and add the corresponding regulators.

This is somewhat ugly because of_find_regulator_init_data_from_device() wou=
ld
modify the same data structure for potentially different devices. This shou=
ld
be okay because the driver core takes care of serializing device probing
(unless I am mistaken). Alternatively we could make the function return a
copy of the regulator_lookup_data structure with the additional fields fill=
ed
in.

Thierry

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+X3IwACgkQZ+BJyKLjJp+3ugCfYTF4vA9I68536NFv4xhCFOsZ
GcEAoJzBZElmitki8/41ickE6tYnkjP0
=mrwT
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============0161822986768355671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0161822986768355671==--
