Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A57241667
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668093; cv=none; b=cufGqaKKWhaAnYNaf1WU3O4kwW0iWeWfAfdspQvYCB1gMlxmHdLqgFCPKrDBfWQmrWDyeM8JCGbPmNTP45T85zHhh9bkUsslEAVpC8Y00ra/qiCMZnkl+ZWV+/fVh2pIDMJaNO/462qDmU+UUKQNuAD4QOWKyzjSYYqI48plyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668093; c=relaxed/simple;
	bh=Sj0nblZmwBde4JWYkXm9/ob2UWRAkw69j22VX4lrtxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTCJUfY0HX7aOFE1v490gUpO3T2aAmblP/tWUFQgOhbPQblAqTU83rjFlDy/kk2e5cwaHxVb2oDgC6Cuvxmju0e+U5382rRztWphHNaivFghJ16QKUAahpKE1H/IcTZMRGLHWarcadzHb66DLy6kALErrK0wxaAB5ucuwxAKTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCF3106F;
	Thu,  3 Apr 2025 01:14:52 -0700 (PDT)
Received: from [10.57.88.195] (unknown [10.57.88.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9A853F59E;
	Thu,  3 Apr 2025 01:14:44 -0700 (PDT)
Message-ID: <fc505d3f-8ee4-40ed-8b8e-9e1c07b21fe1@arm.com>
Date: Thu, 3 Apr 2025 09:14:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 ardb@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
 baohua@kernel.org, david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250325093625.55184-1-miko.lenczewski@arm.com>
 <20250325093625.55184-4-miko.lenczewski@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250325093625.55184-4-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/2025 05:36, Mikołaj Lenczewski wrote:
> When converting a region via contpte_convert() to use mTHP, we have two
> different goals. We have to mark each entry as contiguous, and we would
> like to smear the dirty and young (access) bits across all entries in
> the contiguous block. Currently, we do this by first accumulating the
> dirty and young bits in the block, using an atomic
> __ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
> performing a tlbi, and finally smearing the correct bits across the
> block using __set_ptes().
> 
> This approach works fine for BBM level 0, but with support for BBM level
> 2 we are allowed to reorder the tlbi to after setting the pagetable
> entries. We expect the time cost of a tlbi to be much greater than the
> cost of clearing and resetting the PTEs. As such, this reordering of the
> tlbi outside the window where our PTEs are invalid greatly reduces the
> duration the PTE are visibly invalid for other threads. This reduces the
> likelyhood of a concurrent page walk finding an invalid PTE, reducing
> the likelyhood of a fault in other threads, and improving performance
> (more so when there are more threads).
> 
> Because we support via allowlist only bbml2 implementations that never
> raise conflict aborts and instead invalidate the tlb entries
> automatically in hardware, we can avoid the final flush altogether.
> Avoiding flushes is a win.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/mm/contpte.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 55107d27d3f8..77ed03b30b72 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -68,7 +68,8 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>  			pte = pte_mkyoung(pte);
>  	}
>  
> -	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> +	if (!system_supports_bbml2_noabort())
> +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>  
>  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);

Despite all the conversation we had about completely eliding the TLBI for the
BBML2 case, I've continued to be a bit uneasy about it. I had another chat with
Alex C and we concluded that it is safe, but there could be conceivable
implementations where it is not performant. Alex suggested doing a TLBI without
the DSB and I think that's a good idea. So after the __set_ptes(), I suggest adding:

	if (system_supports_bbml2_noabort())
		__flush_tlb_range_nosync(mm, start_addr, addr, PAGE_SIZE,
					 true, 3);

That will issue the TLBI but won't wait for it to complete. So it should be very
fast. We are guranteed correctness immediately. We are guranteed performance
after the next DSB (worst-case; next context switch).

Thanks,
Ryan

>  }

