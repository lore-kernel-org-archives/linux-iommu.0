Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27536A
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 02:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686796353; x=1718332353;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2XYz/4kLcutFLO2VPQ0RDJjaX/PmjaxFr9McZyU/Aio=;
  b=P0RqUzv5UBPMBqfny/Th+vSqRwvhj3dXBKX/baL5rguZa4+aZsNHAOWk
   lvExCKa0keXzzHjrZJpt71n2aO5pxe5wCPFuoeehywU/JHXA5w9k5ogg4
   ERzOhpFozxxhm6A4lKuiu1IiWcBeyIfIFniIFKz3gGSuZW3Zo82CHa0Ck
   sS/BUeXURVkqQN0Pf5U+6+OAUEOGvtcn1a8fPmmNyumhYskJ6sKrV/8bu
   9b9XA6YeHxHkPJ6cKbs+Aed07CsWomdd3j04GQglxlPoGKr/3RKuQxP30
   phPfWaIt9LT2yUa06zOaoLkfEhBhjalEkvfF2dboyudY0xjyfioqK4UNw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="348460351"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="348460351"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 19:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="825060419"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="825060419"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2023 19:32:31 -0700
Message-ID: <e8304083-931b-f52d-9865-8a79ba96c370@linux.intel.com>
Date: Thu, 15 Jun 2023 10:31:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix missing check for return value of
 iommu_group_get()
Content-Language: en-US
To: Chenyuan Mi <cymi20@fudan.edu.cn>, joro@8bytes.org
References: <20230614154308.118783-1-cymi20@fudan.edu.cn>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230614154308.118783-1-cymi20@fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/23 11:43 PM, Chenyuan Mi wrote:
> The iommu_group_get() function may return NULL, which may
> cause null pointer deference, and most other callsites of
> iommu_group_get() do Null check. Add Null check for return
> value of iommu_group_get().
> 
> Found by our static analysis tool.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> ---
>   drivers/iommu/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..ef3483e75511 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3217,6 +3217,8 @@ EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
>   void iommu_device_release_dma_owner(struct device *dev)
>   {
>   	struct iommu_group *group = iommu_group_get(dev);
> +	if (!group)
> +		return;

This interface should never be used in this way.

Check the comments of this function:

"Release the DMA ownership claimed by iommu_device_claim_dma_owner()."

iommu group has been checked in the claim api.

If any driver misuses this api, a null pointer deference warning is
better than ignoring silently.

>   
>   	mutex_lock(&group->mutex);
>   	if (group->owner_cnt > 1)
> @@ -3329,6 +3331,8 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			       ioasid_t pasid)
>   {
>   	struct iommu_group *group = iommu_group_get(dev);
> +	if (!group)
> +		return;

Ditto...

>   
>   	mutex_lock(&group->mutex);
>   	__iommu_remove_group_pasid(group, pasid);

Best regards,
baolu
