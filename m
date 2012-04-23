From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 1/1] dt: Add general DMA window parser
Date: Mon, 23 Apr 2012 12:16:40 -0600
Message-ID: <4F959C88.3090805@wwwdotorg.org>
References: <20120418.131907.2172387798112620167.hdoyu@nvidia.com><4F8EF99E.3050709@wwwdotorg.org><20120419151920.68ab735a5b9eb8fb938b4d11@nvidia.com> <20120423.145352.1868450546332033138.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120423.145352.1868450546332033138.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/23/2012 05:53 AM, Hiroshi Doyu wrote:
> From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This code was based on:
> 	"arch/microblaze/kernel/prom_parse.c"
> 	"arch/powerpc/kernel/prom_parse.c"
> 
> "ibm," prefix could be supported with some modification.

That'd probably be a good idea. If it isn't supported, then this code
can't be used as a replacement for the PPC and Microblaze code.

> +int of_parse_dma_window(struct device_node *dn,
> +			const char *propname, int index,
> +			unsigned long *busno,
> +			dma_addr_t *addr, size_t *size)
> +{
> +	const __be32 *dma_window, *end;
> +	int bytes, cur_index = 0;
> +
> +	if (!dn || !propname || !addr || !size)
> +		return -EINVAL;

Instead of erroring out if (!propname), perhaps:

if (!propname)
    propname = "dma-window";

so that only drivers using bindings before this common binding was
defined actually need to write out the property name?

> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
...
> +extern int of_parse_dma_window(struct device_node *dev,
> +			       const char *propname, int index,
> +			       unsigned long *busno,
> +			       dma_addr_t *phys, size_t *size);

This function has the same name as the PPC and Microblaze code it's
based on. Is that going to cause compile and link errors due to
duplicate symbol definitions?
