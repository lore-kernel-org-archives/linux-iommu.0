Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1DC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:33:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548222078B
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IeTfafWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548222078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17D23873C9;
	Mon, 25 May 2020 06:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZXlKgHLvt34; Mon, 25 May 2020 06:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CD7986E59;
	Mon, 25 May 2020 06:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12772C088D;
	Mon, 25 May 2020 06:33:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A01D8C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8DA848639F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtXTuA90iHh2 for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 06:33:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 60C9086375
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:33:34 +0000 (UTC)
X-UUID: 48b26c1c68a14608a973e5b51d23e488-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=yX9DbdtxP2DzviHUTXSqqtm5djMy9Kag6CeDl4UJwgY=; 
 b=IeTfafWwPLEbAPhbQZE0+j/nMakuBQIqVw1S0a1OgGTuMqV7iDBdNv2cwTu6awEKzPxWltdd3GhBHebgfSYDFxtLWvOjD6z9RZE7A63VsBr88GENRFVOxr+6rj8IFTHG0U7NNl4Ipm8HGbkRLxaze07zEeQin9lWJ6XMzIaLk1o=;
X-UUID: 48b26c1c68a14608a973e5b51d23e488-20200525
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 815997012; Mon, 25 May 2020 14:33:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 May 2020 14:33:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:33:26 +0800
Message-ID: <1590388305.13912.16.camel@mhfsdcap03>
Subject: Re: [PATCH v3 5/7] iommu/mediatek: Add sub_comm id in translation
 fault
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Mon, 25 May 2020 14:31:45 +0800
In-Reply-To: <20200509083654.5178-6-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
 <20200509083654.5178-6-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D04CEC16514D9461F79069ADF288E5C328AE4284FF7CB22830DF0E34DCEFE93A2000:8
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
> The max larb number that a iommu HW support is 8(larb0~larb7 in the below
> diagram).
> If the larb's number is over 8, we use a sub_common for merging
> several larbs into one larb. At this case, we will extend larb_id:
> bit[11:9] means common-id;
> bit[8:7] means subcommon-id;
> From these two variable, we could get the real larb number when
> translation fault happen.
> The diagram is as below:
> 		 EMI
> 		  |
> 		IOMMU
> 		  |
>            -----------------
> 	   |               |
> 	common1   	common0
> 	   |		   |
> 	   -----------------
> 		  |
>              smi common
> 		  |
>   ------------------------------------
>   |       |       |       |     |    |
>  3'd0    3'd1    3'd2    3'd3  ...  3'd7   <-common_id(max is 8)
>   |       |       |       |     |    |
> Larb0   Larb1     |     Larb3  ... Larb7
> 		  |
> 	    smi sub common
> 		  |
>      --------------------------
>      |        |       |       |
>     2'd0     2'd1    2'd2    2'd3   <-sub_common_id(max is 4)
>      |        |       |       |
>    Larb8    Larb9   Larb10  Larb11
> 
> In this patch we extern larb_remap[] to larb_remap[8][4] for this.
> larb_remap[x][y]: x mean common-id above, y means subcommon_id above.
> 
> We can also distinguish if the M4U HW has sub_common by has_sub_comm
> property.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 20 +++++++++++++-------
>  drivers/iommu/mtk_iommu.h |  3 ++-
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d73de987f8be..3914c418d1b0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -90,6 +90,8 @@
>  #define REG_MMU1_INVLD_PA			0x148
>  #define REG_MMU0_INT_ID				0x150
>  #define REG_MMU1_INT_ID				0x154
> +#define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
> +#define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
>  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
>  
> @@ -228,7 +230,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	struct mtk_iommu_data *data = dev_id;
>  	struct mtk_iommu_domain *dom = data->m4u_dom;
>  	u32 int_state, regval, fault_iova, fault_pa;
> -	unsigned int fault_larb, fault_port;
> +	unsigned int fault_larb, fault_port, sub_comm = 0;
>  	bool layer, write;
>  
>  	/* Read error info from registers */
> @@ -244,10 +246,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>  	}
>  	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
>  	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
> -	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
>  	fault_port = F_MMU_INT_ID_PORT_ID(regval);
> -
> -	fault_larb = data->plat_data->larbid_remap[fault_larb];
> +	if (data->plat_data->has_sub_comm) {
> +		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
> +		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
> +	} else {
> +		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> +	}
> +	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
>  
>  	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>  			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> @@ -785,7 +791,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>  	.has_bclk     = true,
>  	.has_vld_pa_rng   = true,
>  	.inv_sel_reg = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},

The original mt2712 has 10 larbs, but it actually has 2 IOMMU HWs.
For each a smi-common, The max larb number could only be 8. So it is
right here.

Thus,
Reviewed-by: Yong Wu <yong.wu@mediatek.com>

>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
> @@ -794,14 +800,14 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>  	.has_bclk     = true,
>  	.reset_axi    = true,
>  	.inv_sel_reg = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
>  };
>  
>  static const struct mtk_iommu_plat_data mt8183_data = {
>  	.m4u_plat     = M4U_MT8183,
>  	.reset_axi    = true,
>  	.inv_sel_reg = REG_MMU_INV_SEL_GEN1,
> -	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
> +	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>  };
>  
>  static const struct of_device_id mtk_iommu_of_ids[] = {
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index afd7a2de5c1e..d51ff99c2c71 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -41,10 +41,11 @@ struct mtk_iommu_plat_data {
>  	/* HW will use the EMI clock if there isn't the "bclk". */
>  	bool                has_bclk;
>  	bool		    has_misc_ctrl;
> +	bool		    has_sub_comm;
>  	bool                has_vld_pa_rng;
>  	bool                reset_axi;
>  	u32                 inv_sel_reg;
> -	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> +	unsigned char       larbid_remap[8][4];
>  };
>  
>  struct mtk_iommu_domain;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
