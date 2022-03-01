Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C9C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 13:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7A594155B;
	Tue,  1 Mar 2022 13:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aamm-yhaECEu; Tue,  1 Mar 2022 13:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E6D54155F;
	Tue,  1 Mar 2022 13:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57706C0077;
	Tue,  1 Mar 2022 13:56:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDF51C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 13:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EA6A824EF
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 13:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOgfUco5d8da for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 13:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E281824E3
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 13:56:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66ABA1042;
 Tue,  1 Mar 2022 05:56:36 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA0353F70D;
 Tue,  1 Mar 2022 05:56:34 -0800 (PST)
Message-ID: <b10031aa-8e49-70b3-b498-8aa6b7021fbb@arm.com>
Date: Tue, 1 Mar 2022 13:56:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] iommu/iova: Reset max32_alloc_size after cleaning
 rcache in the fail path
Content-Language: en-GB
To: yf.wang@mediatek.com
References: <20220301014246.5011-1-yf.wang@mediatek.com>
 <20220301015919.5116-1-yf.wang@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220301015919.5116-1-yf.wang@mediatek.com>
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning.Li@mediatek.com,
 matthias.bgg@gmail.com, stable@vger.kernel.org, will@kernel.org,
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

On 2022-03-01 01:59, yf.wang--- via iommu wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In alloc_iova_fast function, if __alloc_and_insert_iova_range fail,
> alloc_iova_fast will try flushing rcache and retry alloc iova, but
> this has an issue:
> 
> Since __alloc_and_insert_iova_range fail will set the current alloc
> iova size to max32_alloc_size (iovad->max32_alloc_size = size),
> when the retry is executed into the __alloc_and_insert_iova_range
> function, the retry action will be blocked by the check condition
> (size >= iovad->max32_alloc_size) and goto iova32_full directly,
> causes the action of retry regular alloc iova in
> __alloc_and_insert_iova_range to not actually be executed.
> 
> Based on the above, so need reset max32_alloc_size before retry alloc
> iova when alloc iova fail, that is set the initial dma_32bit_pfn value
> of iovad to max32_alloc_size, so that the action of retry alloc iova
> in __alloc_and_insert_iova_range can be executed.

Have you observed this making any difference in practice?

Given that both free_cpu_cached_iovas() and free_global_cached_iovas() 
call iova_magazine_free_pfns(), which calls remove_iova(), which calls 
__cached_rbnode_delete_update(), I'm thinking no...

Robin.

> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Cc: <stable@vger.kernel.org> # 5.10.*
> ---
> v2: Cc stable@vger.kernel.org
>      1. This patch needs to be merged stable branch, add stable@vger.kernel.org
>         in mail list.
> 
> ---
>   drivers/iommu/iova.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b28c9435b898..0c085ae8293f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -453,6 +453,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   retry:
>   	new_iova = alloc_iova(iovad, size, limit_pfn, true);
>   	if (!new_iova) {
> +		unsigned long flags;
>   		unsigned int cpu;
>   
>   		if (!flush_rcache)
> @@ -463,6 +464,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>   		for_each_online_cpu(cpu)
>   			free_cpu_cached_iovas(cpu, iovad);
>   		free_global_cached_iovas(iovad);
> +
> +		/* Reset max32_alloc_size after flushing rcache for retry */
> +		spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +
>   		goto retry;
>   	}
>   
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
