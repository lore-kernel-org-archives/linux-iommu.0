Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA95662
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679663794; x=1711199794;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GDZg2mRuA1og/+FYECT/suAKTGeLw7ZZtMrYY5CS7do=;
  b=QiMTro6vUi1LIHY7ChQsefMAu+in2j61Ih1mi6mQTlZmzyKVywn3YJBL
   jJM6SmqrD0BlOwixfXgSLBXvdkThF40/MVMgflnqzK+lb7v2xWEyGo9fy
   iP62RvwoZ+MqMoxVbR1u0nrMTN9/zw9XS9n0eKh3CHPiaa86WCcvJt7Of
   G4dqHCFKaEr4xRDXmHJClwb77pUmm+6WhweVatIDZJjyw6ohFXULW4qiU
   ZQxflAiXQ1sPo6J5Ff5KLWyt253yNPOF4LViYqN0MwlMZFvVuwEJcGtTT
   72ck2QajNrFwGifTPzvxCEYh/OSaX+CjGYy3XhWMsZkFEYz3b6eSIZ9DY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339800371"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="339800371"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="928657058"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="928657058"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.177]) ([10.254.215.177])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 06:16:26 -0700
Message-ID: <8fda817c-98e7-1988-325d-52d09f3e61a8@linux.intel.com>
Date: Fri, 24 Mar 2023 21:16:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
To: Steven Price <steven.price@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230324111127.221640-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/24 19:11, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to have a singleton rk_identity_domain which is assigned
> to domain when using an identity mapping rather than "detaching". This
> makes the code easier to reason about.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1[1]:
> 
>   * Reworked the code to avoid a NULL domain, instead a singleton
>     rk_identity_domain is used instead. The 'detach' language is no
>     longer used.
> 
> [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> 
>   drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
>   1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index f30db22ea5d7..437541004994 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -124,6 +124,7 @@ struct rk_iommudata {
>   
>   static struct device *dma_dev;
>   static const struct rk_iommu_ops *rk_ops;
> +static struct iommu_domain rk_identity_domain;
>   
>   static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
>   				  unsigned int count)
> @@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>   	return ret;
>   }
>   
> -static void rk_iommu_detach_device(struct iommu_domain *domain,
> -				   struct device *dev)
> +static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
> +				    struct device *dev)
>   {
>   	struct rk_iommu *iommu;
> -	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> +	struct rk_iommu_domain *rk_domain;
>   	unsigned long flags;
>   	int ret;
>   
>   	/* Allow 'virtual devices' (eg drm) to detach from domain */
>   	iommu = rk_iommu_from_dev(dev);
>   	if (!iommu)
> -		return;
> +		return -ENODEV;
> +
> +	rk_domain = to_rk_domain(iommu->domain);
>   
>   	dev_dbg(dev, "Detaching from iommu domain\n");
>   
> -	/* iommu already detached */
> -	if (iommu->domain != domain)
> -		return;
> +	if (iommu->domain == identity_domain)
> +		return 0;
>   
> -	iommu->domain = NULL;
> +	iommu->domain = identity_domain;

Where did identity_domain come from? Is it rk_identity_domain?

Best regards,
baolu
