Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC531C43219
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 05:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EBFC60C0B;
	Thu, 12 May 2022 05:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tugu4Y_XFezS; Thu, 12 May 2022 05:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4987560ADC;
	Thu, 12 May 2022 05:51:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11A43C0032;
	Thu, 12 May 2022 05:51:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F9FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A1A283E90
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wtVJgsAxMC4 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:51:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23F3183E6C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:51:18 +0000 (UTC)
X-UUID: bc075dd5dd7149c5a3d19c88f1121c7e-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:e210bcc1-f115-4f11-af59-f2692a195f82, OB:0,
 LO
 B:0,IP:0,URL:5,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:14
X-CID-META: VersionHash:faefae9, CLOUDID:f4a128f6-13a6-4067-b017-3b2864319134,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: bc075dd5dd7149c5a3d19c88f1121c7e-20220512
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 147289659; Thu, 12 May 2022 13:51:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 12 May 2022 13:51:12 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 13:51:11 +0800
Message-ID: <2ff41b86a7f7c7ce73cf800a7c1ecb531b835786.camel@mediatek.com>
Subject: Re: [PATCH] iommu/dma: Fix iova map result check bug
To: <yf.wang@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Logan
 Gunthorpe" <logang@deltatee.com>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, 
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Date: Thu, 12 May 2022 13:51:11 +0800
In-Reply-To: <20220507085204.16914-1-yf.wang@mediatek.com>
References: <20220507085204.16914-1-yf.wang@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Ning Li <Ning.Li@mediatek.com>, stable@vger.kernel.org,
 Libo Kang <Libo.Kang@mediatek.com>, wsd_upstream@mediatek.com
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, 2022-05-07 at 16:52 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> The data type of the return value of the iommu_map_sg_atomic
> is ssize_t, but the data type of iova size is size_t,
> e.g. one is int while the other is unsigned int.
> 
> When iommu_map_sg_atomic return value is compared with iova size,
> it will force the signed int to be converted to unsigned int, if
> iova map fails and iommu_map_sg_atomic return error code is less
> than 0, then (ret < iova_len) is false, which will to cause not
> do free iova, and the master can still successfully get the iova
> of map fail, which is not expected.
> 
> Therefore, we need to check the return value of iommu_map_sg_atomic
> in two cases according to whether it is less than 0.
> 
> Fixes: ad8f36e4b6b1 ("iommu: return full error code from
> iommu_map_sg[_atomic]()")
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Cc: <stable@vger.kernel.org> # 5.15.*
> ---
>  drivers/iommu/dma-iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..2932281e93fc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -776,6 +776,7 @@ static struct page
> **__iommu_dma_alloc_noncontiguous(struct device *dev,
>  	unsigned int count, min_size, alloc_sizes = domain-
> >pgsize_bitmap;
>  	struct page **pages;
>  	dma_addr_t iova;
> +	ssize_t ret;
>  
>  	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>  	    iommu_deferred_attach(dev, domain))
> @@ -813,8 +814,8 @@ static struct page
> **__iommu_dma_alloc_noncontiguous(struct device *dev,
>  			arch_dma_prep_coherent(sg_page(sg), sg-
> >length);
>  	}
>  
> -	if (iommu_map_sg_atomic(domain, iova, sgt->sgl, sgt-
> >orig_nents, ioprot)
> -			< size)
> +	ret = iommu_map_sg_atomic(domain, iova, sgt->sgl, sgt-
> >orig_nents, ioprot);
> +	if (ret < 0 || ret < size)

        if (IS_ERR_VALUE(ret) || ret < size) for readable?

>  		goto out_free_sg;
>  
>  	sgt->sgl->dma_address = iova;
> @@ -1209,7 +1210,7 @@ static int iommu_dma_map_sg(struct device *dev,
> struct scatterlist *sg,
>  	 * implementation - it knows better than we do.
>  	 */
>  	ret = iommu_map_sg_atomic(domain, iova, sg, nents, prot);
> -	if (ret < iova_len)
> +	if (ret < 0 || ret < iova_len)
>  		goto out_free_iova;
>  
>  	return __finalise_sg(dev, sg, nents, iova);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
