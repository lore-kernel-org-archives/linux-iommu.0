Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC4C6377D
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 14:59:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89276128C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 14:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89276128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95FDF40253;
	Thu, 22 Jul 2021 14:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gkh14fpFceWU; Thu, 22 Jul 2021 14:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40A6640259;
	Thu, 22 Jul 2021 14:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A660C001A;
	Thu, 22 Jul 2021 14:58:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 712FCC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 14:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F1AD40259
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 14:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cKkL2WynnzdU for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 14:58:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50DB840253
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 14:58:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B620106F;
 Thu, 22 Jul 2021 07:58:53 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5328B3F694;
 Thu, 22 Jul 2021 07:58:52 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: kmemleak when disable SRIOV.
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, iommu@lists.linux-foundation.org
References: <20210722081629.7863-1-PengJu.Zhou@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4b59b7ee-5258-a2ca-531c-b1b5d9c064e7@arm.com>
Date: Thu, 22 Jul 2021 15:58:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722081629.7863-1-PengJu.Zhou@amd.com>
Content-Language: en-GB
Cc: Alexander.Deucher@amd.com, Yin.Wang@amd.com, will@kernel.org
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

On 2021-07-22 09:16, Peng Ju Zhou via iommu wrote:
> the object iova->head allocated statically when enable SRIOV but
> freed dynamically when disable SRIOV which causing kmemleak.
> changing the allocation from statically to dynamically.

Thanks for the glimpse into the kind of weird and wonderful things 
people are doing to the IOVA allocator out-of-tree (the "holes" list 
sounds like an idea I also thought about a long time ago), but judging 
by the context this patch is clearly of no use to mainline ;)

Robin.

> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>   drivers/iommu/iova.c | 15 ++++++++-------
>   include/linux/iova.h |  4 ++--
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 2371524796d3..505881d8d97f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -26,6 +26,8 @@ static void free_iova_rcaches(struct iova_domain *iovad);
>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>   static void fq_flush_timeout(struct timer_list *t);
>   static void free_global_cached_iovas(struct iova_domain *iovad);
> +static inline struct iova *alloc_and_init_iova(unsigned long pfn_lo,
> +					       unsigned long pfn_hi);
>   
>   void
>   init_iova_domain(struct iova_domain *iovad, unsigned long granule,
> @@ -47,17 +49,16 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   
>   	INIT_LIST_HEAD(&iovad->holes);
>   
> -	iovad->head.pfn_lo = 0;
> -	iovad->head.pfn_hi = start_pfn;
> -	rb_link_node(&iovad->head.node, NULL, &iovad->rbroot.rb_node);
> -	rb_insert_color(&iovad->head.node, &iovad->rbroot);
> -	list_add(&iovad->head.hole, &iovad->holes);
> +	iovad->head = alloc_and_init_iova(0, start_pfn);
> +	rb_link_node(&iovad->head->node, NULL, &iovad->rbroot.rb_node);
> +	rb_insert_color(&iovad->head->node, &iovad->rbroot);
> +	list_add(&iovad->head->hole, &iovad->holes);
>   
>   	iovad->tail.pfn_lo = IOVA_ANCHOR;
>   	iovad->tail.pfn_hi = IOVA_ANCHOR;
>   	rb_link_node(&iovad->tail.node,
> -		     &iovad->head.node,
> -		     &iovad->head.node.rb_right);
> +		     &iovad->head->node,
> +		     &iovad->head->node.rb_right);
>   	rb_insert_color(&iovad->tail.node, &iovad->rbroot);
>   
>   	init_iova_rcaches(iovad);
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 076eb6cfc613..553905ef41fe 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -81,7 +81,7 @@ struct iova_domain {
>   						   have been finished */
>   
>   	struct list_head holes;
> -	struct iova	head, tail;		/* rbtree lookup anchors */
> +	struct iova	*head, tail;		/* rbtree lookup anchors */
>   	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
>   
>   	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
> @@ -252,7 +252,7 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
>   
>   static inline unsigned long iovad_start_pfn(struct iova_domain *iovad)
>   {
> -	return iovad->head.pfn_hi;
> +	return iovad->head->pfn_hi;
>   }
>   
>   #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
