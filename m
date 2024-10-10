Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A919F10A
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542423; cv=none; b=MRTwsBFWyjXnnVqpasfCRdvGzXlpRqvoUVi6vd8NTE/1QZhjp1KDe7W5rE50/jDpFV2YEpArzZIUd3TUk6MX639Yfn2Mhu9qbfVpM4zHCmPGXigO589SbM6bgQqv68GbrdIa2yDNnQ3wOTpeNxXKHhmNu276g0SDX4Qc8scpC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542423; c=relaxed/simple;
	bh=vcx79OQMKguYnBywchkkXPj/Lw/EntkIkXPAlqdnjvI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JfJlLd3Rkn6r3R7phS4egJDmpahZ/dGizdLwwvs3VkiVG0rq3urJjEhOkBab9O9PzvI2qccFNO1yjX3w6wggjXLO3rYBXqXMzCG+LEq3a6YfdAVQIBqi0cQyrJiwNgKbrGHLByHcRooXd0jbDWCT9SH6AE1YBVdN5TTUe9BTA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgzFoZpn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgzFoZpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728542422; x=1760078422;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vcx79OQMKguYnBywchkkXPj/Lw/EntkIkXPAlqdnjvI=;
  b=GgzFoZpn9BUYUsbcIIVxA0Q4RFUqCtXIn0p4/vcrgPGR7u33WiDAlbH6
   gXYdd3tmIPeJVcP4EJBrwWhU9477mGiutfAHGJYWnR2OWaFjWHl288km6
   yE93r6Cg7mrhSogMXzLD8RGL0b5bPfxngynnk2DDpSdYStz6e7ZWUB6sW
   GxGqtnlOw18F+SrzK0ua0dr6N90NnvWHaGjrxWrI7zGqDuM2UvHU1eyUe
   TurjykgqG/Z4CNLi1VGxTTu8t638kMAXigt68FZ+4/lAb6snNyvZ5xJH3
   dnO9UGDL80uFSq3dRzGHkKHy4AahOMQ//T9fD+MTo4KDqc4JVssz0NKnw
   w==;
X-CSE-ConnectionGUID: zjfMODNiSlGuPECXV/Rb5Q==
X-CSE-MsgGUID: FN59fRyXTQe0UDkrno24Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28011540"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28011540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:40:21 -0700
X-CSE-ConnectionGUID: rvzZVR3BQ6atM0wbcbmHFQ==
X-CSE-MsgGUID: OeEj4AACT8KLdxHL8CQCKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81064585"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:40:18 -0700
Message-ID: <f8cf4532-3bfe-4b0a-9399-0760ab6a4612@linux.intel.com>
Date: Thu, 10 Oct 2024 14:40:16 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241009121548.GE762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/9 20:15, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:
> 
>>> This change might cause a functional regression when it comes to nested
>>> translation. In nested translation mode, the user page table (e.g.,
>>> created and managed by a guest VM for guest kernel DMA) must be in the
>>> first-stage page table format. Then, it can be nested on a second-stage
>>> page table managed by the host kernel.
>>>
>>> Currently, the kernel automatically selects the page table formats. For
>>> example, the Intel IOMMU driver always uses the first-stage page table
>>> for guest kernel DMA. After this change, this assumption no longer holds
>>> true. This means the kernel might use a second-stage page table for
>>> guest kernel DMA, breaking nested translation.
>> Hmmm. I assumed after discussion in v1 series you are fine. Looks like I misread it?
> It is a bug in the implementation in the intel driver.
> 
> intel_iommu_domain_alloc_user() should always allocate a page table
> that works, if you are in a guest context it must allocate a first
> level/guest page table otherwise nested VFIO will be broken.
> 
> For this reason Intel driver should always allocate the guest
> compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
> specified.
> 
> Something like this:

This will break the existing dirty page tracking functionality. Intel
IOMMU only supports enabling or disabling dirty page tracking at the
second-stage page table.

/*
  * Set up dirty tracking on a second only or nested translation type.
  */
int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
                                      struct device *dev, u32 pasid,
                                      bool enabled)
{
[...]
         pgtt = pasid_pte_get_pgtt(pte);
         if (pgtt != PASID_ENTRY_PGTT_SL_ONLY &&
             pgtt != PASID_ENTRY_PGTT_NESTED) {
                 spin_unlock(&iommu->lock);
                 dev_err_ratelimited(
                         dev,
                         "Dirty tracking not supported on translation 
type %d\n",
                         pgtt);
                 return -EOPNOTSUPP;
         }

Thanks,
baolu
