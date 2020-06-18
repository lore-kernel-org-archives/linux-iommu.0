Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E9C433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9D62073E
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QDCb+AFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9D62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D7E420504;
	Thu, 18 Jun 2020 11:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqgyd32VSp90; Thu, 18 Jun 2020 11:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0619320362;
	Thu, 18 Jun 2020 11:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEE22C088C;
	Thu, 18 Jun 2020 11:49:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8820CC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8439887E3C
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iH2jpCjwjlz9 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 11:49:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id F27BA87CE4
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 11:49:54 +0000 (UTC)
X-UUID: 6e5b1069c6694ebdb808c16dfa8c7202-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=BezqSJANb6qgtOc2Spryl5/bYO+3fAr4t48HhEcwp3w=; 
 b=QDCb+AFsC8iwjS8oolB/6LS9fcteaHYJ6uJjtdVrRkl8WD4UfOCAjva/DKHPsSXEubP5XZADt0DfSTci3NiFUZ0xpk7CIaoVPP7iYb2S0zgklbqUGOd3cX8FRTWAyMrtd+R3sQiLhU4fuKfN6pzHHB3+wMJkku3Gvg9P/zmiGqY=;
X-UUID: 6e5b1069c6694ebdb808c16dfa8c7202-20200618
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 2130525936; Thu, 18 Jun 2020 19:49:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 19:49:47 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 19:49:45 +0800
Message-ID: <1592480963.12647.5.camel@mbjsdccf07>
Subject: Re: [PATCH v4 3/7] iommu/mediatek: Set MISC_CTRL register
From: chao hao <Chao.Hao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 18 Jun 2020 19:49:23 +0800
In-Reply-To: <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
 <20200617030029.4082-4-chao.hao@mediatek.com>
 <aaf422f5-2ac8-252d-a064-0c1246e09acc@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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

On Wed, 2020-06-17 at 11:34 +0200, Matthias Brugger wrote:
> 
> On 17/06/2020 05:00, Chao Hao wrote:
> > Add F_MMU_IN_ORDER_WR_EN definition in MISC_CTRL.
> > In order to improve performance, we always disable STANDARD_AXI_MODE
> > and IN_ORDER_WR_EN in MISC_CTRL.
> > 
> > Change since v3:
> 
> The changelog should go below the '---' as we don't want this in the git history
> once the patch get's accepted.
> 
okok, thanks

> > 1. Rename Disable STANDARD_AXI_MODE in MISC_CTRL to Set MISC_CTRL register
> > 2. Add F_MMU_IN_DRDER_WR_EN definition in MISC_CTRL
> >        We need to disable in_order_write to improve performance
> > 
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 11 +++++++++++
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 88d3df5b91c2..239d2cdbbc9f 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -42,6 +42,9 @@
> >  #define F_INVLD_EN1				BIT(1)
> >  
> >  #define REG_MMU_MISC_CTRL			0x048
> > +#define F_MMU_IN_ORDER_WR_EN			(BIT(1) | BIT(17))
> > +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> > +
> >  #define REG_MMU_DCM_DIS				0x050
> >  
> >  #define REG_MMU_CTRL_REG			0x110
> > @@ -578,6 +581,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
> >  	}
> >  
> > +	if (data->plat_data->has_misc_ctrl) {
> 
> That's confusing. We renamed the register to misc_ctrl, but it's present in all
> SoCs. We should find a better name for this flag to describe what the hardware
> supports.
> 

ok, thanks for you advice, I will rename it in next version.
ex:has_perf_req(has performance requirement)


> Regards,
> Matthias
> 
> > +		/* For mm_iommu, it can improve performance by the setting */
> > +		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> > +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
> > +		regval &= ~F_MMU_IN_ORDER_WR_EN;
> > +		writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
> > +	}
> > +
> >  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> >  			     dev_name(data->dev), (void *)data)) {
> >  		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index 1b6ea839b92c..d711ac630037 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -40,6 +40,7 @@ struct mtk_iommu_plat_data {
> >  
> >  	/* HW will use the EMI clock if there isn't the "bclk". */
> >  	bool                has_bclk;
> > +	bool		    has_misc_ctrl;
> >  	bool                has_vld_pa_rng;
> >  	bool                reset_axi;
> >  	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
