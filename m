Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A886E158DC1
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791650; cv=none; b=TECvb7VFgL4/hRxiBzTssG3CnKK/y6+8l6C8QLxhsPIWqiKyWFc/D7xyqrCwO9nzr8FI7aBfcqxKZ0WMz2Bul8EfEBKduMZ9y5ZBiRtDfg2OSy93kfdBtkihcHz5ui97sEEGiVrX7L+OhhuCBwE68WAa3FKBhNzMYoR/jImoyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791650; c=relaxed/simple;
	bh=Kza6OuYUhR1a00NG7V+XnF4tUKgD4uxQiX5ENXC3jAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xophl2jQHFm2m2mDeIVq5E+JW/otbUM3WSIi568rYGP84ItvdNxHagV9iCO5tMVSHg1/6fgY4hJvjoFrpjj8nOW+dv0hfxS7nSueUMONdMM2yQ8wbGyowFR03om3Px0yNbrWFrnLkNAxcTPVyhQsOrj3OWQlvob+8DRW3wCKrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 096711007;
	Fri, 12 Jul 2024 06:41:13 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B918E3F766;
	Fri, 12 Jul 2024 06:40:44 -0700 (PDT)
Message-ID: <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
Date: Fri, 12 Jul 2024 14:40:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
 <20240711234917.GW14050@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240711234917.GW14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 12:49 am, Jason Gunthorpe wrote:
> On Wed, Jul 10, 2024 at 12:17:17PM +0800, Yi Liu wrote:
>> On 2024/7/10 02:23, Jason Gunthorpe wrote:
>>> On Wed, Jul 03, 2024 at 02:57:51PM +0800, Yi Liu wrote:
>>>
>>>> BTW. For AMD, can a single device be attached to multiple V1 page table?
>>>> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
>>>> is a PASID table which has multiple cr3 page table pointers.
>>>
>>> Yes, ARM and AMD both have kinds of iommu_domains that cannot be
>>> attached to a PASID.
>>
>> I see. VT-d does not have such a limitation AFAIK.
> 
> Yeah, it is nice for software that VT-d put the right bits in to let
> all paths select either format.
> 
>> BTW. SVA domain shall not be attached to RID I suppose. This should
>> be a common restriction across vendors. Do you think it is valuable
>> to let iommu core block such an attempt?
> 
> Yeah, maybe.

There's no functional reason to disallow it for Arm SMMUs, at least, so 
it's something that could potentially want relaxing back to per-driver 
in future. I've heard murmurings over the years about potential 
use-cases for SVA with platform and/or non-PASID PCI devices, but never 
anything concrete for existing hardware. I imagine we can expect to see 
more SVA-interested on-chip accelerators in future, but whether they'll 
all be nice and support Substreams (i.e. "platform PASIDs") is the 
question...

Thanks,
Robin.
