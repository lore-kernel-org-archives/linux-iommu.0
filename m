Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2C29BD89
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280088; cv=none; b=DCbryUgZ06PoWRsm61+UAQHt5QHx539EzumiIBM+8SR00Hs4ozG7DBYjWK8yZvb33GsHu1IkoLZH2B2hDXjerjuZ920j7R7j6Wmd+/g0CospxtWHahIuuUFOqExhKhpIU48AYc+CSsNzZLfz28RhgBUylaBuGh9rdKZkVM1LMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280088; c=relaxed/simple;
	bh=Q6S6XOCH7gDNxc8/fnM0J+2fO4vM6wHIWugin5CS67U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7axN5u8lsNOfgba9j498iKsXFkD0wM/WlfdRc96WkGyqUvbdVkvXWk6hPC6xNTT7ZQr6ba7g2F05GjydMyaEffXqn4L5moyiIral6KvCMNG6oqcjbIq1ier/2YmPp4N7wycAkj2kq/SA6aO3T+jrtoLoHoiSv6fOiZ0/YvIf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9218A1691;
	Tue,  9 Dec 2025 03:34:37 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2FD3F762;
	Tue,  9 Dec 2025 03:34:43 -0800 (PST)
Message-ID: <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com>
Date: Tue, 9 Dec 2025 11:34:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: will@kernel.org, joro@8bytes.org, Tomasz Nowicki <tnowicki@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251130194506.593700-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
> arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
> correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
> as IAS would be 40 bits.

But that is only when *using* AArch32 format. The bit in chapter 3.4 of 
the SMMU architecture is talking about the maximum IAS that an SMMU 
implementation needs to be able to accommodate based on its 
configuration, but it does then attempt to clarify that the actual IPA 
size in use by any given context should depend on the VMSA format in use:

"VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas 
VMSAv8-64 and VMSAv9-128 limits the maximum IPA size to the maximum PA 
size."

Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with 
this AArch32/AArch64 detail.

> In that case, concatenation is mandatory in some cases.
> Document those and add the checks, this can be simplified; instead
> of adding extra checks we can say that concatenation is mandatory for:
> - 4K, start level = 0 and OAS <= 42 bits.
> - 16K, start level = 1 and OAS <= 40 bits.
> Which cover all the missing cases.

AArch32 uses a fixed 4K granule, so this cannot impact 16K. Note that we 
don't support AArch32 for SMMUv3 anyway, and while this does technically 
apply to SMMUv1/2, Arm's MMU-400/401/500 implementations all have OAS 
fixed at 40/40/48 bits respectively, so I'd imagine it's quite a rare 
case to encounter in practice.

Thanks,
Robin.

> Reported-by: Tomasz Nowicki <tnowicki@google.com>
> Fixes: 4dcac8407fe1 ("iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e6626004b323..ecf27e86b429 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -223,6 +223,8 @@ static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
>    *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
>    *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
>    *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
> + *   f) 32/36 bits PA size with 4K and 40 bits IAS: use level 1 instead of level 0
> + *   g) 32/36 bits PA size with 16K and 40 bits IAS: use level 2 instead of level 1
>    */
>   static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
>   					     struct arm_lpae_io_pgtable *data)
> @@ -234,13 +236,13 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
>   	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
>   		return (oas == 48) || (ias == 48);
>   
> -	/* Covers 2.a and 2.c */
> +	/* Covers 2.a, 2.c and 2.f */
>   	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
> -		return (oas == 40) || (oas == 42);
> +		return (oas <= 42);
>   
> -	/* Case 2.b */
> +	/* Case 2.b and 2.g */
>   	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
> -	       (data->start_level == 1) && (oas == 40);
> +	       (data->start_level == 1) && (oas <= 40);
>   }
>   
>   static dma_addr_t __arm_lpae_dma_addr(void *pages)

