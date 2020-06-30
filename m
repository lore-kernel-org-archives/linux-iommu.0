Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F3C433E2
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AAD2073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W9mu+44/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AAD2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6DA086D6E;
	Tue, 30 Jun 2020 10:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTO-P4-r1zh2; Tue, 30 Jun 2020 10:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E949868AF;
	Tue, 30 Jun 2020 10:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCF27C088F;
	Tue, 30 Jun 2020 10:54:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A068C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F18EB8787F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enGaCYEUDx0K for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 10:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F6F287C0A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:54:32 +0000 (UTC)
X-UUID: 8652aa4974ec431eb1bd83e81af4e9d5-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=1frGonLY1z6bSq/H3kT64qvgesRuR+pzmBbHCLpti1k=; 
 b=W9mu+44/QT8bk5uDWHK6tphZBC7tG5n/0s/UHdqvnnuKhI1DUkiq1zr7VrTU5GWDCtxRXEZ5P3t4KKC2zyWsIq60TBWONiIppfF5N/XfBLSIsurpv3akPiUZqApzNdtvxxGtN16GT9BoKim+JBIs4LrJsFcFLUV2QhHakTqB7Gs=;
X-UUID: 8652aa4974ec431eb1bd83e81af4e9d5-20200630
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 704726967; Tue, 30 Jun 2020 18:54:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 18:54:17 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:54:16 +0800
Message-ID: <1593514398.2581.7.camel@mbjsdccf07>
Subject: Re: [PATCH v5 04/10] iommu/mediatek: Setting MISC_CTRL register
From: chao hao <Chao.Hao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 30 Jun 2020 18:53:18 +0800
In-Reply-To: <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-5-chao.hao@mediatek.com>
 <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BAF6CEB1E06926B691EB2968E120FA304DAE48B58E1A3A76D8C81A49D6E53EB22000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

On Mon, 2020-06-29 at 11:28 +0200, Matthias Brugger wrote:
> 
> On 29/06/2020 09:13, Chao Hao wrote:
> > Add F_MMU_IN_ORDER_WR_EN and F_MMU_STANDARD_AXI_MODE_BIT definition
> > in MISC_CTRL register.
> > F_MMU_STANDARD_AXI_MODE_BIT:
> >   If we set F_MMU_STANDARD_AXI_MODE_BIT(bit[3][19] = 0, not follow
> > standard AXI protocol), iommu will send urgent read command firstly
> > compare with normal read command to improve performance.
> 
> Can you please help me to understand the phrase. Sorry I'm not a AXI specialist.
> Does this mean that you will send a 'urgent read command' which is not described
> in the specifications instead of a normal read command?

ok.
iommu sends read command to next bus_node normally(we can name it to
cmd1), when cmd1 isn't handled by next bus_node, iommu has a urgent read
command is needed to be sent(we can name it to cmd2), iommu will send
cmd2 and replace cmd1. So cmd2 is handled by next bus_node firstly and
cmd2 will be handled secondly.
But for standard AXI protocol, it will ignore the priority of read
command and only be handled in order. So cmd2 is handled by next
bus_node after cmd1 is done.

> 
> > F_MMU_IN_ORDER_WR_EN:
> >   If we set F_MMU_IN_ORDER_WR_EN(bit[1][17] = 0, out-of-order write), iommu
> > will re-order write command and send more higher priority write command
> > instead of sending write command in order. The feature be controlled
> > by OUT_ORDER_EN macro definition.
> > 
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Suggested-by: Yong Wu <yong.wu@mediatek.com>
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 12 +++++++++++-
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8f81df6cbe51..67b46b5d83d9 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -42,6 +42,9 @@
> >  #define F_INVLD_EN1				BIT(1)
> >  
> >  #define REG_MMU_MISC_CTRL			0x048
> > +#define F_MMU_IN_ORDER_WR_EN			(BIT(1) | BIT(17))
> > +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> 
> Wouldn't it make more sense to name it F_MMU_STANDARD_AXI_MODE_EN?
ok, you are right.
1'b1: follow standard axi protocol

> 
> > +
> >  #define REG_MMU_DCM_DIS				0x050
> >  
> >  #define REG_MMU_CTRL_REG			0x110
> > @@ -574,10 +577,17 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  	}
> >  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >  
> > +	regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> 
> We only need to read regval in the else branch.

ok, I got it. thanks

> 
> >  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
> >  		/* The register is called STANDARD_AXI_MODE in this case */
> > -		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
> > +		regval = 0;
> > +	} else {
> > +		/* For mm_iommu, it can improve performance by the setting */
> > +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
> > +		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_EN))
> > +			regval &= ~F_MMU_IN_ORDER_WR_EN;
> >  	}
> > +	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
> >  
> >  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> >  			     dev_name(data->dev), (void *)data)) {
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index 7cc39f729263..4b780b651ef4 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -22,6 +22,7 @@
> >  #define HAS_BCLK			BIT(1)
> >  #define HAS_VLD_PA_RNG			BIT(2)
> >  #define RESET_AXI			BIT(3)
> > +#define OUT_ORDER_EN			BIT(4)
> 
> Maybe something like OUT_ORDER_WR_EN, to make clear that it's about the the
> write path.
> 
ok, thanks for your advice.

> >  
> >  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> >  		((((pdata)->flags) & (_x)) == (_x))
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
