Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB92F6925;
	Mon, 24 Nov 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020557; cv=none; b=F3gv/wATf69LhVaoTUfs/Uht6BtgqUVDxZIjOKuyXICMrgDw5uRqGDOSxu9tkPkcWl0lvCp8OSAn8ztCa6+NfUpptC2p3UECU6j/NPq47TnXZD3aVhgydw0GkYvCbw6Fp7ke9ExAmpzGsLoOv9oAykUCY0KggDkrE6RDmT+3yDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020557; c=relaxed/simple;
	bh=4dyVxU18eNujO0O+8F/kKf6bj/VTA+a7QmdT7PhUMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR7yqh4r8I6kfUFbRiIOxQCjdiDNxOiive1uCc+R/Axn5jcGaK5zksI6VLgmTOUyEpjZsdtv26hEIOJcrdnNzav242BFwxwIgQoO7mGu+W5aXMN8BTOyYeAQryxIkV4O1d3WL1DhElFh2RuotX96pCGQF7ThcCAxbVCmvvho5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atPW7j9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atPW7j9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0DC4CEFB;
	Mon, 24 Nov 2025 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020557;
	bh=4dyVxU18eNujO0O+8F/kKf6bj/VTA+a7QmdT7PhUMnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atPW7j9f2Hu4HDB3X25xkWERIOMRFRf0xTZtkpWKObwDWf2XsoYp8WvCXIO8LWpCx
	 JcijPOc32d+Su0lxvso6ROBnRwbu1jpOlOuSXPuEvqeAotS0IzfMi2HHRrbEAOuYTm
	 PZXB8D8UYbbYftFuE0+aVjEhMrX9YJfy/1fWRv3rGKI7F2ABTP5H+VzbymqI31vBEQ
	 zT2hwefF/wup8eMmbK+a4fwnyeiIXPxZ6YhjEoYoi76FkoPIc1HeIUO4Bed5xrQFLP
	 3gQ69IT9WJfmN3hL6Ggvlllg1nxXeLm/I3srHuK8lgHcrBl4FdnHM+FeXv5Qmv9J/T
	 aGR+BOymg0whA==
Date: Mon, 24 Nov 2025 21:42:31 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aSTRRyTBh1nATwBa@willie-the-truck>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>

On Sat, Nov 08, 2025 at 12:08:04AM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create a new data structure to hold an array of invalidations that need to
> be performed for the domain based on what masters are attached, to replace
> the single smmu pointer and linked list of masters in the current design.
> 
> Each array entry holds one of the invalidation actions - S1_ASID, S2_VMID,
> ATS or their variant with information to feed invalidation commands to HW.
> It is structured so that multiple SMMUs can participate in the same array,
> removing one key limitation of the current system.
> 
> To maximize performance, a sorted array is used as the data structure. It
> allows grouping SYNCs together to parallelize invalidations. For instance,
> it will group all the ATS entries after the ASID/VMID entry, so they will
> all be pushed to the PCI devices in parallel with one SYNC.
> 
> To minimize the locking cost on the invalidation fast path (reader of the
> invalidation array), the array is managed with RCU.
> 
> Provide a set of APIs to add/delete entries to/from an array, which cover
> cannot-fail attach cases, e.g. attaching to arm_smmu_blocked_domain. Also
> add kunit coverage for those APIs.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  91 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 +++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 248 ++++++++++++++++++
>  3 files changed, 432 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96a23ca633cb6..757158b9ea655 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -649,6 +649,85 @@ struct arm_smmu_cmdq_batch {
>  	int				num;
>  };
>  
> +/*
> + * The order here also determines the sequence in which commands are sent to the
> + * command queue. E.g. TLBI must be done before ATC_INV.
> + */
> +enum arm_smmu_inv_type {
> +	INV_TYPE_S1_ASID,
> +	INV_TYPE_S2_VMID,
> +	INV_TYPE_S2_VMID_S1_CLEAR,
> +	INV_TYPE_ATS,
> +	INV_TYPE_ATS_FULL,
> +};
> +
> +struct arm_smmu_inv {
> +	struct arm_smmu_device *smmu;
> +	u8 type;
> +	u8 size_opcode;
> +	u8 nsize_opcode;
> +	u32 id; /* ASID or VMID or SID */
> +	union {
> +		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
> +		u32 ssid; /* INV_TYPE_ATS */
> +	};
> +
> +	refcount_t users; /* users=0 to mark as a trash to be purged */
> +};
> +
> +static inline bool arm_smmu_inv_is_ats(struct arm_smmu_inv *inv)
> +{
> +	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
> +}
> +
> +/**
> + * struct arm_smmu_invs - Per-domain invalidation array
> + * @num_invs: number of invalidations in the flexible array
> + * @rwlock: optional rwlock to fench ATS operations
> + * @has_ats: flag if the array contains an INV_TYPE_ATS or INV_TYPE_ATS_FULL
> + * @rcu: rcu head for kfree_rcu()
> + * @inv: flexible invalidation array
> + *
> + * The arm_smmu_invs is an RCU data structure. During a ->attach_dev callback,
> + * arm_smmu_invs_merge(), arm_smmu_invs_unref() and arm_smmu_invs_purge() will
> + * be used to allocate a new copy of an old array for addition and deletion in
> + * the old domain's and new domain's invs arrays.
> + *
> + * The arm_smmu_invs_unref() mutates a given array, by internally reducing the
> + * users counts of some given entries. This exists to support a no-fail routine
> + * like attaching to an IOMMU_DOMAIN_BLOCKED. And it could pair with a followup
> + * arm_smmu_invs_purge() call to generate a new clean array.
> + *
> + * Concurrent invalidation thread will push every invalidation described in the
> + * array into the command queue for each invalidation event. It is designed like
> + * this to optimize the invalidation fast path by avoiding locks.
> + *
> + * A domain can be shared across SMMU instances. When an instance gets removed,
> + * it would delete all the entries that belong to that SMMU instance. Then, a
> + * synchronize_rcu() would have to be called to sync the array, to prevent any
> + * concurrent invalidation thread accessing the old array from issuing commands
> + * to the command queue of a removed SMMU instance.
> + */
> +struct arm_smmu_invs {
> +	size_t num_invs;
> +	rwlock_t rwlock;
> +	bool has_ats;
> +	struct rcu_head rcu;
> +	struct arm_smmu_inv inv[];
> +};

Can you use __counted_by(num_invs) here?

> +
> +static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
> +{
> +	struct arm_smmu_invs *new_invs;
> +
> +	new_invs = kzalloc(struct_size(new_invs, inv, num_invs), GFP_KERNEL);
> +	if (!new_invs)
> +		return ERR_PTR(-ENOMEM);

Just return NULL on failure like most allocator functions?

> +	rwlock_init(&new_invs->rwlock);
> +	new_invs->num_invs = num_invs;
> +	return new_invs;
> +}
> +

[...]

> +VISIBLE_IF_KUNIT
> +struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
> +					  struct arm_smmu_invs *to_merge)
> +{
> +	struct arm_smmu_invs *new_invs;
> +	struct arm_smmu_inv *new;
> +	size_t num_trashes = 0;
> +	size_t num_adds = 0;
> +	size_t i, j;
> +
> +	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {

Maybe worth having a simple iterator macro for this?

> +		int cmp;
> +
> +		/* Skip any trash entry */
> +		if (i < invs->num_invs && !refcount_read(&invs->inv[i].users)) {
> +			num_trashes++;
> +			i++;
> +			continue;
> +		}
> +
> +		cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> +		if (cmp < 0) {
> +			/* not found in to_merge, leave alone */
> +			i++;
> +		} else if (cmp == 0) {
> +			/* same item */
> +			i++;
> +			j++;
> +		} else {
> +			/* unique to to_merge */
> +			num_adds++;
> +			j++;
> +		}
> +	}
> +
> +	new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes + num_adds);
> +	if (IS_ERR(new_invs))
> +		return new_invs;
> +
> +	new = new_invs->inv;
> +	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {
> +		int cmp;
> +
> +		if (i < invs->num_invs && !refcount_read(&invs->inv[i].users)) {
> +			i++;
> +			continue;
> +		}
> +
> +		cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> +		if (cmp < 0) {
> +			*new = invs->inv[i];
> +			i++;
> +		} else if (cmp == 0) {
> +			*new = invs->inv[i];
> +			refcount_inc(&new->users);
> +			i++;
> +			j++;
> +		} else {
> +			*new = to_merge->inv[j];
> +			refcount_set(&new->users, 1);
> +			j++;
> +		}
> +
> +		/*
> +		 * Check that the new array is sorted. This also validates that
> +		 * to_merge is sorted.
> +		 */
> +		if (new != new_invs->inv)
> +			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
> +		new++;
> +	}
> +
> +	WARN_ON(new != new_invs->inv + new_invs->num_invs);
> +
> +	return new_invs;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);

There's nothing really SMMU-specific about this data structure manipulation.
Do you think we can abstract the invalidation array concept into a library
which other IOMMU drivers could use too?

Will
