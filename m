Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C910C63697
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 15:49:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCA921D46
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 15:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCA921D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 533CA2E21E;
	Thu, 26 Nov 2020 15:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOrFubJ9Go8g; Thu, 26 Nov 2020 15:49:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EB74E2E1FB;
	Thu, 26 Nov 2020 15:49:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD6B8C0891;
	Thu, 26 Nov 2020 15:49:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F4BC0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 377AE878AF
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jvm0MIX45F-7 for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5E090878AE
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 15:49:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A539531B;
 Thu, 26 Nov 2020 07:49:23 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BC053F23F;
 Thu, 26 Nov 2020 07:49:20 -0800 (PST)
Subject: Re: [PATCH v4 08/24] iommu/io-pgtable-arm-v7s: Extend PA34 for
 MediaTek
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-9-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a85692d8-d514-8c52-e2c7-53c7fc357c66@arm.com>
Date: Thu, 26 Nov 2020 15:49:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-9-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-11-11 12:38, Yong Wu wrote:
> MediaTek extend the bit5 in lvl1 and lvl2 descriptor as PA34.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 9 +++++++--
>   drivers/iommu/mtk_iommu.c          | 2 +-
>   include/linux/io-pgtable.h         | 4 ++--
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index e880745ab1e8..4d0aa079470f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -112,9 +112,10 @@
>   #define ARM_V7S_TEX_MASK		0x7
>   #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>   
> -/* MediaTek extend the two bits for PA 32bit/33bit */
> +/* MediaTek extend the bits below for PA 32bit/33bit/34bit */
>   #define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
>   #define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> +#define ARM_V7S_ATTR_MTK_PA_BIT34	BIT(5)
>   
>   /* *well, except for TEX on level 2 large pages, of course :( */
>   #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> @@ -194,6 +195,8 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>   		pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>   	if (paddr & BIT_ULL(33))
>   		pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +	if (paddr & BIT_ULL(34))
> +		pte |= ARM_V7S_ATTR_MTK_PA_BIT34;
>   	return pte;
>   }
>   
> @@ -218,6 +221,8 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>   		paddr |= BIT_ULL(32);
>   	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
>   		paddr |= BIT_ULL(33);
> +	if (pte & ARM_V7S_ATTR_MTK_PA_BIT34)
> +		paddr |= BIT_ULL(34);
>   	return paddr;
>   }
>   
> @@ -754,7 +759,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>   	if (cfg->ias > ARM_V7S_ADDR_BITS)
>   		return NULL;
>   
> -	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
> +	if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
>   		return NULL;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6451d83753e1..ec3c87d4b172 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -320,7 +320,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>   			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
>   		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
>   		.ias = 32,
> -		.oas = 34,
> +		.oas = 35,
>   		.tlb = &mtk_iommu_flush_ops,
>   		.iommu_dev = data->dev,
>   	};
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 4cde111e425b..1ae0757f4f94 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -77,8 +77,8 @@ struct io_pgtable_cfg {
>   	 *	TLB maintenance when mapping as well as when unmapping.
>   	 *
>   	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) MediaTek IOMMUs extend
> -	 *	to support up to 34 bits PA where the bit32 and bit33 are
> -	 *	encoded in the bit9 and bit4 of the PTE respectively.
> +	 *	to support up to 35 bits PA where the bit32, bit33 and bit34 are
> +	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
>   	 *
>   	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>   	 *	on unmap, for DMA domains using the flush queue mechanism for
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
