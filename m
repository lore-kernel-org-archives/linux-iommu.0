Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98586329;
	Fri, 23 Jan 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190718; cv=none; b=CvMojGXnEU1tjw8TVyDi2muCulmiOcla6mNibCTJTTwv7r/TwuHNbnCAsE2EImDpJE+/fNmVklNd9+z16Yw3c3TEFgZ2ORUkRmAarvF7OW/7OKeDDoeme4TLZJV2uI542OLQa9juPByPDb7TLt9SVcNjCKrlJIMrPB07bNKggZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190718; c=relaxed/simple;
	bh=hvF0TEDnYwT7/9fDIPj1Uln1puS77Z3p/8YlfCj6ZKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J84D4WOVbDz+SoxcorwX3MCCLEphiWPoF/OdXhi4gqzPHO1WCqOaNcu2MhGXKgidModWYebN6AAYfGQ4n+1MK0r3sJXT81GedqqAT4R1CSwEeqSn8UU3iCsCRoXHTy5MUdJEhJMzZHn8GVqB8E/Vx6AaVlaf8yIx9ZDOdVAeT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1O3Tr00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1O3Tr00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB979C4CEF1;
	Fri, 23 Jan 2026 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190718;
	bh=hvF0TEDnYwT7/9fDIPj1Uln1puS77Z3p/8YlfCj6ZKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1O3Tr00NjhkWBu2cym1RRPv0vh+e8ksJSG1tfk30d9wnpWW2NL6H1TU0sXlYeXPD
	 zIYT0vKx88QYOw2XOmY9pdrxdJTkaPCHFkrpJQwD5DTXytUDKY/xkYjilu6NlHpNbv
	 ybh0YF7ZovMl8TU0tfqC9Ms0y/4CR53jkvgiQkLlNvLGfPw2HzP945qYoSooRk+fM3
	 AN6B1bC8dSuyl+skcUOQRp/BAy6lnEeYlpysrRWKVzN6k+zOSrK+ElZJxm4QlBSqeC
	 kkTl1zkifyMZDUOnNWVwL8vsA5O5jyCjD1rNCoace0QnHHMdbGv6JowIJDE0CNpw98
	 PBDDw3INvJ7zw==
Date: Fri, 23 Jan 2026 17:51:52 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXO1OLrOsCkep3V8@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>

On Fri, Jan 23, 2026 at 09:35:58AM -0800, Nicolin Chen wrote:
> On Fri, Jan 23, 2026 at 05:03:10PM +0000, Will Deacon wrote:
> > On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> > > +struct arm_smmu_inv {
> > > +	struct arm_smmu_device *smmu;
> > > +	u8 type;
> > > +	u8 size_opcode;
> > > +	u8 nsize_opcode;
> > > +	u32 id; /* ASID or VMID or SID */
> > > +	union {
> > > +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> > > +		u32 ssid; /* INV_TYPE_ATS */
> > > +	};
> > > +
> > > +	refcount_t users; /* users=0 to mark as a trash to be purged */
> > 
> > The refcount_t API uses atomics with barrier semantics. Do we actually
> > need those properties when updating the refcounts here? The ASID lock
> > gives us pretty strong serialisation even after this patch series and
> > we rely heavily on that.
> 
> But we can't use that mutex in the invalidation function that
> might be an IRQ context?

My question, really, is why do you need the atomic properties in this patch
series? It just looks like overhead at the moment.

Will
