Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF515AA
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663212032; x=1694748032;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EwSKJFPv60mlWUH12bVm0X6Akr50jkmKLrtEGm33TZw=;
  b=DUKK2oVsr3yIBXOK0VZ51gMC9sifVzdfHCah7v5vRmWhiGy6y7FWFLDB
   YzhzVfOBjfDAoS0nPTkjWkBdgj5LIVaRyss9jREWCNZ1W3MkLIH8e/oKO
   u9T+XIl9Dc3DLe796yKt3ymnZm4ijMGZARqj5eGsBq7FyvqHiuzb07sUh
   mRlKAIh5Pn4exBuVsr68W9qEBXC+RLn2d2A+8Cvirb61I5DAgj25vrSbW
   X56NVUlwu/p1SSKmyTqNA9Jqk9q480kslk4GraNdrBUGvB47vWIgYsLJz
   gXnveWpvct9MoXXUdoyXhJXnvPxt9Z4L3l6bY/NXZx2WWqfBJ7pPhI6P2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278985159"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="278985159"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="759456411"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2022 20:20:30 -0700
Message-ID: <1a5195b4-eef2-00dd-1b16-806d662148ea@linux.intel.com>
Date: Thu, 15 Sep 2022 11:14:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com
Subject: Re: [RFC PATCH] iommu: Handle domain allocation failure gracefully
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20220914144424.7356-1-vasant.hegde@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220914144424.7356-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/22 10:44 PM, Vasant Hegde wrote:
> Current code does not validate domain allocation failures. This will
> result in random failure at later stage. Hence handle domain allocation
> failures.
> 
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
> Hi Joerg,
>    With current code whenever amd driver failes to allocate domain we hit
>    failure at late stage and it became difficult to debug. Hence I
>    thought of adding this fix.
> 
>    I see that in commit 6e1aa2049154 you have intentionally didn't check
>    the return value. Looking into drivers/iommu/* it looks like all
>    drivers has domain_alloc() callback handler. But some drivers (like msm
>    - msm_iommu_domain_alloc()) allocates default domain for certain type
>    only. Hence I'm not sure whether its ok to handle domain allocation
>    failures or not. Hence I have marked this patch as RFC.
> 
>    Let me know whether this patch is fine -OR- is there any other way we can
>    handle domain allocation failures?
> 
> -Vasant
> 
>   drivers/iommu/iommu.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 780fb7071577..e8a1e7fbffb9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -289,18 +289,21 @@ int iommu_probe_device(struct device *dev)
>   
>   	/*
>   	 * Try to allocate a default domain - needs support from the
> -	 * IOMMU driver. There are still some drivers which don't
> -	 * support default domains, so the return value is not yet
> -	 * checked.
> +	 * IOMMU driver.
>   	 */
>   	mutex_lock(&group->mutex);
> -	iommu_alloc_default_domain(group, dev);
> +	ret = iommu_alloc_default_domain(group, dev);
> +	if (ret) {
> +		mutex_unlock(&group->mutex);
> +		iommu_group_put(group);
> +		goto err_release;
> +	}

Some IOMMU drivers (s390, gart, tegra...) don't support default domains.
iommu_alloc_default_domain() returns a ENOMEM and the probe process
continues.

Above changes this behavior. The probe process will always fails with
those IOMMU drivers.

Best regards,
baolu
