Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A902F2F
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662456514; x=1693992514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QqmXy2GZLHSohVU0zyxyHogpet/ueg+VsoCb0iGCfBE=;
  b=NKeZAj434YxXUhGhckOSFVUoS3Cj2wQ8wjQoGZ93YXBABEpBv98ERH3f
   fvQQP7fFyhWeT5mcugbAUXqOS+pMARQfdAHyrojzWK90T1gcpe60rclUm
   M3CzzL94zS3DGD9Ez8x5a4jygwUMtTVTSQao8pH3Kmi7CPWlaw4BN0fyF
   tcpKFoWBup5UHCpyr9IMyZ1JNa+bu0J7CdpEPpIciyaR+f3OaA2J7cHKv
   AIbt6tYcf+j3rBhBawiCqzB56o1paNRaHH0Kmc9rizutIR17LoiC4KEJD
   AJcs6grXXvzRN4oPy/sO51ieS3+pPGe11oLouPW6G0g+DCYnLo42fXb+q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="322721086"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="322721086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 02:28:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="644091572"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.214.249]) ([10.254.214.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 02:28:32 -0700
Message-ID: <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
Date: Tue, 6 Sep 2022 17:28:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: John Garry <john.garry@huawei.com>, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <1662369083-238529-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

John,

在 2022/9/5 17:11, John Garry 写道:
> Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
> has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
> pointers. As such, the checks in iova_magazine_full(),
> iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..580fdf669922 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	unsigned long flags;
>   	int i;
>   
> -	if (!mag)
> -		return;
> -

iommu_probe_device
   ops->probe_finalize(dev);
     intel_iommu_probe_finalize
        iommu_setup_dma_ops
          iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
            iova_domain_init_rcaches
              {
              ...
              cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
              cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
   	     if (!cpu_rcache->loaded || !cpu_rcache->prev) {
			    ret = -ENOMEM;
   		            goto out_err;

Do you mean iova_magazine_alloc() is impossible to fail ?

Thanks,

Ethan

>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>   
>   	for (i = 0 ; i < mag->size; ++i) {
> @@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   
>   static bool iova_magazine_full(struct iova_magazine *mag)
>   {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	return mag->size == IOVA_MAG_SIZE;
>   }
>   
>   static bool iova_magazine_empty(struct iova_magazine *mag)
>   {
> -	return (!mag || mag->size == 0);
> +	return mag->size == 0;
>   }
>   
>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,

-- 
"firm, enduring, strong, and long-lived"

