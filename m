Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFBC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:56:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A7F2071A
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gn6DI5iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A7F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D75987DAF;
	Mon, 25 May 2020 06:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfJZMrd5wizA; Mon, 25 May 2020 06:56:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 57A7A880C8;
	Mon, 25 May 2020 06:56:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33E96C088D;
	Mon, 25 May 2020 06:56:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECFC2C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D5C888654C
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id so857sutbsg6 for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 06:56:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3D06E8659F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:56:21 +0000 (UTC)
X-UUID: fbd3d7b1f60848d9a269012ade4917c9-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=6DRd72G/04IUjrJWtULzvnV0W9JE0UNqefujrxFZ1Cs=; 
 b=gn6DI5iy1sAcJebaPEH3cWoU+p0wrbb/2AW989G3Y5roI3t7japerJPGtbNckLDbVnKVfOdiA+PXIg0Y7lC35PPNjJj3pLizUJ5gGZyHVaBacRfGJ73A50eywhDjZuCm6+SNvc5HbvyM8F0b57Eg7UoebLJVN/6ksMeBSqwaZ9Y=;
X-UUID: fbd3d7b1f60848d9a269012ade4917c9-20200525
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1290107391; Mon, 25 May 2020 14:56:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 May 2020 14:56:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:56:13 +0800
Message-ID: <1590389672.13912.26.camel@mhfsdcap03>
Subject: Re: [PATCH v3 7/7] iommu/mediatek: Add mt6779 basic support
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Mon, 25 May 2020 14:54:32 +0800
In-Reply-To: <20200509083654.5178-8-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
 <20200509083654.5178-8-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D84AC03253283C703994F8FF4CE4C4A6A591C83D422D4AD6387936229962A63F2000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Jun Yan <jun.yan@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 2020-05-09 at 16:36 +0800, Chao Hao wrote:
> 1. Start from mt6779, INVLDT_SEL move to offset=0x2c, so we add
>    REG_MMU_INV_SEL_GEN2 definition and mt6779 uses it.
> 2. Change PROTECT_PA_ALIGN from 128 byte to 256 byte.
> 3. For REG_MMU_CTRL_REG register, we only need to change bit[2:0],
>    others bits keep default value, ex: enable victim tlb.
> 4. Add mt6779_data to support mm_iommu HW init.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 18 +++++++++++++++---
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index dc9ae944e712..34c4ffb77c73 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -37,6 +37,7 @@
>  #define REG_MMU_INVLD_START_A			0x024
>  #define REG_MMU_INVLD_END_A			0x028
>  
> +#define REG_MMU_INV_SEL_GEN2			0x02c
>  #define REG_MMU_INV_SEL_GEN1			0x038

Normally the register name comes from the CODA. In the lasted CODA,
this is called "MMU_INVLDT_SEL". But it's same with the previous 0x38
totally. Using _GEN1, _GEN2 is ok for me. Please add its coda name in
the comment. like:

#define REG_MMU_INV_SEL_GEN2		0x02c /* MMU_INVLDT_SEL */

>  #define F_INVLD_EN0				BIT(0)
>  #define F_INVLD_EN1				BIT(1)
> @@ -97,7 +98,7 @@
>  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
>  
> -#define MTK_PROTECT_PA_ALIGN			128
> +#define MTK_PROTECT_PA_ALIGN			256
>  
>  /*
>   * Get the local arbiter ID and the portid within the larb arbiter
> @@ -554,11 +555,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  		return ret;
>  	}
>  
> +	regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
>  	if (data->plat_data->m4u_plat == M4U_MT8173)
> -		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD |

The default value is not ok for mt8173(Its bit9 is in_order_write_en, we
could not use its default 1'b1). thus, Don't touch this line.

>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	else
> -		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR;
> +		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
>  	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>  
>  	regval = F_L2_MULIT_HIT_EN |
> @@ -804,6 +806,15 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>  	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
>  };
>  
> +static const struct mtk_iommu_plat_data mt6779_data = {
> +	.m4u_plat = M4U_MT6779,
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
> +	.has_sub_comm = true,
> +	.has_wr_len = true,
> +	.has_misc_ctrl = true,
> +	.inv_sel_reg = REG_MMU_INV_SEL_GEN2,

align '=' a bit.

> +};
> +
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
>  	.has_4gb_mode = true,
> @@ -822,6 +833,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>  
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
> +	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>  	{}
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 9971cedd72ea..fb79e710c8d9 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -31,6 +31,7 @@ struct mtk_iommu_suspend_reg {
>  enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
> +	M4U_MT6779,
>  	M4U_MT8173,
>  	M4U_MT8183,
>  };

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
