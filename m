Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155D21423C
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287223; cv=none; b=o/mXeLhUfQk+TOwt2dEQCFwtxP+xwEOChXTBloyh1dwa/4ZT8ZqdHCNQH5mKkSqKhiwPkF7VcpRmn3xs0aIfIiGFTPwJDgSrkuS7V6tsm7zzPeTCu8f2kzVtDMT9eaYSfd7jlxRQ92PbxkuqiXHUdImDuZ3GTtKsipJk034vDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287223; c=relaxed/simple;
	bh=8NkfjExjcZQdIrEnQx6NKZtEaRkNlBMrerq7vMUeaVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqva12iJIPR6/PzsEFDH0Ipmh1Tg10g9zhqjcds9QSNL47/vUeIDmi0teiGUpEsOe50WR/jps8T+0D8cgUM44M2SO5nEjGCDa4veXtLLpRbwRbxhejFT43asUSE3Nj/gdTqVVo4JEpDHDDgo0W3kvRnq8l/HFOIdbcoUitwzBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43E181691;
	Tue,  9 Dec 2025 05:33:33 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7773F762;
	Tue,  9 Dec 2025 05:33:38 -0800 (PST)
Message-ID: <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com>
Date: Tue, 9 Dec 2025 13:33:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
 Tomasz Nowicki <tnowicki@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
 <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com> <aTgX9qhaLyrQ5iye@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aTgX9qhaLyrQ5iye@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-09 12:37 pm, Mostafa Saleh wrote:
> On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
>> On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
>>> arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
>>> correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
>>> as IAS would be 40 bits.
>>
>> But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
>> SMMU architecture is talking about the maximum IAS that an SMMU
>> implementation needs to be able to accommodate based on its configuration,
>> but it does then attempt to clarify that the actual IPA size in use by any
>> given context should depend on the VMSA format in use:
>>
>> "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
>> and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
>>
>> Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
>> AArch32/AArch64 detail.
> 
> I see, thanks a lot for the explanation, I got confused by the this
> statement:
> Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.

Indeed, that appears confusingly contradictory; I've filed a bug.

> However, I think this is still a bug but somewere else, as at the moment
> the SMMUv3 dirver will use the SMMU IAS (40-bits) as input for AArch64
> stage-2 page tables, so we need either to limit the IAS as:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d16d35c78c06..d21153156daa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2561,7 +2561,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>          case ARM_SMMU_DOMAIN_S2:
>                  if (enable_dirty)
>                          return -EOPNOTSUPP;
> -               pgtbl_cfg.ias = smmu->ias;
> +               pgtbl_cfg.ias = min(smmu->ias, smmu->oas);
>                  pgtbl_cfg.oas = smmu->oas;
>                  fmt = ARM_64_LPAE_S2;
>                  finalise_stage_fn = arm_smmu_domain_finalise_s2;
> 
> Or, don't populate IAS depending on AArch32 support as the driver
> doesn't support it, effectively reverting:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0c453dbcce7767cd868deb809ba68083c93954e

It does appear we've missed the detail here. TBH I'm not really sure why 
we're bothering to consider the theoretical maximum IAS at all when it 
only makes any difference to a format we've never cared about supporting 
anyway. Frankly I'd be inclined to just remove smmu->ias altogether - 
even if we did ever want to support LPAE format, it would be just as 
trivial for that to hard-code pgtbl_cfg.ias = 40 based on the 
architecture rules.

Thanks,
Robin.
