Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F98283FC8;
	Mon, 26 Jan 2026 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443345; cv=none; b=da9+1H1KVwBCR/5BezKvxtlqIKasOtXYWeq8VTWBQybz73BfIkdWmmDavgWyxc1w1v5uCZlb9m71QeUKZNqg4MUCY/GB0hcjBo9pv9boBTe7fM3ohqzKdfTZodgwEeGWaCHV2rpnR4X4AkoZeHcGgLJtQJkKgE3mHoEH15i1XxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443345; c=relaxed/simple;
	bh=EgFkyoJbsDSFh6qX7Hv4uyf8awBGZ88hYYx/LfvFSGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5IKc5Na2G283AeZpyEFm4kgsQWkZNkgHTAy1ZYxaNjCIecr2XLA4A7jGHhx7iPXjgSaSaq2K1ckjsGpwU9PsCyAvfvJ1MDqq+3sSlA+hRWEH9x73ltHXAh5dr7f5Q4jnFoPfEqw/DAuNXpD4RRfsVE2W+p83Gc0j3mNdrs3q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j48shhal; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j48shhal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFDCC116C6;
	Mon, 26 Jan 2026 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769443345;
	bh=EgFkyoJbsDSFh6qX7Hv4uyf8awBGZ88hYYx/LfvFSGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j48shhaltmH3/WbsngSKV9s1t05sKxtWovpjZEEIw529kVpOBfyCGFLG4tuyVTD1C
	 QL6hAFG9ETT9TaZZm72CJbEq4ef8ESIvgzJB+HtEgq90FMnxl3KnE5zM/6+910yZeP
	 KltuX6Ez5FFwUrJ+H4dv8pluaX644hIPEDVqAhEpl0FuseYS/THSddtFwawUcSROqx
	 YnEMHSzpFExqHblKcorGz6MWatW/gIcTGNNYB9rIObb5L5t1Ld0Vjm0lGHxkFu/2cn
	 9kBur7+e7tAPdhqhnexNPWx5XLAMSFaI+Hk6JZRlfMKhobqOegFEb8BO027nlLpbjY
	 /DRDY1C3lt0PA==
Date: Mon, 26 Jan 2026 16:02:19 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXeQC3GjUgafuOi-@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
 <aXdlnLLFUBwjT0V5@willie-the-truck>
 <20260126152019.GK1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126152019.GK1134360@nvidia.com>

On Mon, Jan 26, 2026 at 11:20:19AM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 01:01:16PM +0000, Will Deacon wrote:
> > On Fri, Jan 23, 2026 at 04:03:27PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> > > > On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > > > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > > > +	/*
> > > > > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > > > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > > > > +	 * IOPTE updates.
> > > > > > +	 *
> > > > > > +	 *  [CPU0]                        | [CPU1]
> > > > > > +	 *                                |
> > > > > > +	 *  change IOPTEs and TLB flush:  |
> > > > > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > > > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > > > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > > > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > > > > +	 *    // load invalidation array  | }
> > > > > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > > > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > > > > +	 */
> > > > > > +	smp_mb();
> > > > > 
> > > > > I don't think we need to duplicate this comment three times, you can just
> > > > > refer to the first function (e.g. "See ordering comment in
> > > > > arm_smmu_domain_inv_range()").
> > > > > 
> > > > > However, isn't the comment above misleading for this case?
> > > > > arm_smmu_install_old_domain_invs() has the sequencing the other way
> > > > > around on CPU 1: we should update the STE first.
> > > > 
> > > > I also think we probably want a dma_mb() instead of an smp_mb() for all
> > > > of these examples? It won't make any practical difference but I think it
> > > > helps readability given that one of the readers is the PTW.
> > > 
> > > The only actual dma_wmb() is inside arm_smmu_install_ste_for_dev()
> > > after updating the STE. Adding that line explicitly would help as that
> > > is the only point where we must have the writes actually visible to
> > > the DMA HW.
> > > 
> > > The ones written here as smp_mb() are not required to be DMA ones and
> > > could all be NOP's on UP..
> > 
> > Hmm, I'm not sure about that.
> > 
> > If we've written a new (i.e. previously invalid) valid PTE to a
> > page-table and then we install that page-table into an STE hitlessly
> > (let's say we write the S2TTB field) then isn't there a window before we
> > do the STE invalidation where the page-table might be accessible to the
> > SMMU but the new PTE is still sitting in the CPU?
> 
> Hmm! Yes seems like it.
> 
> However, that's seems like a general bug, if we allocate an
> iommu_domain and immediately hitlessly install it, then there would be
> no dma_wmb() for the page table memory prior to the earliest point the
> HW is able to read the STE.
> 
> What I wrote is is how things are intended to work, so lets fix it
> with this?
> 
> @@ -1173,6 +1173,13 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
>         __le64 unused_update[NUM_ENTRY_QWORDS];
>         u8 used_qword_diff;
>  
> +       /*
> +        * Many of the entry structures have pointers to other structures that
> +        * need to have their updates be visible before any writes of the entry
> +        * happen.
> +        */
> +       dma_wmb();

If we do that, can we drop the smp_mb()s from
arm_smmu_install_{old,new}_domain_invs()?

Then the barrier in arm_smmu_domain_inv_range() is kind of irritating
but it demonstrates the need for additional ordering (beyond what we
get from the pgtable code) to ensure that a prior update to the
page-table is ordered before the RCU-protected read of the invalidation
array pointer. So that becomes the special case, with everybody else
relying on a dma_wmb() from either the cmdq insertion or the CD/STE
update.

Will
