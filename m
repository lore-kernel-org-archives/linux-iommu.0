Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D21F12F4
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995396; cv=none; b=FJbBNiKIURkhBj3KImXNJX/2rW5/GjjDhs3nvaTa3NThaoFDSpppd4m7WIqIDCgfcr6mw236RQXQIWVxQfcu+dDTY5+wRCARG7fxo90v4O3eFS80ZeZxHpUZqSpNREC2lBnxiii2iv/E6kzuQ+IDp0zXcK+L5hn+mgXVegh01FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995396; c=relaxed/simple;
	bh=12B+oaAwpkcpy00bG61SDeYnN3Hz/xl/L+K2y+Yf8QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7olotJ8ItbxVlYMCbdu/yeEJ0XGzOBaQpCaonN/M3N6K55v+63inqFGCMTd2HN2MyMWS8CMQ18WucOm7kX2yfAZOhqqEBCbkYXjLmJWEOK1b0PRrt5y4/+i1uNEAUGvZFnqVbvTQ0JadHh0tPPWh7D//w1rCd+M1vZdL2g4N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF2CB113E;
	Mon,  3 Mar 2025 01:50:07 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745A53F66E;
	Mon,  3 Mar 2025 01:49:50 -0800 (PST)
Date: Mon, 3 Mar 2025 09:49:47 +0000
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
Message-ID: <20250303094947.GB13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
 <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>

Hi David,

Thanks for taking the time to review.

On Mon, Mar 03, 2025 at 10:17:12AM +0100, David Hildenbrand wrote:
> On 28.02.25 19:24, Mikołaj Lenczewski wrote:
> > If we support bbml2 without conflict aborts, we can avoid the final
> > flush and have hardware manage the tlb entries for us. Avoiding flushes
> > is a win.
> > 
> > Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >   arch/arm64/mm/contpte.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 145530f706a9..77ed03b30b72 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
> >   		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> >   	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> > -
> > -	if (system_supports_bbml2_noabort())
> > -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> >   }
> >   void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> 
> What's the point of not squashing this into #2? :)
> 
> If this split was requested during earlier review, at least seeing patch #2
> on its own confused me.

This split is a holdover from an earlier patchset, where it was still
unknown whether the removal of the second flush was permitted with
BBML2. Partly this was due to us being worried about conflict aborts
after the removal, and partly this was because the "delay" is a separate
optimisation that we could apply even if it turned out the final patch
was not architecturally sound.

Now that we do not handle conflict aborts (preferring only systems that
handle BBML2 without ever raising aborts), the first issue is not a
problem. The reasoning behind the second patch is also a little bit
outdated, but I can see the logical split between a tlbi reorder, and
the removal of the tlbi. If this is truly redundant though, I would be
happy to squash the two into a single patch.

-- 
Kind regards,
Mikołaj Lenczewski
