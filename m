Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50B3C43603
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 12:13:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AE3206CB
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 12:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uOsTI51t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AE3206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68D4D87823;
	Mon, 16 Dec 2019 12:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYweyzxl9RqD; Mon, 16 Dec 2019 12:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 599E48768B;
	Mon, 16 Dec 2019 12:13:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 426C3C18DD;
	Mon, 16 Dec 2019 12:13:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4001FC077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2EDCA877B1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5kN0b1yTmV9 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 12:13:02 +0000 (UTC)
X-Greylist: delayed 00:05:03 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5B2948768B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:13:01 +0000 (UTC)
X-UUID: bb46f94224c747da8dab4df32ad56664-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=GeJYaSSTviQGKC+jAYdPZIk4wLCbJe9Ewnhq0SJZGGQ=; 
 b=uOsTI51tocohCkTABdbaGNiljpGH8Miv1RGczY0gCzXdvtxERE1RsSJe06wyaI+7r+vg3swuQP7csMt53bsL7Qx8N08TaI6xFIcPJhAqBfhX1bsCm2aYC4xcfNhbhCTTU4f6E+e7P9Aalfv15ftlKtxFk+x2Bsfqe0zCSdE/e2A=;
X-UUID: bb46f94224c747da8dab4df32ad56664-20191216
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 782335631; Mon, 16 Dec 2019 20:07:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 16 Dec 2019 20:08:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Dec 2019 20:07:26 +0800
Message-ID: <1576498063.28043.74.camel@mhfsdcap03>
Subject: Re: [RESEND,PATCH 02/13] iommu/mediatek: Add mt6779 IOMMU basic
 support
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Mon, 16 Dec 2019 20:07:43 +0800
In-Reply-To: <20191104115238.2394-3-chao.hao@mediatek.com>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
 <20191104115238.2394-3-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7791763B64BF2B57A9BC52F627E5B0DC36BFAB124FEDC002E5773B2BE4DD279C2000:8
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Cui Zhang <cui.zhang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Guangming Cao <guangming.cao@mediatek.com>
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

On Mon, 2019-11-04 at 19:52 +0800, Chao Hao wrote:
> 1. Add mt6779 registers define for iommu.
> 2. Add mt6779_data define to support mt6779 iommu HW init.
> 3. There are two iommus, one is mm_iommu, the other is vpu_iommu.
> MM_IOMMU is connected smi_larb to support multimedia engine to
> access DRAM, and VPU_IOMMU is connected to APU_bus to support
> VPU,MDLA,EDMA to access DRAM. MM_IOMMU and VPU_IOMMU use the same
> page table to simplify design by "mtk_iommu_get_m4u_data".
> 4. For smi_larb6, it doesn't use mm_iommu, so we can distinguish
> vpu_iommu by it when excutes iommu_probe.
> 5. For mt6779 APU_IOMMU fault id is irregular, so it was treated
> specially.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 91 +++++++++++++++++++++++++++++++++------
>  drivers/iommu/mtk_iommu.h | 10 ++++-
>  2 files changed, 87 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8ca2e99964fe..f2847e661137 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -38,12 +38,24 @@
>  #define REG_MMU_INVLD_END_A			0x028
>  
>  #define REG_MMU_INV_SEL				0x038
> +#define REG_MMU_INV_SEL_MT6779			0x02c
>  #define F_INVLD_EN0				BIT(0)
>  #define F_INVLD_EN1				BIT(1)
>  
>  #define REG_MMU_STANDARD_AXI_MODE		0x048
> +
> +#define REG_MMU_MISC_CRTL_MT6779		0x048

Defining two register in the same offset look strange. see below.

> +#define REG_MMU_STANDARD_AXI_MODE_MT6779	(BIT(3) | BIT(19))
> +#define REG_MMU_COHERENCE_EN			(BIT(0) | BIT(16))
> +#define REG_MMU_IN_ORDER_WR_EN			(BIT(1) | BIT(17))
> +#define F_MMU_HALF_ENTRY_MODE_L			(BIT(5) | BIT(21))
> +#define F_MMU_BLOCKING_MODE_L			(BIT(4) | BIT(20))

The last four ones are not used. Please remove.

> +
>  #define REG_MMU_DCM_DIS				0x050
>  
> +#define REG_MMU_WR_LEN				0x054
> +#define F_MMU_WR_THROT_DIS			(BIT(5) |  BIT(21))
> +
>  #define REG_MMU_CTRL_REG			0x110
>  #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
> @@ -88,10 +100,14 @@
>  #define REG_MMU1_INVLD_PA			0x148
>  #define REG_MMU0_INT_ID				0x150
>  #define REG_MMU1_INT_ID				0x154
> +#define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
> +#define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
> +#define F_MMU_INT_ID_COMM_APU_ID(a)		((a) & 0x3)
> +#define F_MMU_INT_ID_SUB_APU_ID(a)		(((a) >> 2) & 0x3)
>  
> -#define MTK_PROTECT_PA_ALIGN			128
> +#define MTK_PROTECT_PA_ALIGN			256
>  
>  /*
>   * Get the local arbiter ID and the portid within the larb arbiter
> @@ -165,7 +181,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>  
>  	for_each_m4u(data) {
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> -			       data->base + REG_MMU_INV_SEL);
> +			       data->base + data->plat_data->inv_sel_reg);
>  		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
>  		wmb(); /* Make sure the tlb flush all done */
>  	}
> @@ -182,7 +198,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  	for_each_m4u(data) {
>  		spin_lock_irqsave(&data->tlb_lock, flags);
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> -			       data->base + REG_MMU_INV_SEL);
> +			       data->base + data->plat_data->inv_sel_reg);
>  
>  		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
>  		writel_relaxed(iova + size - 1,
> @@ -226,7 +242,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	struct mtk_iommu_data *data = dev_id;
>  	struct mtk_iommu_domain *dom = data->m4u_dom;
>  	u32 int_state, regval, fault_iova, fault_pa;
> -	unsigned int fault_larb, fault_port;
> +	unsigned int fault_larb, fault_port, sub_comm = 0;
>  	bool layer, write;
>  
>  	/* Read error info from registers */
> @@ -242,17 +258,30 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	}
>  	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
>  	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
> -	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
>  	fault_port = F_MMU_INT_ID_PORT_ID(regval);
> +	if (data->plat_data->has_sub_comm[data->m4u_id]) {
> +		/* m4u1 is VPU in mt6779.*/
> +		if (data->m4u_id && data->plat_data->m4u_plat == M4U_MT6779) {
> +			fault_larb = F_MMU_INT_ID_COMM_APU_ID(regval);
> +			sub_comm = F_MMU_INT_ID_SUB_APU_ID(regval);
> +			fault_port = 0; /* for mt6779 APU ID is irregular */
> +		} else {
> +			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
> +			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
> +		}
> +	} else {
> +		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> +	}
>  
> -	fault_larb = data->plat_data->larbid_remap[fault_larb];
> +	fault_larb = data->plat_data->larbid_remap[data->m4u_id][fault_larb];
>  
>  	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>  			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>  		dev_err_ratelimited(
>  			data->dev,
> -			"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
> -			int_state, fault_iova, fault_pa, fault_larb, fault_port,
> +			"fault type=0x%x iova=0x%x pa=0x%x larb=%d sub_comm=%d port=%d regval=0x%x layer=%d %s\n",
> +			int_state, fault_iova, fault_pa, fault_larb,
> +			sub_comm, fault_port, regval,
>  			layer, write ? "write" : "read");
>  	}
>  
> @@ -545,11 +574,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  		return ret;
>  	}
>  
> +	regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
>  	if (data->plat_data->m4u_plat == M4U_MT8173)
> -		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD |
>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	else
> -		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR;
> +		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
>  	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>  
>  	regval = F_L2_MULIT_HIT_EN |
> @@ -589,6 +619,20 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	if (data->plat_data->reset_axi)
>  		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
>  
> +	if (data->plat_data->has_wr_len) {
> +		/* write command throttling mode */
> +		regval = readl_relaxed(data->base + REG_MMU_WR_LEN);
> +		regval &= ~F_MMU_WR_THROT_DIS;
> +		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
> +	}
> +	/* special settings for mmu0 (multimedia iommu) */
> +	if (data->plat_data->has_misc_ctrl[data->m4u_id]) {
> +		regval = readl_relaxed(data->base + REG_MMU_MISC_CRTL_MT6779);
> +		/* non-standard AXI mode */
> +		regval &= ~REG_MMU_STANDARD_AXI_MODE_MT6779;
> +		writel_relaxed(regval, data->base + REG_MMU_MISC_CRTL_MT6779);
> +	}

     0x48 are REG_MMU_STANDARD_AXI_MODE in both mt8173 and mt8183, while
it is REG_MMU_MISC_CRTL in mt2712, mt6779 and the latest soc, right? I
think we can use one defining, like this:

          #define  REG_MMU_MISC_CTRL 0x48

         if (!data->plat_data->has_misc_ctrl[data->m4u_id]) {
               /* Disable standard axi mode while it is
REG_MMU_STANDARD_AXI_MODE */
		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
	 } else if (data->m4u_id == 0) {
		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
		regval &= ~REG_MMU_STANDARD_AXI_MODE_MT6779;
		writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
         }

	 Meanwhile remove the setting for REG_MMU_STANDARD_AXI_MODE above.

> +
>  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
>  			     dev_name(data->dev), (void *)data)) {
>  		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
> @@ -678,6 +722,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  		}
>  		data->larb_imu[id].dev = &plarbdev->dev;
>  
> +		if (data->plat_data->m4u1_mask == (1 << id))
> +			data->m4u_id = 1;
> +
>  		component_match_add_release(dev, &match, release_of,
>  					    compare_of, larbnode);
>  	}
> @@ -731,6 +778,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
>  	void __iomem *base = data->base;
>  
> +	reg->wr_len = readl_relaxed(base + REG_MMU_WR_LEN);
>  	reg->standard_axi_mode = readl_relaxed(base +
>  					       REG_MMU_STANDARD_AXI_MODE);
>  	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
> @@ -756,6 +804,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
>  		return ret;
>  	}
> +	writel_relaxed(reg->wr_len, base + REG_MMU_WR_LEN);
>  	writel_relaxed(reg->standard_axi_mode,
>  		       base + REG_MMU_STANDARD_AXI_MODE);
>  	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> @@ -779,7 +828,20 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>  	.has_4gb_mode = true,
>  	.has_bclk     = true,
>  	.has_vld_pa_rng   = true,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> +	.larbid_remap[0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> +	.inv_sel_reg = REG_MMU_INV_SEL,
> +};
> +
> +static const struct mtk_iommu_plat_data mt6779_data = {
> +	.m4u_plat = M4U_MT6779,
> +	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
> +	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
> +	.larbid_remap[1] = {2, 0, 3, 1},
> +	.has_sub_comm = {true, true},
> +	.has_wr_len = true,
> +	.has_misc_ctrl = {true, false},
> +	.inv_sel_reg = REG_MMU_INV_SEL_MT6779,
> +	.m4u1_mask =  BIT(6),
>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
> @@ -787,17 +849,20 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>  	.has_4gb_mode = true,
>  	.has_bclk     = true,
>  	.reset_axi    = true,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> +	.larbid_remap[0] = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> +	.inv_sel_reg = REG_MMU_INV_SEL,
>  };
>  
>  static const struct mtk_iommu_plat_data mt8183_data = {
>  	.m4u_plat     = M4U_MT8183,
>  	.reset_axi    = true,
> -	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
> +	.larbid_remap[0] = {0, 4, 5, 6, 7, 2, 3, 1},
> +	.inv_sel_reg = REG_MMU_INV_SEL,
>  };
>  
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
> +	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>  	{}
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index ea949a324e33..132dc765a40b 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -25,11 +25,13 @@ struct mtk_iommu_suspend_reg {
>  	u32				int_main_control;
>  	u32				ivrp_paddr;
>  	u32				vld_pa_rng;
> +	u32				wr_len;
>  };
>  
>  enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
> +	M4U_MT6779,
>  	M4U_MT8173,
>  	M4U_MT8183,
>  };
> @@ -42,7 +44,12 @@ struct mtk_iommu_plat_data {
>  	bool                has_bclk;
>  	bool                has_vld_pa_rng;
>  	bool                reset_axi;
> -	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> +	bool                has_sub_comm[2];
> +	bool                has_wr_len;
> +	bool                has_misc_ctrl[2];
> +	u32                 inv_sel_reg;
> +	u32                 m4u1_mask;

alphabetically for the new ones.

> +	unsigned char       larbid_remap[2][MTK_LARB_NR_MAX];
>  };
>  
>  struct mtk_iommu_domain;
> @@ -59,6 +66,7 @@ struct mtk_iommu_data {
>  	bool                            enable_4GB;
>  	spinlock_t			tlb_lock; /* lock for tlb range flush */
>  
> +	u32				m4u_id;
>  	struct iommu_device		iommu;
>  	const struct mtk_iommu_plat_data *plat_data;

Basically this patch looks ok for me. But please split it to several
patches:

1) Extend larbid_remap to larbid_remap[2].
   Actually mt2712 also need this. this is the mt2712 definition.
   larbid_remap[0] = {0, 1, 2, 3},
   larbid_remap[1] = {4, 5, 7, 8, 9},

2) Regarding the 0x48(misc_ctrl register)

3) Add m4u1_mask to distinguish the m4u_id.

4) Add REG_MMU_WR_LEN if you need.

5) Put inv_sel_reg in the plat_data for preparing add 0x2c support in
mt6779.

6) Add new flow to get SUB_COMMON ID and VPU larbid in the translation
fault.

7) Add mt6779 support.

>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
