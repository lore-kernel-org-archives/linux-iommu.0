Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AEEC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:03:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1C120780
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d5UVI0cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1C120780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AABA687DCC;
	Tue, 30 Jun 2020 11:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlxtqMKdSjGW; Tue, 30 Jun 2020 11:03:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92A9387C52;
	Tue, 30 Jun 2020 11:03:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B806C088F;
	Tue, 30 Jun 2020 11:03:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B4D1C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DC2F187D6D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZhSi0c3pRVQd for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 11:03:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id B894987C52
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:03:26 +0000 (UTC)
X-UUID: b09a279ec0ae4986aea6504e62e75534-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=95kISZUSvb1i6OWzMABsaIUaNlAlruFq+xXF6/0ThCQ=; 
 b=d5UVI0cDtCN5mJT9R0W64vMR7q1TVlSamYwBrxPshjmdLLEIgX2V1ZDieKn0VbY3mpE01KjpnKXcOJmX2jQ7XGCv4NvzAZc/8FV2sLjAfJ4lU6856rmkhkxxn4px3AaebX7Z4o39GN0jDBDl6tiDgeLIVsVChX2f/izYb6ZEm3Y=;
X-UUID: b09a279ec0ae4986aea6504e62e75534-20200630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 108669166; Tue, 30 Jun 2020 19:03:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:03:20 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:03:19 +0800
Message-ID: <1593514941.13270.6.camel@mbjsdccf07>
Subject: Re: [PATCH v5 09/10] iommu/mediatek: Modify MMU_CTRL register setting
From: chao hao <Chao.Hao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 30 Jun 2020 19:02:21 +0800
In-Reply-To: <e063a5d2-8edc-9cf9-4872-d3f4abb1e481@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-10-chao.hao@mediatek.com>
 <e063a5d2-8edc-9cf9-4872-d3f4abb1e481@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
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

On Mon, 2020-06-29 at 12:28 +0200, Matthias Brugger wrote:
> 
> On 29/06/2020 09:13, Chao Hao wrote:
> > MT8173 is different from other SoCs for MMU_CTRL register.
> > For mt8173, its bit9 is in_order_write_en and doesn't use its
> > default 1'b1.> For other SoCs, bit[12] represents victim_tlb_en feature and
> > victim_tlb is enable defaultly(bit[12]=1), if we use
> > "regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR", victim_tlb will be
> > disabled, it will drop iommu performace.
> > So we need to deal with the setting of MMU_CTRL separately
> > for mt8173 and others.
> > 
> 
> My proposal to rewrite the commit message:
> 
> The MMU_CTRL regiser of MT8173 is different from other SoCs. The in_order_wr_en
> is bit[9] which is zero by default.
> Other SoCs have the vitcim_tlb_en feature mapped to bit[12]. This bit is set to
> one by default. We need to preserve the bit when setting
> F_MMU_TF_PROT_TO_PROGRAM_ADDR as otherwise the bit will be cleared and IOMMU
> performance will drop.

got it, thanks for your advice very much.

> 
> 
> > Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Suggested-by: Yong Wu <yong.wu@mediatek.com>
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 8299a3299090..e46e2deee3fd 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -543,11 +543,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  		return ret;
> >  	}
> >  
> > +	regval = readl_relaxed(data->base + REG_MMU_CTRL_REG);
> 
> The read is only needed in the else branch.
> 
ok, thanks

> >  	if (data->plat_data->m4u_plat == M4U_MT8173)
> >  		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> >  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
> >  	else
> > -		regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR;
> > +		regval |= F_MMU_TF_PROT_TO_PROGRAM_ADDR;
> >  	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
> >  
> >  	regval = F_L2_MULIT_HIT_EN |
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
