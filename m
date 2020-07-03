Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1495EC433E2
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 02:39:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8215207CD
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 02:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rU+Qxowk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8215207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 90FA287ADD;
	Fri,  3 Jul 2020 02:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Ug3mV_JDV8W; Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EEE838651D;
	Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3AFDC0890;
	Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3992BC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2852787E92
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJxwvQokThdG for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 02:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A81C87E81
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 02:39:18 +0000 (UTC)
X-UUID: 64a3eedf2d8f47b0872f0ccf7b813178-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=ubghZLeTNlicdHeDwlIOfrhXL375GKduXj/VbUzsdHM=; 
 b=rU+Qxowk3TNvO24jARAFD+TWLBTgDwEBgBXZ9wvMsf9Xh+LEkqpXi6+chqUa2OGMuJZey3YxnNxq7o1XY8YN4zjuL62B6DALbw2qLRh5OYwq/kwnijl7fo1wn1aPQA2XFM3IfwjjrCe5vxdvez9e7l4uDn74v/GMWyfN+uwCPMg=;
X-UUID: 64a3eedf2d8f47b0872f0ccf7b813178-20200703
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 901121176; Fri, 03 Jul 2020 10:39:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 10:39:13 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 10:39:13 +0800
Message-ID: <1593743885.22738.2.camel@mbjsdccf07>
Subject: Re: [PATCH v5 04/10] iommu/mediatek: Setting MISC_CTRL register
From: chao hao <Chao.Hao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Fri, 3 Jul 2020 10:38:05 +0800
In-Reply-To: <b9a68cda-bb2e-c9f3-4e44-c201df06c396@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-5-chao.hao@mediatek.com>
 <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
 <1593514398.2581.7.camel@mbjsdccf07>
 <b9a68cda-bb2e-c9f3-4e44-c201df06c396@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3EE8F4A8513308CBFB404D0FBB6A79928236E6EF658504C0F5CE61D2EE0CAC8E2000:8
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

On Wed, 2020-07-01 at 16:58 +0200, Matthias Brugger wrote:
> 
> On 30/06/2020 12:53, chao hao wrote:
> > On Mon, 2020-06-29 at 11:28 +0200, Matthias Brugger wrote:
> >>
> >> On 29/06/2020 09:13, Chao Hao wrote:
> >>> Add F_MMU_IN_ORDER_WR_EN and F_MMU_STANDARD_AXI_MODE_BIT definition
> >>> in MISC_CTRL register.
> >>> F_MMU_STANDARD_AXI_MODE_BIT:
> >>>   If we set F_MMU_STANDARD_AXI_MODE_BIT(bit[3][19] = 0, not follow
> >>> standard AXI protocol), iommu will send urgent read command firstly
> >>> compare with normal read command to improve performance.
> >>
> >> Can you please help me to understand the phrase. Sorry I'm not a AXI specialist.
> >> Does this mean that you will send a 'urgent read command' which is not described
> >> in the specifications instead of a normal read command?
> > 
> > ok.
> > iommu sends read command to next bus_node normally(we can name it to
> > cmd1), when cmd1 isn't handled by next bus_node, iommu has a urgent read
> > command is needed to be sent(we can name it to cmd2), iommu will send
> > cmd2 and replace cmd1. So cmd2 is handled by next bus_node firstly and
> > cmd2 will be handled secondly.
> > But for standard AXI protocol, it will ignore the priority of read
> > command and only be handled in order. So cmd2 is handled by next
> > bus_node after cmd1 is done.
> > 
> 
> Thanks. So I propose change this part of the commit message to something like:
> F_MMU_STANDARD_AXI_MODE_BIT:
> If we set F_MMU_STANDARD_AXI_MODE_EN_MASK (bit[3][19] = 0, not follow standard
> AXI protocol), the iommu will priorize sending of urgent read command over a
> normal read command. This improves the performance.
> 
ok, thanks

> >>
> >>> F_MMU_IN_ORDER_WR_EN:
> >>>   If we set F_MMU_IN_ORDER_WR_EN(bit[1][17] = 0, out-of-order write), iommu
> >>> will re-order write command and send more higher priority write command
> >>> instead of sending write command in order. The feature be controlled
> >>> by OUT_ORDER_EN macro definition.
> 
> F_MMU_IN_ORDER_WR_EN:
> If we set F_MMU_IN_ORDER_WR_EN_MASK (bit[1][17] = 0, out-of-order write), the
> iommu will re-order write commands and send the write command with higher
> priority. Otherwise the sending of write commands will be done in order. The
> feature is controlled by OUT_ORDER_WR_EN platform data flag.
> 
> 
> >>>
> >>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >>> Suggested-by: Yong Wu <yong.wu@mediatek.com>
> >>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> >>> ---
> >>>  drivers/iommu/mtk_iommu.c | 12 +++++++++++-
> >>>  drivers/iommu/mtk_iommu.h |  1 +
> >>>  2 files changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> >>> index 8f81df6cbe51..67b46b5d83d9 100644
> >>> --- a/drivers/iommu/mtk_iommu.c
> >>> +++ b/drivers/iommu/mtk_iommu.c
> >>> @@ -42,6 +42,9 @@
> >>>  #define F_INVLD_EN1				BIT(1)
> >>>  
> >>>  #define REG_MMU_MISC_CTRL			0x048
> >>> +#define F_MMU_IN_ORDER_WR_EN			(BIT(1) | BIT(17))
> >>> +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> >>
> >> Wouldn't it make more sense to name it F_MMU_STANDARD_AXI_MODE_EN?
> > ok, you are right.
> > 1'b1: follow standard axi protocol
> > 
> 
> What about
> F_MMU_IN_ORDER_WR_EN_MASK
> F_MMU_STANDARD_AXI_MODE_EN_MASK
> 
> Background is that we have to set/unset two bits to enable or disable the
> feature, so it's a mask we have to apply to the register.
> 

ok, thanks for your advice

> Regards,
> Matthias
> 
> >>
> >>> +
> >>>  #define REG_MMU_DCM_DIS				0x050
> >>>  
> >>>  #define REG_MMU_CTRL_REG			0x110
> >>> @@ -574,10 +577,17 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >>>  	}
> >>>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> >>>  
> >>> +	regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> >>
> >> We only need to read regval in the else branch.
> > 
> > ok, I got it. thanks
> > 
> >>
> >>>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
> >>>  		/* The register is called STANDARD_AXI_MODE in this case */
> >>> -		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
> >>> +		regval = 0;
> >>> +	} else {
> >>> +		/* For mm_iommu, it can improve performance by the setting */
> >>> +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
> >>> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_EN))
> >>> +			regval &= ~F_MMU_IN_ORDER_WR_EN;
> >>>  	}
> >>> +	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
> >>>  
> >>>  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> >>>  			     dev_name(data->dev), (void *)data)) {
> >>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> >>> index 7cc39f729263..4b780b651ef4 100644
> >>> --- a/drivers/iommu/mtk_iommu.h
> >>> +++ b/drivers/iommu/mtk_iommu.h
> >>> @@ -22,6 +22,7 @@
> >>>  #define HAS_BCLK			BIT(1)
> >>>  #define HAS_VLD_PA_RNG			BIT(2)
> >>>  #define RESET_AXI			BIT(3)
> >>> +#define OUT_ORDER_EN			BIT(4)
> >>
> >> Maybe something like OUT_ORDER_WR_EN, to make clear that it's about the the
> >> write path.
> >>
> > ok, thanks for your advice.
> > 
> >>>  
> >>>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> >>>  		((((pdata)->flags) & (_x)) == (_x))
> >>>
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
