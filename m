Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223551DACB4
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486641; cv=none; b=rGXU9ocwvjqk/axXRt5ITfN6KHZ/Vmb7r639elWBlZTjZUDNJStzOuZw0ykw5WAJ/gEGEwpfRayP2V9Hih2PuHc9+CXoqgnKNCFCRHGpl4w/MgTiIiTQtvTsQZyMwjciyCON0BpXY0EXZTTg+8yJeUih5RXUZRY2vgmx9G1JkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486641; c=relaxed/simple;
	bh=Fitsa9Y6UcgLCLRC3yYHmn3QPvKbodxT+bml+mthUx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPy5w7yoZou2GJqxXZQgowj4eJev2Vv5pnnjFmwOS/bdg+UM2qqB2QMzvWq7d0kFwSm5+xzh1uERJWjaqyc9J1PBnoZMWyBwCYYl0LdiUQxeuxHBUUKDtrcKbJ9YEJRbrr27+SowtGEtzPli0gcHorv4QICDRlfcTpJ5bZS682w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F061474;
	Fri,  6 Dec 2024 04:04:23 -0800 (PST)
Received: from [10.57.90.152] (unknown [10.57.90.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B58F23F58B;
	Fri,  6 Dec 2024 04:03:53 -0800 (PST)
Message-ID: <7f58898d-b9a9-4e54-a198-70351fa51784@arm.com>
Date: Fri, 6 Dec 2024 12:03:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Document SVA interaction with new
 pagetable features
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, catalin.marinas@arm.com, joro@8bytes.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 mark.rutland@arm.com, joey.gouly@arm.com, ryan.roberts@arm.com,
 broonie@kernel.org
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <20241205181404.GB664340@myrica>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241205181404.GB664340@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-05 6:14 pm, Jean-Philippe Brucker wrote:
> On Thu, Dec 05, 2024 at 01:48:09PM +0000, Robin Murphy wrote:
>> Process pagetables may now be using new permission-indirection-based
>> features which an SMMU may not understand when given such a table for
>> SVA. Although SMMUv3.4 does add its own S1PIE feature, realistically
>> we're still going to have to cope with feature mismatches between CPUs
>> and SMMUs, so let's start simple and essentially just document the
>> expectations for what falls out as-is. Although it seems unlikely for
>> SVA applications to also depend on memory-hardening features, or
>> vice-versa,
> 
> Hard to predict, but SVA could be indirectly enabled by some common
> library: for example a libcrypto plugin that shares the address space with
> an accelerator when one is available (see uadk_engine). I'm not familiar
> with the POE use-cases, but I guess a common library could also enable
> those memory-hardening features, such that unsuspecting applications have
> everything enabled.
> 
>> the relative lifecycles make it tricky to enforce mutual
>> exclusivity. Thankfully our PIE index allocation makes it relatively
>> benign for an SMMU to keep interpreting them as direct permissions, the
>> only real implication is that an SVA application cannot harden itself
>> against its own devices with these features. Thus, inform the user about
>> that just in case they have other expectations.
>>
>> Also we don't (yet) support LPA2, so deny SVA entirely if we're going to
>> misunderstand the pagetable format altogether.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index 1d3e71569775..9ba596430e7c 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -112,6 +112,15 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>>   	 * from the current CPU register
>>   	 */
>>   	target->data[3] = cpu_to_le64(read_sysreg(mair_el1));
>> +
>> +	/*
>> +	 * Note that we don't bother with S1PIE on the SMMU, we just rely on
>> +	 * our default encoding scheme matching direct permissions anyway.
>> +	 * SMMU has no notion of S1POE nor GCS, so make sure that is clear if
>> +	 * either is enabled for CPUs, just in case anyone imagines otherwise.
>> +	 */
>> +	if (system_supports_poe() || system_supports_gcs())
>> +		dev_warn_once(master->smmu->dev, "SVA devices ignore permission overlays and GCS\n");
> 
> If POE tightens the page permissions, enabling SVA on top lets the
> application easily bypass the POE protection. Could we actually return
> false in arm_smmu_sva_supported() instead of displaying a warning that
> likely no one will notice?

The difficulty with both features is that they're always unconditionally 
*enabled* if present, but the SVA concern only arises if and when they 
are *actively used*, and that can be a transient thing. It doesn't seem 
reasonable to effectively make SVA unusable on newer CPUs (or at least 
force users to boot with MMFR overrides to lose GCS/POE if they want to 
use SVA), especially when it's far from clear how bothered anyone's 
really going to be about this anyway. I just think we should do at least 
*something* to remember and acknowledge that certain CPU features impact 
SVA too.

> I guess enforcing !(SVA & POE) on an address space would be too much work?

Yes, to attempt to do this "properly" I believe we'd need to keep track 
of how many SVA attachments, overlays, and GCS pages (if the SMMU can't 
support S1PIE) a process has at any given point in time, then check 
those in all 3 places to deny individual usage calls if the "opposing" 
feature is currently in use.

Thanks,
Robin.

> 
> Thanks,
> Jean
> 
>>   }
>>   EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_sva_cd);
>>   
>> @@ -206,8 +215,12 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>   	unsigned long asid_bits;
>>   	u32 feat_mask = ARM_SMMU_FEAT_COHERENCY;
>>   
>> -	if (vabits_actual == 52)
>> +	if (vabits_actual == 52) {
>> +		/* We don't support LPA2 */
>> +		if (PAGE_SIZE != SZ_64K)
>> +			return false;
>>   		feat_mask |= ARM_SMMU_FEAT_VAX;
>> +	}
>>   
>>   	if ((smmu->features & feat_mask) != feat_mask)
>>   		return false;
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>

