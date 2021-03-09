Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754EAC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE05665253
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 15:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE05665253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EBBF6F4FD;
	Tue,  9 Mar 2021 15:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbasxGxlN1Ef; Tue,  9 Mar 2021 15:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63DC56F54A;
	Tue,  9 Mar 2021 15:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF94C000B;
	Tue,  9 Mar 2021 15:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF32C0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 15:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E76E430DE
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 15:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_ffl8P6rtVQ for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 15:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D90A2430DD
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 15:57:28 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dw0511sW8z67w3k;
 Tue,  9 Mar 2021 23:49:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 16:57:25 +0100
Received: from [10.210.172.22] (10.210.172.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 15:57:24 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
Date: Tue, 9 Mar 2021 15:55:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.172.22]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vjitta@codeaurora.org
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

On 05/03/2021 16:35, Robin Murphy wrote:

Hi Robin,

> When restarting after searching below the cached node fails, resetting
> the start point to the anchor node is often overly pessimistic. If
> allocations are made with mixed limits - particularly in the case of the
> opportunistic 32-bit allocation for PCI devices - this could mean
> significant time wasted walking through the whole populated upper range
> just to reach the initial limit. 

Right

> We can improve on that by implementing
> a proper tree traversal to find the first node above the relevant limit,
> and set the exact start point.

Thanks for this. However, as mentioned in the other thread, this does 
not help our performance regression Re: commit 4e89dce72521.

And mentioning this "retry" approach again, in case it was missed, from 
my experiment on the affected HW, it also has generally a dreadfully low 
success rate - less than 1% for the 32b range retry. Retry rate is about 
20%. So I am saying from this 20%, less than 1% of those succeed.

Failing faster sounds key.

Thanks,
John

> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c28003e1d2ee..471c48dd71e7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -154,6 +154,43 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   		iovad->cached_node = rb_next(&free->node);
>   }
>   
> +static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> +{
> +	struct rb_node *node, *next;
> +	/*
> +	 * Ideally what we'd like to judge here is whether limit_pfn is close
> +	 * enough to the highest-allocated IOVA that starting the allocation
> +	 * walk from the anchor node will be quicker than this initial work to
> +	 * find an exact starting point (especially if that ends up being the
> +	 * anchor node anyway). This is an incredibly crude approximation which
> +	 * only really helps the most likely case, but is at least trivially easy.
> +	 */
> +	if (limit_pfn > iovad->dma_32bit_pfn)
> +		return &iovad->anchor.node;
> +
> +	node = iovad->rbroot.rb_node;
> +	while (to_iova(node)->pfn_hi < limit_pfn)
> +		node = node->rb_right;
> +
> +search_left:
> +	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> +		node = node->rb_left;
> +
> +	if (!node->rb_left)
> +		return node;
> +
> +	next = node->rb_left;
> +	while (next->rb_right) {
> +		next = next->rb_right;
> +		if (to_iova(next)->pfn_lo >= limit_pfn) {
> +			node = next;
> +			goto search_left;
> +		}
> +	}
> +
> +	return node;
> +}
> +
>   /* Insert the iova into domain rbtree by holding writer lock */
>   static void
>   iova_insert_rbtree(struct rb_root *root, struct iova *iova,
> @@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>   			high_pfn = limit_pfn;
>   			low_pfn = retry_pfn;
> -			curr = &iovad->anchor.node;
> +			curr = iova_find_limit(iovad, limit_pfn);
>   			curr_iova = to_iova(curr);
>   			goto retry;
>   		}
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
