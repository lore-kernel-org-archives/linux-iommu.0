Return-Path: <SRS0=AIYf=GB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F754C433E0
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:06:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BE220825
	for <iommu@archiver.kernel.org>; Tue, 29 Dec 2020 11:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BE220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7C7B3271F5;
	Tue, 29 Dec 2020 11:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEc8TD2ZoXLT; Tue, 29 Dec 2020 11:06:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 36B6420031;
	Tue, 29 Dec 2020 11:06:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFC1C088B;
	Tue, 29 Dec 2020 11:06:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E04C0174
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E0F586C64
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UEEJJzqn6rB for <iommu@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 11:06:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6C6EA86C50
 for <iommu@lists.linux-foundation.org>; Tue, 29 Dec 2020 11:06:07 +0000 (UTC)
X-UUID: 8a05a6fe1c26428b9092d125bb033018-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=kBXEFHEYE3UKfnPdFHxODX9PA3xu0wCHnxHyXHF9dIY=; 
 b=Si8UijRGBrB9rSlu49RKJzwWB5SjW5u/piNa/3eYvTymuU5/8ji2OKRDc7+uRuPL8S+cQWoRrPZbLdOV6IB46BBGELbQ1D94hMnxCNGZTVwH1N/2mJyiy331L+UJ6azeXcHa64DykBLBw6KKi0rRrFRbCgfUFcbl51JNsFUs+rg=;
X-UUID: 8a05a6fe1c26428b9092d125bb033018-20201229
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1241701737; Tue, 29 Dec 2020 19:06:03 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 29 Dec 2020 19:06:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:06:01 +0800
Message-ID: <1609239960.26323.291.camel@mhfsdcap03>
Subject: Re: [PATCH v5 17/27] iommu/mediatek: Add pm runtime callback
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 29 Dec 2020 19:06:00 +0800
In-Reply-To: <X+MAh87dFsY2p8vF@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-18-yong.wu@mediatek.com>
 <X+MAh87dFsY2p8vF@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6193CBCDE50237FB6220DACC2EDA79262E49C0591F513503724C7571B2EDA9F12000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 2020-12-23 at 17:32 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:52PM +0800, Yong Wu wrote:
> > This patch adds pm runtime callback.
> > 
> > In pm runtime case, all the registers backup/restore and bclk are
> > controlled in the pm_runtime callback, then pm_suspend is not needed in
> > this case.
> > 
> > runtime PM is disabled when suspend, thus we call
> > pm_runtime_status_suspended instead of pm_runtime_suspended.
> > 
> > And, m4u doesn't have its special pm runtime domain in previous SoC, in
> > this case dev->power.runtime_status is RPM_SUSPENDED defaultly,
> 
> This sounds wrong and could lead to hard to debug errors when the driver
> is changed in the future. Would it be possible to make the behavior
> consistent across the SoCs instead, so that runtime PM status is ACTIVE
> when needed, even on SoCs without an IOMMU PM domain?

Appreciate the reviewing so detailly.

I have tested this.
a) always call pm_runtime_enable.
b) always add device_link with smi_common.

Then, the runtime PM status meet expectation. 

We don't call pm_runtime_get_sync so often, thus, we don't always touch
dev->power.lock. this is ok for us.

I will use this in the next version.

> 
> > thus add
> > a "dev->pm_domain" checking for the SoC that has pm runtime domain.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 5614015e5b96..6fe3ee2b2bf5 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -808,7 +808,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> > +static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
> >  {
> >  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> >  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> > @@ -826,7 +826,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> >  	return 0;
> >  }
> >  
> > -static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > +static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
> >  {
> >  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> >  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> > @@ -853,7 +853,25 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> > +{
> > +	/* runtime PM is disabled when suspend in pm_runtime case. */
> > +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> > +		return 0;
> > +
> > +	return mtk_iommu_runtime_suspend(dev);
> > +}
> > +
> > +static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > +{
> > +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> > +		return 0;
> > +
> > +	return mtk_iommu_runtime_resume(dev);
> > +}
> 
> Wouldn't it be enough to just use pm_runtime_force_suspend() and
> pm_runtime_force_resume() as system sleep ops?

After above solution, this is ok.

Thanks.
> 
> > +
> >  static const struct dev_pm_ops mtk_iommu_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(mtk_iommu_runtime_suspend, mtk_iommu_runtime_resume, NULL)
> >  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
> >  };
> >  
> > -- 
> > 2.18.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
