Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6101D5CD4
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695366; cv=none; b=ntpFjXiuZMkSD7EXdydmChEO8wxi21OjrpQKvLU4TtD7G54cXMxp6+TbRjSk6oKRaknSzfBpnEpPXouPe9aP/fBgIHYYHWJDnEqIBy3rXjOHxzmftHz1hmIRVW9rd+xEBcmGLtUzHM3CTMKnqrMNdodWuShVAIWujcaaez+BOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695366; c=relaxed/simple;
	bh=MkeYKa5cqeFSXj7twX8L/2hZDjliL4ro3Xl7ydv9qV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXFF5V00OyhnyyauDUtIblDh+KvXdcR8i0/IanygYsu7pFoScoH4tkrLmVdKhg+HWNU0/Ojt5tEG9YivAw5ms4LcTx6MsT5731Je3/9gGjCTYz7PcgUsNdy3qt2XsHAm6NmdDSLSZar+Ouca10dql3I4V7+TbCyL+riTK6B3ygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E908153B;
	Fri, 15 Nov 2024 10:29:52 -0800 (PST)
Received: from [10.1.25.41] (010265703453.arm.com [10.1.25.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D50E3F66E;
	Fri, 15 Nov 2024 10:29:21 -0800 (PST)
Message-ID: <888e6542-2aa4-43f1-b31e-79432c1ad199@arm.com>
Date: Fri, 15 Nov 2024 18:29:20 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/io-pgtable-arm: Fix stage concatenation with 16K
To: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, joro@8bytes.org, Daniel Mentz <danielmentz@google.com>
References: <20241115172235.1493328-1-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241115172235.1493328-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-15 5:22 pm, Mostafa Saleh wrote:
> According to the Arm spec DDI0487 K.a, in:
> "Table D8-9 Implications of the effective minimum T0SZ value on the
> initial stage 2 lookup level"
> 
> Some combinations of granule and input size with stage-2 would
> require to use initial lookup levels that can only be achieved
> with concatenated PGDs.
> 
> There was one missing case in the current implementation for 16K,
> which is 40-bits.
> 
> Cc: Daniel Mentz <danielmentz@google.com>
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 0e67f1721a3d..9a57874a5cb8 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -1044,10 +1044,18 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   		return NULL;
>   
>   	/*
> -	 * Concatenate PGDs at level 1 if possible in order to reduce
> -	 * the depth of the stage-2 walk.
> +	 * Some cases where concatenation is mandatory after de-ciphering RSRKBC
> +	 * in the Arm DDI0487 (K.a):
> +	 * - 40 bits with 4K: use 2 table at level 1 instead of level 0
> +	 * - 40 bits with 16K: use 16 tables at level 2 instead of level 1
> +	 * - 42 bits with 4K: use 8 tabels at level 1 instead of level 0
> +	 * - 48 bits with 16K: use 2 tabels at level 1 instead of level 0

This confused me, since per R_DXBSH, that last one is the only one which 
is actually mandatory in general; the others may be valid per R_PZFHQ 
and R_FBHPY. The additional R_SRKBC constraints come from the PA size, 
not the choice of T0SZ (and thus ultimately start_level) itself, so 
although I guess this probably works out true in practice based on how 
the SMMU drivers happen to behave today, it's none too obvious why.

Thanks,
Robin.

> +	 * Looking at the possible valid input size, that concludes to always
> +	 * use level 1 with concatentation if possible or at level 2 only
> +	 * with 16K.
>   	 */
> -	if (data->start_level == 0) {
> +	if ((data->start_level == 0) ||
> +	    ((data->start_level == 1) && (ARM_LPAE_GRANULE(data) == SZ_16K))) {
>   		unsigned long pgd_pages;
>   
>   		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);

