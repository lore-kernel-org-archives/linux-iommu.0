Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3862C56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CAA20857
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CAA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F70686ACB;
	Wed, 25 Nov 2020 16:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IK5d-+Snajof; Wed, 25 Nov 2020 16:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D8E886A14;
	Wed, 25 Nov 2020 16:38:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48A16C0891;
	Wed, 25 Nov 2020 16:38:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19334C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0887286F06
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9qviF8fZ__7 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 919D486EF9
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F333931B;
 Wed, 25 Nov 2020 08:38:48 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2E953F7BB;
 Wed, 25 Nov 2020 08:38:46 -0800 (PST)
Subject: Re: [PATCH v2 6/6] iommu/mediatek: Convert tlb_flush_walk to
 gather_add_page
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-7-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <94c11702-0ca0-62bb-2980-1daa4e147fb0@arm.com>
Date: Wed, 25 Nov 2020 16:38:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-7-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, jun.wen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-11-19 06:18, Yong Wu wrote:
> MediaTek TLB flush don't care about granule. when unmap, it could gather
> whole the iova range then do tlb flush once.
> 
> In current v7s, If unmap the lvl2 pagetable, the steps are:
> step1: set this current pdg to 0.
> step2: tlb flush for this lvl2 block iova(1M).
> step3: free the lvl2 pagetable.
> 
> This patch means we delay the step2 after unmap whole the iova.
> the iommu consumer HW should have stopped before it call dma_free_xx,
> thus, this delay looks ok.

If you can guarantee that no kind of speculative table walks can happen 
(i.e. the hardware has no kind of translation prefetching that could be 
triggered by, say, an unrelated device accessing an adjacent page) then 
I guess it's probably OK to reason that this can be safe.

However at that point I wonder whether you really need to do anything 
for flush_walk at all, if you don't need to differentiate between leaf 
and non-leaf invalidations either. In DMA API usage you should never be 
actually unmapping a table at block granularity, since the matching map 
request would have used a block mapping in the first place, so I guess 
you're hitting this in the case of *mapping* a block over an empty 
table. For that, the subsequent iotlb_sync_map() will overlap the whole 
region anyway. You'd still want to handle the general unmap case 
properly for the sake of correctness, but AFAICS you could just 
manipulate the gather data directly in mtk_iommu_unmap() far more easily 
than threading a special case all the way through io-pgtable.

> Since tlb_flush_walk doesn't have the "gather" parameter, so we have to
> add this "gather" in ourself private data.
> 
> Meanswhile, After this patch, the gather_add_pages will always be called,
> then "gather->start == ULONG_MAX" is impossible. remove this checking.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> tlb_flush_walk is designed for tlb flush range, I'm not sure whether it's ok
> if adding "gather" as a parameter in tlb_flush_walk. in this version, I put
> it into our private data.
> ---
>   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 94786860bd84..4c8200f4403a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -128,6 +128,8 @@ struct mtk_iommu_domain {
>   	struct io_pgtable_ops		*iop;
>   
>   	struct iommu_domain		domain;
> +
> +	struct iommu_iotlb_gather	*gather;
>   };
>   
>   static const struct iommu_ops mtk_iommu_ops;
> @@ -227,6 +229,17 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   	}
>   }
>   
> +static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
> +				     size_t granule, void *cookie)
> +{
> +	struct mtk_iommu_data *data = cookie;
> +	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
> +	struct iommu_domain *domain = &m4u_dom->domain;
> +
> +	/* Gather all the iova and tlb flush once after unmap. */
> +	iommu_iotlb_gather_add_page(domain, m4u_dom->gather, iova, size);
> +}
> +
>   static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>   					    unsigned long iova, size_t granule,
>   					    void *cookie)
> @@ -239,8 +252,8 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>   
>   static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>   	.tlb_flush_all = mtk_iommu_tlb_flush_all,
> -	.tlb_flush_walk = mtk_iommu_tlb_flush_range_sync,
> -	.tlb_flush_leaf = mtk_iommu_tlb_flush_range_sync,
> +	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
> +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
>   	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
>   };
>   
> @@ -432,6 +445,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>   {
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>   
> +	dom->gather = gather;

Either way, this definitely doesn't work - multiple threads could be 
unmapping different regions in the same domain at the same time. That's 
why the gather structure has to be on each caller's stack in the first 
place.

Robin.

>   	gather->granule_ignore = true;
>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>   }
> @@ -447,9 +461,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>   	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>   	size_t length = gather->end - gather->start;
>   
> -	if (gather->start == ULONG_MAX)
> -		return;
> -
>   	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>   				       data);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
