Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D2C63777
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 06:23:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73075221FD
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 06:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ug/+xYEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73075221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC6FA876A3;
	Fri, 27 Nov 2020 06:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecN6IsVpcqMs; Fri, 27 Nov 2020 06:23:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57728876A0;
	Fri, 27 Nov 2020 06:23:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14D44C163C;
	Fri, 27 Nov 2020 06:23:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 564E7C0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3CF662E2DC
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1k-6VRcNZ5r for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 06:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by silver.osuosl.org (Postfix) with ESMTP id E433A2E2C6
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 06:23:21 +0000 (UTC)
X-UUID: 1c604bebc27747fa8bfd2f20124312cf-20201127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=OMqcICORIcAhhkjnMDt3nLKuOy2OfxolaCABKDolAkc=; 
 b=Ug/+xYELIK6kMlj3IIsEmoYCFqKuOLS6MwmyAURs1j9HDn6ltMCkA2jVyMZgFqEJyoN9g226OXa2a5V+TS02GlUMopl2T4iOOXAeFlEyN5khfsfH91I2DE9ILyUIg9ZpJOEYXhPUWgsF1lrUuJHNfsmbZXQL8pL11yy7fLGvL1s=;
X-UUID: 1c604bebc27747fa8bfd2f20124312cf-20201127
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1465978574; Fri, 27 Nov 2020 14:23:16 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 27 Nov 2020 14:23:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 14:23:13 +0800
Message-ID: <1606458194.26323.193.camel@mhfsdcap03>
Subject: Re: [PATCH v4 12/24] iommu/mediatek: Move hw_init into attach_device
From: Yong Wu <yong.wu@mediatek.com>
To: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 27 Nov 2020 14:23:14 +0800
In-Reply-To: <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-13-yong.wu@mediatek.com>
 <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8E4E74E78C2C0A3F2DB182D6E5EF394369AE6F486379FA945EA54C8360F9A0862000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com, Tomasz
 Figa <tfiga@google.com>, kernel-team@android.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, 2020-11-26 at 16:43 +0000, Robin Murphy wrote:
> On 2020-11-11 12:38, Yong Wu wrote:
> > In attach device, it will update the pagetable base address register.
> > Move the hw_init function also here. Then it only need call
> > pm_runtime_get/put one time here if m4u has power domain.
> 
> Doesn't that mean you'll end up writing most of the registers twice 
> every time? (first from mtk_iommu_resume(), then again from 
> mtk_iommu_hw_init())

I have skipped the first resume from mtk_iommu_resume with the code in
[15/24]:

@@ -828,6 +848,9 @@ static int __maybe_unused
mtk_iommu_runtime_resume(struct device *dev)

+/* Avoid first resume to affect the default value of registers below.*/
+if (!m4u_dom)
+   return 0;

> It might be neater to have mtk_iommu_hw_init() simply populate the 
> mtk_iommu_suspend_reg data with the initial values at probe time and 
> manually call mtk_iommu_resume() if the hardware is already powered up 
> at that point. Or maybe just don't bother saving those registers on 

Yes. All the power-domains are enabled in lk when bootup.

Actually I have plan to remove the pm_runtime_get in this attach_device
in the later patchset.

This is for fixing a issue that the screen is turned off when bootup.
In android project. we always show boot image. If iommu call
pm_runtime_get/put here, the display power-domain will be turned off
here given that iommu always probe before display drivers and iommu's
power-domain always is display's power-domain.

Even I plan to move the device's pm_runtime_enable into this
attach_device in the case all the drivers(iommu and display...) build as
modules. it is for skipping turn off display's power-domain in
genpd_power_off_unused.

This is only a plan, I'm not sure if power-domain could fix it like[1].

In this patchset, I'd like to keep current status.

[1]
https://patchwork.kernel.org/project/linux-clk/patch/20190630150230.7878-3-robdclark@gmail.com/

> suspend and put the initialisation directly in the resume path.
> 
> Robin.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 55f9b329e637..cfdf5ce696fd 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -125,6 +125,8 @@ struct mtk_iommu_domain {
> >   
> >   static const struct iommu_ops mtk_iommu_ops;
> >   
> > +static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
> > +
> >   /*
> >    * In M4U 4GB mode, the physical address is remapped as below:
> >    *
> > @@ -380,12 +382,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
> >   {
> >   	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> >   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> > +	int ret;
> >   
> >   	if (!data)
> >   		return -ENODEV;
> >   
> >   	/* Update the pgtable base address register of the M4U HW */
> >   	if (!data->m4u_dom) {
> > +		ret = mtk_iommu_hw_init(data);
> > +		if (ret)
> > +			return ret;
> >   		data->m4u_dom = dom;
> >   		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> >   		       data->base + REG_MMU_PT_BASE_ADDR);
> > @@ -729,10 +735,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >   
> >   	platform_set_drvdata(pdev, data);
> >   
> > -	ret = mtk_iommu_hw_init(data);
> > -	if (ret)
> > -		return ret;
> > -
> >   	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
> >   				     "mtk-iommu.%pa", &ioaddr);
> >   	if (ret)
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
