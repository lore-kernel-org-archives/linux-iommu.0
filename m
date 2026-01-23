Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3B2C21C3;
	Fri, 23 Jan 2026 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187931; cv=none; b=RQhThGuM23rodmz15mZ9XYSKI7juj9FgHiIdoj1shHjh2B6trR6VywJZ/rs6DipiAdDcCDHpUiDpbR9xRMBLO3n/2Hb7A0dAttwzpmnT/HRMgzApJrrOMcL+fJUZe4v0ws4Bu7vQYxtwR21VuGnooEnJ+ou8FKGR1/DbgwmzlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187931; c=relaxed/simple;
	bh=WO63o5Q2VVInqzhmP1GbbfLkgfmmJvMmamxU+orQc3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEzU/8Q3Q6sdvEChDIaQmI/pqfauHx38oOFAS/8mGz2tsDjwJGpMU0RoaHaDbAFjSQIP5u/9IYG3YzD7qc6Yz1BdkC8BP0BtoFnro8Ia3CZAw9Ecfn3EVxiwB9c0p7JxbJJy/Vj/OcAQsdwecSLKjhUubYJ0Z1TW0W4372ydlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxhiRxd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxhiRxd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C7FC19421;
	Fri, 23 Jan 2026 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769187931;
	bh=WO63o5Q2VVInqzhmP1GbbfLkgfmmJvMmamxU+orQc3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxhiRxd1Hfn5KzlrT15FtbckKVsEmE1qomTLIiIT4CjXs35d9bZI0CVlysgsOw/c+
	 00xFonQe2mFliwip/9Ie1xiwKPO2hEoboAvuv7WHBo/UnLtvDmxFRU2YJAVs3BaKKy
	 3FwkGK/af7rVb1ZTuveuAuYBMnarC1CUHF/h1S3UU/dC4xKWWm51/dIjjhAKAS6k8E
	 D1Gm4E/iI1pR5kyZzfuotZglN+wU/5X0/8vjp1ZdTNBf79TEjskTdpqqpKQ1uSnrGB
	 Z7n3+2TPD0zsO4x1wR6s5dzV+oxQVsjx0+PgapJVl+ZW3pIRwHdIlP1v1C8JSuMLAl
	 BBtfU1TBDFlXw==
Date: Fri, 23 Jan 2026 17:05:25 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXOqVcX9YEC-Ikdt@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> +void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
> +			       unsigned long iova, size_t size,
> +			       unsigned int granule, bool leaf)
> +{
> +	struct arm_smmu_invs *invs;
> +
> +	/*
> +	 * An invalidation request must follow some IOPTE change and then load
> +	 * an invalidation array. In the meantime, a domain attachment mutates
> +	 * the array and then stores an STE/CD asking SMMU HW to acquire those
> +	 * changed IOPTEs. In other word, these two are interdependent and can
> +	 * race.
> +	 *
> +	 * In a race, the RCU design (with its underlying memory barriers) can
> +	 * ensure the invalidation array to always get updated before loaded.
> +	 *
> +	 * smp_mb() is used here, paired with the smp_mb() following the array
> +	 * update in a concurrent attach, to ensure:
> +	 *  - HW sees the new IOPTEs if it walks after STE installation
> +	 *  - Invalidation thread sees the updated array with the new ASID.
> +	 *
> +	 *  [CPU0]                        | [CPU1]
> +	 *                                |
> +	 *  change IOPTEs and TLB flush:  |
> +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs {
> +	 *    ...                         |   rcu_assign_pointer(new_invs);
> +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> +	 *    // load invalidation array  | }
> +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> +	 *                                |   STE = TTB0 // read new IOPTEs
> +	 */
> +	smp_mb();
> +
> +	rcu_read_lock();
> +	invs = rcu_dereference(smmu_domain->invs);
> +
> +	/*
> +	 * Avoid locking unless ATS is being used. No ATC invalidation can be
> +	 * going on after a domain is detached.
> +	 */
> +	if (invs->has_ats) {
> +		read_lock(&invs->rwlock);
> +		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
> +		read_unlock(&invs->rwlock);
> +	} else {
> +		__arm_smmu_domain_inv_range(invs, iova, size, granule, leaf);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
>  					 unsigned long iova, size_t granule,
>  					 void *cookie)
> @@ -3285,6 +3483,23 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
>  		return;
>  
>  	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> +	/*
> +	 * We are committed to updating the STE. Ensure the invalidation array
> +	 * is visible to concurrent map/unmap threads, and acquire any racing
> +	 * IOPTE updates.
> +	 *
> +	 *  [CPU0]                        | [CPU1]
> +	 *                                |
> +	 *  change IOPTEs and TLB flush:  |
> +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_new_domain_invs {
> +	 *    ...                         |   rcu_assign_pointer(new_invs);
> +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> +	 *    // load invalidation array  | }
> +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> +	 *                                |   STE = TTB0 // read new IOPTEs
> +	 */
> +	smp_mb();
>  	kfree_rcu(invst->old_invs, rcu);
>  }
>  
> @@ -3334,6 +3549,23 @@ arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
>  		return;
>  
>  	rcu_assign_pointer(*invst->invs_ptr, new_invs);
> +	/*
> +	 * We are committed to updating the STE. Ensure the invalidation array
> +	 * is visible to concurrent map/unmap threads, and acquire any racing
> +	 * IOPTE updates.
> +	 *
> +	 *  [CPU0]                        | [CPU1]
> +	 *                                |
> +	 *  change IOPTEs and TLB flush:  |
> +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> +	 *    ...                         |   rcu_assign_pointer(new_invs);
> +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> +	 *    // load invalidation array  | }
> +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> +	 *                                |   STE = TTB0 // read new IOPTEs
> +	 */
> +	smp_mb();

I don't think we need to duplicate this comment three times, you can just
refer to the first function (e.g. "See ordering comment in
arm_smmu_domain_inv_range()").

However, isn't the comment above misleading for this case?
arm_smmu_install_old_domain_invs() has the sequencing the other way
around on CPU 1: we should update the STE first.

Will
