From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Sat, 30 Jun 2012 20:01:44 +0200
Message-ID: <20120630180143.GA23990@avionic-0098.adnet.avionic-design.de>
References: <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<1340812795.1350.7.camel@antimon>
	<20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>
	<4FEC8B91.6010107@wwwdotorg.org> <1340903992.1348.27.camel@antimon>
	<4FEDAB9F.5040406@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9087065117799155212=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEDAB9F.5040406-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============9087065117799155212==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2012 at 04:20:31PM +0300, Terje Bergstr=C3=B6m wrote:
> On 28.06.2012 20:19, Lucas Stach wrote:
> > TTM though solves more advanced matters, like buffer synchronisation
> > between 3D and 2D block of hardware or syncing buffer access between GPU
> > and CPU.
> > One of the most interesting things of TTM is the ability to purge the
> > GPU DMA buffers to scattered sysmem or even swap them out, if they are
> > not currently used by the GPU. It then makes sure to move them in the
> > contig space again when the GPU really needs them and fix up the GPU
> > command stream with the new buffer address.
>=20
> We preferably should choose dma_buf as a common interface towards
> buffers. That way whatever we choose as the memory manager, all dma_buf
> aware drivers will be able to use buffers allocated by other drivers.
>=20
> We probably need to accommodate multiple memory managers to take care of
> legacy and new drivers. If V4L2 and DRM projects all move to dma_buf, we
> have the possibility to do zero-copy video without forcing everybody to
> use the same memory manager.

I agree. Supporting DMA BUF also doesn't seem very difficult.

> As I understand, TTM is good for platforms where we have a separate
> frame buffer memory, as is the case with most of the graphics cards. In
> Tegra, graphics and CPU occupy the same memory, so I'm not sure if we
> require the level of functionality that TTM provides. I guess the level
> of functionality and the complexity that it brings is one reason why TTM
> hasn't really caught on in the ARM world.
>=20
> The synchronization primitives attached to TTM are slightly confusing.
> At the bottom level, it's operations which need to be synchronized
> between each other. That's the API level that we should to export from
> kernel to user space. It's then up to libdrm level (or whatever is doing
> the rendering in user space) to decide which operations it wants to have
> completed before a buffer can be reused/read/passed on to the next stage.
>=20
> Anyway, if we hide the memory manager behind dma_buf, we're free to muck
> around with multiple of them and see what works best.

Exactly. Other subthreads echo this as well. Using CMA seems the easiest
and most flexible for now but still covers everything we need. If it
turns out that it isn't suited for more advanced stuff once we start
supporting 3D then we can still opt for something like TTM.

Thierry

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP7z8HAAoJEN0jrNd/PrOhRGUP/1p3W4wboBdnVmN+sieGPkPB
uOMhHwM+bJsgdU8jF/aEifT5YayEki0RTHVz6Ulq1LQwgtKS1VHdLF6Gn6E6FPvo
TtNyq+4tZhlW9hyCU9sM7v/WHBbqVIkdLm4ngXWSUwiuWTfsFqrkYBKt0ENG40Ao
inlCgSsQ58REk8dl/nZcUYZgX0QrA0Bqqq5LSl1D/83HyX6/7sUcF3thdS7cri8S
lQ6zdA9ztZRVh2YKpNXCYZ3u+fASWHQ1XkNQqUMSaQXmkW8PPO+GTuu98yI7M/Il
orirwS/jm9Ck9gudIyH0vLy5OVOFRmF/jxIf2Ri98NzmL1BZmAdGk/8rJwsKwCBU
z+wsZen/n2MGKruQTN8jDiNAT0BB158m2hQFaJbt/WZbGoS3ECrxWldaebDSl8Ya
b4XLtNAJaFsDQElgdHJaJ1r5xeitFM5JqbWcfa6bUb3lDV3GejoeZDADV6kdv7h5
D0CR8VrPnLBQyhicnC3kOagIa3/AYgq6+bIZpBXYfKZ9PAXwYI0e68Ck3a8ZiK7q
yfJke+dVaM/N7IldvJtlIViTpG9yvHh5g+6glz6lFnaStUXfiIgM7Emz91H4mk6K
cwogcXTiWZNGO/S4AG9af4fE9Gh+wlwkC8ArMUPUPrJeGZKCiQN2xuB1NlKTqGft
JE3JcVL1JNLeaOOmdFq6
=QaLJ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============9087065117799155212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9087065117799155212==--
