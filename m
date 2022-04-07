Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BD7C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E161540570;
	Thu,  7 Apr 2022 08:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM6pIo0yMAtj; Thu,  7 Apr 2022 08:27:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A6F2400CC;
	Thu,  7 Apr 2022 08:27:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48FA9C001D;
	Thu,  7 Apr 2022 08:27:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D67D0C0012;
 Thu,  7 Apr 2022 08:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEB9683E69;
 Thu,  7 Apr 2022 08:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_f4-TtplMtB; Thu,  7 Apr 2022 08:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C30378134B;
 Thu,  7 Apr 2022 08:27:23 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYvZM5L19zFpYl;
 Thu,  7 Apr 2022 16:24:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 16:27:19 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 16:27:18 +0800
Subject: Re: [PATCH RESEND v5 5/5] iova: Add iova_len argument to
 iova_domain_init_rcaches()
To: John Garry <john.garry@huawei.com>, <joro@8bytes.org>, <will@kernel.org>, 
 <robin.murphy@arm.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-6-git-send-email-john.garry@huawei.com>
Message-ID: <b09aeef5-106c-b477-e16b-a537929cb7c1@huawei.com>
Date: Thu, 7 Apr 2022 16:27:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1649071634-188535-6-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> Add max opt argument to iova_domain_init_rcaches(), and use it to set the
> rcaches range.
> 
> Also fix up all users to set this value (at 0, meaning use default),
> including a wrapper for that, iova_domain_init_rcaches_default().
> 
> For dma-iommu.c we derive the iova_len argument from the IOMMU group
> max opt DMA size.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c            | 15 ++++++++++++++-
>  drivers/iommu/iova.c                 | 19 ++++++++++++++++---
>  drivers/vdpa/vdpa_user/iova_domain.c |  4 ++--
>  include/linux/iova.h                 |  3 ++-
>  4 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 42ca42ff1b5d..19f35624611c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -525,6 +525,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	unsigned long order, base_pfn;
>  	struct iova_domain *iovad;
> +	size_t max_opt_dma_size;
> +	unsigned long iova_len = 0;
>  	int ret;
>  
>  	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> @@ -560,7 +562,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	}
>  
>  	init_iova_domain(iovad, 1UL << order, base_pfn);
> -	ret = iova_domain_init_rcaches(iovad);
> +
> +	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
> +	if (max_opt_dma_size) {
> +		unsigned long shift = __ffs(1UL << order);
> +
> +		iova_len = roundup_pow_of_two(max_opt_dma_size);
> +		iova_len >>= shift;
> +		if (!iova_len)
> +			iova_len = 1;

How about move "iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);" here? So that,
iova_domain_init_rcaches() can remain the same. And iova_domain_init_rcaches_default() does
not need to be added.

> +	}
> +
> +	ret = iova_domain_init_rcaches(iovad, iova_len);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 5c22b9187b79..d65e79e132ee 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -706,12 +706,20 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>  	mag->pfns[mag->size++] = pfn;
>  }
>  
> -int iova_domain_init_rcaches(struct iova_domain *iovad)
> +static unsigned long iova_len_to_rcache_max(unsigned long iova_len)
> +{
> +	return order_base_2(iova_len) + 1;
> +}
> +
> +int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len)
>  {
>  	unsigned int cpu;
>  	int i, ret;
>  
> -	iovad->rcache_max_size = 6; /* Arbitrarily high default */
> +	if (iova_len)
> +		iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);
> +	else
> +		iovad->rcache_max_size = 6; /* Arbitrarily high default */
>  
>  	iovad->rcaches = kcalloc(iovad->rcache_max_size,
>  				 sizeof(struct iova_rcache),
> @@ -755,7 +763,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>  	free_iova_rcaches(iovad);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
> +
> +int iova_domain_init_rcaches_default(struct iova_domain *iovad)
> +{
> +	return iova_domain_init_rcaches(iovad, 0);
> +}
> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches_default);
>  
>  /*
>   * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 6daa3978d290..3a2acef98a4a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -514,12 +514,12 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>  	spin_lock_init(&domain->iotlb_lock);
>  	init_iova_domain(&domain->stream_iovad,
>  			PAGE_SIZE, IOVA_START_PFN);
> -	ret = iova_domain_init_rcaches(&domain->stream_iovad);
> +	ret = iova_domain_init_rcaches_default(&domain->stream_iovad);
>  	if (ret)
>  		goto err_iovad_stream;
>  	init_iova_domain(&domain->consistent_iovad,
>  			PAGE_SIZE, bounce_pfns);
> -	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
> +	ret = iova_domain_init_rcaches_default(&domain->consistent_iovad);
>  	if (ret)
>  		goto err_iovad_consistent;
>  
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 02f7222fa85a..56281434ce0c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -95,7 +95,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>  	unsigned long pfn_hi);
>  void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn);
> -int iova_domain_init_rcaches(struct iova_domain *iovad);
> +int iova_domain_init_rcaches(struct iova_domain *iovad, unsigned long iova_len);
> +int iova_domain_init_rcaches_default(struct iova_domain *iovad);
>  struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>  void put_iova_domain(struct iova_domain *iovad);
>  #else
> 

-- 
Regards,
  Zhen Lei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
