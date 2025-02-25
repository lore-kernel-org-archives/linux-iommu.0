Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9E2561A9
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489529; cv=none; b=cCzj4Nu0+O82/0MTmq7fWCzSoRSFCUt79p12+Dv8RXHKw58CvFQX8unH9pltfyDfNaHTElNRmAp5L/fUPjnRd/FzwHNoUPKzvmBo4F3Y11CwSak1yEUYefQITi655wYMyvcMKxqRJOTj+koo+6qKloCZ1ebs4qZdiA60/S2rznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489529; c=relaxed/simple;
	bh=1Oehkk3qQvu3XE+zFUCQdMUm91EvoWDD7CLwMJd9TNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbgrJfRHsgoDRv4KOBSvk4vOEbdj7HdxMIjJqfB3j5DjDaq3nIn93sLKSJ9L5vH+rSPLMpQtn2iU2BUHE0y6A8CmocAyxIWAFBb02u+KagXN4weAtru6hVdoGtxaQgnS0g6Q6kAXDtf2ozDlKJ1WhN/EAUhqh0sOBLTbjKXWGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8935F152B;
	Tue, 25 Feb 2025 05:19:02 -0800 (PST)
Received: from [10.57.38.173] (unknown [10.57.38.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315CF3F5A1;
	Tue, 25 Feb 2025 05:18:45 -0800 (PST)
Message-ID: <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
Date: Tue, 25 Feb 2025 13:18:43 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, suravee.suthikulpanit@amd.com
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-25 12:30 pm, Yi Liu wrote:
> On 2025/2/25 18:58, Vasant Hegde wrote:
>> AMD IOMMU supports processing ATS requests as Secure ATS requests when 
>> IOTLB
>> is supported and enabled (See section "2.11 Secure ATS Supports" in 
>> AMD IOMMU
>> spec [1] for more detail).
> 
> glad to see it. I'm also working on Secure ATS for VT-d. Intel Secure ATS
> has an extra table named HPT (Host Permission Table) chapter 4.2.4 in
> revision 5.0 spec. IOMMU uses this table to check the address in the
> translated transactions to ensure the device has access permission.
> 
> We plan to support the HPT on S2 when nested translation is configured. But
> we may let the userspace VMM to decide if it wants SATS on specific device.
> The reason is that some devices might be considered as trusted. e.g.
> integrated devices.
> 
> My thought is to add a flag in iommufd_hw_capabilities to report the
> capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
> know if HPT is needed when allocating S2 domain. Userspace attaches the
> un-trusted devices to the domains with HPT. While trusted devices can be
> attached to 'normal' S2 domains.  Will to send it out soon.:)
> 
>> With Secure ATS, for ATS requests IOMMU return GPA to device instead 
>> of SPA.
> 
> I suppose AMD Secure ATS only works under nested translation configuration.
> is it? I guess admin may want some flexibility to opt-in it. :)

Heh, and in SMMUv3 we have both options, with split-stage ATS for nested 
translation, and our Device Permission Table for full ATS, so it seems 
like there should be room for some kind of generalised capability.

Thanks,
Robin.
