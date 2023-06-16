Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B04627
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 02:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686880978; x=1718416978;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BMPz4Do2SaGpAD8qHhUtOKMRTvwbRAuUSKYYeb83iGg=;
  b=dgVvhkTCGuIpaV+nhGxqnkXra/QoCoamWtxrjzhATyj10Xet7vNGlitz
   udcsPtC906CkpHEV9PcmqHXlNkZ5cL9CaAadv7xxOixkXerU0hWXKg1pc
   edyjCn49rbX/97mugLajsCQyd8zJ3njuIxLTkz20CP9OymPs/ziel3fpK
   NiW0yU7Ymw3a1vA81+iBhLOZpVyAAXr7vro4MrrbipLlG6LWCbyPfoUIC
   pvtc/DeN5RB6bpJOoyyN3Wf/DbEet/e+7Hw293vrHD35J7MCl4h65TcOG
   9AVUwf62a3ql9YH2AQN/diFE2Lxu9EtW1+1HA1BEpSJELwPmMTQtWN31/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357967059"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="357967059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042905935"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="1042905935"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 19:02:56 -0700
Message-ID: <3f60b35a-683c-5e18-c9d5-964df9331f0f@linux.intel.com>
Date: Fri, 16 Jun 2023 10:01:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Content-Language: en-US
To: Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com
References: <20230615071613.690639-1-yanfei.xu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230615071613.690639-1-yanfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/23 3:16 PM, Yanfei Xu wrote:
> Even the PCI devices don't support pasid capability, PASID
> table is mandatory for a PCI device in scalable mode. However
> flushing cache of pasid directory table for these devices are
> not taken after pasid table is allocated as the "size" of
> table is zero. Fix to assign it with a page size.

Documentation/process/submitting-patches.rst

Please add more information about

- Describe your problem.
- Any background of the problem?
- How your change fixes the problem.
...

> 
> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")

Do you need a Cc stable?

> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c5d479770e12..bde7df055865 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
>   				  intel_pasid_max_id);
>   
>   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> -	order = size ? get_order(size) : 0;
> +	if (!size)
> +		size = PAGE_SIZE;
> +	order = get_order(size);
>   	pages = alloc_pages_node(info->iommu->node,
>   				 GFP_KERNEL | __GFP_ZERO, order);
>   	if (!pages) {

Is it similar to

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..49fc5a038a14 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -129,7 +129,7 @@ int intel_pasid_alloc_table(struct device *dev)
         info->pasid_table = pasid_table;

         if (!ecap_coherent(info->iommu->ecap))
-               clflush_cache_range(pasid_table->table, size);
+               clflush_cache_range(pasid_table->table, (1 << order) * 
PAGE_SIZE);

         return 0;
  }

?

Best regards,
baolu
