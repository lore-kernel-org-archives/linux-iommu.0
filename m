Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276A258A
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749234; cv=none; b=DzlkjxBQWmz3us9dLvQHUM/7NmN8O0v/OcbWhGuwKmuXK5dOpliOronlNk6LxVjiCwosveT0vXjq5pVq7FvUF+ru/v/f6MvCRtneeJHlpGiTaDEtgJDMPe/s+678QatCipmOat/C//9WRLqgSERm7hLVihtGfE1ZBhHtW8gyv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749234; c=relaxed/simple;
	bh=vZP/OWilNqRz2nLVUrTXlm3X/gTdpyOvbDwZjv28q3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uw80MD+yR6bOkvIBiSq1RN+O9TdtcSFUBwudRcBnzwTDG8PV0FaLX89PgPasCNn/Maax1hppfRTA3aXHnvroIs9jI+8ghqBA3kjTla1PMQ4BY1/uCo7aS4G+Jd7slbpiZMdgW14MNHzPwiqQT8PMrzGz09G8DWipmW79n7PBVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT++cAfr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT++cAfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741749233; x=1773285233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vZP/OWilNqRz2nLVUrTXlm3X/gTdpyOvbDwZjv28q3g=;
  b=aT++cAfrtruT/+lI07axUPEB3dK8kEPbOmwDpZjJ3nyiVagfKWpuyaoG
   v0u2wHKW1eYLjQIB+B215dXI2fm+tT9W60FZiYzRvnXZbvIcM+bnkbh7u
   JYEgH62VDWcyPzB4JXR0GEHsmj9KkMAfQ2yiVK9gYKYez1ujRnkPQ/cYY
   80cVtlDiUH6VRdAfAzsdCLFtfySWygIY8TEo3jvGPyQJ/kO7cx58DEUxe
   AdgvZ56rycGsdC3nzNviZB6xpPRRal5kPvXbHJscZDGTQmv3uksm0Lmtx
   8Hb3UAZN/WhswVVoZ5f4R7xzeBDhYDYlZyOzQhck5wUdjMrFVauCFGY8f
   Q==;
X-CSE-ConnectionGUID: Vhc8M+HxSHqVuHdcC6e/vw==
X-CSE-MsgGUID: 7WwofHoATG+/B0L5ikBkUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42993199"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42993199"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 20:13:52 -0700
X-CSE-ConnectionGUID: sdPyfKAJSrOBnZj8nds3Uw==
X-CSE-MsgGUID: 3bjCZga+R2ytTNiActIz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120458319"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 20:13:50 -0700
Message-ID: <b1625daf-b77a-4838-8fed-f5ee2233fd2a@linux.intel.com>
Date: Wed, 12 Mar 2025 11:10:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] iommu/arm-smmu-v3: Put iopf enablement in the
 domain attach path
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-2-baolu.lu@linux.intel.com>
 <20250311161337.GD5138@willie-the-truck>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250311161337.GD5138@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 00:13, Will Deacon wrote:
> On Fri, Feb 28, 2025 at 05:26:20PM +0800, Lu Baolu wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>>
>> SMMUv3 co-mingles FEAT_IOPF and FEAT_SVA behaviors so that fault reporting
>> doesn't work unless both are enabled. This is not correct and causes
>> problems for iommufd which does not enable FEAT_SVA for it's fault capable
>> domains.
>>
>> These APIs are both obsolete, update SMMUv3 to use the new method like AMD
>> implements.
>>
>> A driver should enable iopf support when a domain with an iopf_handler is
>> attached, and disable iopf support when the domain is removed.
>>
>> Move the fault support logic to sva domain allocation and to domain
>> attach, refusing to create or attach fault capable domains if the HW
>> doesn't support it.
>>
>> Move all the logic for controlling the iopf queue under
>> arm_smmu_attach_prepare(). Keep track of the number of domains on the
>> master (over all the SSIDs) that require iopf. When the first domain
>> requiring iopf is attached create the iopf queue, when the last domain is
>> detached destroy it.
>>
>> Turn FEAT_IOPF and FEAT_SVA into no ops.
>>
>> Remove the sva_lock, this is all protected by the group mutex.
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +-------------
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 105 +++++++++++++-----
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 ++-----
>>   3 files changed, 91 insertions(+), 139 deletions(-)
> 
> [...]
> 
>> @@ -2748,6 +2750,54 @@ to_smmu_domain_devices(struct iommu_domain *domain)
>>   	return NULL;
>>   }
>>   
>> +static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
>> +				struct arm_smmu_master_domain *master_domain)
>> +{
>> +	int ret;
>> +
>> +	iommu_group_mutex_assert(master->dev);
>> +
>> +	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Drivers for devices supporting PRI or stall require iopf others have
>> +	 * device-specific fault handlers and don't need IOPF, so this is not a
>> +	 * failure.
>> +	 */
>> +	if (!master->stall_enabled)
>> +		return 0;
>> +
>> +	/* We're not keeping track of SIDs in fault events */
>> +	if (master->num_streams != 1)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (master->iopf_refcount) {
>> +		master->iopf_refcount++;
>> +		master_domain->using_iopf = true;
>> +		return 0;
>> +	}
>> +
>> +	ret = iopf_queue_add_device(master->smmu->evtq.iopf, master->dev);
>> +	if (ret)
>> +		return ret;
>> +	master->iopf_refcount = 1;
>> +	master_domain->using_iopf = true;
>> +	return 0;
>> +}
>> +
>> +static void arm_smmu_disable_iopf(struct arm_smmu_master *master)
>> +{
>> +	iommu_group_mutex_assert(master->dev);
>> +
>> +	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
>> +		return;
> 
> I think it would be a little cleaner to push the '->using_iopf' check
> in here rather than have the callers check it. Then the SVA check above
> makes more sense and I think the enable/disable paths are a bit more
> symmetric.

Yes, sure. I will address it like this,

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4aaf9b7bf862..a519854b3798 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2786,13 +2786,17 @@ static int arm_smmu_enable_iopf(struct 
arm_smmu_master *master,
         return 0;
  }

-static void arm_smmu_disable_iopf(struct arm_smmu_master *master)
+static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
+                                 struct arm_smmu_master_domain 
*master_domain)
  {
         iommu_group_mutex_assert(master->dev);

         if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
                 return;

+       if (!master_domain || !master_domain->using_iopf)
+               return;
+
         master->iopf_refcount--;
         if (master->iopf_refcount == 0)
                 iopf_queue_remove_device(master->smmu->evtq.iopf, 
master->dev);
@@ -2823,11 +2827,8 @@ static void arm_smmu_remove_master_domain(struct 
arm_smmu_master *master,
         }
         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

-       if (master_domain) {
-               if (master_domain->using_iopf)
-                       arm_smmu_disable_iopf(master);
-               kfree(master_domain);
-       }
+       arm_smmu_disable_iopf(master, master_domain);
+       kfree(master_domain);
  }

  /*
@@ -2945,8 +2946,7 @@ int arm_smmu_attach_prepare(struct 
arm_smmu_attach_state *state,
         return 0;

  err_iopf:
-       if (master_domain && master_domain->using_iopf)
-               arm_smmu_disable_iopf(master);
+       arm_smmu_disable_iopf(master);
  err_free_master_domain:
         kfree(master_domain);
         return ret;

> 
> With that:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will

Thanks,
baolu
