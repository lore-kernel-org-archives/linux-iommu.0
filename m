Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CB29D267;
	Mon, 26 Jan 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432483; cv=none; b=o7JtyEujuxcw0l3pgsXXcn5uf4o0onLvigZrqzoA00lcA42rXV3GAjnV20YWgEkLDOH7s7YlrJeKBi6Joes0IGZ0d9y3AK1Cq6bisE0gOTcqCmgC4O+rBOwnHbw2m9zFtGvMP8rUse//gsn06E3yvXedP1uRS1pChyURppd0g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432483; c=relaxed/simple;
	bh=Xd/THcuRvy2RSO+rSHGNKmY7CloZ2FTMBlhUWMAkVEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMI7eXhI2LRZtt1lWiFpIW2FzJ+Wimn2FrTYTqzEPDQmYmK486+9m7FVrj83b6JlGOB/gv6sZag46exdRZNvTAxk4hy3lJK9oB8+/YOzlv4GETpk88Qv3nHd1vrDnad/X92qPs5w8jUUwmXoOmZ8ATR3BrrtwMz59ygdc/qpM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV3MfgYk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV3MfgYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3100BC16AAE;
	Mon, 26 Jan 2026 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769432482;
	bh=Xd/THcuRvy2RSO+rSHGNKmY7CloZ2FTMBlhUWMAkVEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oV3MfgYkjwLHxbQ1rbJwpCxTtGFEQ0kl+4zNojjSerWZvNfYgt/8Kow5f942gxDRG
	 xzTRA4kmjJcK/fcT6XAV1xINY3ph9SRmk4aR2uHWGaTvSkvGW8ADi5ZpkP5FLo/MQI
	 MdQsxZ5uEn+BNS1rScetfi9jONT0FNZka5cCSqOADtVY+t+mng8DxEFXtUXT6XfKVD
	 5xzyPNBZtXsxONYZ30/H58abvczWfXv1kf1aVXMD4peXWM/I/qImaqgHa2VaJlCAem
	 EADMuNJQOOvSXBvH8YrtOM3Na3jto/aJt8MrmpGkCqZ1Q9HqiMMFvVWWbJoPkHqBZ2
	 OoIjrEGbaPmsw==
Date: Mon, 26 Jan 2026 13:01:16 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXdlnLLFUBwjT0V5@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123200327.GF1134360@nvidia.com>

On Fri, Jan 23, 2026 at 04:03:27PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> > On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > +	/*
> > > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > > +	 * IOPTE updates.
> > > > +	 *
> > > > +	 *  [CPU0]                        | [CPU1]
> > > > +	 *                                |
> > > > +	 *  change IOPTEs and TLB flush:  |
> > > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > > +	 *    // load invalidation array  | }
> > > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > > +	 */
> > > > +	smp_mb();
> > > 
> > > I don't think we need to duplicate this comment three times, you can just
> > > refer to the first function (e.g. "See ordering comment in
> > > arm_smmu_domain_inv_range()").
> > > 
> > > However, isn't the comment above misleading for this case?
> > > arm_smmu_install_old_domain_invs() has the sequencing the other way
> > > around on CPU 1: we should update the STE first.
> > 
> > I also think we probably want a dma_mb() instead of an smp_mb() for all
> > of these examples? It won't make any practical difference but I think it
> > helps readability given that one of the readers is the PTW.
> 
> The only actual dma_wmb() is inside arm_smmu_install_ste_for_dev()
> after updating the STE. Adding that line explicitly would help as that
> is the only point where we must have the writes actually visible to
> the DMA HW.
> 
> The ones written here as smp_mb() are not required to be DMA ones and
> could all be NOP's on UP..

Hmm, I'm not sure about that.

If we've written a new (i.e. previously invalid) valid PTE to a
page-table and then we install that page-table into an STE hitlessly
(let's say we write the S2TTB field) then isn't there a window before we
do the STE invalidation where the page-table might be accessible to the
SMMU but the new PTE is still sitting in the CPU?

i.e. we can't rely on the command insertion barrier for that.

Will
