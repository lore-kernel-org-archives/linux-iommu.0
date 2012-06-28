From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 13:58:43 +0200
Message-ID: <20120628115843.GD15137@avionic-0098.mockup.avionic-design.de>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
	<20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	<20120627154400.d9d7db67128404079d98ab39@nvidia.com>
	<4FEB4AC6.2060909@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8983684205935869069=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEB4AC6.2060909-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8983684205935869069==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 12:02:46PM -0600, Stephen Warren wrote:
> On 06/27/2012 06:44 AM, Hiroshi Doyu wrote:
> ...
> > I think that there are 2 cases:
> >=20
> >   (1) discontiguous memory with IOMMU
> >   (2) contiguous memory without IOMMU(called "carveout" in general?)
> ...
> > For (2), although memory is mostly anonymous one, we may need to know
> > how much to allocate, where we only need "size". This size is not from
> > h/w feature, but it depends on the system load/usage. So I think that
> > this size can be passed from kernel command line? For exmaple, we can
> > specify how much contiguous memory is necessary with putting
> > "coherent_pool=3D??M" in the kernel command line as below:
> >=20
> > 	coherent_pool=3Dnn[KMG]	[ARM,KNL]
> > 			Sets the size of memory pool for coherent, atomic dma
> > 			allocations.
>=20
> I guess if that's the standard way of initializing CMA, then that's fine.
>=20
> It'd be nice if there was a way to specify that from the DT too; that
> way the user/distro/bootloader constructing the kernel command-line
> wouldn't have to remember to add "random" (potentially
> Tegra-/board-specific) extra arguments onto the command-line; the Tegra
> command-line in the upstream kernel is quite clean right now, especially
> compare to the enormous number of options we require downstream:-(

Looking at Documentation/kernel-parameters.txt it seems the canonical
way to initialize CMA is using the "cma" kernel command-line parameter.
For device tree we could extend the "chosen" node to include something
like "carveout =3D <0x04000000>;". Or "contiguous-memory" or whatever.

Thierry

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP7EbzAAoJEN0jrNd/PrOhhCEP/1PsDueyxAmE8VmpTvD2OJsf
Q/4Db7Zq9PJi1qZDrfUzuVDCywgxZCRECsFsintsJUOT66u2YXJpfSCQbnoLP4B6
8VIVuvurj4018sf0kOKOoUblH8RRgM0Oi8BkxoB/BbLQDw/Qw9lq2xPwxR9ZbV5e
2tHuXv0/rx8rELP8XDJnsx5MWgY2wDL1Vp6fp58sOSOD3mypK5FrddeT6GlKBE9P
SWJIeW9eOiqa9QDUXanioQeFluMY1PzpLGDCJ+FaDIQgH0QttJ+Z5MMsLaWQjrC5
xaPgWiRj8OWlXwSYbO2tryK0oOJ55V8Jk8iNnCFtSYTPYDIjN8xMUFDQko9fil0d
Wy8edm/n9E7dlxCXwwEZrc/dH/7+TjuglDMwpF1KfNc3M0lrWAeggBHEON2bko62
JS+S59HRF7ZX8Q1hb1RYkDW95f6Uamtn6qyR+hU5Bn12N3Bu/PU06egCzz+/OPjQ
rrwotUTl3C/l2l/Of3ApiQyYRktnbQfpWzq7w8kyaeaG4vdhggKiv5s+DHRlSgud
YQkBLApykz1XAP6csHY/8RQyNlQsK9D1oAdaC/scjV2a8+b4QSpY/NjCzcy1+O6+
HANNTIHNxdWF9hQiH5BseC7qbXFRrcPgpEi4Y2fJmzj1l/BxefUbbHi+aGRoTPsO
45uVbSH+0K3FgNQKuJnj
=wgnG
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

--===============8983684205935869069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8983684205935869069==--
