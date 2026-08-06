Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C65311C07
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022262; cv=none; b=W7b5rYNRXx+3/9xNBkR/mfWSoVclqZOSHyh+4+VzUx8iFr40QPvSurWUwU8u7fBoWRI4X5ryrjLazHJOdDkVGYtuSScwVdaAGF+hIBUP1EH5diqo1aivITNsotT9VXbWD9wliWF94k48idu/cYH71aZcbaYwuV5O8V4nlI6peGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022262; c=relaxed/simple;
	bh=Xi0GI+CCHAN9OYhaAuPoCvL+bhIRpBxTXYrZjuadPO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9r6iI6S8US9NgIDxJ6jgYRpJF+oUb6CK3xib5sY4zIWe5yHTEAs/LnGpP8TMw0mcROsqjuyBvM8q+puuIHXXpFXa78J9PQKmB75iZIZPvtCkrN9Ll4qxN6F7FE1kq3MA6iQelEaODtplAd2gCGNlfu6TKDHyAHo1KnKCCo52/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LH79uJ1J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LH79uJ1J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6686A153B;
	Thu,  6 Aug 2026 06:17:31 -0700 (PDT)
Received: from [10.57.42.103] (unknown [10.57.42.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388EF3F632;
	Thu,  6 Aug 2026 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786022255; bh=Xi0GI+CCHAN9OYhaAuPoCvL+bhIRpBxTXYrZjuadPO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LH79uJ1Jg2SNwztVGfB2pmdXfLorfNsLrP+Ftqm/LOL1yi7R7Vv98nZjRu+MQWYcz
	 gpF5kVEPbHs+qGMcmFhnXyHGgHcIV+UHSR7a9RtQy8z1HG8Gp6lEVj+wqCp4t7y0+7
	 stpowvv+zBdM0WV4ABt5UlPSRDHY3yqNgcX3f+DI=
Message-ID: <7e66d67a-f63f-465c-acb0-c1238f534c07@arm.com>
Date: Thu, 6 Aug 2026 14:17:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/tegra241-cmdqv: Reject a VCMDQ base above the
 48-bit hardware limit
To: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260729220329.805417-1-nicolinc@nvidia.com>
 <anSCXUjivdb_aOv_@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <anSCXUjivdb_aOv_@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-06 1:47 pm, Will Deacon wrote:
> On Wed, Jul 29, 2026 at 03:03:29PM -0700, Nicolin Chen wrote:
>> tegra241_vcmdq_alloc_smmu_cmdq() allocates the VCMDQ buffer via the common
>> arm_smmu_init_one_queue(), which uses smmu->dev and its coherent DMA mask
>> of DMA_BIT_MASK(smmu->oas). An SMMUv3 queue base holds a 52-bit address in
>> Q_BASE_ADDR_MASK, but the VCMDQ_BASE register holds only 48 (VCMDQ_ADDR),
>> so the masked write "q_base = base_dma & VCMDQ_ADDR" silently drops bits 48
>> and up. The HW would then fetch its commands from a wrong memory location,
>> which likely raises VCMDQ errors.
>>
>> Real hardware always pairs an SMMU OAS with a matching VCMDQ address field,
>> so this cannot happen; it takes a VMM that gives a guest a mismatched OAS.
>> Nor can the guest rely on the VMM to catch it: an SMMU CMDQ base keeps bits
>> 48 and up in Q_BASE_ADDR_MASK, so a trapped CMDQ_BASE write still carries
>> them, while a VCMDQ base goes straight to the hardware and loses them.
>>
>> Reject a base_dma with bits set outside VCMDQ_ADDR, the way the user-VCMDQ
>> path already does for its base_addr_pa, failing the queue init rather than
>> silently truncating the base. Use dev_warn_once() rather than WARN_ON(), as
>> the OAS is VMM-controlled and a WARN_ON() would let it panic a guest booted
>> with panic_on_warn.
>>
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
> 
> This still just sounds like something that a VMM shouldn't do?

Yeah, if a VMM is going out of its way to emulate obviously-broken 
hardware, then in my opinion we should just give it what it wants and 
let it deal with the consequences of its brokenness.

But if we really do want to bother sanity-checking emulations, then why 
allow them to still get away with being broken in the case that we do 
happen to allocate queue memory at a sufficiently low PA anyway? Why not 
actually validate smmu->oas itself (plus anything else relevant) in 
__tegra241_cmdqv_probe()?

Thanks,
Robin.
