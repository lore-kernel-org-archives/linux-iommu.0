From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] dt: Add general DMA window parser
Date: Wed, 18 Apr 2012 13:13:01 +0200
Message-ID: <20120418.141301.716316488779792574.hdoyu@nvidia.com>
References: <20120418102629.GA14533@avionic-0098.mockup.avionic-design.de><20120418.133629.1664781135413277375.hdoyu@nvidia.com><20120418105423.GA5667@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418105423.GA5667-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] dt: Add general DMA window parser
Date: Wed, 18 Apr 2012 12:54:23 +0200
Message-ID: <20120418105423.GA5667-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>

> * PGP Signed by an unknown key
> 
> * Hiroshi Doyu wrote:
> > diff --git a/drivers/of/of_dma.c b/drivers/of/of_dma.c
> > new file mode 100644
> > index 0000000..45c9e88
> > --- /dev/null
> > +++ b/drivers/of/of_dma.c
> > @@ -0,0 +1,35 @@
> > +/*
> > + * Stolen from:
> > + *	"arch/microblaze/kernel/prom_parse.c"
> > + *	"arch/powerpc/kernel/prom_parse.c"
> > + */
> > +
> > +#include <linux/of_address.h>
> > +
> > +void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
> > +		unsigned long *busno, unsigned long *phys, unsigned long *size)
> > +{
> > +	const __be32 *dma_window;
> > +	u32 cells;
> > +	const unsigned char *prop;
> 
> There's no need for this to be const unsigned char *, const void * will do
> just as well.
> 
> > +
> > +	dma_window = dma_window_prop;
> > +
> > +	/* busno is always one cell */
> > +	if (busno)
> > +		*busno = be32_to_cpup(dma_window++);
> > +
> > +	prop = of_get_property(dn, "#dma-address-cells", NULL);
> > +	if (!prop)
> > +		prop = of_get_property(dn, "#address-cells", NULL);
> > +
> > +	cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
> > +	*phys = of_read_number(dma_window, cells);
> 
> This should probably fail gracefully if phys == NULL, similar to what you do
> for busno.
> 
> > +
> > +	dma_window += cells;
> > +
> > +	prop = of_get_property(dn, "#dma-size-cells", NULL);
> > +	cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
> > +	*size = of_read_number(dma_window, cells);
> 
> Same here.
> 
> > +}
> > +
> 
> And you might want to add a EXPORT_SYMBOL(of_parse_dma_window) here so the
> function can be used from modules.
> 
> Sorry for having you go through another round. I should have looked more
> closely before.

No problem, I'll wait for another comments, and post again later. Thank you for reivew.
