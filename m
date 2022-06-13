Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD09C433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 12:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72EE860B6C;
	Mon, 13 Jun 2022 12:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ciyAqieyxnY6; Mon, 13 Jun 2022 12:04:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FEFE60A6A;
	Mon, 13 Jun 2022 12:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 057EAC0032;
	Mon, 13 Jun 2022 12:04:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19AFFC002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 12:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16EF181AEA
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 12:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDquQf_Rq4-o for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 12:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1B3E8149C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 12:04:47 +0000 (UTC)
X-UUID: bc5b06b7414c4008bf4af9e070d92552-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:e1dfe471-26a4-4d41-9671-d546e6afb218, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:15
X-CID-META: VersionHash:b14ad71, CLOUDID:77b666c6-12ba-4305-bfdf-9aefbdc32516,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: bc5b06b7414c4008bf4af9e070d92552-20220613
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 44229586; Mon, 13 Jun 2022 20:04:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 20:04:40 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 20:04:40 +0800
Message-ID: <6172e09f04adeade200fe28109e02add89bf722a.camel@mediatek.com>
Subject: Re: [PATCH v8 3/3] iommu/mediatek: Allow page table PA up to 35bit
To: <yf.wang@mediatek.com>
Date: Mon, 13 Jun 2022 20:04:39 +0800
In-Reply-To: <20220611102656.10954-4-yf.wang@mediatek.com>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
 <20220611102656.10954-4-yf.wang@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Miles Chen <miles.chen@mediatek.com>, wsd_upstream@mediatek.com,
 open list <linux-kernel@vger.kernel.org>, Libo Kang <Libo.Kang@mediatek.com>,
 "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Ning Li <ning.li@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Mediatek SoC
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

On Sat, 2022-06-11 at 18:26 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So
> add
> the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and level
> 2
> pgtable support at most 35bit PA.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Thanks very much for this function. All the lastest SoCs like
mt8192/mt8195 support this.

> ---
>  drivers/iommu/mtk_iommu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3d62399e8865..4dbc33758711 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,7 @@
>  /* PM and clock always on. e.g. infra iommu */
>  #define PM_CLK_AO			BIT(15)
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +#define PGTABLE_PA_35_EN		BIT(17)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -240,6 +241,7 @@ struct mtk_iommu_data {
>  struct mtk_iommu_domain {
>  	struct io_pgtable_cfg		cfg;
>  	struct io_pgtable_ops		*iop;
> +	u32				ttbr;
>  
>  	struct mtk_iommu_bank_data	*bank;
>  	struct iommu_domain		domain;
> @@ -596,6 +598,9 @@ static int mtk_iommu_domain_finalise(struct
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
> @@ -684,8 +689,8 @@ static int mtk_iommu_attach_device(struct
> iommu_domain *domain,
>  			goto err_unlock;
>  		}
>  		bank->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       bank->base + REG_MMU_PT_BASE_ADDR);
> +		bank->m4u_dom->ttbr = MTK_IOMMU_ADDR(dom-
> >cfg.arm_v7s_cfg.ttbr);
> +		writel(bank->m4u_dom->ttbr, data->base +
> REG_MMU_PT_BASE_ADDR);
>  
>  		pm_runtime_put(m4udev);
>  	}
> @@ -1366,8 +1371,7 @@ static int __maybe_unused
> mtk_iommu_runtime_resume(struct device *dev)
>  		writel_relaxed(reg->int_control[i], base +
> REG_MMU_INT_CONTROL0);
>  		writel_relaxed(reg->int_main_control[i], base +
> REG_MMU_INT_MAIN_CONTROL);
>  		writel_relaxed(reg->ivrp_paddr[i], base +
> REG_MMU_IVRP_PADDR);
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr &
> MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +		writel(m4u_dom->ttbr, base + REG_MMU_PT_BASE_ADDR);
>  	} while (++i < data->plat_data->banks_num);
>  
>  	/*
> @@ -1401,7 +1405,7 @@ static const struct mtk_iommu_plat_data
> mt2712_data = {
>  static const struct mtk_iommu_plat_data mt6779_data = {
>  	.m4u_plat      = M4U_MT6779,
>  	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
> WR_THROT_EN |
> -			 MTK_IOMMU_TYPE_MM,
> +			 MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
>  	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
>  	.banks_num    = 1,
>  	.banks_enable = {true},

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
