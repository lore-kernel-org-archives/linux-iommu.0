Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F5205AC1
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365218; cv=none; b=UQP5+8RCsf1NTyCt4oZ/bZFFf8xyiBjYvYIuGGJAMSr+GsJSjZ6zqtyrgp3zVQVgNmPb8NjmmPdVlvSEcg9jO6BVIp4igvJXNH1zfVMaFGhFaHHwm694Gl7jxA9YfwgKP8dJPu86n2tLfmFkUiBhSgXWQn74pZzXZM29Wr77eME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365218; c=relaxed/simple;
	bh=tUTPNtMMGbiXn0NFdM8fC5U/fZR8hg5cQ6pGxUNVE2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwIkRRPI3IHFSh85HtzL3rQo0dURcmbiJJeuQwaGSSJ50qolPLP2VGTEipRyfokhCUvPKJBOK7swTF+MH7fmn3mSGASTTN1X8K5x/FcHyde7exQoxboQmQ6mWa7IiqL+86kFWToJ7IvC5aHKVzpzsK0eyVZSh5TG29JQ0u0Pf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3260412FC;
	Wed, 12 Feb 2025 05:00:36 -0800 (PST)
Received: from [10.57.36.235] (unknown [10.57.36.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9A33F58B;
	Wed, 12 Feb 2025 05:00:13 -0800 (PST)
Message-ID: <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
Date: Wed, 12 Feb 2025 13:00:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Yi Liu <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-12 7:47 am, Yi Liu wrote:
> On 2024/12/25 15:13, Baolu Lu wrote:
>> On 2024/12/25 12:30, Yi Liu wrote:
>>> On 2024/12/25 09:02, Baolu Lu wrote:
>>>> On 12/24/24 19:35, Yi Liu wrote:
>>>>>> Another related consideration is the support for page faults in 
>>>>>> nested
>>>>>> domains once PASID is available in user space. Would it be 
>>>>>> reasonable to
>>>>>> support page faults for nested domains?
>>>>>
>>>>> yeah, it's good to discuss it.
>>>>>
>>>>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>>>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>>>>
>>>>> IMHO, the PRQ support for nested domains requires some more 
>>>>> facility. PRQ
>>>>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>>>>> it and forward to the correct domain (nested domain or parent 
>>>>> domain). Or
>>>>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, 
>>>>> any PRQ
>>>>> happens under nested translation should be due to stage-1.
>>>>
>>>> The parent domain is currently always pinned and does not yet support
>>>> page faults. Therefore, when a page fault occurs within a nested 
>>>> domain,
>>>> it apparently should be routed to user space...
>>>>
>>>> If we decide to support page faults on the stage-2 domain in the 
>>>> future,
>>>> we will need to figure out the correct destination of each page fault
>>>> and route it accordingly, either to the parent domain or the user space
>>>> nested domain. Hardware assistance would be beneficial, otherwise the
>>>> software may need to traverse the parent domain, which is not
>>>> performance friendly.
>>>
>>> this is my question. Is it still true the parent domain is always pinned
>>> after the below series? If yes, then it's fine to enable IOPF for nested
>>> domain.
>>>
>>> https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0- 
>>> b696ca89ba29@kernel.org/
>>
>> Then, perhaps we could enforce this in iommufd for a short-term purpose?
>>
>> When allocating a hwpt in iommufd, we should enforce that the flags
>> IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_FAULT_ID_VALID cannot be set
>> at the same time.
> 
> Let's consult with other vendors. We need this enforcement because we lack
> a straightforward method to distinguish between PRIs in stage-1 and stage-2
> under nested translation. If other vendors share this requirement, it would
> be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
> check it in intel iommu driver.
> 
> @arm and amd folks. :)

Yup, SMMUv3 is more or less in the same boat - we *could* reasonably 
manage unpinned S2 for non-PCI devices using the stall model where the 
F_TRANSLATION or F_PERMISSION event tells us all we need, but for ATS 
it's the same thing where by the time the fault has taken a round-trip 
through an ATS response and a PRI request, we've lost the details of 
exactly how it faulted (or if the PRI request was sent eagerly without a 
prior translation request, then we simply have no idea at all). Thus the 
prospective mechanism would be to inject a virtual PRI, wait until we 
see the guest issue a matching CMD_PRI_RESP, then sniff the IPA/GPA for 
the given input address out of the guest pagetables to see if there's 
anything to do at S2 as well/instead. Yuck.

Thanks,
Robin.
