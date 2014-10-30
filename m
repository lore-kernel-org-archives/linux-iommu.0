From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
	support
Date: Thu, 30 Oct 2014 16:32:20 +0100
Message-ID: <20141030153218.GH20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
	<1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
	<CAOesGMjMcqa_wE7rfA42QyvF7yxAkgjEN+-0UVMuErnjHr4zkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5469638582327874078=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOesGMjMcqa_wE7rfA42QyvF7yxAkgjEN+-0UVMuErnjHr4zkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5469638582327874078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 03:05:36PM -0700, Olof Johansson wrote:
> Hi,
>=20
> On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> [...]
> > diff --git a/drivers/memory/tegra/tegra-mc.c b/drivers/memory/tegra/teg=
ra-mc.c
> > new file mode 100644
> > index 000000000000..0f0c8be096d0
> > --- /dev/null
> > +++ b/drivers/memory/tegra/tegra-mc.c
> > @@ -0,0 +1,1061 @@
> > +/*
> > + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iommu.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
>=20
> You need a linux/mm.h in here (on 64-bit).

Can you show what build error this fixes? I don't see any build failures
(after fixing up the obvious ones you pointed out below).

> > diff --git a/drivers/memory/tegra/tegra124-mc.c b/drivers/memory/tegra/=
tegra124-mc.c
> > new file mode 100644
> > index 000000000000..db31c96fc288
> > --- /dev/null
> > +++ b/drivers/memory/tegra/tegra124-mc.c
>=20
> [...]
>=20
>=20
> > @@ -0,0 +1,1028 @@
> > +/*
> > + * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/mm.h>
> > +
> > +#include <asm/cacheflush.h>
> > +
> > +#include <dt-bindings/memory/tegra124-mc.h>
> > +
> > +#include "tegra-mc.h"
> > +
> > +static const struct tegra_mc_client tegra124_mc_clients[] =3D {
> > +       {
> > +               .id =3D 0x00,
> > +               .name =3D "ptcr",
> > +               .swgroup =3D TEGRA_SWGROUP_PTC,
> > +       }, {
> > +               .id =3D 0x01,
> > +               .name =3D "display0a",
> > +               .swgroup =3D TEGRA_SWGROUP_DC,
> > +               .smmu =3D {
> > +                       .reg =3D 0x228,
> > +                       .bit =3D 1,
> > +               },
> > +               .latency =3D {
> > +                       .reg =3D 0x2e8,
> > +                       .shift =3D 0,
> > +                       .mask =3D 0xff,
> > +                       .def =3D 0xc2,
> > +               },
> > +       }, {
>=20
> These are very verbose tables. Having a macro for the initializers
> could help density a lot.

I've tried to use macros here, but I find that it hurts readability:

	...
	}, {
		TEGRA_MC_CLIENT(0x01, "display0a", TEGRA_SWGROUP_DC),
		TEGRA_MC_SMMU_ENABLE(0x228, 1),
		TEGRA_MC_LATENCY(0x2e8, 0, 0xff, 0xc2),
	}, {
	...

The original is more readable because it immediately gives you the
context, whereas with the macros you need to look up what the parameters
refer to.

> > +#ifdef CONFIG_ARCH_TEGRA_132_SOC
> > +static void tegra132_flush_dcache(struct page *page, unsigned long off=
set,
> > +                                 size_t size)
> > +{
> > +       void *virt =3D page_address(page) + offset;
> > +
> > +       __flush_dcache_area(virt, size);
> > +}
> > +
> > +static const struct tegra_smmu_ops tegra132_smmu_ops =3D {
> > +       .flush_dcache =3D tegra132_flush_dcache,
> > +};
> > +
> > +static const struct tegra_smmu_soc tegra132_smmu_soc =3D {
> > +       .groups =3D tegra124_smmu_groups,
> > +       .num_groups =3D ARRAY_SIZE(tegra124_smmu_groups),
> > +       .clients =3D tegra124_mc_clients,
> > +       .num_clients =3D ARRAY_SIZE(tegra124_mc_clients),
> > +       .swgroups =3D tegra124_swgroups,
> > +       .num_swgroups =3D ARRAY_SIZE(tegra124_swgroups),
> > +       .supports_round_robin_arbitration =3D true,
> > +       .supports_request_limit =3D true,
> > +       .num_address_bits =3D 34,
> > +       .num_asids =3D 128,
> > +       .ops =3D &tegra132_smmu_ops,
> > +};
> > +
> > +const struct tegra_mc_soc tegra132_mc_soc =3D {
> > +       .clients =3D tegra124_mc_clients,
> > +       .num_clients =3D ARRAY_SIZE(tegra124_mc_clients),
> > +       .atom_size =3D 32,
> > +       .smmu =3D &tegra132_smmu_soc,
> > +};
> > +#endif /* CONFIG_ARCH_TEGRA_132_SOC */
>=20
>=20
> This won't compile -- several of the tegra132_smmu_soc members are no
> longer valid. In particular:
>=20
> groups
> num_groups

Fixed.

> supports_round_robin_arbitration
> supports_request_limit

In the version that I have these are still part of the tegra_smmu_soc
structure.

I've been thinking of extracting the Tegra132 changes into a separate
patch that can be applied once we have basic Tegra132 SoC support. It
feels wrong to merge Tegra132 SMMU support if there's no support in
arch/arm64 for the SoC yet. Though if nobody else thinks that's a
problem that's fine with me too.

Thierry

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUloCAAoJEN0jrNd/PrOhFA4P+wfsIsKsR5fYSS9v76Iav8BS
6DFLWk3ta63eSOKKtXU87gsbw/73bLIS0c4AiX01iG9Lgk5fzE0B0HHkAQGloB1W
tCHAwhUDd095R9BfK5ofPXM7jt/duBTjNoLu5xdhOZNh5VgUF/tEppSvWzztQyFz
YnKAfJcFWCm+46nasGnRi76Zh+Oatw7vZq5f5KNf6UUz0DzXBqHaV6/n4/hmgGIE
GPqdSMNTaXFHAhi17iVSALfYcZHW9T0+kj6+SteZkd5U7x94+CfFZewPtciCMAQo
GjospiBFHXcitGjjOPGZVhx4wSAxR14mA4ao//hI39GQpcmjLIvcuIU7wrapMgZs
sbj8kbj2ZRxOdIfN6bHlltNkHJyo0NVrFrXvcuAJ7V+AxIzByyLcYO4OaHUdyDZs
1C0+J12XFhTisO18KaSqjcRtkF76qcmDpEYGlOnee6D/yNksRTNFP6yk7jUgn2D7
GYwwoxyYncdDCP53St54L7GsgmBIvAJM00vfISNdxlxet4TmUafF6P5QCqjiPttM
pCdlxYbZIiidN98lvU+zOyO5zrq1KXRnZkpdkG7km9Nz0A3DEI7PSJ97dKoDAB8D
SQpX+qJBppn37gKhpb7JBa3x0iwOdArIxM3FHrWTtrWUVtdwmRAweclgqlytZbkL
FyzUJ9UbJZDmY/SUAWLM
=qr/1
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--

--===============5469638582327874078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5469638582327874078==--
