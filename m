Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7B14D283
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440203; cv=none; b=cpF8pMepP51DGfvOp1acrXdLPrULPTeb7P4V6253tiBs9bl7SFIfDqVIaBUbYwktGFxn5ALYpt2CkQrHiQDr+Y663R2cix6kBuR2vCD0dEqVKCgXYjraBoMe22aHsD77uLvB/ss1i9320uFbnnIY/gZe4TVP1TgXE7YNaxw+kpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440203; c=relaxed/simple;
	bh=/1TPc1mlJpP4iYstRwjFHfKmzRYt3oEaYLWUQHJEybw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW5LykuCzgaLXCY2mkQTCpUorYu3sGSsqWAvDOjmyBLxaKZIFImp0NJtzzThPH/a4NUEy3TPNErmsZno3a3SIrt8eHnd5523Yuch5YyDe9oXGIa8NPhNTAxkU09KY1G+FqHSzb1G3aEgLCYa0tADoiguMDrMCM5ydC/1edbfhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FFC01A9A;
	Tue, 14 Oct 2025 04:09:53 -0700 (PDT)
Received: from [10.57.7.84] (unknown [10.57.7.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC723F66E;
	Tue, 14 Oct 2025 04:09:59 -0700 (PDT)
Message-ID: <526186fa-d17a-4b79-b51d-83492b19c941@arm.com>
Date: Tue, 14 Oct 2025 12:09:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, praan@google.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-2-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250929155001.3287719-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-29 4:49 pm, Mostafa Saleh wrote:
> At the moment, if the self test fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> and fmt is enough to identify the failed case, and the rest can
> be deduced from the code.

That is the same cfg information already logged at the start of the 
test, so if it's not useful to dump the actual internal details of the 
ops then just remove the whole function and make life even simpler. 
(Otherwise export it or turn it into a callback.)

Thanks,
Robin.
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7e8e2216c294..00218af5d5f7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -1299,14 +1299,10 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
>   
>   static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
>   {
> -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
>   
> -	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
> -		cfg->pgsize_bitmap, cfg->ias);
> -	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
> -		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
> -		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
> +	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
> +		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
>   }
>   
>   #define __FAIL(ops, i)	({						\

