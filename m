Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BFFC433E1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 11:13:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720CA208B3
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 11:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pehOUXfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720CA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49391879DD;
	Wed, 17 Jun 2020 11:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TAbH23TR3xsl; Wed, 17 Jun 2020 11:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4680087386;
	Wed, 17 Jun 2020 11:13:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17B6DC07FF;
	Wed, 17 Jun 2020 11:13:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62900C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 11:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4FA1B886D8
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 11:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBO7PmWlZCZG for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 11:13:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8806D886C2
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 11:13:44 +0000 (UTC)
X-UUID: 9aab6f1766984337876e9e22eefd6c6b-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=JjpDADDiCK+qlE9hxMEA1Nw1DRsXUx4e15ajv8iZahc=; 
 b=pehOUXfm2oBtRs2IrjhACQQlFXiHBIHTYly3LBPvh2EFc/JUzpUduysubyCEp2a/wCG+6jFC7eiqzwVBb4/yZ1tR+Q1Z5LLUVy+/QdsXqr7Hy/m7/2DyfnHRHetlrzbU9vkvB9wPOZrF7BkctoOn6qeuqZHHbwd9Fe/IjCF7wN8=;
X-UUID: 9aab6f1766984337876e9e22eefd6c6b-20200617
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1191921047; Wed, 17 Jun 2020 19:13:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 17 Jun 2020 19:13:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 19:13:31 +0800
Message-ID: <1592392265.20080.11.camel@mhfsdcap03>
Subject: Re: [PATCH v4 5/7] iommu/mediatek: Add sub_comm id in translation
 fault
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 17 Jun 2020 19:11:05 +0800
In-Reply-To: <4418c5a7-3f17-9d00-43b2-4ffc5d458116@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
 <20200617030029.4082-6-chao.hao@mediatek.com>
 <4418c5a7-3f17-9d00-43b2-4ffc5d458116@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 79947D4BE307F06ECA65FD2E22387D3FF8C1D8F5738CBBCA8FB0B3F504850C092000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Matthias,

Thanks very much for your review.

On Wed, 2020-06-17 at 11:17 +0200, Matthias Brugger wrote:
> 
> On 17/06/2020 05:00, Chao Hao wrote:
> > The max larb number that a iommu HW support is 8(larb0~larb7 in the below
> > diagram).
> > If the larb's number is over 8, we use a sub_common for merging
> > several larbs into one larb. At this case, we will extend larb_id:
> > bit[11:9] means common-id;
> > bit[8:7] means subcommon-id;
> > From these two variable, we could get the real larb number when
> > translation fault happen.
> > The diagram is as below:
> > 		 EMI
> > 		  |
> > 		IOMMU
> > 		  |
> >            -----------------
> > 	   |               |
> > 	common1   	common0
> > 	   |		   |
> > 	   -----------------
> > 		  |
> >              smi common
> > 		  |
> >   ------------------------------------
> >   |       |       |       |     |    |
> >  3'd0    3'd1    3'd2    3'd3  ...  3'd7   <-common_id(max is 8)
> >   |       |       |       |     |    |
> > Larb0   Larb1     |     Larb3  ... Larb7
> > 		  |
> > 	    smi sub common
> > 		  |
> >      --------------------------
> >      |        |       |       |
> >     2'd0     2'd1    2'd2    2'd3   <-sub_common_id(max is 4)
> >      |        |       |       |
> >    Larb8    Larb9   Larb10  Larb11
> > 
> > In this patch we extern larb_remap[] to larb_remap[8][4] for this.
> 
> extern -> extend
> 
> > larb_remap[x][y]: x mean common-id above, y means subcommon_id above.
> 
> mean -> means
> 
> > 
> > We can also distinguish if the M4U HW has sub_common by has_sub_comm
> > property.
> > 
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 20 +++++++++++++-------
> >  drivers/iommu/mtk_iommu.h |  3 ++-
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index f23919feba4e..a687e8db0e51 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -91,6 +91,8 @@
> >  #define REG_MMU1_INVLD_PA			0x148
> >  #define REG_MMU0_INT_ID				0x150
> >  #define REG_MMU1_INT_ID				0x154
> > +#define F_MMU_INT_ID_COMM_ID(a)			(((a) >> 9) & 0x7)
> > +#define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
> >  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
> >  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
> >  
> > @@ -229,7 +231,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> >  	struct mtk_iommu_data *data = dev_id;
> >  	struct mtk_iommu_domain *dom = data->m4u_dom;
> >  	u32 int_state, regval, fault_iova, fault_pa;
> > -	unsigned int fault_larb, fault_port;
> > +	unsigned int fault_larb, fault_port, sub_comm = 0;
> >  	bool layer, write;
> >  
> >  	/* Read error info from registers */
> > @@ -245,10 +247,14 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> >  	}
> >  	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
> >  	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
> > -	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> >  	fault_port = F_MMU_INT_ID_PORT_ID(regval);
> > -
> > -	fault_larb = data->plat_data->larbid_remap[fault_larb];
> > +	if (data->plat_data->has_sub_comm) {
> > +		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
> > +		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
> > +	} else {
> > +		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> > +	}
> > +	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
> >  
> >  	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
> >  			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> > @@ -778,7 +784,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
> >  	.has_bclk       = true,
> >  	.has_vld_pa_rng = true,
> >  	.inv_sel_reg    = REG_MMU_INV_SEL_GEN1,
> > -	.larbid_remap   = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> > +	.larbid_remap   = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
> >  };
> >  
> >  static const struct mtk_iommu_plat_data mt8173_data = {
> > @@ -787,14 +793,14 @@ static const struct mtk_iommu_plat_data mt8173_data = {
> >  	.has_bclk     = true,
> >  	.reset_axi    = true,
> >  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> > -	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> > +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
> >  };
> >  
> >  static const struct mtk_iommu_plat_data mt8183_data = {
> >  	.m4u_plat     = M4U_MT8183,
> >  	.reset_axi    = true,
> >  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> > -	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
> > +	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
> >  };
> >  
> >  static const struct of_device_id mtk_iommu_of_ids[] = {
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index afd7a2de5c1e..d51ff99c2c71 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -41,10 +41,11 @@ struct mtk_iommu_plat_data {
> >  	/* HW will use the EMI clock if there isn't the "bclk". */
> >  	bool                has_bclk;
> >  	bool		    has_misc_ctrl;
> > +	bool		    has_sub_comm;
> >  	bool                has_vld_pa_rng;
> >  	bool                reset_axi;
> >  	u32                 inv_sel_reg;
> > -	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> > +	unsigned char       larbid_remap[8][4];
> 
> MTK_LARB_NR_MAX is 16, why do you decrease it to 8?

From the diagram above, the max number of the larbs that could connected
with a IOMMU HW is 8. thus, 8 is right here for each a IOMMU HW.

as I commented when v3. mt2712 have the larbs over 8 since it has 2
IOMMU HWes.

and MTK_LARB_NR_MAX means the max larbs number that this SoC support.
Keep its value as is.


> Should we use a define for the subcommon as well?
> 
> Regards,
> Matthias
> 
> >  };
> >  
> >  struct mtk_iommu_domain;
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
