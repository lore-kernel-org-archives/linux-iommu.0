From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 07:52:24 +0200
Message-ID: <20120627055224.GA8470@avionic-0098.adnet.avionic-design.de>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
	<20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	<23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	<4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2598876119013372781=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEA7472.7050201-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2598876119013372781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> On 06/26/2012 08:32 PM, Mark Zhang wrote:
> >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> >> ...
> >>>> I'm not sure I understand how information about the carveout would be
> >>>> obtained from the IOMMU API, though.
> >>>
> >>> I think that can be similar with current gart implementation. Define =
carveout as:
> >>>
> >>> carveout {
> >>>         compatible =3D "nvidia,tegra20-carveout";
> >>>         size =3D <0x10000000>;
> >>> };
> >>>
> >>> Then create a file such like "tegra-carveout.c" to get these definiti=
ons and
> >> register itself as platform device's iommu instance.
> >>
> >> The carveout isn't a HW object, so it doesn't seem appropriate to defi=
ne a DT
> >> node to represent it.
> >=20
> > Yes. But I think it's better to export the size of carveout as a config=
urable item.
> > So we need to define this somewhere. How about define carveout as a pro=
perty of gart?
>=20
> There already exists a way of preventing Linux from using certain chunks
> of memory; the /memreserve/ syntax. From a brief look at the dtc source,
> it looks like /memreserve/ entries can have labels, which implies that a
> property in the GART node could refer to the /memreserve/ entry by
> phandle in order to know what memory regions to use.

That doesn't work, unfortunately. The /memreserve/ label isn't even
stored in the DTB. Even DTC throws an error when you try to reference
the /memreserve/ by label.

Thierry

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6p+YAAoJEN0jrNd/PrOhtigP/jdZ/e50hngj4djJNp3ZjUc8
IVv9j5TQiSWJ3SgI05lGAvu6NBtHiRQl+SHjNzOAgvTVWYjNXrooDdkEEWakNvHr
C77mN5dqH5XasdoPh2YwVKuJbahyvkwmhPoB3NP2WiRL+DVbU8zEmHsQvp3Njqkf
ixLbfkP/AidOb1s0TOjRkS97JWb9Is8UMBLpKg6zwKmy6oQ9mlcG0cKq1E06WUnG
Y97F50pJPysr5k+g+7U075k6cSdxd/IMONMdFN3Y9CRFrCZpHhkVtZlPNu8eX5+d
up+6uWv7Usa5tsnOaSv4pK4+rAXnZZMdfCXjdHosalJ3it/nqFt+1mVyc3fBRFwT
NMAP01D11iQvMgXh/EXgQai4EmaeIkiVeMiWTBRm1jldfdjb0pwbjoSciIOgiP/0
WjRKLwpIk8GahhQtB78RMLvfD2ZiGkqAdRnF4mBEQOK44VX1X9/i/b9hCf5cj7hL
ozdJBnMWpRJmbD9zukZk4V6Ro5gi6+iOUtfCueW+0DHpSlhSxHWKQZ3C5C9ILLHT
UyLwgcwdhqsgg4lWpk6z0ty9YioNT/wgwli2rY2UlhlfW+VMqZUJbsE0erh3xd9C
erV54qzBSJHp5b0XxYq9zacHLaiIR/b1KyhykSJ6Z0X2y6QjJPZsToN9zmGStVrq
NsLPBrtEVnKCc9LcGdaB
=kSpE
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--===============2598876119013372781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2598876119013372781==--
