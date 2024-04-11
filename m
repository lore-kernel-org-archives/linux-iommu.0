Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CC13E88A
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822161; cv=none; b=sRB7RLaIDIUREAhCtHee6tRDsJLbPjFv1CIoQVcq1+3a47vOUpiDjtX40smbnOyM/CCKPn34QWpEojr/mYu9OrWTtsIJitjDIFT4lEisXtyZQ2WtjRj9bBTFm/7KnQb6o1PNPecDpd8zCgQ5ilILKDu02WunhQDlKBSR5OchvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822161; c=relaxed/simple;
	bh=sQricaFVardeRNoeALXm88UVTwDWrm/8nJe3nCYv/l4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyCE47mI6k+FiUxCSCOStujyHoVSa1/TlnrEIZiWIS+H2tEI1PiWocCScaI6hNdO1IGDoK7lPrpvS5Y0j04bBbdvswN2h97EFXWJSaqQY3+4aTk4tddhQLGxU7cPEhrY/V1QCI2MwSiQ+e7g9VPEXTlm/vP2sqYyE1o/3f0q1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyTIT3eg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyTIT3eg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712822160; x=1744358160;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sQricaFVardeRNoeALXm88UVTwDWrm/8nJe3nCYv/l4=;
  b=MyTIT3eghuR9269LPvz2p43MXUc5C1cwv/37OADp22k9p19dDQk42S2G
   8WULlBGlGf/zkNhvBaQ/X3Jh06XO69a76eCDVnEf0cuNGL/V8J3Ur4Rcv
   oKp9hQzkJi0mpOsd2ITmhPrty6CGPALszWXx29gVRzXOh4f5qT9/45QE7
   LMiFqQ5i4w7B/DBaRp4BgBneg3UNYU3Ys6ptllf+AffA937bDva6ZnfGj
   PRhaZNlWMpDpBW7nHOFfs7zsbS8cfyCUS4x+NO4h/zvX/PJxiT3ep54zb
   glX2HkZjZBX4H+bQw3b8oy4Z04lEC2RcOnlqmSYtyDApCr1JUyhM/BNOX
   g==;
X-CSE-ConnectionGUID: eOOtSDEMQ3WKl+ed0HwwsA==
X-CSE-MsgGUID: W9w9mpN7S9uEguJvXT5xXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18778086"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="18778086"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:55:59 -0700
X-CSE-ConnectionGUID: 1nKsQyOiTkSCQzQS3OzEqA==
X-CSE-MsgGUID: kJZtlgJVTI+m2W+xPOA37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20827190"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:55:52 -0700
Message-ID: <b24f3380-1ac3-41c4-9163-56c1dcff6297@linux.intel.com>
Date: Thu, 11 Apr 2024 15:55:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Tina Zhang <tina.zhang@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] iommu/vt-d: Retire struct intel_svm
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
 <20240410020844.253535-13-baolu.lu@linux.intel.com>
 <20240410154951.GH223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240410154951.GH223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 23:49, Jason Gunthorpe wrote:
> On Wed, Apr 10, 2024 at 10:08:44AM +0800, Lu Baolu wrote:
>> The struct intel_svm was used for keeping attached devices info for sva
>> domain. Since sva domain is a kind of iommu_domain, the struct
>> dmar_domain should centralize all info of a sva domain, including the
>> info of attached devices. Therefore, retire struct intel_svm to clean up
>> the code.
>>
>> Besides, allocate sva domain in domain_alloc_sva() callback which allows
>> the memory management notifier lifetime to follow the lifetime of the
>> iommu_domain.
>>
>> Co-developed-by: Tina Zhang <tina.zhang@intel.com>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h | 26 ++++------
>>   drivers/iommu/intel/iommu.c |  9 +---
>>   drivers/iommu/intel/svm.c   | 94 +++++++++----------------------------
>>   3 files changed, 32 insertions(+), 97 deletions(-)
> 
> Happy to see the pasid xarray in the driver go away.

Yeah, it was really ugly.

> 
>> @@ -4388,14 +4386,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>>   	WARN_ON_ONCE(!dev_pasid);
>>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>   
>> -	/*
>> -	 * The SVA implementation needs to handle its own stuffs like the mm
>> -	 * notification. Before consolidating that code into iommu core, let
>> -	 * the intel sva code handle it.
>> -	 */
>>   	if (domain->type == IOMMU_DOMAIN_SVA) {
>>   		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
>> -		intel_svm_remove_dev_pasid(domain);
>>   	} else {
>>   		did = domain_id_iommu(dmar_domain, iommu);
>>   		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
> 
> It seems very strange that SVA has a different DID scheme, why is
> this? PASID and SVA should not be different at this layer.

The VT-d spec recommends that all SVA domains share a single domain ID.
The PASID is unique to each SVA domain, hence the cache tags are unique.
Currently, the Intel IOMMU driver assigns different domain IDs for all
domains except the SVA type.

Sharing a domain ID is not specific to SVA. In general, for devices
under a single IOMMU, domains with unique PASIDs can share the same
domain ID.

In the long term (also on my task list), we will extend the cache tag
code to support sharing domain IDs and remove the domain type check from
the main code. This will also benefit the nesting case, where user
domains nested on the same parent could share a domain ID.

> 
>> @@ -663,7 +596,12 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
>>   
>>   static void intel_svm_domain_free(struct iommu_domain *domain)
>>   {
>> -	kfree(to_dmar_domain(domain));
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +
>> +	if (dmar_domain->notifier.ops)
>> +		mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
> 
> This should really use mmu_notifier_put() and a delayed kfree, see my
> part 2 ARM series for how that should look.

Learning from

https://lore.kernel.org/linux-iommu/23-v6-228e7adf25eb+4155-smmuv3_newapi_p2_jgg@nvidia.com/

I will make it like below

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 47e475f67046..41374979eecc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -178,9 +178,15 @@ static void intel_mm_release(struct mmu_notifier 
*mn, struct mm_struct *mm)

  }

+static void intel_mm_free_notifier(struct mmu_notifier *mn)
+{
+       kfree(container_of(mn, struct dmar_domain, notifier));
+}
+
  static const struct mmu_notifier_ops intel_mmuops = {
         .release = intel_mm_release,
         .arch_invalidate_secondary_tlbs = 
intel_arch_invalidate_secondary_tlbs,
+       .free_notifier = intel_mm_free_notifier,
  };

  static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
@@ -598,10 +604,8 @@ static void intel_svm_domain_free(struct 
iommu_domain *domain)
  {
         struct dmar_domain *dmar_domain = to_dmar_domain(domain);

-       if (dmar_domain->notifier.ops)
-               mmu_notifier_unregister(&dmar_domain->notifier, domain->mm);
-
-       kfree(dmar_domain);
+       /* dmar_domain free is defered to the mmu free_notifier callback. */
+       mmu_notifier_put(&dmar_domain->notifier);
  }

  static const struct iommu_domain_ops intel_svm_domain_ops = {

> 
> Otherwise I think it looks fine

Thank you for review.

Best regards,
baolu

