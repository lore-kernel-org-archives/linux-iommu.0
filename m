Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9437C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50962613A5;
	Thu, 30 Jun 2022 15:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50962613A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FD2zRrHNyLsD; Thu, 30 Jun 2022 15:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10034613A2;
	Thu, 30 Jun 2022 15:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10034613A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D625DC002D;
	Thu, 30 Jun 2022 15:27:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23AA7C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3EAD84686
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3EAD84686
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g8XwAnFS8-Jg for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:27:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 211008464E
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 211008464E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 15:27:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3B01063;
 Thu, 30 Jun 2022 08:27:16 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB243F66F;
 Thu, 30 Jun 2022 08:27:14 -0700 (PDT)
Message-ID: <ad86a9b0-42b3-6d10-0f77-74b35cc02a6a@arm.com>
Date: Thu, 30 Jun 2022 16:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 2/2] iommu/mediatek: Allow page table PA up to 35bit
Content-Language: en-GB
To: yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Yong Wu <Yong.Wu@mediatek.com>,
 Miles Chen <miles.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220630092927.24925-1-yf.wang@mediatek.com>
 <20220630092927.24925-3-yf.wang@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220630092927.24925-3-yf.wang@mediatek.com>
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo Kang <Libo.Kang@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning Li <ning.li@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
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
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So add
> the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and level 2
> pgtable support at most 35bit PA.

FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3b9f4bdb15b7 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -34,7 +34,6 @@
>   #include <dt-bindings/memory/mtk-memory-port.h>
>   
>   #define REG_MMU_PT_BASE_ADDR			0x000
> -#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
>   
>   #define REG_MMU_INVALIDATE			0x020
>   #define F_ALL_INVLD				0x2
> @@ -138,6 +137,7 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +#define PGTABLE_PA_35_EN		BIT(17)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -596,6 +596,9 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
>   		.iommu_dev = data->dev,
>   	};
>   
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> +
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>   		dom->cfg.oas = data->enable_4GB ? 33 : 32;
>   	else
> @@ -684,8 +687,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   			goto err_unlock;
>   		}
>   		bank->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       bank->base + REG_MMU_PT_BASE_ADDR);
> +		writel(dom->cfg.arm_v7s_cfg.ttbr, bank->base + REG_MMU_PT_BASE_ADDR);
>   
>   		pm_runtime_put(m4udev);
>   	}
> @@ -1366,8 +1368,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
>   		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
>   		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr, base + REG_MMU_PT_BASE_ADDR);
>   	} while (++i < data->plat_data->banks_num);
>   
>   	/*
> @@ -1401,7 +1402,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   static const struct mtk_iommu_plat_data mt6779_data = {
>   	.m4u_plat      = M4U_MT6779,
>   	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
> -			 MTK_IOMMU_TYPE_MM,
> +			 MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>   	.banks_num    = 1,
>   	.banks_enable = {true},
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
