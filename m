Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6FC43466
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 14:41:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5772311B
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 14:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5772311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 16EFF87394;
	Fri, 18 Sep 2020 14:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bt6sMLFQlEj8; Fri, 18 Sep 2020 14:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0390B872EA;
	Fri, 18 Sep 2020 14:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3BCC0888;
	Fri, 18 Sep 2020 14:41:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAB4C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7022E8712C
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbE6ylloRhfM for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 14:41:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9120A870F7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 14:41:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 079E51045;
 Fri, 18 Sep 2020 07:41:03 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A923F718;
 Fri, 18 Sep 2020 07:41:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: vjitta@codeaurora.org, joro@8bytes.org, iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
Date: Fri, 18 Sep 2020 15:41:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

On 2020-08-20 13:49, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever an iova alloc request fails we free the iova
> ranges present in the percpu iova rcaches and then retry
> but the global iova rcache is not freed as a result we could
> still see iova alloc failure even after retry as global
> rcache is holding the iova's which can cause fragmentation.
> So, free the global iova rcache as well and then go for the
> retry.
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>   include/linux/iova.h |  6 ++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 4e77116..5836c87 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>   		flush_rcache = false;
>   		for_each_online_cpu(cpu)
>   			free_cpu_cached_iovas(cpu, iovad);
> +		free_global_cached_iovas(iovad);
>   		goto retry;
>   	}
>   
> @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   	}
>   }
>   
> +/*
> + * free all the IOVA ranges of global cache
> + */
> +void free_global_cached_iovas(struct iova_domain *iovad)

As John pointed out last time, this should be static and the header 
changes dropped.

(TBH we should probably register our own hotplug notifier instance for a 
flush queue, so that external code has no need to poke at the per-CPU 
caches either)

Robin.

> +{
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
> +	int i, j;
> +
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		spin_lock_irqsave(&rcache->lock, flags);
> +		for (j = 0; j < rcache->depot_size; ++j) {
> +			iova_magazine_free_pfns(rcache->depot[j], iovad);
> +			iova_magazine_free(rcache->depot[j]);
> +			rcache->depot[j] = NULL;
> +		}
> +		rcache->depot_size = 0;
> +		spin_unlock_irqrestore(&rcache->lock, flags);
> +	}
> +}
> +
>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>   MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index a0637ab..a905726 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>   struct iova *split_and_remove_iova(struct iova_domain *iovad,
>   	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>   void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> +void free_global_cached_iovas(struct iova_domain *iovad);
>   #else
>   static inline int iova_cache_get(void)
>   {
> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
>   					 struct iova_domain *iovad)
>   {
>   }
> +
> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +}
> +
>   #endif
>   
>   #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
