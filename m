Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F1C433E0
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 07:17:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2AE206F5
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 07:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eiGybXaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2AE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40BEA87C5B;
	Wed, 22 Jul 2020 07:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CiowxlWelV-m; Wed, 22 Jul 2020 07:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 935AF8789B;
	Wed, 22 Jul 2020 07:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A756C088E;
	Wed, 22 Jul 2020 07:17:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F841C016F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0BCB487C57
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tHN+hxkAC4+c for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 07:17:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id D09BE8789B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 07:17:25 +0000 (UTC)
X-UUID: 7a2513fa0d424fa1a7682445476d6c20-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=0eYS2Sr9yV83oAq6NJ7EPUIvy6CetJuQT3lQICq8KtI=; 
 b=eiGybXaI8Y+E4yJdFDB9GZh+xxct51/zsUP0YJWa2H+gIUVbnQbJzQs9vxlYKJ/Vh+IID3oXb1Yhr34TJST3HN/oq9/qtgq61Kbq7kYRQBceIMrjc7Lu8rLPnXS0oHwJxN0F9zPU24Vg0Y5SzLpb9WG7p5iw7CQC8ew5Xmd/w44=;
X-UUID: 7a2513fa0d424fa1a7682445476d6c20-20200722
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1610361252; Wed, 22 Jul 2020 15:17:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:17:17 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:17:18 +0800
Message-ID: <1595402238.10848.3.camel@mtkswgap22>
Subject: Re: [PATCH v2] iommu/mediatek: check 4GB mode by reading infracfg
From: Miles Chen <miles.chen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 22 Jul 2020 15:17:18 +0800
In-Reply-To: <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
References: <20200721021619.25575-1-miles.chen@mediatek.com>
 <cbdd2820-fd3c-3e51-8140-58408dcf3cd3@gmail.com>
 <1595330677.16172.55.camel@mhfsdcap03>
 <28bf052f-e388-d300-4abe-38f17bff01b6@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 58DFCF7CA20D7056E3E09FFF1EF0DBB987C420E96805A5AFD92BC2023E6D19FD2000:8
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On Tue, 2020-07-21 at 23:19 +0200, Matthias Brugger wrote:
> 
> On 21/07/2020 13:24, Yong Wu wrote:
> > On Tue, 2020-07-21 at 11:40 +0200, Matthias Brugger wrote:
> >>
> >> On 21/07/2020 04:16, Miles Chen wrote:
> >>> In previous discussion [1] and [2], we found that it is risky to
> >>> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> >>>
> >>> Check 4GB mode by reading infracfg register, remove the usage
> >>> of the un-exported symbol max_pfn.
> >>>
> >>> This is a step towards building mtk_iommu as a kernel module.
> >>>
> >>> Change since v1:
> >>> 1. remove the phandle usage, search for infracfg instead [3]
> >>> 2. use infracfg instead of infracfg_regmap
> >>> 3. move infracfg definitaions to linux/soc/mediatek/infracfg.h
> >>> 4. update enable_4GB only when has_4gb_mode
> >>>
> >>> [1] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/3/733__;!!CTRNKA9wMg0ARbw!w5YjY83YRL9_ijgXHwB1x2Dnb5BqiFUI8H5IAyAWWFMvUJKI9Qbj_zta2AaiFZejiQ$ 
> >>> [2] https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/4/136__;!!CTRNKA9wMg0ARbw!w5YjY83YRL9_ijgXHwB1x2Dnb5BqiFUI8H5IAyAWWFMvUJKI9Qbj_zta2Aa9U2yQyg$ 
> >>> [3] https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/15/1147__;!!CTRNKA9wMg0ARbw!w5YjY83YRL9_ijgXHwB1x2Dnb5BqiFUI8H5IAyAWWFMvUJKI9Qbj_zta2Aaxpk_Wjw$ 
> >>>
> >>> Cc: Mike Rapoport <rppt@linux.ibm.com>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Yong Wu <yong.wu@mediatek.com>
> >>> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Cc: Yong Wu <yong.wu@mediatek.com>
> >>> Cc: Chao Hao <chao.hao@mediatek.com>
> >>> Cc: Rob Herring <robh@kernel.org>
> >>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> >>> ---
> >>>    drivers/iommu/mtk_iommu.c             | 26 +++++++++++++++++++++-----
> >>>    include/linux/soc/mediatek/infracfg.h |  3 +++
> >>>    2 files changed, 24 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> >>> index 2be96f1cdbd2..16765f532853 100644
> >>> --- a/drivers/iommu/mtk_iommu.c
> >>> +++ b/drivers/iommu/mtk_iommu.c
> >>> @@ -3,7 +3,6 @@
> >>>     * Copyright (c) 2015-2016 MediaTek Inc.
> >>>     * Author: Yong Wu <yong.wu@mediatek.com>
> >>>     */
> >>> -#include <linux/memblock.h>
> >>>    #include <linux/bug.h>
> >>>    #include <linux/clk.h>
> >>>    #include <linux/component.h>
> >>> @@ -15,13 +14,16 @@
> >>>    #include <linux/iommu.h>
> >>>    #include <linux/iopoll.h>
> >>>    #include <linux/list.h>
> >>> +#include <linux/mfd/syscon.h>
> >>>    #include <linux/of_address.h>
> >>>    #include <linux/of_iommu.h>
> >>>    #include <linux/of_irq.h>
> >>>    #include <linux/of_platform.h>
> >>>    #include <linux/platform_device.h>
> >>> +#include <linux/regmap.h>
> >>>    #include <linux/slab.h>
> >>>    #include <linux/spinlock.h>
> >>> +#include <linux/soc/mediatek/infracfg.h>
> >>>    #include <asm/barrier.h>
> >>>    #include <soc/mediatek/smi.h>
> >>>    
> >>> @@ -599,8 +601,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >>>    	struct resource         *res;
> >>>    	resource_size_t		ioaddr;
> >>>    	struct component_match  *match = NULL;
> >>> +	struct regmap		*infracfg;
> >>>    	void                    *protect;
> >>>    	int                     i, larb_nr, ret;
> >>> +	u32			val;
> >>>    
> >>>    	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >>>    	if (!data)
> >>> @@ -614,10 +618,22 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >>>    		return -ENOMEM;
> >>>    	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> >>>    
> >>> -	/* Whether the current dram is over 4GB */
> >>> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> >>> -	if (!data->plat_data->has_4gb_mode)
> >>> -		data->enable_4GB = false;
> >>> +	data->enable_4GB = false;
> >>> +	if (data->plat_data->has_4gb_mode) {
> >>> +		infracfg = syscon_regmap_lookup_by_compatible(
> >>> +				"mediatek,mt8173-infracfg");
> >>> +		if (IS_ERR(infracfg)) {
> >>> +			infracfg = syscon_regmap_lookup_by_compatible(
> >>> +					"mediatek,mt2712-infracfg");
> >>> +			if (IS_ERR(infracfg))
> >>> +				return PTR_ERR(infracfg);
> >>
> >> I think we should check m4u_plat instead to decide which compatible we have to
> >> look for.
> >> Another option would be to add a general compatible something like
> >> "mtk-infracfg" and search for that. That would need an update of all DTS having
> >> a infracfg compatible right now. After thinking twice, this would break newer
> >> kernel with older device tree, so maybe it's better to go with m4u_plat switch
> >> statement.
> > 
> > Add a "char *infracfg" in the plat_data, Use the mt2712, mt8173
> > corresponding string in it. If it is NULL, It means the "enable_4GB"
> > always is false. Then we also can remove the flag "has_4gb_mode".
> > 
> > is this OK?
> > 
> 
> It's an option, but I personally find that a bit hacky.

Thanks Yong and Matthias for your comment.
I will try adding a char *infracfg in patch v3.


> 
> Regards,
> Matthias

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
