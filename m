Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF32451C8;
	Thu, 19 Jun 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750361364; cv=none; b=StB6zJGAfzB8S2SJg850EMbUSfCyp3ptDXDFRP4IR37J9s3/95TqnBGw+J8KyIzVoSWWnNj8OyJAjCf2EevrxLi/umjUDcKYEyNjKdXg6E+fWMTpIufk2Juc+LKO9xyxY8fhTd+O9OifUKmPUqSga+LZlH87TS0r7CFA63BhQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750361364; c=relaxed/simple;
	bh=hJlbQdsKxVMtt9Kp85pBFUNoKX0kIf6XpKlK2LU7+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBImgTbB0VUwyE7m1lakby1MpEConHsRJCImrqGUMln5E7cmwd2b3D/ACbhMbhrrKRLq3yv/AjSxiIk6O/G72wpE38EhKNCaL+NHsp3rnx8caw15rGkmItlo/9xvFe9ivev7todcXYXjE5Dv2SuPH1BuiFU3R0Na5FHd/awjMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E41C4CEED;
	Thu, 19 Jun 2025 19:29:19 +0000 (UTC)
Date: Thu, 19 Jun 2025 20:29:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <aFRlDSZ2PPnHixjc@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-5-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617095104.6772-5-miko.lenczewski@arm.com>

On Tue, Jun 17, 2025 at 09:51:04AM +0000, Mikołaj Lenczewski wrote:
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index bcac4f55f9c1..203357061d0a 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -68,7 +68,144 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>  			pte = pte_mkyoung(pte);
>  	}
>  
> -	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> +	/*
> +	 * On eliding the __tlb_flush_range() under BBML2+noabort:
> +	 *
> +	 * NOTE: Instead of using N=16 as the contiguous block length, we use
> +	 *       N=4 for clarity.
> +	 *
> +	 * NOTE: 'n' and 'c' are used to denote the "contiguous bit" being
> +	 *       unset and set, respectively.
> +	 *
> +	 * We worry about two cases where contiguous bit is used:
> +	 *  - When folding N smaller non-contiguous ptes as 1 contiguous block.
> +	 *  - When unfolding a contiguous block into N smaller non-contiguous ptes.
> +	 *
> +	 * Currently, the BBML0 folding case looks as follows:
> +	 *
> +	 *  0) Initial page-table layout:
> +	 *
> +	 *   +----+----+----+----+
> +	 *   |RO,n|RO,n|RO,n|RW,n| <--- last page being set as RO
> +	 *   +----+----+----+----+
> +	 *
> +	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
> +	 *
> +	 *   +----+----+----+----+
> +	 *   |  0 |  0 |  0 |  0 |
> +	 *   +----+----+----+----+
> +	 *
> +	 *  2) __flush_tlb_range():
> +	 *
> +	 *   |____ tlbi + dsb ____|
> +	 *
> +	 *  3) __set_ptes() to repaint contiguous block:
> +	 *
> +	 *   +----+----+----+----+
> +	 *   |RO,c|RO,c|RO,c|RO,c|
> +	 *   +----+----+----+----+

From the initial layout to point (3), we are also changing the
permission. Given the rules you mentioned in the Arm ARM, I think that's
safe (hardware seeing either the old or the new attributes). The
FEAT_BBM description, however, only talks about change between larger
and smaller blocks but no mention of also changing the attributes at the
same time. Hopefully the microarchitects claiming certain CPUs don't
generate conflict aborts understood what Linux does.

> +	 *
> +	 *  4) The kernel will eventually __flush_tlb() for changed page:
> +	 *
> +	 *                  |____| <--- tlbi + dsb
[...]
> +	 * It is also important to note that at the end of the BBML2 folding
> +	 * case, we are still left with potentially all N TLB entries still
> +	 * cached (the N-1 non-contiguous ptes, and the single contiguous
> +	 * block). However, over time, natural TLB pressure will cause the
> +	 * non-contiguous pte TLB entries to be flushed, leaving only the
> +	 * contiguous block TLB entry. This means that omitting the tlbi+dsb is
> +	 * not only correct, but also keeps our eventual performance benefits.

Step 4 above implies some TLB flushing from the core code eventually.
What is the situation mentioned in the paragraph above? Is it only until
we get the TLB flushing from the core code?

[...]
> +	if (!system_supports_bbml2_noabort())
> +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>  
>  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);

Eliding the TLBI here is all good but looking at the overall set_ptes(),
why do we bother with unfold+fold for BBML2? Can we not just change
them in place without going through __ptep_get_and_clear()?

-- 
Catalin
