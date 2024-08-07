Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD271B86C8
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012906; cv=none; b=YizRxN3ZMC++SdMlSiOkEtaLJxbOdgZqXX9gkH9riY8Y4S7WK10mN8EktfZ85cLQXH6ujmcZ7ATdM8U79BgsXv1rmW4dckaEAWhDIupyFYrhqK9s96rzu3Qw+RazAXzTkQia7innk6eqhlQCtjDm31xBH1DITZopGjLHbqQ2UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012906; c=relaxed/simple;
	bh=qvcEvY9w2gf8Sw2bAz9uYqd2aj72DXaqYATQa2G+aLY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PG/1x1cuTYvjGLZRp9J9xffFYLO8CEibeQpU5AeADl3gBd/CYawaMD956DxSUBLZiL7VEtVzTmT4DVYNm7GKcK0KFBIwQpPHmItNpKZN873xcDbBV6YxbGYU636Au7CuYrDVmEZdTAnA2r2E0HwZ3rhPWuhfmT+wG6/17tEnZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maHN5jNd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maHN5jNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723012904; x=1754548904;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qvcEvY9w2gf8Sw2bAz9uYqd2aj72DXaqYATQa2G+aLY=;
  b=maHN5jNd/slTy6aY7vknyQ3eE4jJUaUr/263Q4ocFkQQ5dVfgRAyLXXH
   PSFTlr4eV+g4aQ9oCEVqxeXUNqQ7lqMBafC7nepNEC23OSYeY/dqSQDkl
   892NFANF2fnEUItCWIwV7y+LpLTPe2HsmAZnGwGonzSMJ3FosCbWytvMZ
   tGwDIS9AlVY5ObYFLX/qEYlvwG8/66GLb3da7RfX71lsdehnroZ/EwjyD
   2qfylcCyjo3BXprb12alyYkFzv3xTa+ARSZqfxmfHZcFyjM6ADjUvS6Dw
   Sr8miarGbrPbid3RBUAeofj5p2qFQcGP78gtZD5NAHK/Iw6dL6iRSeVF0
   A==;
X-CSE-ConnectionGUID: HFdLZzgWT6+4FOwgkj7LeA==
X-CSE-MsgGUID: d4N6eqVcSee+KGXb4k2geg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38521403"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="38521403"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:41:43 -0700
X-CSE-ConnectionGUID: nMMK8BnRRRmNjwT40vVDqw==
X-CSE-MsgGUID: toW+aRZlRQKRsApSyjgBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61632074"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:41:42 -0700
Message-ID: <9aa9e93e-915e-4c6d-9adb-b7d5facdf3bc@linux.intel.com>
Date: Wed, 7 Aug 2024 14:41:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Prepare for global static identity
 domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-5-baolu.lu@linux.intel.com>
 <20240806171236.GM676757@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806171236.GM676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 1:12, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 10:39:38AM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index c019fb3b3e78..f37c8c3cba3c 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1270,6 +1270,9 @@ void domain_update_iotlb(struct dmar_domain *domain)
>>   	bool has_iotlb_device = false;
>>   	unsigned long flags;
>>   
>> +	if (!domain)
>> +		return;
>> +
> This seems really strange, maybe wrong..
> 
> The only callers that could take advantage are
> iommu_enable_pci_caps()/iommu_disable_pci_caps()

Yes.

When the PCI ATS status changes, the domain attached to the device
should have its domain->has_iotlb_device flag updated.

The global static identity domain is a dummy domain without a
corresponding dmar_domain structure. Consequently, the device's
info->domain will be NULL. This is why a check is necessary.

I might need to make this check explicit with an additional change.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f37c8c3cba3c..d59e9ac223ba 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1270,9 +1270,6 @@ void domain_update_iotlb(struct dmar_domain *domain)
         bool has_iotlb_device = false;
         unsigned long flags;

-       if (!domain)
-               return;
-
         spin_lock_irqsave(&domain->lock, flags);
         list_for_each_entry(info, &domain->devices, link) {
                 if (info->ats_enabled) {
@@ -1330,7 +1327,8 @@ static void iommu_enable_pci_caps(struct 
device_domain_info *info)
         if (info->ats_supported && pci_ats_page_aligned(pdev) &&
             !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
                 info->ats_enabled = 1;
-               domain_update_iotlb(info->domain);
+               if (info->domain)
+                       domain_update_iotlb(info->domain);
         }
  }

@@ -1346,7 +1344,8 @@ static void iommu_disable_pci_caps(struct 
device_domain_info *info)
         if (info->ats_enabled) {
                 pci_disable_ats(pdev);
                 info->ats_enabled = 0;
-               domain_update_iotlb(info->domain);
+               if (info->domain)
+                       domain_update_iotlb(info->domain);
         }

         if (info->pasid_enabled) {

> 
> But if they are mucking with ATS then the ATC flushes should not be
> done wrong!
> 
> So I looked at this and, uh, who even reads domain->has_iotlb_device ?

The has_iotlb_device flag indicates whether a domain is attached to
devices with ATS enabled. If a domain lacks this flag, no device TBLs
need to be invalidated during unmap operations. This optimization avoids
unnecessary looping through all attached devices.

> So I'd just delete  domain->has_iotlb_device and domain_update_iotlb()
> as well.

Thanks,
baolu
