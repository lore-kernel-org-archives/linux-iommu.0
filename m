Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A71C32
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680096769; x=1711632769;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2T3KhxKi0HIV6Yd0PqR5Wi77C9Sgt/bFcIe427tYueI=;
  b=N/GRw2QL5zNnpe718wh8cMMJR5kq+aC/hY3PU+Gn43to/dnfX4vzKcgt
   HMIP5oUEPt7ErHMkI6dcnYtVA093Zxtjq3beB54qoaRVLOoIZvRfME7XB
   WMEREKTSbIm3fxR+6ajlPF4PUdIb8rWQDs9M6MFGhHNLr5gISU2SxuW10
   KDNAKkHNMebdt+4tejA3yMXkgZtKrLOYeRwaTmwr2FL3cvsR8O2XC3l1z
   1xXFLcXKOXL6bWc/6OFxWWWN56j+Wx9yjsp7WSgYgyJFz3IDvPSPTb0mp
   JJnHGsKK5rfBV8ZYTox+v72lkeOt/EyiG1lhWGYliiYWV8LBnSlt+i7my
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338375431"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="338375431"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014027969"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="1014027969"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:32:45 -0700
Message-ID: <5315d7ee-48f4-6810-72c5-9066aa456c24@linux.intel.com>
Date: Wed, 29 Mar 2023 21:32:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Fix operand size in bitwise operation
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-3-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230329124654.2698853-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/29 20:46, Tina Zhang wrote:
> The patch fixes the klocwork issues that operands in a bitwise operation have
> different size at line 1692 of dmar.c, line 1898 and line 1907 of iommu.c.
> 
> Reported-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 2 +-
>   drivers/iommu/intel/iommu.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 6acfe879589c..7c77a59889ea 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1689,7 +1689,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
>   	 * is present.
>   	 */
>   	if (ecap_smts(iommu->ecap))
> -		val |= (1 << 11) | 1;
> +		val |= (1ull << 11) | 1ull;

How about BIT_ULL(11) | BIT_ULL(0)?

Ditto to other changes.

Best regards,
baolu

>   
>   	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7c2f4bd33582..085d31a77f6f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1895,7 +1895,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
>    */
>   static inline void context_set_sm_dte(struct context_entry *context)
>   {
> -	context->lo |= (1 << 2);
> +	context->lo |= (1ull << 2);
>   }
>   
>   /*
> @@ -1904,7 +1904,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
>    */
>   static inline void context_set_sm_pre(struct context_entry *context)
>   {
> -	context->lo |= (1 << 4);
> +	context->lo |= (1ull << 4);
>   }
>   
>   /* Convert value to context PASID directory size field coding. */

