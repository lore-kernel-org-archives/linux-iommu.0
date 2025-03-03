Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DA1EF0AA
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999364; cv=none; b=rqyAgrvbTeg+faAUqe3Mi2AUIPzGvd89ssWSfU8pSnjNHwnlz3BHYbshSxFmBVZY8ZfCo+LxT/ntOXYA8vlVw97I4i3ETD2sFe+GEUzVZl1XJQcIOU2K9zyoHsC3GzNxv8Ipu0eGOG2Qz6brb1BmC5D9SXdXTx3hPBMwRyskD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999364; c=relaxed/simple;
	bh=FlxgyLo4pSK6DnDRMZ2Gy02rNuDZ9j7QbXDlKG6JUnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX/AcuF6FYKboydsv5s+PIS1MDyyGFP68/Lxap2YOxnreBSoQrjsmaC4j8Lf8s4XlbtgKq90VWTwCsZZEWyEJcXiVCU4yNwO7VW7J9LK7t4kIUqzMPvgqAHJKGzhJfp54j6f+fZ2tHLc8DKUnRlJGHzYitLkfg49iTB9B+kK7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 836CD113E;
	Mon,  3 Mar 2025 02:56:16 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77DE73F673;
	Mon,  3 Mar 2025 02:55:58 -0800 (PST)
Date: Mon, 3 Mar 2025 10:55:47 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	akpm@linux-foundation.org, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Message-ID: <20250303105539.GA74129@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
 <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
 <20250303094947.GB13345@e133081.arm.com>
 <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e987f17-ffcb-45e0-8588-2d569d90f776@redhat.com>

On Mon, Mar 03, 2025 at 10:57:21AM +0100, David Hildenbrand wrote:
> On 03.03.25 10:49, Mikołaj Lenczewski wrote:
> > Hi David,
> > 
> > Thanks for taking the time to review.
> > 
> > On Mon, Mar 03, 2025 at 10:17:12AM +0100, David Hildenbrand wrote:
> > > On 28.02.25 19:24, Mikołaj Lenczewski wrote:
> > > > If we support bbml2 without conflict aborts, we can avoid the final
> > > > flush and have hardware manage the tlb entries for us. Avoiding flushes
> > > > is a win.
> > > > 
> > > > Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> > > > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > > > ---
> > > >    arch/arm64/mm/contpte.c | 3 ---
> > > >    1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > > > index 145530f706a9..77ed03b30b72 100644
> > > > --- a/arch/arm64/mm/contpte.c
> > > > +++ b/arch/arm64/mm/contpte.c
> > > > @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
> > > >    		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> > > >    	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> > > > -
> > > > -	if (system_supports_bbml2_noabort())
> > > > -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> > > >    }
> > > >    void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> > > 
> > > What's the point of not squashing this into #2? :)
> > > 
> > > If this split was requested during earlier review, at least seeing patch #2
> > > on its own confused me.
> > 
> > This split is a holdover from an earlier patchset, where it was still
> > unknown whether the removal of the second flush was permitted with
> > BBML2. Partly this was due to us being worried about conflict aborts
> > after the removal, and partly this was because the "delay" is a separate
> > optimisation that we could apply even if it turned out the final patch
> > was not architecturally sound.
> > 
> > Now that we do not handle conflict aborts (preferring only systems that
> > handle BBML2 without ever raising aborts), the first issue is not a
> > problem. The reasoning behind the second patch is also a little bit
> > outdated, but I can see the logical split between a tlbi reorder, and
> > the removal of the tlbi. If this is truly redundant though, I would be
> > happy to squash the two into a single patch.
> 
> Thanks for the information.
> 
> Does patch #2 (reordering the tlbi) have any benefit on its own? I read
> "other threads will not see an invalid pagetable entry", but I am not sure
> that is correct. A concurrent HW page table walker would still find the
> invalid PTE? It's just a matter of TLB state.

I think I understand what you mean. I agree that it is possible for a
concurrent walk to see an invalid TLBI state, if it is on the same TLB
that the repaint is happening on. For other TLBs, the flush has not yet
propagated our invalidated PTEs (from `__ptep_get_and_clear()`) though?
That invalidation will only be seen by other TLBs after the
`__flush_tlb_range()`, so we should save a few faults because only
"local" threads will ever see the invalid entry, as opposed to all
threads that try to read our modified range? Or it is the case that I
have misunderstood something basic here, or that I have misinterpreted
what you have written?

> If there is no benefit in having patch #2 independently, I'd just squash
> them. Reordering to then remove is more complicated than just removing it
> IMHO.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Kind regards,
Mikołaj Lenczewski
