Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06125C433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B48C2074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X0s6uLih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B48C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B23025D1D;
	Tue, 16 Jun 2020 06:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3uV7ZCFC+Xe; Tue, 16 Jun 2020 06:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A383E25A3A;
	Tue, 16 Jun 2020 06:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA74C0888;
	Tue, 16 Jun 2020 06:10:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62537C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46FB98941D
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id asvx9rvj8MTL for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 06:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id CADDA88FE0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:10:36 +0000 (UTC)
X-UUID: 1626b7beed3549a1b48b01ff9235c2d0-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=o0aNLsq8928JAJ6+k5VSSOBMViWOoytBxgKCL5V42kA=; 
 b=X0s6uLihh9WJQAq/QIZNlCXHitKpRwdbPhnw+XF6brmzFjactGUBFSdTz53YEy3L3qchs5zE86v0IbjeH3h+t3Ly+/p92p9gxq+5yt37Y6249a1bxQxBk1VsP/LpQiE1Q6ErPQM54xRpKxC0JYJZ15Bdx6/c91S5+70LK+zMR1w=;
X-UUID: 1626b7beed3549a1b48b01ff9235c2d0-20200616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1405085909; Tue, 16 Jun 2020 14:10:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 14:10:26 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 14:10:28 +0800
Message-ID: <1592287811.29899.3.camel@mbjsdccf07>
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Disable STANDARD_AXI_MODE in
 MISC_CTRL
From: chao hao <Chao.Hao@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Tue, 16 Jun 2020 14:10:11 +0800
In-Reply-To: <1590387275.13912.7.camel@mhfsdcap03>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
 <20200509083654.5178-4-chao.hao@mediatek.com>
 <1590387275.13912.7.camel@mhfsdcap03>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
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

On Mon, 2020-05-25 at 14:14 +0800, Yong Wu wrote:
> On Sat, 2020-05-09 at 16:36 +0800, Chao Hao wrote:
> > In order to improve performance, we always disable STANDARD_AXI_MODE in
> > MISC_CTRL.
> > 
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 8 +++++++-
> >  drivers/iommu/mtk_iommu.h | 1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index e7e7c7695ed1..9ede327a418d 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -42,6 +42,8 @@
> >  #define F_INVLD_EN1				BIT(1)
> >  
> >  #define REG_MMU_MISC_CTRL			0x048
> > +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> > +
> >  #define REG_MMU_DCM_DIS				0x050
> >  
> >  #define REG_MMU_CTRL_REG			0x110
> > @@ -585,7 +587,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  	}
> >  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >  
> > -	if (data->plat_data->reset_axi) {
> > +	if (data->plat_data->has_misc_ctrl) {
> > +		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> > +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
> > +		writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
> > +	} else if (data->plat_data->reset_axi) {
> >  		/* The register is called STANDARD_AXI_MODE in this case */
> >  		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
> >  	}
> 
> 
> 0x48 is either STANDARD_AXI_MODE or MISC_CTRL.
> 
> Thus, 
> 
> if (data->plat_data->reset_axi) {
>    xxx
> } else {  /* MISC_CTRL */
>    xxx
> }
> 
> No need add "has_misc_ctrl".

Thanks for you comment.
Only mm_iommu/m4u needs to set MISC_CTRL register and apu_iommu don't
need to set it. So I think we need to use has_misc_ctrl to distinguish
it.

> 
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
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
