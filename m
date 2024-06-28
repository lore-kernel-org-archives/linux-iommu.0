Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440E153810
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580014; cv=none; b=Bi5bJLVUQnBe9Cmx1Hic7jxSfd92bUy6kvNG2Ai96UZB9q3gIy8IYfvSLOsoB7ET7FxSw/Cf+wN3BVjZ+UDBgcsxnT98RZrIylURRNSsG/D1tQVDlGPmaaMOkyts/3sin8nSeG5lnW1KxvxWUOpgjFWW/f6G6ToSF/uVyeK2hME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580014; c=relaxed/simple;
	bh=UASR4RrQ6zjg+HjpURz3DIHTRB+FH+BmvQfPL/qg6GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDZcyJQ/2llsLwwJkmkrBul7u8TPCy21kmxYV2Qcym2y2oJqHglotFvduByMLn1svrCsnNwpiabRZsSdMsU/9gWoLft/Ml3Wrsn4XxlOaK2IqOZfYCrBVqIiScLA6YZ4NvXqxUsextuvEqXTbp3meeWGliUO/rNWDqlVAO5sFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A66106F;
	Fri, 28 Jun 2024 06:07:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4C63F73B;
	Fri, 28 Jun 2024 06:06:50 -0700 (PDT)
Message-ID: <903594d3-00c3-42f8-8003-eef30f110510@arm.com>
Date: Fri, 28 Jun 2024 14:06:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 1:23 pm, Baolu Lu wrote:
> On 2024/6/28 14:43, Vasant Hegde wrote:
>> We are working on adding domain_alloc_paging() support in AMD driver 
>> and came
>> across below issue.
>>
>> BACKGROUND:
>> ============
>> - AMD IOMMU HW has two different page tables : V1 (host page table) 
>> and V2
>> (guest page table). Only V2 page table supports PASID and PRI features.
>>
>> - With V2 page table we have an aliasing issue. Hence we added
>> per-device-domain-id when domain is configured with v2 page table. See 
>> upstream
>> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix 
>> potential
>> TLB aliasing issue")
>>
>>
>>
>> PROBLEM :
>> =========
>> With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose 
>> best page
>> table based on device capabilities (V2 for PASID capable device and V1 
>> page
>> table for rest of the devices).
>>
>> But we would like to continue enforcing V1 page table for UNMANAGED 
>> domain. As
>> in terms of IOMMU caching, it performs better than V2 page table.
>>
>> Also while adding SVA in AMD driver Jason mentioned that we should 
>> support PASID
>> with UNMANAGED domain. As I understand currently we don't have this 
>> feature in
>> upstream but we would like to support it in future. Keeping this use 
>> case also
>> in mind, we came up with below two options :
>>
>>    1 - Pass domain type : domain_alloc_paging(dev, type)
>>     When we add PASID with UNMANAGED domain we need a way to 
>> differentiate the
>> domain 'type' (See below attach sample code)
> 
> The domain type is not enough for the iommu driver to differentiate
> between device or PASID. For example, a domain of type UNMANAGED could
> be attached to either a device or a PASID. Furthermore, SVA domain is
> not a paging domain.
> 
>>    2 - Introduce new flag for domain_alloc_paging()
>>      Something like :
>>      #define DOMAIN_FLAG_UNMANAGED    0x01
>>      #define DOMAIN_FLAG_UNMANAGED_SVA    0x02
>>
>>      domain_alloc_paging(dev, flag)
>>      For now we will have 'DOMAIN_PAGING_UNMANAGED'.
> 
> Add an allocation flag seems to work. It doesn't indicate any type of
> domain. Instead, it indicates the required iommu feature.
> 
> Something like
> 
> #define DOMAIN_ALLOC_FLAG_PASID        0x1
> 
> means the allocated domain requires PASID to support on both device and
> IOMMU. If the hardware lacks this support, it should return failure.

Yeah, we could do with something sufficiently general, as we'll also 
have a need for passing pagetable-format options through to drivers to 
be able to replace iommu_set_pgtable_quirks().

Thanks,
Robin.
