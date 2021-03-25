Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A7C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B0061A11
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B0061A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CE814018A;
	Thu, 25 Mar 2021 12:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ugGYLhGP0l10; Thu, 25 Mar 2021 12:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE7294016B;
	Thu, 25 Mar 2021 12:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEE28C000E;
	Thu, 25 Mar 2021 12:52:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E738C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0111640F3A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKu-vyy0Mje4 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 12:52:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB1DE40F39
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:52:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEAC71474;
 Thu, 25 Mar 2021 05:52:40 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5083F792;
 Thu, 25 Mar 2021 05:52:39 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] iommu: Delete iommu_dma_free_cpu_cached_iovas()
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
 <1616675401-151997-4-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9852e410-eec8-1d82-8704-cd7bc8b0a07b@arm.com>
Date: Thu, 25 Mar 2021 12:52:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616675401-151997-4-git-send-email-john.garry@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

On 2021-03-25 12:30, John Garry wrote:
> Function iommu_dma_free_cpu_cached_iovas() no longer has any caller, so
> delete it.
> 
> With that, function free_cpu_cached_iovas() may be made static.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 9 ---------
>   drivers/iommu/iova.c      | 3 ++-
>   include/linux/dma-iommu.h | 8 --------
>   include/linux/iova.h      | 5 -----
>   4 files changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..9da7e9901bec 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -53,15 +53,6 @@ struct iommu_dma_cookie {
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain)
> -{
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> -
> -	free_cpu_cached_iovas(cpu, iovad);
> -}
> -
>   static void iommu_dma_entry_dtor(unsigned long data)
>   {
>   	struct page *freelist = (struct page *)data;
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c78312560425..8a493ee92c79 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -22,6 +22,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   				     unsigned long size,
>   				     unsigned long limit_pfn);
>   static void init_iova_rcaches(struct iova_domain *iovad);
> +static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   static void free_iova_rcaches(struct iova_domain *iovad);
>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>   static void fq_flush_timeout(struct timer_list *t);
> @@ -998,7 +999,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   /*
>    * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
>    */
> -void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
> +static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   {
>   	struct iova_cpu_rcache *cpu_rcache;
>   	struct iova_rcache *rcache;
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 706b68d1359b..2112f21f73d8 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -37,9 +37,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain);
> -
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
> @@ -81,10 +78,5 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> -static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain)
> -{
> -}
> -
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 4be6c0ab4997..71d8a2de6635 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -157,7 +157,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>   			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void put_iova_domain(struct iova_domain *iovad);
> -void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   #else
>   static inline int iova_cache_get(void)
>   {
> @@ -234,10 +233,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
>   {
>   }
>   
> -static inline void free_cpu_cached_iovas(unsigned int cpu,
> -					 struct iova_domain *iovad)
> -{
> -}
>   #endif
>   
>   #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
