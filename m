Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADA8C433E3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 05:32:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4C82177B
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 05:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ajbc6Esw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4C82177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A434486ACC;
	Thu, 27 Aug 2020 05:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XSfnpT0vPt6; Thu, 27 Aug 2020 05:32:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 660EF869C9;
	Thu, 27 Aug 2020 05:32:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43802C0890;
	Thu, 27 Aug 2020 05:32:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5331C016F
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 05:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 809A7204C8
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 05:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-lEL53lNenB for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 05:32:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by silver.osuosl.org (Postfix) with ESMTP id 2E5BE20405
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 05:32:53 +0000 (UTC)
X-UUID: 4fffbe82f1f046eb8ef3ec22a46a7691-20200827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Ljw7Jcp00ljyO28csPPvYUltiWBjZk46SOJ+biHKHNY=; 
 b=Ajbc6Eswqs21Jefub6KGvvfv73Lud7orEBzwGtp+OitA8p7S9TTcJXMdW3OQ5FE3UE7NnVlzq20DoeDJrOLdOJWBSfTAKb1+XnG9tINMQnVJUPXR1GNlBzXCJWDFAoH/REsiFYWKPC/YbpMbScbICkq4Huk+C/d6ARU0ZVZUzRE=;
X-UUID: 4fffbe82f1f046eb8ef3ec22a46a7691-20200827
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 459103778; Thu, 27 Aug 2020 13:32:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 Aug 2020 13:32:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Aug 2020 13:32:44 +0800
Message-ID: <1598506280.19851.5.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH v4] iommu/mediatek: check 4GB mode by reading
 infracfg
From: Yong Wu <yong.wu@mediatek.com>
To: Miles Chen <miles.chen@mediatek.com>
Date: Thu, 27 Aug 2020 13:31:20 +0800
In-Reply-To: <20200826085618.2889-1-miles.chen@mediatek.com>
References: <20200826085618.2889-1-miles.chen@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: Rob Herring <robh@kernel.org>, wsd_upstream@mediatek.com,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, iommu@lists.linux-foundation.org,
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

On Wed, 2020-08-26 at 16:56 +0800, Miles Chen wrote:
> In previous discussion [1] and [2], we found that it is risky to
> use max_pfn or totalram_pages to tell if 4GB mode is enabled.
> 
> Check 4GB mode by reading infracfg register, remove the usage
> of the un-exported symbol max_pfn.
> 
> This is a step towards building mtk_iommu as a kernel module.
> 
> [1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
> [2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
> [3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> ---
> 
> Change since v3
> - use lore.kernel.org links
> - move "change since..." after "---"
> 
> Change since v2:
> - determine compatible string by m4u_plat
> - rebase to next-20200720
> - add "---"
> 
> Change since v1:
> - remove the phandle usage, search for infracfg instead [3]
> - use infracfg instead of infracfg_regmap
> - move infracfg definitaions to linux/soc/mediatek/infracfg.h
> - update enable_4GB only when has_4gb_mode
> ---
>  drivers/iommu/mtk_iommu.c             | 34 +++++++++++++++++++++++----
>  include/linux/soc/mediatek/infracfg.h |  3 +++
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 785b228d39a6..adc350150492 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2015-2016 MediaTek Inc.
>   * Author: Yong Wu <yong.wu@mediatek.com>
>   */
> -#include <linux/memblock.h>
>  #include <linux/bug.h>
>  #include <linux/clk.h>
>  #include <linux/component.h>
> @@ -15,13 +14,16 @@
>  #include <linux/iommu.h>
>  #include <linux/iopoll.h>
>  #include <linux/list.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/soc/mediatek/infracfg.h>
>  #include <asm/barrier.h>
>  #include <soc/mediatek/smi.h>
>  
> @@ -640,8 +642,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	struct resource         *res;
>  	resource_size_t		ioaddr;
>  	struct component_match  *match = NULL;
> +	struct regmap		*infracfg;
>  	void                    *protect;
>  	int                     i, larb_nr, ret;
> +	u32			val;
> +	char                    *p;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -655,10 +660,29 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>  
> -	/* Whether the current dram is over 4GB */
> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
> -		data->enable_4GB = false;
> +	data->enable_4GB = false;
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> +		switch (data->plat_data->m4u_plat) {
> +		case M4U_MT2712:
> +			p = "mediatek,mt2712-infracfg";
> +			break;
> +		case M4U_MT8173:
> +			p = "mediatek,mt8173-infracfg";
> +			break;
> +		default:
> +			p = NULL;
> +		}
> +

This can be simplified:

        if (data->plat_data->m4u_plat == M4U_MT2712)
		p = "mediatek,mt2712-infracfg";
	else if(data->plat_data->m4u_plat == M4U_MT8173)
		p = "mediatek,mt8173-infracfg";
	else
		return -EINVAL;

Then,
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
	

> +		infracfg = syscon_regmap_lookup_by_compatible(p);
> +
> +		if (IS_ERR(infracfg))
> +			return PTR_ERR(infracfg);
> +
> +		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
> +		if (ret)
> +			return ret;
> +		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
> +	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	data->base = devm_ioremap_resource(dev, res);
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index fd25f0148566..233463d789c6 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -32,6 +32,9 @@
>  #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
>  						 BIT(7) | BIT(8))
>  
> +#define REG_INFRA_MISC				0xf00
> +#define F_DDR_4GB_SUPPORT_EN			BIT(13)
> +
>  int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
>  		bool reg_update);
>  int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
