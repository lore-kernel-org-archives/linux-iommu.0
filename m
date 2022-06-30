Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A8FC43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 15:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6507C60F37;
	Thu, 30 Jun 2022 15:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6507C60F37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8aAK6UOBWcp; Thu, 30 Jun 2022 15:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED4DE60F31;
	Thu, 30 Jun 2022 15:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED4DE60F31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C058BC002D;
	Thu, 30 Jun 2022 15:26:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9BAEC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4C1860F34
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4C1860F34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YTEQoXp6Kcgm for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6E6560F31
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6E6560F31
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:26:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E0F91063;
 Thu, 30 Jun 2022 08:26:14 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5784F3F66F;
 Thu, 30 Jun 2022 08:26:11 -0700 (PDT)
Message-ID: <2925438a-27d6-aee4-a412-591628ab2373@arm.com>
Date: Thu, 30 Jun 2022 16:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Content-Language: en-GB
To: yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Yong Wu <Yong.Wu@mediatek.com>,
 Miles Chen <miles.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220630092927.24925-1-yf.wang@mediatek.com>
 <20220630092927.24925-2-yf.wang@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220630092927.24925-2-yf.wang@mediatek.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo Kang <Libo.Kang@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Ning Li <ning.li@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On 2022-06-30 10:29, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> cause pgtable PA size larger than 32bit.
> 
> Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> so add a quirk to allow the PA of pgtables support up to bit35.

This looks about as clean as it's likely to get now, thanks for persevering.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 75 ++++++++++++++++++++++--------
>   include/linux/io-pgtable.h         | 15 ++++--
>   2 files changed, 66 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index be066c1503d3..ba3115fd0f86 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -182,14 +182,8 @@ static bool arm_v7s_is_mtk_enabled(struct io_pgtable_cfg *cfg)
>   		(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT);
>   }
>   
> -static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> -				    struct io_pgtable_cfg *cfg)
> +static arm_v7s_iopte to_mtk_iopte(phys_addr_t paddr, arm_v7s_iopte pte)
>   {
> -	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> -
> -	if (!arm_v7s_is_mtk_enabled(cfg))
> -		return pte;
> -
>   	if (paddr & BIT_ULL(32))
>   		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>   	if (paddr & BIT_ULL(33))
> @@ -199,6 +193,17 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>   	return pte;
>   }
>   
> +static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> +				    struct io_pgtable_cfg *cfg)
> +{
> +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> +
> +	if (arm_v7s_is_mtk_enabled(cfg))
> +		return to_mtk_iopte(paddr, pte);
> +
> +	return pte;
> +}
> +
>   static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>   				  struct io_pgtable_cfg *cfg)
>   {
> @@ -240,10 +245,17 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>   	dma_addr_t dma;
>   	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
>   	void *table = NULL;
> +	gfp_t gfp_l1;
> +
> +	/*
> +	 * ARM_MTK_TTBR_EXT extend the translation table base support larger
> +	 * memory address.
> +	 */
> +	gfp_l1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> +		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
>   
>   	if (lvl == 1)
> -		table = (void *)__get_free_pages(
> -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
> +		table = (void *)__get_free_pages(gfp_l1 | __GFP_ZERO, get_order(size));
>   	else if (lvl == 2)
>   		table = kmem_cache_zalloc(data->l2_tables, gfp);
>   
> @@ -251,7 +263,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>   		return NULL;
>   
>   	phys = virt_to_phys(table);
> -	if (phys != (arm_v7s_iopte)phys) {
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> +	    phys >= (1ULL << cfg->oas) : phys != (arm_v7s_iopte)phys) {
>   		/* Doesn't fit in PTE */
>   		dev_err(dev, "Page table does not fit in PTE: %pa", &phys);
>   		goto out_free;
> @@ -457,9 +470,14 @@ static arm_v7s_iopte arm_v7s_install_table(arm_v7s_iopte *table,
>   					   arm_v7s_iopte curr,
>   					   struct io_pgtable_cfg *cfg)
>   {
> +	phys_addr_t phys = virt_to_phys(table);
>   	arm_v7s_iopte old, new;
>   
> -	new = virt_to_phys(table) | ARM_V7S_PTE_TYPE_TABLE;
> +	new = phys | ARM_V7S_PTE_TYPE_TABLE;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		new = to_mtk_iopte(phys, new);
> +
>   	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
>   		new |= ARM_V7S_ATTR_NS_TABLE;
>   
> @@ -779,6 +797,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   						void *cookie)
>   {
>   	struct arm_v7s_io_pgtable *data;
> +	slab_flags_t slab_flag;
> +	phys_addr_t paddr;
>   
>   	if (cfg->ias > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
>   		return NULL;
> @@ -788,7 +808,8 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>   			    IO_PGTABLE_QUIRK_NO_PERMS |
> -			    IO_PGTABLE_QUIRK_ARM_MTK_EXT))
> +			    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
> +			    IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT))
>   		return NULL;
>   
>   	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
> @@ -796,15 +817,27 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
>   			return NULL;
>   
> +	if ((cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT) &&
> +	    !arm_v7s_is_mtk_enabled(cfg))
> +		return NULL;
> +
>   	data = kmalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return NULL;
>   
>   	spin_lock_init(&data->split_lock);
> +
> +	/*
> +	 * ARM_MTK_TTBR_EXT extend the translation table base support larger
> +	 * memory address.
> +	 */
> +	slab_flag = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> +		    0 : ARM_V7S_TABLE_SLAB_FLAGS;
> +
>   	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
>   					    ARM_V7S_TABLE_SIZE(2, cfg),
>   					    ARM_V7S_TABLE_SIZE(2, cfg),
> -					    ARM_V7S_TABLE_SLAB_FLAGS, NULL);
> +					    slab_flag, NULL);
>   	if (!data->l2_tables)
>   		goto out_free_data;
>   
> @@ -850,12 +883,16 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   	wmb();
>   
>   	/* TTBR */
> -	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
> -				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
> -				 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
> -				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
> -				(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
> -				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
> +	paddr = virt_to_phys(data->pgd);
> +	if (arm_v7s_is_mtk_enabled(cfg))
> +		cfg->arm_v7s_cfg.ttbr = paddr | upper_32_bits(paddr);
> +	else
> +		cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
> +					(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
> +					 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
> +					 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
> +					(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
> +					 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
>   	return &data->iop;
>   
>   out_free_data:
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 86af6f0a00a2..ca98aeadcc80 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -74,17 +74,22 @@ struct io_pgtable_cfg {
>   	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
>   	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
>   	 *
> +	 * IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT: (ARM v7s format) MediaTek IOMMUs
> +	 *	extend the translation table base support up to 35 bits PA, the
> +	 *	encoding format is same with IO_PGTABLE_QUIRK_ARM_MTK_EXT.
> +	 *
>   	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
>   	 *	for use in the upper half of a split address space.
>   	 *
>   	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-cacheability
>   	 *	attributes set in the TCR for a non-coherent page-table walker.
>   	 */
> -	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
> -	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> -	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
> -	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
> -	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
> +	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
> +	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> +	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT		BIT(3)
> +	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
> +	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
> +	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
