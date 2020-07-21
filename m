Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA9C433E1
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021BC208E4
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZRsNNfLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021BC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BBA64874E3;
	Tue, 21 Jul 2020 11:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2z23zwQuy3Z8; Tue, 21 Jul 2020 11:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8B56874C8;
	Tue, 21 Jul 2020 11:25:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 965C6C088E;
	Tue, 21 Jul 2020 11:25:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 788E5C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64DC88945C
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eL3zBlXgw-KJ for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 11:25:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E1EB89451
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 11:25:50 +0000 (UTC)
X-UUID: 0515596a95c24048a7b50e6f2c9789e6-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=qpykmZSQGs2bMX7gw2YPF5m+GwO54FLnah9QDtNvrQ0=; 
 b=ZRsNNfLe2QClA7ks/IJQ35Eb2WrkD3idGZMPmzmS5ZcXcFbVPc1u1eiC1TCntDcxiRiiePXhccXyq7TIX7P/TKHaqCp+sHB+YRbGNufIqdQExCocbCLvStuwJJ2eqgxjx3kRj5Hynm8dwpKyZniVfhH6iZmfzNYLoVW1SACiRi0=;
X-UUID: 0515596a95c24048a7b50e6f2c9789e6-20200721
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1266660983; Tue, 21 Jul 2020 19:25:42 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 21 Jul 2020 19:25:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 19:25:39 +0800
Message-ID: <1595330677.16172.55.camel@mhfsdcap03>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 21 Jul 2020 19:24:37 +0800
In-Reply-To: <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
 <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FAB7B75237DE000BACAED1A8055572801DDE7023171D49975F3AB582270F9ECD2000:8
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com,
 David Hildenbrand <david@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 Miles Chen <miles.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Tue, 2020-07-21 at 11:40 +0200, Matthias Brugger wrote:
> 
> On 21/07/2020 04:16, Miles Chen wrote:
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
> > 
> > [1] https://lkml.org/lkml/2020/6/3/733
> > [2] https://lkml.org/lkml/2020/6/4/136
> > [3] https://lkml.org/lkml/2020/7/15/1147
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
> >   drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
> >   include/linux/soc/mediatek/infracfg.h |  3 +++
> >   2 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2be96f1cdbd2..16765f532853 100644
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
> > @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >   	struct resource         *res;
> >   	resource_size_t		ioaddr;
> >   	struct component_match  *match = NULL;
> > +	struct regmap		*infracfg;
> >   	void                    *protect;
> >   	int                     i, larb_nr, ret;
> > +	u32			val;
> >   
> >   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >   	if (!data)
> > @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
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
> 
> I think we should check m4u_plat instead to decide which compatible we have to 
> look for.
> Another option would be to add a general compatible something like 
> "mtk-infracfg" and search for that. That would need an update of all DTS having 
> a infracfg compatible right now. After thinking twice, this would break newer 
> kernel with older device tree, so maybe it's better to go with m4u_plat switch 
> statement.

Add a "char *infracfg" in the plat_data, Use the mt2712, mt8173
corresponding string in it. If it is NULL, It means the "enable_4GB"
always is false. Then we also can remove the flag "has_4gb_mode".

is this OK?

> 
> Regards,
> Matthias
> 
> > +
> > +		}
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
