Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93758296BA7;
	Fri, 23 Jan 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188258; cv=none; b=RJhKZCnlZJlIujqs6GEgtZgdD5UVxE+IH6BQX6MKLkv+G1siGspXGRaf4XP1vo26kAsAtQp+kr/CscuZM8rhXVTQXbZZCvF8JGtwULHnnUMZkixiz4cGnHMjFQcehUnn7sIpKgX/IqcvcDBIUQv9vC1cB5vKnLOzKjL0KQQ7mFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188258; c=relaxed/simple;
	bh=lO0XoMvaSm4zmRJXg0BjRuB2G9xf1KKNimz3m5o3Otk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDlVJVupw1Vsco70GkgTPyuLDis7ZeTdBiqOgVDDJn7J2sOaCJR7m7XOlB+yxqzlHWlERW+Jz6DonFUOHY8HCFa5Md0oGvAETe4yfDU6g9Vg14GlfXuXSjWi33WGp7gvnK7pDmeN6SDAAfnAS/AMB9P47NP+Tur1A37LAwHIfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omjz6D4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omjz6D4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FEAC19422;
	Fri, 23 Jan 2026 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188258;
	bh=lO0XoMvaSm4zmRJXg0BjRuB2G9xf1KKNimz3m5o3Otk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Omjz6D4ZpCbXYm6LHQszcy7YdAn4FZwmhBSVgTULkdCLbyJ5+hiz3M0nO9ghSZQLw
	 wwGIlwsMxs9/S2JlTYEwCHUUHyrKllIPaF69bGdAslFwoRKd/tMkGMq6cZhEnL7qTg
	 QnknNLuoGvFwWY4WJAsQrRffIXke1VG0SRcH3/+j2Q5NIgu/tJXOoZrcY2um6/3l1+
	 /puP1oGW/c87h9I6rv6cWG1RZnM4Um8QGAkpA180f9DDLJtFM6VdKAgUvGnUp0+VI+
	 Xm/f02uK0UQhgD9c3wfID5CkwPLuYNUb1ohUh4VJZFYmNRZvohlhjKfglFnm70+9c9
	 WtWElzomfp5VA==
Date: Fri, 23 Jan 2026 17:10:52 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXOrnMLLzZL9BtRT@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOqVcX9YEC-Ikdt@willie-the-truck>

On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > +	/*
> > +	 * We are committed to updating the STE. Ensure the invalidation array
> > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > +	 * IOPTE updates.
> > +	 *
> > +	 *  [CPU0]                        | [CPU1]
> > +	 *                                |
> > +	 *  change IOPTEs and TLB flush:  |
> > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > +	 *    // load invalidation array  | }
> > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > +	 *                                |   STE = TTB0 // read new IOPTEs
> > +	 */
> > +	smp_mb();
> 
> I don't think we need to duplicate this comment three times, you can just
> refer to the first function (e.g. "See ordering comment in
> arm_smmu_domain_inv_range()").
> 
> However, isn't the comment above misleading for this case?
> arm_smmu_install_old_domain_invs() has the sequencing the other way
> around on CPU 1: we should update the STE first.

I also think we probably want a dma_mb() instead of an smp_mb() for all
of these examples? It won't make any practical difference but I think it
helps readability given that one of the readers is the PTW.

Will
