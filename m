From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Tue, 26 Jun 2012 16:00:33 +0200
Message-ID: <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
 <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120626160224.40ba10a26e3dd3a56b1f312c-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 04:02:24PM +0300, Hiroshi Doyu wrote:
> Hi Thierry,
>=20
> On Tue, 26 Jun 2012 12:55:13 +0200
> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
>=20
> > * PGP Signed by an unknown key
> >=20
> > Hi,
> >=20
> > while I haven't got much time to work on the actual code right now, I
> > think it might still be useful if we could get the device tree binding
> > to a point where everybody is happy with it. That'll also save me some
> > time once I get to writing the code because I won't have to redo it over
> > again. =3D)
> >=20
> > So here's the current proposal:
> >=20
> > 	host1x {
> > 		compatible =3D "nvidia,tegra20-host1x", "simple-bus";
> > 		reg =3D <0x50000000 0x00024000>;
> > 		interrupts =3D <0 64 0x04   /* cop syncpt */
> > 			      0 65 0x04   /* mpcore syncpt */
> > 			      0 66 0x04   /* cop general */
> > 			      0 67 0x04>; /* mpcore general */
> >=20
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> >=20
> > 		ranges =3D <0x54000000 0x54000000 0x04000000>;
> >=20
> > 		status =3D "disabled";
> >=20
> > 		gart =3D <&gart>;
> ...
> > output and hooks up a static EDID block with the LVDS output. There is
> > also a carveout property which might be a better replacement for the
> > "crippled" GART on Tegra20. Alternatively the CMA might work just as
> > well instead.
> >=20
> > The Plutux can be described like this:
> >=20
> > 	host1x {
> > 		carveout =3D <0x0e000000 0x02000000>;
>=20
> As discussed in the following ML thread previously, the necessary info
> related to the "gart" would be got from the standard IOMMU API(or
> something above layers, DMABUF or TTM?). So I don't think that we need
> to refer to "gart" and "carveout" here in the end.
>=20
> http://lists.linuxfoundation.org/pipermail/iommu/2012-June/004266.html

Yes, if IOMMU or some layer above can provide the same information, then
that is certainly better than explicitly referencing it in the DT.

I'm not sure I understand how information about the carveout would be
obtained from the IOMMU API, though.

Thierry

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6cCBAAoJEN0jrNd/PrOh61UP/35MXxx9f6Xmd8osMBM6gfP9
j6v6A3W2HbyD1AF4AamHiuqvSPX+QGltd9njImljyuqTumu98itojicu0YKYF3hp
d7+olhzhwFegVdk8W7Fs06OvhEg+KQmCMvOTnIvMoG8HfJRJXo5qlTOpTZVQ1MuS
X56OaAOZOcch6rmmyTEy/aQL3E32ZJtHbwvRFlNuWeOhLn/Lp3HkeFCDclxN238n
a+sQ5jLgisgVdmFQ1rgnO0z1ZT/7JrinXU17MHX42daNLRnOEioFGHvMRyGSmEp9
PZ2rCSUAryDx6L/iZDf6Wif0bLf3acMI7hi2MhD1tKB8PenluYyUnlzMfoEusgzt
EVudoJ92bKtxlDE4/E4Zb9Us1IK1Xx2fiEDAj5WUwzsBKk0GwTedG4c6sx8DKYfT
ahQgj9wdUkbHJxrzCFNPbK6MRSQGJHrc+87aaScUIsIylFIBOS/ipWfT3Sh3z+CS
uzu3bikqszgpeaZuoBp3yS2gHh34pauQTx1PLFcLSyXu6AM2V2Lpp2qXGcmfWZM/
+MDaKSjLA+YjXEa34nspKO7MQ7ivDCL12n5Gp/uym00qED9SFEsfrMdU/FSL4SyI
+cXK7/QTs+zCiOndyoVEotneNVPboTSc4PxCcWOR1aPLP76hesl7yNDuVi7I0Wwn
T8/Hh5YAAxIX0soMtXew
=Lk0D
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
