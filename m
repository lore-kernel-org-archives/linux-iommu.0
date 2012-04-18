From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/1] dt: Add general DMA window parser
Date: Wed, 18 Apr 2012 11:27:58 -0600
Message-ID: <4F8EF99E.3050709@wwwdotorg.org>
References: <201204180731.54064.arnd@arndb.de><20120418.121824.1894043789811063795.hdoyu@nvidia.com><20120418092613.GA8632@avionic-0098.mockup.avionic-design.de> <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418.131907.2172387798112620167.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/18/2012 04:19 AM, Hiroshi Doyu wrote:

> Subject: [PATCH 1/1] dt: Add general DMA window parser
> 
> This code was stolen from:
> 	"arch/microblaze/kernel/prom_parse.c"
> 	"arch/powerpc/kernel/prom_parse.c"
> 
> Once "ibm," prefix is removed from dts file. This generic one could
> replace the originals.

> +extern void of_parse_dma_window(struct device_node *dn,
> +		       const void *dma_window_prop, unsigned long *busno,
> +			       unsigned long *phys, unsigned long *size);

At least some other of_*() parsing functions take the property name
rather than the property pointer, and also take an index into the
property in order to support multiple entries in it. See for example
of_parse_phandle and of_get_named_gpio_flags. Should this new API be
similar? E.g.:

extern void of_parse_dma_window(struct device_node *np,
			const char *propname, int index,
			unsigned long *busno,
			unsigned long *phys, unsigned long *size);
