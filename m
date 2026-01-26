Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4333066B;
	Mon, 26 Jan 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439285; cv=none; b=IlChuno6cAPrQOxq8SfSF2H+CRaO+2NlvZg7zm7qd0yoyf8lv7sV7POloKvpn+/7GRgn+UKAEL/Obx0uXzFwBADyqijTzVlYHn2IkdDb9iL3hXoedBBeI2aDgzaDPoHfJYOWll9OSEOODZuqCq4SVS5PwlcD34xuvnUyHjKLu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439285; c=relaxed/simple;
	bh=7sRyq9vC8/ABpNkwM+B6b4cRdcvsa50dvpc8Ewv/ufM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1xB6qeuMeKZ864V1653XEyx51MTL80HpxjoYhyrB7jHwDPlhV4QjjJZLOu47KCYwHyUWccgKiAJR+ySz7+ejUtTUtIl+7Hh2FLwkKbkzfsMFcBE+SBtfGHK9+eckk0quXIJ1+NwJo/ymm8WY5qi7tRmlG7CgJXeF92FVVeXeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDxdNLEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDxdNLEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD1FC116C6;
	Mon, 26 Jan 2026 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769439284;
	bh=7sRyq9vC8/ABpNkwM+B6b4cRdcvsa50dvpc8Ewv/ufM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDxdNLEyhAhLPM9W+w9yGtoYMuvdFpDU4if2F/p6P197GRjupD8TsigOvI5CaZv9k
	 sK96+NZp97x4X6xVF08Gt62nGXGKg3lcFhLEjf36+JboinAsU3PZfmM7T8ZsINaLeS
	 LO2NdtIbU0pWRchVnOzJsmTyj2hWkXSpccD5ITTgly0UZPkQ2yZMbZSu4DENeGl/A9
	 rjtZuX1lrnPDjAF9SVU8i2taw7CACtOPdl4mvuhG9kIljzP9dKZ25uNmU/vC0iQWKS
	 5qaf3qk718m0LvQuNYb3rhQqVaqgbK9s8em5hZ+V+J3Klspfh0ZOdGlIykPOeoM17E
	 11QP0vbpVYqhA==
Date: Mon, 26 Jan 2026 14:54:38 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXeALpV1wcQk9tah@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
 <aXOpzjkAgODnh2HU@willie-the-truck>
 <aXOxfi8ZQAkr4zHU@Asurada-Nvidia>
 <aXO1OLrOsCkep3V8@willie-the-truck>
 <aXO2MY6gzs/lxT7S@Asurada-Nvidia>
 <20260123191654.GD1134360@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123191654.GD1134360@nvidia.com>

On Fri, Jan 23, 2026 at 03:16:54PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 23, 2026 at 09:56:01AM -0800, Nicolin Chen wrote:
> > On Fri, Jan 23, 2026 at 05:51:52PM +0000, Will Deacon wrote:
> > > On Fri, Jan 23, 2026 at 09:35:58AM -0800, Nicolin Chen wrote:
> > > > On Fri, Jan 23, 2026 at 05:03:10PM +0000, Will Deacon wrote:
> > > > > On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> > > > > > +struct arm_smmu_inv {
> > > > > > +	struct arm_smmu_device *smmu;
> > > > > > +	u8 type;
> > > > > > +	u8 size_opcode;
> > > > > > +	u8 nsize_opcode;
> > > > > > +	u32 id; /* ASID or VMID or SID */
> > > > > > +	union {
> > > > > > +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> > > > > > +		u32 ssid; /* INV_TYPE_ATS */
> > > > > > +	};
> > > > > > +
> > > > > > +	refcount_t users; /* users=0 to mark as a trash to be purged */
> > > > > 
> > > > > The refcount_t API uses atomics with barrier semantics. Do we actually
> > > > > need those properties when updating the refcounts here? The ASID lock
> > > > > gives us pretty strong serialisation even after this patch series and
> > > > > we rely heavily on that.
> > > > 
> > > > But we can't use that mutex in the invalidation function that
> > > > might be an IRQ context?
> > > 
> > > My question, really, is why do you need the atomic properties in this patch
> > > series? It just looks like overhead at the moment.
> > 
> > Hmm, shouldn't it be atomic, since..
> > 
> > (might be IRQ, no mutex) __arm_smmu_domain_inv_range() reads it.
> > (mutex protected) arm_smmu_attach_dev() writes it.
> > 
> > ..?
> 
> It doesn't need to be a full atomic, you can use WRITE_ONCE/READ_ONCE
> instead for this case.
> 
> The general argument of this scheme is it doesn't matter if the
> invalidation side is doing extra invalidation, that is supposed to
> always be safe except for ATS. For ATS we hold locks and then it
> doesn't to be atomic because of the lock.
> 
> So I think Will has it right, just use READ_ONCE/WRITE_ONCE on a naked
> unsigned int.

There's the usual scary ordering worries with this stuff, but they exist
with refcount_read() too. We're ok because cur->users is address dependent
on the read of the invalidation array pointer, which is RCU protected.

(I think!)

Will
