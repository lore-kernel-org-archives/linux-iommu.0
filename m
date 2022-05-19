Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B616CC433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 06:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F47D843DC;
	Thu, 19 May 2022 06:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3JJS0sDMCA6; Thu, 19 May 2022 06:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AEA7843DA;
	Thu, 19 May 2022 06:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5481C0039;
	Thu, 19 May 2022 06:58:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABA21C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94D5A843DC
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZY9OMv18EYS for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 06:58:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7F1A843DA
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 06:58:31 +0000 (UTC)
X-UUID: 5e06e23243c441ed9b7ba938ae37ae72-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:c0bcec9f-7c0c-4b7f-9dc2-8f6095442be5, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:5
X-CID-META: VersionHash:2a19b09, CLOUDID:1fa3d379-5ef6-470b-96c9-bdb8ced32786,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:0,BEC:nil
X-UUID: 5e06e23243c441ed9b7ba938ae37ae72-20220519
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1184963467; Thu, 19 May 2022 14:58:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 19 May 2022 14:58:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 14:58:18 +0800
Message-ID: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
Subject: Re: [PATCH v5 2/2] iommu/mediatek: Allow page table PA up to 35bit
To: <yf.wang@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>
Date: Thu, 19 May 2022 14:58:18 +0800
In-Reply-To: <20220516141608.11709-3-yf.wang@mediatek.com>
References: <20220516141608.11709-1-yf.wang@mediatek.com>
 <20220516141608.11709-3-yf.wang@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, open list <linux-kernel@vger.kernel.org>,
 Libo Kang <Libo.Kang@mediatek.com>,
 "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Ning Li <ning.li@mediatek.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-arm-kernel@lists.infradead.org>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2022-05-16 at 22:16 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
> allows
> page table PA up to 35bit, not only in ZONE_DMA32.

Comment why this is needed.

e.g. For single normal zone.

> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd6..1b9a876ef271 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -33,6 +33,7 @@
>  
>  #define REG_MMU_PT_BASE_ADDR			0x000
>  #define MMU_PT_ADDR_MASK			GENMASK(31, 7)
> +#define MMU_PT_ADDR_2_0_MASK			GENMASK(2, 0)
>  
>  #define REG_MMU_INVALIDATE			0x020
>  #define F_ALL_INVLD				0x2
> @@ -118,6 +119,7 @@
>  #define WR_THROT_EN			BIT(6)
>  #define HAS_LEGACY_IVRP_PADDR		BIT(7)
>  #define IOVA_34_EN			BIT(8)
> +#define PGTABLE_PA_35_EN		BIT(9)
>  
>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>  		((((pdata)->flags) & (_x)) == (_x))
> @@ -401,6 +403,9 @@ static int mtk_iommu_domain_finalise(struct
> mtk_iommu_domain *dom,
>  		.iommu_dev = data->dev,
>  	};
>  
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> +
>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>  		dom->cfg.oas = data->enable_4GB ? 33 : 32;
>  	else
> @@ -450,6 +455,7 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>  	struct device *m4udev = data->dev;
>  	int ret, domid;
> +	u32 regval;
>  
>  	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
>  	if (domid < 0)
> @@ -472,8 +478,14 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  			return ret;
>  		}
>  		data->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       data->base + REG_MMU_PT_BASE_ADDR);
> +
> +		/* Bits[6:3] are invalid for mediatek platform */
> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data,
> PGTABLE_PA_35_EN))
> +			regval = (dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK) |
> +				 (dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_2_0_MASK);

The bits[2:0] has already handled in ARM_V7S_TTBR_35BIT_PA of
patch[1/2], we need calculate it again here?

1) Extend arm_v7s_cfg.ttbr to u64, then we could put the special ttbr
logical into our file.

2) if 1) is not allowed, We have to put this in v7s.
if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT) {
       cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
upper_32_bits(paddr);
       return &data->iop;
}

This need Robin/Will confirm.

> +		else
> +			regval = dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK;

Save this value to our data. then we don't need calculate it again in
the resume cb.   

> +		writel(regval, data->base + REG_MMU_PT_BASE_ADDR);
>  
>  		pm_runtime_put(m4udev);
>  	}
> @@ -987,6 +999,7 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
>  	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
>  	void __iomem *base = data->base;
> +	u32 regval;
>  	int ret;
>  
>  	ret = clk_prepare_enable(data->bclk);
> @@ -1010,7 +1023,14 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  	writel_relaxed(reg->int_main_control, base +
> REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>  	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base +
> REG_MMU_PT_BASE_ADDR);
> +
> +	/* Bits[6:3] are invalid for mediatek platform */
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> +		regval = (m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK) |
> +			 (m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_2_0_MASK);
> +	else
> +		regval = m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK;
> +	writel(regval, base + REG_MMU_PT_BASE_ADDR);
>  
>  	/*
>  	 * Users may allocate dma buffer before they call
> pm_runtime_get,
> @@ -1038,7 +1058,8 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  
>  static const struct mtk_iommu_plat_data mt6779_data = {
>  	.m4u_plat      = M4U_MT6779,
> -	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
> +	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
> +			 PGTABLE_PA_35_EN,
>  	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>  	.iova_region   = single_domain,
>  	.iova_region_nr = ARRAY_SIZE(single_domain),

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
