Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163B5C433E3
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 07:16:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC415206F5
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 07:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W/1lPp0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC415206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8B325203B9;
	Wed, 22 Jul 2020 07:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lNj+HRPtcj1q; Wed, 22 Jul 2020 07:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E521203AE;
	Wed, 22 Jul 2020 07:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A872C088E;
	Wed, 22 Jul 2020 07:16:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CED80C016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B6D9D8789B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEBpoGkHBS-E for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 07:15:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 549B9877D4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:15:58 +0000 (UTC)
X-UUID: d331a230923941bb81206dcd421e9959-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=eioeC0FtTQ1I836sh9xci60mvaR1B/7eikG6MlrGfMw=; 
 b=W/1lPp0NEbJf+lJZGPKIs45XHDlPMt+SpLnLA5Lft7lV/0qolfOC2yAziWropllbzcr4m8Qm+kWWc3dX2mozJOaB2nWdo3gpKz6BDNoPj+BY7rfEeuqW1OSFcOF2or4URpnuHRwbw+NungSZmBONWNJHf90hplUuRz1Qgg0Fbcg=;
X-UUID: d331a230923941bb81206dcd421e9959-20200722
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 160040994; Wed, 22 Jul 2020 15:15:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:15:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:15:50 +0800
Message-ID: <1595402150.10848.1.camel@mtkswgap22>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From: Miles Chen <miles.chen@mediatek.com>
To: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Jul 2020 15:15:50 +0800
In-Reply-To: <cc04ce89-9790-b127-19e5-8f2f1b91ad4f@redhat.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
 <cc04ce89-9790-b127-19e5-8f2f1b91ad4f@redhat.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 125A2A6B996131DF2178586BE457C60F26919FB3EC0293BA66AB66B8DF6B504B2000:8
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 Chao Hao <chao.hao@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Christoph Hellwig <hch@lst.de>,
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

On Tue, 2020-07-21 at 11:10 +0200, David Hildenbrand wrote:
> On 21.07.20 04:16, Miles Chen wrote:
> > In previous discussion [1] and [2], we found that it is risky to
> > use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> > 
> > Check 4GB mode by reading infracfg register, remove the usage
> > of the un-exported symbol max_pfn.
> > 
> > This is a step towards building mtk_iommu as a kernel module.
> > 
> > Change since v1:
> > 1. remove the phandle usage, search for infracfg instead [3]
> > 2. use infracfg instead of infracfg_regmap
> > 3. move infracfg definitaions to linux/soc/mediatek/infracfg.h
> > 4. update enable_4GB only when has_4gb_mode
> 
> Nit: We tend to place such information below the "---" (adding a second
> one) such that this information is discarded when the patch is picked up.

Thanks, I'll add a "---" before the "Change since..." in patch v3.
> 
> > 
> > [1] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/3/733__;!!CTRNKA9wMg0ARbw!wrP2H0azuZkTHSnM_ETki4kT_FMF0Cl7abQX8tIHX0iTr65JkvMCe4jDt84d_YhBrA$ 
> > [2] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/4/136__;!!CTRNKA9wMg0ARbw!wrP2H0azuZkTHSnM_ETki4kT_FMF0Cl7abQX8tIHX0iTr65JkvMCe4jDt86IGhmouQ$ 
> > [3] https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/15/1147__;!!CTRNKA9wMg0ARbw!wrP2H0azuZkTHSnM_ETki4kT_FMF0Cl7abQX8tIHX0iTr65JkvMCe4jDt855z4xdqw$ 
> > 
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: Chao Hao <chao.hao@mediatek.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
> >  include/linux/soc/mediatek/infracfg.h |  3 +++
> >  2 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2be96f1cdbd2..16765f532853 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -3,7 +3,6 @@
> >   * Copyright (c) 2015-2016 MediaTek Inc.
> >   * Author: Yong Wu <yong.wu@mediatek.com>
> >   */
> > -#include <linux/memblock.h>
> >  #include <linux/bug.h>
> >  #include <linux/clk.h>
> >  #include <linux/component.h>
> > @@ -15,13 +14,16 @@
> >  #include <linux/iommu.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/list.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> >  #include <asm/barrier.h>
> >  #include <soc/mediatek/smi.h>
> >  
> > @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  	struct resource         *res;
> >  	resource_size_t		ioaddr;
> >  	struct component_match  *match = NULL;
> > +	struct regmap		*infracfg;
> >  	void                    *protect;
> >  	int                     i, larb_nr, ret;
> > +	u32			val;
> >  
> >  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> >  
> > -	/* Whether the current dram is over 4GB */
> > -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> > -	if (!data->plat_data->has_4gb_mode)
> > -		data->enable_4GB = false;
> > +	data->enable_4GB = false;
> > +	if (data->plat_data->has_4gb_mode) {
> > +		infracfg = syscon_regmap_lookup_by_compatible(
> > +				"mediatek,mt8173-infracfg");
> > +		if (IS_ERR(infracfg)) {
> > +			infracfg = syscon_regmap_lookup_by_compatible(
> > +					"mediatek,mt2712-infracfg");
> > +			if (IS_ERR(infracfg))
> > +				return PTR_ERR(infracfg);
> > +
> > +		}
> > +		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
> > +		if (ret)
> > +			return ret;
> > +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> 
> (I am absolutely not familiar with syscon_regmap_lookup_by ..., I am
> missing some context, so sorry for the stupid questions)
> 
> Who sets the regmap value and based on what? Who decides that 4GB mode
> is supported or not? And who decides if 4GB mode is *required* or not?
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
