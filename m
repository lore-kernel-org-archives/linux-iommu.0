Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8426EC433DF
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 01:44:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2F20781
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 01:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MZ5Ul3xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E43FE22EC9;
	Thu, 23 Jul 2020 01:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NapbLASQjmmF; Thu, 23 Jul 2020 01:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38E3C22EC1;
	Thu, 23 Jul 2020 01:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20A5EC004D;
	Thu, 23 Jul 2020 01:44:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17B1FC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 01:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0672187DC5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 01:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id opAetI-eC5HH for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 01:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id D62EC887FD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 01:44:39 +0000 (UTC)
X-UUID: 737ffbcf37b14de09cd15acb110df036-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=cKmMFK1O+h5dPYD9MsyI3StTIBTg4rxNNGZFhvkWx2U=; 
 b=MZ5Ul3xkqE8l3RiWKdAExcWkOcYw4+kzaKMGkLCas6Q/r5C6Xma6hsB9fBEmZzW2o2mNEGZpfnUYmKbyF+qfT2hU0VtilBRkmXeMR8+V+O3VGa3JROhrTN3aQeWUnb3hmWy67rl6d67EH7xr7hoNLpdjGyht5iTDvBvjxJ2iJkE=;
X-UUID: 737ffbcf37b14de09cd15acb110df036-20200723
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1167492603; Thu, 23 Jul 2020 09:44:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 09:44:33 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 09:44:30 +0800
Message-ID: <1595468673.10848.10.camel@mtkswgap22>
Subject: Re: [PATCH v3] iommu/mediatek: check 4GB mode by reading infracfg
From: Miles Chen <miles.chen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 23 Jul 2020 09:44:33 +0800
In-Reply-To: <eb36fb32-9a90-2b63-bdc2-506c02a5cb07@gmail.com>
References: <20200722141925.14861-1-miles.chen@mediatek.com>
 <eb36fb32-9a90-2b63-bdc2-506c02a5cb07@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com, David
 Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Yingjoe
 Chen <yingjoe.chen@mediatek.com>, Christoph Hellwig <hch@lst.de>,
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

On Wed, 2020-07-22 at 17:19 +0200, Matthias Brugger wrote:
> 
> On 22/07/2020 16:19, Miles Chen wrote:
> > In previous discussion [1] and [2], we found that it is risky to
> > use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> > 
> > Check 4GB mode by reading infracfg register, remove the usage
> > of the un-exported symbol max_pfn.
> > 
> > This is a step towards building mtk_iommu as a kernel module.
> > 
> > ---
> 
> That's wrong. The commit message would be cut after this '---' so we would loose 
> the Cc and Signed-of-by tags.

Thanks for the comment.
understood, I will fix that in patch v4.
> 
> > 
> > Change since v2:
> > - determine compatible string by m4u_plat
> > - rebase to next-20200720
> > - add "---"
> > 
> > Change since v1:
> > - remove the phandle usage, search for infracfg instead [3]
> > - use infracfg instead of infracfg_regmap
> > - move infracfg definitaions to linux/soc/mediatek/infracfg.h
> > - update enable_4GB only when has_4gb_mode
> > 
> > [1] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/3/733__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMY4tB_vBw$ 
> > [2] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/4/136__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMZ7PRs7yw$ 
> 
> I think using links to lore.kernel.org would make sure that the URL does not 
> change over time. As the commit log will stay there for ever, but who konws what 
> happens with lkml.org

I will use lore.kernel.org links
> 
> > [3] https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/15/1147__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMYreY-qqA$ 
> > 
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Yong Wu <yong.wu@mediatek.com>
> > Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> The formating should look like this:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/3/733__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMY4tB_vBw$ 
> [2] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/4/136__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMZ7PRs7yw$ 
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
> 
> Change since v2:
> - determine compatible string by m4u_plat
> - rebase to next-20200720
> - add "---"
> 
> Change since v1:
> - remove the phandle usage, search for infracfg instead 
> https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/15/1147__;!!CTRNKA9wMg0ARbw!073_W_0qmeQnHgSGJRNPTbK2KnPa4VzaPqFBffFn12odyEL1LDaQtZEmrMYreY-qqA$ 
> - use infracfg instead of infracfg_regmap
> - move infracfg definitaions to linux/soc/mediatek/infracfg.h
> - update enable_4GB only when has_4gb_mode
> 
> 
> 
> > ---
> >   drivers/iommu/mtk_iommu.c             | 34 +++++++++++++++++++++++----
> >   include/linux/soc/mediatek/infracfg.h |  3 +++
> >   2 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 59e5a62a34db..9ec666168822 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -3,7 +3,6 @@
> >    * Copyright (c) 2015-2016 MediaTek Inc.
> >    * Author: Yong Wu <yong.wu@mediatek.com>
> >    */
> > -#include <linux/memblock.h>
> >   #include <linux/bug.h>
> >   #include <linux/clk.h>
> >   #include <linux/component.h>
> > @@ -15,13 +14,16 @@
> >   #include <linux/iommu.h>
> >   #include <linux/iopoll.h>
> >   #include <linux/list.h>
> > +#include <linux/mfd/syscon.h>
> >   #include <linux/of_address.h>
> >   #include <linux/of_iommu.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/of_platform.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> >   #include <asm/barrier.h>
> >   #include <soc/mediatek/smi.h>
> >   
> > @@ -640,8 +642,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >   	struct resource         *res;
> >   	resource_size_t		ioaddr;
> >   	struct component_match  *match = NULL;
> > +	struct regmap		*infracfg;
> >   	void                    *protect;
> >   	int                     i, larb_nr, ret;
> > +	u32			val;
> > +	char                    *p;
> >   
> >   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >   	if (!data)
> > @@ -655,10 +660,29 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> >   
> > -	/* Whether the current dram is over 4GB */
> > -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> > -	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
> > -		data->enable_4GB = false;
> > +	data->enable_4GB = false;
> > +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> > +		switch (data->plat_data->m4u_plat) {
> > +		case M4U_MT2712:
> > +			p = "mediatek,mt2712-infracfg";
> > +			break;
> > +		case M4U_MT8173:
> > +			p = "mediatek,mt8173-infracfg";
> > +			break;
> > +		default:
> > +			p = NULL;
> > +		}
> > +
> > +		infracfg = syscon_regmap_lookup_by_compatible(p);
> 
> 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> 		switch (data->plat_data->m4u_plat) {
> 		case M4U_MT2712:
> 			infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt2712-infracfg");
> 			break;
> 		case M4U_MT8173:
> 			infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt8173-infracfg");
> 			break;
> 		default:
> 			infracfg = -ENODEV;
> 		}
> > +
> > +		if (IS_ERR(infracfg))
> > +			return PTR_ERR(infracfg);
> > +
> > +		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
> > +		if (ret)
> > +			return ret;
> > +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> > +	}
> >   
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   	data->base = devm_ioremap_resource(dev, res);
> > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > index fd25f0148566..233463d789c6 100644
> > --- a/include/linux/soc/mediatek/infracfg.h
> > +++ b/include/linux/soc/mediatek/infracfg.h
> > @@ -32,6 +32,9 @@
> >   #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> >   						 BIT(7) | BIT(8))
> >   
> > +#define REG_INFRA_MISC				0xf00
> > +#define F_DDR_4GB_SUPPORT_EN			BIT(13)
> > +
> >   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> >   		bool reg_update);
> >   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
