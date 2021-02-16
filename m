Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04CC433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 12:47:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A47B64DDA
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 12:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A47B64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EAB54871C8;
	Tue, 16 Feb 2021 12:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TC3d+O9j4BX4; Tue, 16 Feb 2021 12:47:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D765871C4;
	Tue, 16 Feb 2021 12:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E91A3C0174;
	Tue, 16 Feb 2021 12:47:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6261C013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 12:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 98143871C4
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 12:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUVjwEWf6XkA for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 12:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id D797686D63
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 12:47:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B151FB;
 Tue, 16 Feb 2021 04:47:50 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7AED3F694;
 Tue, 16 Feb 2021 04:47:47 -0800 (PST)
Subject: Re: [RFC PATCH 1/8] of/device: Allow specifying a custom iommu_spec
 to of_dma_configure
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 frowand.list@gmail.com
References: <20210208163848.2504291-1-mperttunen@nvidia.com>
 <20210208163848.2504291-2-mperttunen@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c33f914-9109-42aa-01f3-04e50cf038c6@arm.com>
Date: Tue, 16 Feb 2021 12:47:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208163848.2504291-2-mperttunen@nvidia.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Mikko,

On 2021-02-08 16:38, Mikko Perttunen wrote:
> To allow for more customized device tree bindings that point to IOMMUs,
> allow manual specification of iommu_spec to of_dma_configure.
> 
> The initial use case for this is with Host1x, where the driver manages
> a set of device tree-defined IOMMU contexts that are dynamically
> allocated to various users. These contexts don't correspond to
> platform devices and are instead attached to dummy devices on a custom
> software bus.

I'd suggest taking a closer look at the patches that made this 
of_dma_configure_id() in the first place, and the corresponding bus code 
in fsl-mc. At this level, Host1x sounds effectively identical to DPAA2 
in terms of being a bus of logical devices composed from bits of 
implicit behind-the-scenes hardware. I mean, compare your series title 
to the fact that their identifiers are literally named "Isolation 
Context ID" ;)

Please just use the existing mechanisms to describe a mapping between 
Host1x context IDs and SMMU Stream IDs, rather than what looks like a 
giant hacky mess here.

(This also reminds me I wanted to rip out all the PCI special-cases and 
convert pci_dma_configure() over to passing its own IDs too, so thanks 
for the memory-jog...)

Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c  | 12 ++++++++----
>   drivers/of/device.c       |  9 +++++----
>   include/linux/of_device.h | 34 +++++++++++++++++++++++++++-------
>   include/linux/of_iommu.h  |  6 ++++--
>   4 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e505b9130a1c..3fefa6c63863 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -87,8 +87,7 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>   }
>   EXPORT_SYMBOL_GPL(of_get_dma_window);
>   
> -static int of_iommu_xlate(struct device *dev,
> -			  struct of_phandle_args *iommu_spec)
> +int of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
>   {
>   	const struct iommu_ops *ops;
>   	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
> @@ -117,6 +116,7 @@ static int of_iommu_xlate(struct device *dev,
>   	module_put(ops->owner);
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(of_iommu_xlate);
>   
>   static int of_iommu_configure_dev_id(struct device_node *master_np,
>   				     struct device *dev,
> @@ -177,7 +177,8 @@ static int of_iommu_configure_device(struct device_node *master_np,
>   
>   const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					   struct device_node *master_np,
> -					   const u32 *id)
> +					   const u32 *id,
> +					   struct of_phandle_args *iommu_spec)
>   {
>   	const struct iommu_ops *ops = NULL;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> @@ -209,7 +210,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
>   	} else {
> -		err = of_iommu_configure_device(master_np, dev, id);
> +		if (iommu_spec)
> +			err = of_iommu_xlate(dev, iommu_spec);
> +		else
> +			err = of_iommu_configure_device(master_np, dev, id);
>   
>   		fwspec = dev_iommu_fwspec_get(dev);
>   		if (!err && fwspec)
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..84ada2110c5b 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -88,8 +88,9 @@ int of_device_add(struct platform_device *ofdev)
>    * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>    * to fix up DMA configuration.
>    */
> -int of_dma_configure_id(struct device *dev, struct device_node *np,
> -			bool force_dma, const u32 *id)
> +int __of_dma_configure(struct device *dev, struct device_node *np,
> +			bool force_dma, const u32 *id,
> +			struct of_phandle_args *iommu_spec)
>   {
>   	const struct iommu_ops *iommu;
>   	const struct bus_dma_region *map = NULL;
> @@ -170,7 +171,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   	dev_dbg(dev, "device is%sdma coherent\n",
>   		coherent ? " " : " not ");
>   
> -	iommu = of_iommu_configure(dev, np, id);
> +	iommu = of_iommu_configure(dev, np, id, iommu_spec);
>   	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>   		kfree(map);
>   		return -EPROBE_DEFER;
> @@ -184,7 +185,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   	dev->dma_range_map = map;
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(of_dma_configure_id);
> +EXPORT_SYMBOL_GPL(__of_dma_configure);
>   
>   int of_device_register(struct platform_device *pdev)
>   {
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 07ca187fc5e4..40cc3e788cb9 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -55,14 +55,27 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>   	return of_node_get(cpu_dev->of_node);
>   }
>   
> -int of_dma_configure_id(struct device *dev,
> +int __of_dma_configure(struct device *dev,
>   		     struct device_node *np,
> -		     bool force_dma, const u32 *id);
> +		     bool force_dma, const u32 *id,
> +		     struct of_phandle_args *iommu_spec);
>   static inline int of_dma_configure(struct device *dev,
>   				   struct device_node *np,
>   				   bool force_dma)
>   {
> -	return of_dma_configure_id(dev, np, force_dma, NULL);
> +	return __of_dma_configure(dev, np, force_dma, NULL, NULL);
> +}
> +static inline int of_dma_configure_id(struct device *dev,
> +				      struct device_node *np,
> +				      bool force_dma, const u32 *id)
> +{
> +	return __of_dma_configure(dev, np, force_dma, id, NULL);
> +}
> +static inline int
> +of_dma_configure_iommu_spec(struct device *dev, struct device_node *np,
> +			    bool force_dma, struct of_phandle_args *iommu_spec)
> +{
> +	return __of_dma_configure(dev, np, force_dma, NULL, iommu_spec);
>   }
>   #else /* CONFIG_OF */
>   
> @@ -112,18 +125,25 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>   	return NULL;
>   }
>   
> -static inline int of_dma_configure_id(struct device *dev,
> +static inline int of_dma_configure(struct device *dev,
>   				   struct device_node *np,
>   				   bool force_dma)
>   {
>   	return 0;
>   }
> -static inline int of_dma_configure(struct device *dev,
> -				   struct device_node *np,
> -				   bool force_dma)
> +
> +static inline int of_dma_configure_id(struct device *dev,
> +				      struct device_node *np,
> +				      bool force_dma, const u32 *id)
>   {
>   	return 0;
>   }
> +
> +static inline int
> +of_dma_configure_iommu_spec(struct device *dev, struct device_node *np,
> +			    bool force_dma, struct of_phandle_args *iommu_spec)
> +{	return 0;
> +}
>   #endif /* CONFIG_OF */
>   
>   #endif /* _LINUX_OF_DEVICE_H */
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 16f4b3e87f20..e8d1e6d32d77 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -14,7 +14,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>   
>   extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					struct device_node *master_np,
> -					const u32 *id);
> +					const u32 *id,
> +					struct of_phandle_args *iommu_spec);
>   
>   #else
>   
> @@ -27,7 +28,8 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
>   
>   static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					 struct device_node *master_np,
> -					 const u32 *id)
> +					 const u32 *id,
> +					 struct of_phandle_args *iommu_spec);
>   {
>   	return NULL;
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
