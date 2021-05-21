Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B83C433ED
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 12:59:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A88B613D9
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 12:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A88B613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFEBC60618;
	Fri, 21 May 2021 12:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdWi1iDj_vkC; Fri, 21 May 2021 12:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84A0560649;
	Fri, 21 May 2021 12:59:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF46C000D;
	Fri, 21 May 2021 12:59:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBEB5C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 12:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94AD560649
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 12:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WpKdzXO_yDc for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 12:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6472F60618
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 12:59:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CD311B3;
 Fri, 21 May 2021 05:59:06 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA5FF3F719;
 Fri, 21 May 2021 05:59:04 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] iommu: rockchip: Add internal ops to handle
 variants
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, heiko@sntech.de, xxm@rock-chips.com
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
 <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e709c99c-02c4-69e1-0ae1-f12da9b2f915@arm.com>
Date: Fri, 21 May 2021 13:58:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

On 2021-05-21 09:36, Benjamin Gaignard wrote:
> Add internal ops to be able to handle incoming variant v2.
> The goal is to keep the overall structure of the framework but
> to allow to add the evolution of this hardware block.
> 
> The ops are global for a SoC because iommu domains are not
> attached to a specific devices if they are for a virtuel device like
> drm. Use a global variable shouldn't be since SoC usually doesn't
> embedded different versions of the iommu hardware block.
> If that happen one day a WARN_ON will be displayed at probe time.

IMO it would be a grievous error if such a "virtual device" ever gets 
near the IOMMU API, so personally I wouldn't use that as a justification 
for anything :)

FWIW you should be OK to handle things on a per-instance basis, it just 
means you have to defer some of the domain setup to .attach_dev time, 
like various other drivers do. That said, there's nothing wrong with the 
global if we do expect instances to be consistent across any given 
Rockchip SoC (and my gut feeling is that we probably should).

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 5:
>   - Use of_device_get_match_data()
>   - Add internal ops inside the driver
> 
>   drivers/iommu/rockchip-iommu.c | 69 ++++++++++++++++++++++++----------
>   1 file changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 7a2932772fdf..e7b9bcf174b1 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -19,6 +19,7 @@
>   #include <linux/iopoll.h>
>   #include <linux/list.h>
>   #include <linux/mm.h>
> +#include <linux/module.h>

This seems to be an unrelated and unnecessary change.

>   #include <linux/init.h>
>   #include <linux/of.h>
>   #include <linux/of_iommu.h>
> @@ -96,6 +97,14 @@ static const char * const rk_iommu_clocks[] = {
>   	"aclk", "iface",
>   };
>   
> +struct rk_iommu_ops {
> +	phys_addr_t (*pt_address)(u32 dte);
> +	u32 (*mk_dtentries)(dma_addr_t pt_dma);
> +	u32 (*mk_ptentries)(phys_addr_t page, int prot);
> +	phys_addr_t (*dte_addr_phys)(phys_addr_t addr);
> +	u32 pt_address_mask;
> +};
> +
>   struct rk_iommu {
>   	struct device *dev;
>   	void __iomem **bases;
> @@ -116,6 +125,7 @@ struct rk_iommudata {
>   };
>   
>   static struct device *dma_dev;
> +static const struct rk_iommu_ops *rk_ops;
>   
>   static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
>   				  unsigned int count)
> @@ -215,11 +225,6 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
>   #define RK_PTE_PAGE_READABLE      BIT(1)
>   #define RK_PTE_PAGE_VALID         BIT(0)
>   
> -static inline phys_addr_t rk_pte_page_address(u32 pte)
> -{
> -	return (phys_addr_t)pte & RK_PTE_PAGE_ADDRESS_MASK;
> -}
> -
>   static inline bool rk_pte_is_page_valid(u32 pte)
>   {
>   	return pte & RK_PTE_PAGE_VALID;
> @@ -451,7 +456,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, DTE_ADDR_DUMMY);
>   
>   		dte_addr = rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR);
> -		if (dte_addr != (DTE_ADDR_DUMMY & RK_DTE_PT_ADDRESS_MASK)) {
> +		if (dte_addr != (DTE_ADDR_DUMMY & rk_ops->pt_address_mask)) {

Nit: might it make more sense to do something like:

		dte_addr = rk_ops->pt_address(... DTE_ADDR_DUMMY);
		rk_iommu_write(... dte_addr)
		if (rk_iommu_read(...) != dte_addr)

so that you don't need to bother defining ->pt_address_mask for just 
this one sanity-check?

>   			dev_err(iommu->dev, "Error during raw reset. MMU_DTE_ADDR is not functioning\n");
>   			return -EFAULT;
>   		}
> @@ -470,6 +475,11 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   	return 0;
>   }
>   
> +static inline phys_addr_t rk_dte_addr_phys(phys_addr_t addr)

The argument type here should be u32, since it's a DTE, not a physical 
address...

> +{
> +	return addr;
> +}
> +
>   static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   {
>   	void __iomem *base = iommu->bases[index];
> @@ -489,7 +499,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   	page_offset = rk_iova_page_offset(iova);
>   
>   	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
> -	mmu_dte_addr_phys = (phys_addr_t)mmu_dte_addr;
> +	mmu_dte_addr_phys = rk_ops->dte_addr_phys((phys_addr_t)mmu_dte_addr);

...and the cast here should not be here, since it *is* the conversion 
that the called function is supposed to be performing.

>   	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
>   	dte_addr = phys_to_virt(dte_addr_phys);
> @@ -498,14 +508,14 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   	if (!rk_dte_is_pt_valid(dte))
>   		goto print_it;
>   
> -	pte_addr_phys = rk_dte_pt_address(dte) + (pte_index * 4);
> +	pte_addr_phys = rk_ops->pt_address(dte) + (pte_index * 4);
>   	pte_addr = phys_to_virt(pte_addr_phys);
>   	pte = *pte_addr;
>   
>   	if (!rk_pte_is_page_valid(pte))
>   		goto print_it;
>   
> -	page_addr_phys = rk_pte_page_address(pte) + page_offset;
> +	page_addr_phys = rk_ops->pt_address(pte) + page_offset;
>   	page_flags = pte & RK_PTE_PAGE_FLAGS_MASK;
>   
>   print_it:
> @@ -601,13 +611,13 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
>   	if (!rk_dte_is_pt_valid(dte))
>   		goto out;
>   
> -	pt_phys = rk_dte_pt_address(dte);
> +	pt_phys = rk_ops->pt_address(dte);
>   	page_table = (u32 *)phys_to_virt(pt_phys);
>   	pte = page_table[rk_iova_pte_index(iova)];
>   	if (!rk_pte_is_page_valid(pte))
>   		goto out;
>   
> -	phys = rk_pte_page_address(pte) + rk_iova_page_offset(iova);
> +	phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
>   out:
>   	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
>   
> @@ -679,14 +689,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	dte = rk_mk_dte(pt_dma);
> +	dte = rk_ops->mk_dtentries(pt_dma);
>   	*dte_addr = dte;
>   
>   	rk_table_flush(rk_domain, pt_dma, NUM_PT_ENTRIES);
>   	rk_table_flush(rk_domain,
>   		       rk_domain->dt_dma + dte_index * sizeof(u32), 1);
>   done:
> -	pt_phys = rk_dte_pt_address(dte);
> +	pt_phys = rk_ops->pt_address(dte);
>   	return (u32 *)phys_to_virt(pt_phys);
>   }
>   
> @@ -728,7 +738,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
>   		if (rk_pte_is_page_valid(pte))
>   			goto unwind;
>   
> -		pte_addr[pte_count] = rk_mk_pte(paddr, prot);
> +		pte_addr[pte_count] = rk_ops->mk_ptentries(paddr, prot);
>   
>   		paddr += SPAGE_SIZE;
>   	}
> @@ -750,7 +760,7 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
>   			    pte_count * SPAGE_SIZE);
>   
>   	iova += pte_count * SPAGE_SIZE;
> -	page_phys = rk_pte_page_address(pte_addr[pte_count]);
> +	page_phys = rk_ops->pt_address(pte_addr[pte_count]);
>   	pr_err("iova: %pad already mapped to %pa cannot remap to phys: %pa prot: %#x\n",
>   	       &iova, &page_phys, &paddr, prot);
>   
> @@ -785,7 +795,8 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
>   	dte_index = rk_domain->dt[rk_iova_dte_index(iova)];
>   	pte_index = rk_iova_pte_index(iova);
>   	pte_addr = &page_table[pte_index];
> -	pte_dma = rk_dte_pt_address(dte_index) + pte_index * sizeof(u32);
> +
> +	pte_dma = rk_ops->pt_address(dte_index) + pte_index * sizeof(u32);
>   	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
>   				paddr, size, prot);
>   
> @@ -821,7 +832,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>   		return 0;
>   	}
>   
> -	pt_phys = rk_dte_pt_address(dte);
> +	pt_phys = rk_ops->pt_address(dte);
>   	pte_addr = (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iova);
>   	pte_dma = pt_phys + rk_iova_pte_index(iova) * sizeof(u32);
>   	unmap_size = rk_iommu_unmap_iova(rk_domain, pte_addr, pte_dma, size);
> @@ -1037,7 +1048,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>   	for (i = 0; i < NUM_DT_ENTRIES; i++) {
>   		u32 dte = rk_domain->dt[i];
>   		if (rk_dte_is_pt_valid(dte)) {
> -			phys_addr_t pt_phys = rk_dte_pt_address(dte);
> +			phys_addr_t pt_phys = rk_ops->pt_address(dte);
>   			u32 *page_table = phys_to_virt(pt_phys);
>   			dma_unmap_single(dma_dev, pt_phys,
>   					 SPAGE_SIZE, DMA_TO_DEVICE);
> @@ -1138,6 +1149,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	iommu->dev = dev;
>   	iommu->num_mmu = 0;
>   
> +	if (!rk_ops)
> +		rk_ops = of_device_get_match_data(dev);
> +
> +	/*
> +	 * That should not happen unless different versions of the
> +	 * hardware block are embedded the same SoC
> +	 */
> +	WARN_ON(rk_ops != of_device_get_match_data(dev));

Nit: calling of_device_get_match_data() twice seems rather untidy - how 
about something like:

	ops = of_device_get_match_data(dev);
	if (!rk_ops)
		rk_ops = ops;
	else if (WARN_ON(rk_ops != ops))
		return -EINVAL;

Either way I think it would be good to treat unexpected inconsistentcy 
as an actual error, rather than second-guessing the DT and carrying on 
under the assumption the device is something other than it claimed to be.

> +
>   	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
>   				    GFP_KERNEL);
>   	if (!iommu->bases)
> @@ -1277,10 +1297,21 @@ static const struct dev_pm_ops rk_iommu_pm_ops = {
>   				pm_runtime_force_resume)
>   };
>   
> +static struct rk_iommu_ops iommu_data_ops_v1 = {
> +	.pt_address = &rk_dte_pt_address,
> +	.mk_dtentries = &rk_mk_dte,
> +	.mk_ptentries = &rk_mk_pte,
> +	.dte_addr_phys = &rk_dte_addr_phys,
> +	.pt_address_mask = RK_DTE_PT_ADDRESS_MASK,
> +};
> +
>   static const struct of_device_id rk_iommu_dt_ids[] = {
> -	{ .compatible = "rockchip,iommu" },
> +	{	.compatible = "rockchip,iommu",
> +		.data = &iommu_data_ops_v1,
> +	},
>   	{ /* sentinel */ }
>   };
> +MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);

As before, unrelated and unnecessary since this driver is still bool in 
the Kconfig. If you do want to support modular builds you'll also need 
to ensure rk_iommu_ops.owner is set, but do it all as a separate patch 
please.

Thanks,
Robin.

>   
>   static struct platform_driver rk_iommu_driver = {
>   	.probe = rk_iommu_probe,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
