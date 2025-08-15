Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C401DA21
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269011; cv=none; b=CShniS7IeaNuVPdZCdMTLjgZDdYN7qSGNLXMEAfUSZR6yhkIo2JRMIbfPInhwPV7aAJKcg45OB14GHcpoyu6FBDeXzXDblxWuGOkJi/r/ussM0vFbGWGKxHdF2QP/nsSOYkPvnY80/6hIxxRnjYBk04iDMsYrTEO8M3TLxgILAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269011; c=relaxed/simple;
	bh=H+MKg2uxNKB4lyEh3o4Bh7PG+GoIsHy/48Um6bNfqCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7eY+i5yyGnNTqak+gscO6JwT/6CfjyMakKVnuzRnzxuc+TolHxqIGrsSk/h7/C6HvvpnklThcFB5FMZP9dCE7hWHEjHdHSsQX9lSFy0R3LSnSO/cHBD2uclr3uSTayePQwY2Rd8Li0KqPCUo6KHbbkzkXK9LLn31uW+o5/h3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEDFF1691;
	Fri, 15 Aug 2025 07:43:20 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E7B33F738;
	Fri, 15 Aug 2025 07:43:27 -0700 (PDT)
Message-ID: <e87aa091-5c02-4cd6-9636-0cb6c0015768@arm.com>
Date: Fri, 15 Aug 2025 15:43:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/riscv: prevent NULL deref in iova_to_phys
To: Joerg Roedel <joro@8bytes.org>,
 XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: tjeznach@rivosinc.com, markus.elfring@web.de, will@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>
 <aJ8FbvCJEOj2XjT-@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aJ8FbvCJEOj2XjT-@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 11:01 am, Joerg Roedel wrote:
> On Fri, Aug 15, 2025 at 03:12:44PM +0800, XianLiang Huang wrote:
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index 2d0d31ba2886..0eae2f4bdc5e 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>>   	unsigned long *ptr;
>>   
>>   	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
>> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
>> +	if (!ptr)
>>   		return 0;
> 
> Zero is usually not an invalid physical address, or is it on RISC-V?

It's a valid PA on many systems of many architectures, but it's also 
been the "not mapped/error" value for the iova_to_phys operation all the 
way back to the very very first intel_iommu_iova_to_pfn() nearly 17 
years ago, so hey :)

Thanks,
Robin.
