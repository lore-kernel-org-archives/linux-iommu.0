Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F6252900;
	Wed,  5 Mar 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203358; cv=none; b=YQfOeax1n7xJySC3PTQjROY4VY1GW5IoxWfmGG+ouC+VLHIBc6mJIXC74OyNEDEGlZCVMLF7J6wpvOPHey+dTRvZRrQRXuapUxdBleuVA9bB94FiTyCQJ0Cs56G9Y2bnh6qEiceXYettzFLsMkTvFYQFCCc5LXdjy/X7c7FXB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203358; c=relaxed/simple;
	bh=opvlMC7/dJjo3sftbWz3StojmcMoaNBHavqjKNA8v6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IerqBWkWITySafUvk9ecO4NBwh1VsBrlRCrFlaqvIX5/3WCbn0CrdM7CQHC7BOoat554vSkHdPDx18MmHok7abtXaBv9uvVpTvxADRy83klPIA2DzqBf6Vdf9zz+lg5N0Ke/Cu5wdwR4MvzWo4JlLZ5pZGqlhF8OjD9qlsUCyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlI0YgwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlI0YgwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF4BC4CEE0;
	Wed,  5 Mar 2025 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741203357;
	bh=opvlMC7/dJjo3sftbWz3StojmcMoaNBHavqjKNA8v6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlI0YgwRiawZxVfrzvh4EJlkNqVQ1InEA61nj5QxoxVAjruJi1q2XRqZC7mlmXb1Q
	 a+xEx2hFlaU+nsxDoVMo26p5IUrVsnpaAqNXcoT3WKFjo2PVyFA4RneQVwmOjqclqU
	 RFmHzOxsMcNiNG3HSoCU/AslAXoM/l8y0dDxq5virnG8fZInzdVcZO8ivDc8npM1b1
	 j9FkaqKHxs7W+AJ5v8+pMpWDkqnBuZJhceyCj2IMjl5d1dAbig0QCpplvQ5y+Zy25T
	 LOlrl5dZWUq7BWZgaCSpPiayGmXJrhqnTpQcfeEw3WjdAQVX/YmljeMmjwjv+YjgLk
	 cL8L7w0omJlPw==
Date: Wed, 5 Mar 2025 19:35:52 +0000
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] [arm64/tlb] Fix mmu notifiers for range-based invalidates
Message-ID: <20250305193551.GB32246@willie-the-truck>
References: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
 <Z8iccxCo7tkqvE_p@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iccxCo7tkqvE_p@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Mar 05, 2025 at 06:48:19PM +0000, Catalin Marinas wrote:
> On Tue, Mar 04, 2025 at 12:51:27AM -0800, Piotr Jaroszynski wrote:
> > Update the __flush_tlb_range_op macro not to modify its parameters as
> > these are unexepcted semantics. In practice, this fixes the call to
> > mmu_notifier_arch_invalidate_secondary_tlbs() in
> > __flush_tlb_range_nosync() to use the correct range instead of an empty
> > range with start=end. The empty range was (un)lucky as it results in
> > taking the invalidate-all path that doesn't cause correctness issues,
> > but can certainly result in suboptimal perf.
> > 
> > This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
> > invalidate_range() when invalidating TLBs") when the call to the
> > notifiers was added to __flush_tlb_range(). It predates the addition of
> > the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
> > Refactor the core flush algorithm of __flush_tlb_range") that made the
> > bug hard to spot.
> 
> That's the problem with macros.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Will, do you want to take this as a fix? It's only a performance
> regression, though you never know how it breaks the callers of the macro
> at some point.

Yeah, I'll pick it up but I'm travelling atm so it may have to wait until
next week.

Will
