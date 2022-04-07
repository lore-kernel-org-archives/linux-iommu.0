Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C94C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 07:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89FCD83EDF;
	Thu,  7 Apr 2022 07:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7WH9OP0lL9K; Thu,  7 Apr 2022 07:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49FDF83E2B;
	Thu,  7 Apr 2022 07:53:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0F0C001D;
	Thu,  7 Apr 2022 07:53:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC8EC0012;
 Thu,  7 Apr 2022 07:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81CE240570;
 Thu,  7 Apr 2022 07:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bptGlxN9E_7Q; Thu,  7 Apr 2022 07:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACC6F400CC;
 Thu,  7 Apr 2022 07:52:58 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KYtrp6zp8z13VdT;
 Thu,  7 Apr 2022 15:52:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 15:52:47 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 15:52:54 +0800
Subject: Re: [PATCH RESEND v5 2/5] iova: Allow rcache range upper limit to be
 flexible
To: John Garry <john.garry@huawei.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <robin.murphy@arm.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-3-git-send-email-john.garry@huawei.com>
Message-ID: <834447a0-675a-5978-8ffe-285ce09f4213@huawei.com>
Date: Thu, 7 Apr 2022 15:52:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1649071634-188535-3-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, jasowang@redhat.com, mst@redhat.com,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
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
From: "Leizhen \(ThunderTown\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2022/4/4 19:27, John Garry wrote:
> Some low-level drivers may request DMA mappings whose IOVA length exceeds
> that of the current rcache upper limit.
> 
> This means that allocations for those IOVAs will never be cached, and
> always must be allocated and freed from the RB tree per DMA mapping cycle.
> This has a significant effect on performance, more so since commit
> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> fails"), as discussed at [0].
> 
> As a first step towards allowing the rcache range upper limit be
> configured, hold this value in the IOVA rcache structure, and allocate
> the rcaches separately.
> 
> Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 20 ++++++++++----------
>  include/linux/iova.h |  3 +++
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..5c22b9187b79 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,8 +15,6 @@
>  /* The anchor node sits above the top of the usable address space */
>  #define IOVA_ANCHOR	~0UL
>  
> -#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> -
>  static bool iova_rcache_insert(struct iova_domain *iovad,
>  			       unsigned long pfn,
>  			       unsigned long size);
> @@ -443,7 +441,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  	 * rounding up anything cacheable to make sure that can't happen. The
>  	 * order of the unadjusted size will still match upon freeing.
>  	 */
> -	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +	if (size < (1 << (iovad->rcache_max_size - 1)))
>  		size = roundup_pow_of_two(size);
>  
>  	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> @@ -713,13 +711,15 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>  	unsigned int cpu;
>  	int i, ret;
>  
> -	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> +	iovad->rcache_max_size = 6; /* Arbitrarily high default */

It would be better to assign this constant value to iovad->rcache_max_size in init_iova_domain().

> +
> +	iovad->rcaches = kcalloc(iovad->rcache_max_size,
>  				 sizeof(struct iova_rcache),
>  				 GFP_KERNEL);
>  	if (!iovad->rcaches)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < iovad->rcache_max_size; ++i) {
>  		struct iova_cpu_rcache *cpu_rcache;
>  		struct iova_rcache *rcache;
>  
> @@ -816,7 +816,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pfn,
>  {
>  	unsigned int log_size = order_base_2(size);
>  
> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
> +	if (log_size >= iovad->rcache_max_size)
>  		return false;
>  
>  	return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
> @@ -872,7 +872,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  {
>  	unsigned int log_size = order_base_2(size);
>  
> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
> +	if (log_size >= iovad->rcache_max_size || !iovad->rcaches)
>  		return 0;
>  
>  	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> @@ -888,7 +888,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>  	unsigned int cpu;
>  	int i, j;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < iovad->rcache_max_size; ++i) {
>  		rcache = &iovad->rcaches[i];
>  		if (!rcache->cpu_rcaches)
>  			break;
> @@ -916,7 +916,7 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>  	unsigned long flags;
>  	int i;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < iovad->rcache_max_size; ++i) {
>  		rcache = &iovad->rcaches[i];
>  		cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>  		spin_lock_irqsave(&cpu_rcache->lock, flags);
> @@ -935,7 +935,7 @@ static void free_global_cached_iovas(struct iova_domain *iovad)
>  	unsigned long flags;
>  	int i, j;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (i = 0; i < iovad->rcache_max_size; ++i) {
>  		rcache = &iovad->rcaches[i];
>  		spin_lock_irqsave(&rcache->lock, flags);
>  		for (j = 0; j < rcache->depot_size; ++j) {
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..02f7222fa85a 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -38,6 +38,9 @@ struct iova_domain {
>  
>  	struct iova_rcache	*rcaches;
>  	struct hlist_node	cpuhp_dead;
> +
> +	/* log of max cached IOVA range size (in pages) */
> +	unsigned long	rcache_max_size;
>  };
>  
>  static inline unsigned long iova_size(struct iova *iova)
> 

-- 
Regards,
  Zhen Lei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
