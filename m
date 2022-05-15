Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627D4C433F5
	for <iommu@archiver.kernel.org>; Sun, 15 May 2022 11:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E280E409EF;
	Sun, 15 May 2022 11:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2BqO_mdX-Tt; Sun, 15 May 2022 11:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E56E409EE;
	Sun, 15 May 2022 11:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FFEFC0039;
	Sun, 15 May 2022 11:10:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7CC8C002D
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 11:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C756B404F4
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 11:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2UW34-fQMDN for <iommu@lists.linux-foundation.org>;
 Sun, 15 May 2022 11:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F177240112
 for <iommu@lists.linux-foundation.org>; Sun, 15 May 2022 11:10:40 +0000 (UTC)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
 id E1D0026EA99; Sun, 15 May 2022 13:10:38 +0200 (CEST)
Date: Sun, 15 May 2022 13:10:38 +0200
From: Janne Grunau <j@jannau.net>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/5] iommu: Implement of_iommu_get_resv_regions()
Message-ID: <20220515111038.GE26732@jannau.net>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
 <20220512190052.1152377-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512190052.1152377-3-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Sameer Pujar <spujar@nvidia.com>,
 asahi@lists.linux.dev
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-12 21:00:49 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This is an implementation that IOMMU drivers can use to obtain reserved
> memory regions from a device tree node. It uses the reserved-memory DT
> bindings to find the regions associated with a given device. If these
> regions are marked accordingly, identity mappings will be created for
> them in the IOMMU domain that the devices will be attached to.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v5:
> - update for new "iommu-addresses" device tree bindings
> 
> Changes in v4:
> - fix build failure on !CONFIG_OF_ADDRESS
> 
> Changes in v3:
> - change "active" property to identity mapping flag that is part of the
>   memory region specifier (as defined by #memory-region-cells) to allow
>   per-reference flags to be used
> 
> Changes in v2:
> - use "active" property to determine whether direct mappings are needed
> 
>  drivers/iommu/of_iommu.c | 90 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  8 ++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5696314ae69e..9e341b5e307f 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -11,12 +11,15 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/fsl/mc.h>
>  
> +#include <dt-bindings/reserved-memory.h>
> +
>  #define NO_IOMMU	1
>  
>  static int of_iommu_xlate(struct device *dev,
> @@ -172,3 +175,90 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  
>  	return ops;
>  }
> +
> +/**
> + * of_iommu_get_resv_regions - reserved region driver helper for device tree
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * IOMMU drivers can use this to implement their .get_resv_regions() callback
> + * for memory regions attached to a device tree node. See the reserved-memory
> + * device tree bindings on how to use these:
> + *
> + *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> + */
> +void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
> +{
> +#if IS_ENABLED(CONFIG_OF_ADDRESS)
> +	struct of_phandle_iterator it;
> +	int err;
> +
> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
> +		struct iommu_resv_region *region;
> +		struct resource res;
> +		const __be32 *maps;
> +		int size;

Adding 'if (!of_device_is_available(it.node)) continue;' here would help 
backwards compatibility. My plan was to add the reserved regions with 
"iommu-addresses" with all zero adresses and sizes with status = 
"disabled" to the devicetree. A bootloader update is required to fill 
those.

> +
> +		memset(&res, 0, sizeof(res));
> +
> +		/*
> +		 * The "reg" property is optional and can be omitted by reserved-memory regions
> +		 * that represent reservations in the IOVA space, which are regions that should
> +		 * not be mapped.
> +		 */
> +		if (of_find_property(it.node, "reg", NULL)) {
> +			err = of_address_to_resource(it.node, 0, &res);
> +			if (err < 0) {
> +				dev_err(dev, "failed to parse memory region %pOF: %d\n",
> +					it.node, err);
> +				continue;
> +			}
> +		}
> +
> +		maps = of_get_property(it.node, "iommu-addresses", &size);
> +		if (maps) {
> +			const __be32 *end = maps + size / sizeof(__be32);
> +			struct device_node *np;
> +			unsigned int index = 0;
> +			u32 phandle;
> +			int na, ns;
> +
> +			while (maps < end) {
> +				phys_addr_t start, end;
> +				size_t length;
> +
> +				phandle = be32_to_cpup(maps++);
> +				np = of_find_node_by_phandle(phandle);
> +				na = of_n_addr_cells(np);
> +				ns = of_n_size_cells(np);
> +
> +				start = of_translate_dma_address(np, maps);
> +				length = of_read_number(maps + na, ns);

alternatively we could handle mappings/reservations with length 0 as 
error and skip them.

> +				end = start + length - 1;
> +
> +				if (np == dev->of_node) {
> +					int prot = IOMMU_READ | IOMMU_WRITE;
> +					enum iommu_resv_type type;
> +
> +					/*
> +					 * IOMMU regions without an associated physical region
> +					 * cannot be mapped and are simply reservations.
> +					 */
> +					if (res.end > res.start)
> +						type = IOMMU_RESV_DIRECT_RELAXABLE;
> +					else
> +						type = IOMMU_RESV_RESERVED;
> +
> +					region = iommu_alloc_resv_region(start, length, prot, type);
> +					if (region)
> +						list_add_tail(&region->list, list);
> +				}
> +
> +				maps += na + ns;
> +				index++;
> +			}
> +		}
> +	}
> +#endif
> +}
> +EXPORT_SYMBOL(of_iommu_get_resv_regions);
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 55c1eb300a86..9a5e6b410dd2 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -12,6 +12,9 @@ extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					struct device_node *master_np,
>  					const u32 *id);
>  
> +extern void of_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *list);
> +
>  #else
>  
>  static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> @@ -21,6 +24,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline void of_iommu_get_resv_regions(struct device *dev,
> +					     struct list_head *list)
> +{
> +}
> +
>  #endif	/* CONFIG_OF_IOMMU */
>  
>  #endif /* __OF_IOMMU_H */
> -- 
> 2.36.1
> 

Janne
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
