Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C43DC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FEB2067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KY3IKegX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FEB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6CF588600;
	Tue, 30 Jun 2020 11:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rynTLm7fUQom; Tue, 30 Jun 2020 11:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E236F884D9;
	Tue, 30 Jun 2020 11:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D306BC088F;
	Tue, 30 Jun 2020 11:00:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFE45C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B801687A50
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4vC-+-Xr5mYt for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 11:00:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C7A187A2D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 11:00:32 +0000 (UTC)
X-UUID: 45ce0cb4af224ae2b6bdd637800262d0-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Qgf6+KnJU1C/9ERhG+00Cd7X5IE2bZgFvfn2R9N4ujg=; 
 b=KY3IKegXO3DSuD/QVvBPekshjSIttVde6VaOcWgugHvPr6vyyUNCcHSuf0jYtu3aHCWyTnywl4IgN78UoCSEECRoHPUNzctSBlnIGY+2AWW91K4tTqrKFzA7qXKv+xxCx9yf0kkwWolAVnzOt2tOojZ+IRh3J21EpOnVt5jV9x4=;
X-UUID: 45ce0cb4af224ae2b6bdd637800262d0-20200630
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 739440965; Tue, 30 Jun 2020 19:00:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:00:23 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:00:23 +0800
Message-ID: <1593514765.13270.3.camel@mbjsdccf07>
Subject: Re: [PATCH v5 07/10] iommu/mediatek: Add REG_MMU_WR_LEN register
 definition
From: chao hao <Chao.Hao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 30 Jun 2020 18:59:25 +0800
In-Reply-To: <ccb63946-e187-187e-c92c-0423f1831d8f@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-8-chao.hao@mediatek.com>
 <ccb63946-e187-187e-c92c-0423f1831d8f@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 329E5CED00E1E6D984FED548CE85F058205BE3EED5886D85F7D19028D1218CCC2000:8
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

On Mon, 2020-06-29 at 12:16 +0200, Matthias Brugger wrote:
> 
> On 29/06/2020 09:13, Chao Hao wrote:
> > Some platforms(ex: mt6779) need to improve performance by setting
> > REG_MMU_WR_LEN register. And we can use WR_THROT_EN macro to control
> > whether we need to set the register. If the register uses default value,
> > iommu will send command to EMI without restriction, when the number of
> > commands become more and more, it will drop the EMI performance. So when
> > more than ten_commands(default value) don't be handled for EMI, iommu will
> > stop send command to EMI for keeping EMI's performace by enabling write
> > throttling mechanism(bit[5][21]=0) in MMU_WR_LEN_CTRL register.
> > 
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 10 ++++++++++
> >  drivers/iommu/mtk_iommu.h |  2 ++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index ec1f86913739..92316c4175a9 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -46,6 +46,8 @@
> >  #define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> >  
> >  #define REG_MMU_DCM_DIS				0x050
> > +#define REG_MMU_WR_LEN				0x054
> 
> The register name is confusing. For me it seems to describe the length of a
> write but it is used for controlling the write throttling. Is this the name
> that's used in the datasheet?
> 

Thanks for your review carefully, we can name it to REG_MMU_WR_LEN_CTRL


> > +#define F_MMU_WR_THROT_DIS_BIT			(BIT(5) |  BIT(21))
> 
> There are two spaces between '|' and 'BIT(21)', should be one.
> 
> Regarding the name of the define, what does the 'F_' statnds for? 

F_ is used to described some bits in register and doesn't have other
meanings. The format is refer to other bits definition

> Also I think
> it should be called '_MASK' instead of '_BIT' as it defines a mask of bits.
> 

Thanks for your advice.
For F_MMU_WR_THROT_DIS_BIT:
1'b0: Enable write throttling mechanism
1'b1: Disable write throttling mechanism
So I think we can name "F_MMU_WR_THROT_DIS  BIT(5) | BIT(21)" directly,
it maybe more clearer.

> Regards,
> Matthias
> 
> >  
> >  #define REG_MMU_CTRL_REG			0x110
> >  #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
> > @@ -582,6 +584,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
> >  	}
> >  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> > +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
> > +		/* write command throttling mode */
> > +		regval = readl_relaxed(data->base + REG_MMU_WR_LEN);
> > +		regval &= ~F_MMU_WR_THROT_DIS_BIT;
> > +		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
> > +	}
> >  
> >  	regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> >  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
> > @@ -737,6 +745,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> >  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> >  	void __iomem *base = data->base;
> >  
> > +	reg->wr_len = readl_relaxed(base + REG_MMU_WR_LEN);
> >  	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
> >  	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
> >  	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
> > @@ -761,6 +770,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
> >  		return ret;
> >  	}
> > +	writel_relaxed(reg->wr_len, base + REG_MMU_WR_LEN);
> >  	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
> >  	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> >  	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index be6d32ee5bda..ce4f4e8f03aa 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -24,6 +24,7 @@
> >  #define RESET_AXI			BIT(3)
> >  #define OUT_ORDER_EN			BIT(4)
> >  #define HAS_SUB_COMM			BIT(5)
> > +#define WR_THROT_EN			BIT(6)
> >  
> >  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> >  		((((pdata)->flags) & (_x)) == (_x))
> > @@ -36,6 +37,7 @@ struct mtk_iommu_suspend_reg {
> >  	u32				int_main_control;
> >  	u32				ivrp_paddr;
> >  	u32				vld_pa_rng;
> > +	u32				wr_len;
> >  };
> >  
> >  enum mtk_iommu_plat {
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
