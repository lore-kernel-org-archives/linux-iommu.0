Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0746C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 08:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6AB4400A4;
	Mon,  6 Dec 2021 08:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KA4Z1C1l5ie; Mon,  6 Dec 2021 08:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B5EB40018;
	Mon,  6 Dec 2021 08:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00C5FC001E;
	Mon,  6 Dec 2021 08:16:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F0BBC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 08:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C58860A3E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 08:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fsrvZdXyDlFI for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF6086070A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 08:16:01 +0000 (UTC)
X-UUID: 609d79adcd3f4cadbe01c5f4985a4d4f-20211206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Gwi9NQMi+aJlqofRC9/2Cdnnhql1ssg2h7PD3Qu6tws=; 
 b=Z08QStxoNbqTiW1WRshvSqF8wGbc7Gv6bihg6mJxnWv1F1KZbkNuOgvRuOcHG0WnUAJHvmesy3d4QAGLM7KenLjfassalmT3Jwgi8OqjEfvDTzhZHRmThBWFjoCTJyp7dG1pOr5iHICqFILsgnnEK1raH/8tUBLYSgD6clsjZpI=;
X-UUID: 609d79adcd3f4cadbe01c5f4985a4d4f-20211206
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1785352478; Mon, 06 Dec 2021 16:15:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 6 Dec 2021 16:15:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Dec 2021 16:15:53 +0800
Message-ID: <303eaeb2d371c96def8e5f0284495b1762879905.camel@mediatek.com>
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 6 Dec 2021 16:15:53 +0800
In-Reply-To: <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
 <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com, Matthias
 Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Sat, 2021-12-04 at 12:48 +0100, Krzysztof Kozlowski wrote:
> On 03/12/2021 07:40, Yong Wu wrote:
> > sleep control means that when the larb go to sleep, we should wait
> > a bit
> 
> s/go/goes/
> 
> > until all the current commands are finished. thus, when the larb
> > runtime
> 
> Please start every sentence with a capital letter.
> 
> > suspend, we need enable this function to wait until all the existed
> 
> s/suspend/suspends/
> s/we need enable/we need to enable/
> 
> > command are finished. when the larb resume, just disable this
> > function.
> 
> s/command/commands/
> s/resume/resumes/
> 
> > This function only improve the safe of bus. Add a new flag for this
> 
> s/improve/improves/
> s/the safe/the safety/
> 
> > function. Prepare for mt8186.
> 
> In total it is hard to parse, really.

Will fix them in next version.

Thanks for reviewing so detailedly. Sorry. I didn't pay attention to
the grammar before.

> 
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 39 +++++++++++++++++++++++++++++++++++-
> > ---
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..4b59b28e4d73 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > @@ -32,6 +33,10 @@
> >  #define SMI_DUMMY			0x444
> >  
> >  /* SMI LARB */
> > +#define SMI_LARB_SLP_CON                0x00c
> > +#define SLP_PROT_EN                     BIT(0)
> > +#define SLP_PROT_RDY                    BIT(16)
> > +
> >  #define SMI_LARB_CMD_THRT_CON		0x24
> >  #define SMI_LARB_THRT_RD_NU_LMT_MSK	GENMASK(7, 4)
> >  #define SMI_LARB_THRT_RD_NU_LMT		(5 << 4)
> > @@ -81,6 +86,7 @@
> >  
> >  #define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
> >  #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
> > +#define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
> >  #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
> >  
> >  struct mtk_smi_reg_pair {
> > @@ -371,6 +377,24 @@ static const struct of_device_id
> > mtk_smi_larb_of_ids[] = {
> >  	{}
> >  };
> >  
> > +static int mtk_smi_larb_sleep_ctrl(struct device *dev, bool
> > to_sleep)
> > +{
> 
> Make two functions instead. There is no single code reuse (shared)
> between sleep and resume. In the same time bool arguments are
> confusing
> when looking at caller and one never knows whether true means to
> resume
> or to sleep. Having two functions is obvious. Obvious code is easier
> to
> read and maintain.

Make sense. Thanks for this suggestion.

> 
> > +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > +	int ret = 0;
> > +	u32 tmp;
> > +
> > +	if (to_sleep) {
> > +		writel_relaxed(SLP_PROT_EN, larb->base +
> > SMI_LARB_SLP_CON);
> > +		ret = readl_poll_timeout_atomic(larb->base +
> > SMI_LARB_SLP_CON,
> > +						tmp, !!(tmp &
> > SLP_PROT_RDY), 10, 1000);
> > +		if (ret)
> > +			dev_warn(dev, "sleep ctrl is not
> > ready(0x%x).\n", tmp);
> > +	} else {
> > +		writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
> > +	}
> > +	return ret;
> > +}
> > +
> >  static int mtk_smi_device_link_common(struct device *dev, struct
> > device **com_dev)
> >  {
> >  	struct platform_device *smi_com_pdev;
> > @@ -477,24 +501,31 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >  {
> >  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> >  	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> > -	int ret;
> > +	int ret = 0;
> 
> This line does not have a sense.

Yes. This is unhelpful. Will remove this.

> 
> >  
> >  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb-
> > >smi.clks);
> > -	if (ret < 0)
> > +	if (ret)
> 
> Why changing this?

The successful return value should be 0. I will use a independent patch
for this.

> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
