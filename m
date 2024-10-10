Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70E18BBB0
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542896; cv=none; b=ohS2Qqpmv3dotLCBi2jIM9xOWzANLuvik9TjV+qz6UPnZQWdwK+VdZDvvqGqgMVI+U4CChsD1yXC/dpl0/Qn2/Ei0qTyzzmcTJwhZLrXKMubU5nQ+rlc+LTJWiCOT7oykVy9089R9NcNmEDsEpddXxe7S5ix1innHgUmpGUsh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542896; c=relaxed/simple;
	bh=RhYCURhcFksJY1XuxVP8B9cPZTWlG0aG+54EtgbldWY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L1/az+pGKSurePtSve4VOoMAWQI3egZHL8hm+pUkkPdmzLmq6fVgvCG2qYX+K7aAkVegPtT0BE3zgOHn3UFvjCjao9CibhqdH/o163Y2D74cB+FoGPj6IIbnc1+wpd7d0FNLd5b4MmieTi+NqBopuSxwohNXa738b+4N71hEQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx8jX6Tu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx8jX6Tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728542896; x=1760078896;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RhYCURhcFksJY1XuxVP8B9cPZTWlG0aG+54EtgbldWY=;
  b=bx8jX6TuyDk1uhULK4Y72Yuv+kQY+O3+A+EhVjGKUG+NbhnXg9B6L8eM
   wU9spC1S26Ysnj0/av6HMwAnvhr4tS86ELe5RZCsIpUMzSV8bUQpT7vB0
   3Cz+7l9AMu5AO/4lahoB3sPPyu+q1O8s7zLDmgQ3OaRnAy8L8Cdb342Xa
   OQYZk3eBn1QmFhGn9VwUWSLThk0j+OEGE1BLiRn2zsl1aJa/0I0qnGXo/
   uX/ez5xLkCTms20Vbq9+brNOaNYL9l7Yw0o7ua+frkOxNAxSjcLOQ9jaG
   1Rotm2bimENfYhe6J43YQY52MrMkq3tMFkHZHFhowx2xz370vZmHXztEg
   A==;
X-CSE-ConnectionGUID: Z3l2L87eSiKkoT41RPj9qA==
X-CSE-MsgGUID: 24+raXd0Tma5Ctxo4YZS3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39010329"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="39010329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:48:15 -0700
X-CSE-ConnectionGUID: yaLXwsRZRz6UhT3Rz1nviw==
X-CSE-MsgGUID: dJgVtmyaRAG+mCl4ZI3tDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="107333235"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:48:12 -0700
Message-ID: <2ba53bb0-b84a-4eae-91da-4ff7d13b582b@linux.intel.com>
Date: Thu, 10 Oct 2024 14:48:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 yi.l.liu@intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
 <f8cf4532-3bfe-4b0a-9399-0760ab6a4612@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f8cf4532-3bfe-4b0a-9399-0760ab6a4612@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/10 14:40, Baolu Lu wrote:
> On 2024/10/9 20:15, Jason Gunthorpe wrote:
>> On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:
>>
>>>> This change might cause a functional regression when it comes to nested
>>>> translation. In nested translation mode, the user page table (e.g.,
>>>> created and managed by a guest VM for guest kernel DMA) must be in the
>>>> first-stage page table format. Then, it can be nested on a second-stage
>>>> page table managed by the host kernel.
>>>>
>>>> Currently, the kernel automatically selects the page table formats. For
>>>> example, the Intel IOMMU driver always uses the first-stage page table
>>>> for guest kernel DMA. After this change, this assumption no longer 
>>>> holds
>>>> true. This means the kernel might use a second-stage page table for
>>>> guest kernel DMA, breaking nested translation.
>>> Hmmm. I assumed after discussion in v1 series you are fine. Looks 
>>> like I misread it?
>> It is a bug in the implementation in the intel driver.
>>
>> intel_iommu_domain_alloc_user() should always allocate a page table
>> that works, if you are in a guest context it must allocate a first
>> level/guest page table otherwise nested VFIO will be broken.
>>
>> For this reason Intel driver should always allocate the guest
>> compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
>> specified.
>>
>> Something like this:
> 
> This will break the existing dirty page tracking functionality. Intel
> IOMMU only supports enabling or disabling dirty page tracking at the
> second-stage page table.

So, perhaps something like below?

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..e11dde259afa 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -544,6 +544,8 @@ enum {
                                 ecap_slads((iommu)->ecap))
  #define nested_supported(iommu)        (sm_supported(iommu) && 
         \
                                  ecap_nest((iommu)->ecap))
+#define flts_supported(iommu)  (sm_supported(iommu) &&                 \
+                                ecap_flts((iommu)->ecap))

  struct pasid_entry;
  struct pasid_state_entry;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..d1a7378489a4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3530,6 +3530,7 @@ intel_iommu_domain_alloc_user(struct device *dev, 
u32 flags,
         struct intel_iommu *iommu = info->iommu;
         struct dmar_domain *dmar_domain;
         struct iommu_domain *domain;
+       bool first_stage;

         /* Must be NESTING domain */
         if (parent) {
@@ -3546,8 +3547,14 @@ intel_iommu_domain_alloc_user(struct device *dev, 
u32 flags,
         if (user_data || (dirty_tracking && !ssads_supported(iommu)))
                 return ERR_PTR(-EOPNOTSUPP);

-       /* Do not use first stage for user domain translation. */
-       dmar_domain = paging_domain_alloc(dev, false);
+       /*
+        * Always allocate the guest compatible page table unless
+        * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+        * is specified.
+        */
+       first_stage = (nested_parent || dirty_tracking) ?
+                       false : flts_supported(iommu);
+       dmar_domain = paging_domain_alloc(dev, first_stage);
         if (IS_ERR(dmar_domain))
                 return ERR_CAST(dmar_domain);
         domain = &dmar_domain->domain;

Thanks,
baolu
