Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4423B61E;
	Mon, 26 Jan 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453800; cv=none; b=EWfAJJm28bXSlFNo0R1T4A6Z6Y/Oe9xs8OWDGHCCTs1W9UrS5gUrOjAZC30gMoa2JwPHSWJHpXUIx6BR2/gZ0tdOlF9h4/1KH/S3ns9kqwTflW/lnChG9AZtAb5ozs2jnLIuZQIZx2sHxsRyg1px5dKWzihutXxAKlveFmPFFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453800; c=relaxed/simple;
	bh=RK0yLvS/H1dCapN7yhJ4VLO4e8zez9xvVOjncJv7jew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE9TnRqZq+DqlikVmzc8Adi/db2jM2S98EGaevLJQNNjDe09IlLQyl7nd7JF9SFRJK7GcnyifQ4/WerooWeLXh+AEnjpenUyr0GtRWIDm6rtHI8rUmnOoA2QURY5kG7NX0MfI5Xe6RRHRw5zt3MScj4EzbcLdzb1O8TQ+L37SVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvM4iFxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvM4iFxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4C6C116C6;
	Mon, 26 Jan 2026 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769453800;
	bh=RK0yLvS/H1dCapN7yhJ4VLO4e8zez9xvVOjncJv7jew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvM4iFxr+f/wFDXQSK8NT83OzplMeoeF4/k19OjEM06oT8+iQXYl7iJGwezwXkux7
	 QK9QLjeL96W/imrxoz8n28+EQ8f8XuPNr6fttDnG4TY42YtGSb9QawAX7sB2Mtbxzj
	 5/CLclzqbuAQWMa8QW3gv1sSLVDRik0j7OTj4rGyQbxPJkq7AQHX5djpeth2WNfuu3
	 smQVrp7XawN65z3ZtetJA9tH09cwKwBsBhrcoSAnWIDXnFwpZHXDCcGFQXQA7wQcxA
	 jmFWVX1w1YzMK8ozhl/s58H4RlaW+lhkbgdY7oSnBmoAIUCuzAEAe3K+U5Bk564X0/
	 ga1sWg732h4Ww==
Date: Mon, 26 Jan 2026 18:56:34 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXe44sLQ3yUYiS9H@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
 <aXdlnLLFUBwjT0V5@willie-the-truck>
 <20260126152019.GK1134360@nvidia.com>
 <aXeQC3GjUgafuOi-@willie-the-truck>
 <20260126160940.GM1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126160940.GM1134360@nvidia.com>

On Mon, Jan 26, 2026 at 12:09:40PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 26, 2026 at 04:02:19PM +0000, Will Deacon wrote:
> > On Mon, Jan 26, 2026 at 11:20:19AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Jan 26, 2026 at 01:01:16PM +0000, Will Deacon wrote:
> > > > On Fri, Jan 23, 2026 at 04:03:27PM -0400, Jason Gunthorpe wrote:
> > > > > On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> > > > > > On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > > > > > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > > > > > +	/*
> > > > > > > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > > > > > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > > > > > > +	 * IOPTE updates.
> > > > > > > > +	 *
> > > > > > > > +	 *  [CPU0]                        | [CPU1]
> > > > > > > > +	 *                                |
> > > > > > > > +	 *  change IOPTEs and TLB flush:  |
> > > > > > > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > > > > > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > > > > > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > > > > > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > > > > > > +	 *    // load invalidation array  | }
> > > > > > > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > > > > > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > > > > > > +	 */
> > > > > > > > +	smp_mb();
> 
> > If we do that, can we drop the smp_mb()s from
> > arm_smmu_install_{old,new}_domain_invs()?
> 
> I suppose so, but domain attach isn't a performance path so it depends
> on your preference for strict pairing of barriers. Currently the two
> smp_mbs() are paired. Can we reliably pair smp_mb() with dma_wmb()?
> Are you happy with that clarity?

Yeah, I think that's ok.

> My view is attach isn't a performance path, so having extra barriers
> is fine if it helps understandability.

I think that the more barriers we have, the harder the code is to
understand so I would prefer just to have the smp_mb() for the
write->read case in arm_smmu_domain_inv_range() along with a comment
explaining why it's needed.

I think that also means that my concern about the old comments on the
other patch largely disappears.

Will
