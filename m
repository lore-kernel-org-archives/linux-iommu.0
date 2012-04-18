From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 11:26:13 +0200
Message-ID: <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
References: <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
 <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
 <201204180731.54064.arnd@arndb.de>
 <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120418.121824.1894043789811063795.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Hiroshi Doyu wrote:
> diff --git a/drivers/of/of_dma.c b/drivers/of/of_dma.c
> new file mode 100644
> index 0000000..1db1ccd
> --- /dev/null
> +++ b/drivers/of/of_dma.c
> @@ -0,0 +1,35 @@
> +/*
> + * Stealed from:

"Stolen from"

> + *	"arch/microblaze/kernel/prom_parse.c"
> + *	"arch/powerpc/kernel/prom_parse.c"
> + */
> +
> +#include <linux/of_address.h>
> +
> +void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
> +		unsigned long *busno, unsigned long *phys, unsigned long *size)
> +{
> +	const u32 *dma_window;

Should be __be32.

> +	u32 cells;
> +	const unsigned char *prop;
> +
> +	dma_window = dma_window_prop;
> +
> +	/* busno is always one cell */
> +	if (busno)
> +		*busno = *(dma_window++);

This needs endianness conversion:

	*busno = be32_to_cpup(dma_window++);

> +
> +	prop = of_get_property(dn, "#dma-address-cells", NULL);
> +	if (!prop)
> +		prop = of_get_property(dn, "#address-cells", NULL);
> +
> +	cells = prop ? *(u32 *)prop : of_n_addr_cells(dn);

Same here.

> +	*phys = of_read_number(dma_window, cells);
> +
> +	dma_window += cells;
> +
> +	prop = of_get_property(dn, "#dma-size-cells", NULL);
> +	cells = prop ? *(u32 *)prop : of_n_size_cells(dn);

And here.

Thierry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+OiLUACgkQZ+BJyKLjJp+DKwCfSNeFZjTxeSOWy+QVjEpug9HP
HqQAn1Rhf3OCI5oPtLxWVFASoPPnZphV
=WYQD
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
