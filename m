Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EB2E413;
	Tue, 16 Dec 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876175; cv=none; b=lVtyzAFbRF/2KHd5f8q8c7AY5sVqccUKpmEGJnPCqxzixhQpNMQgjNm++7EkklLtQpz0RVGEmPH4U3GvQYkLN9QNNQ/WoeTHNh98iTyqNu3ndj16tM6xlHfrx/pwvQS71Zjhvaem1L+sfrFFCnOj4gK7ez8D3xo7+kGAHbhOG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876175; c=relaxed/simple;
	bh=7MOXEZd8OTG1jJroXP2S5YsMEq0H5oZI9rstiyJuS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2thn67Z89RgrS+DYZj+6/H7xm2WuIR0GzTkO9sQbBbry4Hg3AXFiXkQuPC66CjZ1gfWO2rTGXAe+/GzLxwwhrXwr8KnqeaRGppe/U/WLdxoyPQlRbR34cOhwOuSuIGBtSj+4vSjBEktsLqFdJ7lDN/MIXkVA3OjRnDAQAEgLAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EGU98HFn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EGU98HFn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G8vFdbCoXoQWxNuIqiNC6avfN6oRhkb8uCVonpEE+I0=; b=EGU98HFnnll3heXhjq18qwymyH
	/QKoX+/871pQUKl/ZshD2tjHva/Dwwsw47cYj9RQ7w44CcxrseEa4AV9ufaAXwPyjHpe8Uaw59o+g
	+rAP7RPzk4JKesINprYJsR+MldWdRQK8igKyccQUGMiUbniQfY8T4ywtqVYkX7Zu2iV7VKpZGzTiG
	v/DZZB+ehFL6zun03fDm1Nmxc093/owcWReREwy/Qs+5UAJ+wkm+tbVQTZHD8gE99y3Qq51ewavJ4
	XGi7n37JFGgnjKMeLFaNOq5IONIyLdCa7szQCH+/Jf6f409dk575dbaiC6nU65GpWVc4PM3hSX+/F
	tjalKIKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVR3f-0000000357m-1Vnb;
	Tue, 16 Dec 2025 09:09:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEF0530057C; Tue, 16 Dec 2025 10:09:26 +0100 (CET)
Date: Tue, 16 Dec 2025 10:09:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
References: <cover.1765850465.git.nicolinc@nvidia.com>
 <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>

On Mon, Dec 15, 2025 at 06:09:35PM -0800, Nicolin Chen wrote:


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
> @@ -3280,6 +3478,12 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
>  		return;
>  
>  	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> +	/*
> +	 * We are committed to updating the STE. Ensure the invalidation array
> +	 * is visable to concurrent map/unmap threads, and acquire any racying
> +	 * IOPTE updates.
> +	 */
> +	smp_mb();
>  	kfree_rcu(invst->old_invs, rcu);
>  }


s/visable/visible/ s/racying/racing/


Anyway, if I understand the above correctly, the smb_mb() is for:

  arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()

    [W] IOPTE				  [Wrel] smmu_domain->invs
    smp_mb()				  smp_mb()
    [Lacq] smmu_domain->invs		  [L] IOPTE

Right? But I'm not sure about your 'HW sees the new IOPTEs' claim; that
very much depend on what coherency domain the relevant hardware plays
in. For smp_mb() to work, the hardware must be in the ISH domain, while
typically devices are (if I remember my arrrrgh64 correctly) in the OSH.

Please clarify and all that ;-)
