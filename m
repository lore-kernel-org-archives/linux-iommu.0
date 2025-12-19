Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFE346FD0
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147697; cv=none; b=UtUi+X9BAYcmKLHcC95SlAOqEDnkSibjEVQaAXZdijy+few8r8VXoD0VyY4yDSnTysbx6oceKZuN25b920e6BghhY+nE4nt+ySphv7jXw5jqwbq5/s4tGGNDAmgJqkTgXG2+l9olVTaG83o81uM642/Cm9ctYMnqHO33khAcldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147697; c=relaxed/simple;
	bh=++2XhAvqg7lrV2gvEgNbASdTMpPvXQQIZdb6cbP4z8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHPcaIIJ4UrwfccWaicQmfSdgMjez8N8FNitVzQS3z0T6DEE96GhYdOhqYUNrMWpaBP/1m4jqPBp5S32gxTJ29ZtMlpPb3OD1Il2pWe4V/EVRCSFHBMFr20m/Vx7oVysbiticgJD4xOZOH+RExYKMazNEWxnOcIleE6ctHL8ulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0C9FEC;
	Fri, 19 Dec 2025 04:34:47 -0800 (PST)
Received: from [10.57.47.58] (unknown [10.57.47.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13CAC3F5CA;
	Fri, 19 Dec 2025 04:34:51 -0800 (PST)
Message-ID: <99bb1797-06ba-440d-b173-db62d5f54e08@arm.com>
Date: Fri, 19 Dec 2025 12:34:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: Provide dcache_inval_poc_nosync helper
To: Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com,
 m.szyprowski@samsung.com, will@kernel.org
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, maz@kernel.org, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, zhengtangquan@oppo.com
References: <20251219053658.84978-1-21cnbao@gmail.com>
 <20251219053658.84978-4-21cnbao@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251219053658.84978-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-19 5:36 am, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> dcache_inval_poc_nosync does not wait for the data cache invalidation to
> complete. Later, we defer the synchronization so we can wait for all SG
> entries together.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   arch/arm64/include/asm/cacheflush.h |  1 +
>   arch/arm64/mm/cache.S               | 43 +++++++++++++++++++++--------
>   2 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 9b6d0a62cf3d..382b4ac3734d 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
>   extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
>   extern void dcache_inval_poc(unsigned long start, unsigned long end);
>   extern void dcache_clean_poc(unsigned long start, unsigned long end);
> +extern void dcache_inval_poc_nosync(unsigned long start, unsigned long end);
>   extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
>   extern void dcache_clean_pop(unsigned long start, unsigned long end);
>   extern void dcache_clean_pou(unsigned long start, unsigned long end);
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index 4a7c7e03785d..8c1043c9b9e5 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -132,17 +132,7 @@ alternative_else_nop_endif
>   	ret
>   SYM_FUNC_END(dcache_clean_pou)
>   
> -/*
> - *	dcache_inval_poc(start, end)
> - *
> - * 	Ensure that any D-cache lines for the interval [start, end)
> - * 	are invalidated. Any partial lines at the ends of the interval are
> - *	also cleaned to PoC to prevent data loss.
> - *
> - *	- start   - kernel start address of region
> - *	- end     - kernel end address of region
> - */
> -SYM_FUNC_START(__pi_dcache_inval_poc)
> +.macro _dcache_inval_poc_impl, do_sync
>   	dcache_line_size x2, x3
>   	sub	x3, x2, #1
>   	tst	x1, x3				// end cache line aligned?
> @@ -158,11 +148,42 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
>   3:	add	x0, x0, x2
>   	cmp	x0, x1
>   	b.lo	2b
> +.if \do_sync
>   	dsb	sy
> +.endif

Similarly, don't bother with complication like this, just put the DSB in 
the one place it needs to be.

Thanks,
Robin.

>   	ret
> +.endm
> +
> +/*
> + *	dcache_inval_poc(start, end)
> + *
> + * 	Ensure that any D-cache lines for the interval [start, end)
> + * 	are invalidated. Any partial lines at the ends of the interval are
> + *	also cleaned to PoC to prevent data loss.
> + *
> + *	- start   - kernel start address of region
> + *	- end     - kernel end address of region
> + */
> +SYM_FUNC_START(__pi_dcache_inval_poc)
> +	_dcache_inval_poc_impl 1
>   SYM_FUNC_END(__pi_dcache_inval_poc)
>   SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
>   
> +/*
> + *	dcache_inval_poc_nosync(start, end)
> + *
> + * 	Issue the instructions of D-cache lines for the interval [start, end)
> + * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
> + *	sy later
> + *
> + *	- start   - kernel start address of region
> + *	- end     - kernel end address of region
> + */
> +SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
> +	_dcache_inval_poc_impl 0
> +SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
> +SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
> +
>   /*
>    *	dcache_clean_poc(start, end)
>    *

