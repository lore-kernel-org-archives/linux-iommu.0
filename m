Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9332E6BE;
	Mon, 24 Nov 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020604; cv=none; b=GyJ9JKYJpNvWZA3UXABe8CZUPA2KtbKo9jl2YLM+94P8HF8HkbxQLkJNBTD2yrKyQTeibYgqKUf6r4rfxEGtRxokB0eeG/tSprF8FaRCGeXZ6p7hK+6iweb+JbACaI4eXuVRO8Wyxp3TM9SC/ySqiUYSNcxPh27izfltP40ifa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020604; c=relaxed/simple;
	bh=/HI/3G8PZC5PSdjygFMc0+oN1va7/g8zNAfvPSP/dts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr9Ls8HJeZ7x7QDr1PJVK6MXeODI/4kHm4s4pLqsmxdbKRT/hmOHXYLOyv2+wfWZ79wvmM0qdrfzWZm1jeviMDvSqjrutKHEHam6u7+18uXdrzX1GCdnxPfglxNEqXWYu/aPvMHEV3UVAvbF6P5Mpzf/IaQwGkSv63TlCL1YtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJreQDV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJreQDV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DDBC16AAE;
	Mon, 24 Nov 2025 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020603;
	bh=/HI/3G8PZC5PSdjygFMc0+oN1va7/g8zNAfvPSP/dts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJreQDV4O5WgiuFKyz16QwBC9D04BFi5S+dduKtGkrzzBL5PdS7+nYlFJv8mL0qnv
	 /mhRPBMiunVTxrYDzNzywHqHQ+sJ/134kafQvqQtSjCLwiV0gCFUT89V+Chqd5kN4u
	 I5ZAnAyBqzKll4okCkgijzOAQvOrMaraZzYQnbS8OfxGAfT9MkgOD8hMnwWHkJGqba
	 gmIDYikgtmefym5WFxNL5UNmBBuXfQBY/AfO4f1kXQ5qITDYL7O0YJlVCCntQVORSi
	 RP5OnA6NCt7CrDcs3IYDOmsXnkgfiNr0HNnxJ2W/tWknRsBa97yof2m3deGwWs8+Tb
	 /QlVdXnWVyNuQ==
Date: Mon, 24 Nov 2025 21:43:18 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <aSTRdltJpMeFLDN8@willie-the-truck>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <ebf35fa1b2025be736475950503f0dc0612371f4.1762588839.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf35fa1b2025be736475950503f0dc0612371f4.1762588839.git.nicolinc@nvidia.com>

On Sat, Nov 08, 2025 at 12:08:06AM -0800, Nicolin Chen wrote:
> Update the invs array with the invalidations required by each domain type
> during attachment operations.
> 
> Only an SVA domain or a paging domain will have an invs array:
>  a. SVA domain will add an INV_TYPE_S1_ASID per SMMU and an INV_TYPE_ATS
>     per SID
> 
>  b. Non-nesting-parent paging domain with no ATS-enabled master will add
>     a single INV_TYPE_S1_ASID or INV_TYPE_S2_VMID per SMMU
> 
>  c. Non-nesting-parent paging domain with ATS-enabled master(s) will do
>     (b) and add an INV_TYPE_ATS per SID
> 
>  d. Nesting-parent paging domain will add an INV_TYPE_S2_VMID followed by
>     an INV_TYPE_S2_VMID_S1_CLEAR per vSMMU. For an ATS-enabled master, it
>     will add an INV_TYPE_ATS_FULL per SID
> 
>  Note that case #d prepares for a future implementation of VMID allocation
>  which requires a followup series for S2 domain sharing. So when a nesting
>  parent domain is attached through a vSMMU instance using a nested domain.
>  VMID will be allocated per vSMMU instance v.s. currectly per S2 domain.
> 
> The per-domain invalidation is not needed until the domain is attached to
> a master (when it starts to possibly use TLB). This will make it possible
> to attach the domain to multiple SMMUs and avoid unnecessary invalidation
> overhead during teardown if no STEs/CDs refer to the domain. It also means
> that when the last device is detached, the old domain must flush its ASID
> or VMID, since any new iommu_unmap() call would not trigger invalidations
> given an empty domain->invs array.
> 
> Introduce some arm_smmu_invs helper functions for building scratch arrays,
> preparing and installing old/new domain's invalidation arrays.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  17 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 242 +++++++++++++++++++-
>  2 files changed, 258 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 7b81a82c0dfe4..5899429a514ab 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1094,6 +1094,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  	       IOMMU_FWSPEC_PCI_RC_CANWBS;
>  }
>  
> +/**
> + * struct arm_smmu_inv_state - Per-domain invalidation array state
> + * @invs_ptr: points to the domain->invs (unwinding nesting/etc.) or is NULL if
> + *            no change should be made
> + * @old_invs: the original invs array
> + * @new_invs: for new domain, this is the new invs array to update domin->invs;

nit: typo "domin"

> + *            for old domain, this is the master->build_invs to pass in as the
> + *            to_unref argument to an arm_smmu_invs_unref() call
> + */
> +struct arm_smmu_inv_state {
> +	struct arm_smmu_invs __rcu **invs_ptr;
> +	struct arm_smmu_invs *old_invs;
> +	struct arm_smmu_invs *new_invs;
> +};
> +
>  struct arm_smmu_attach_state {
>  	/* Inputs */
>  	struct iommu_domain *old_domain;
> @@ -1103,6 +1118,8 @@ struct arm_smmu_attach_state {
>  	ioasid_t ssid;
>  	/* Resulting state */
>  	struct arm_smmu_vmaster *vmaster;
> +	struct arm_smmu_inv_state old_domain_invst;
> +	struct arm_smmu_inv_state new_domain_invst;
>  	bool ats_enabled;
>  };
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 26b8492a13f20..22875a951488d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3058,6 +3058,97 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
>  		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
>  }
>  
> +/*
> + * Use the preallocated scratch array at master->build_invs, to build a to_merge
> + * or to_unref array, to pass into a following arm_smmu_invs_merge/unref() call.
> + *
> + * Do not free the returned invs array. It is reused, and will be overwritten by
> + * the next arm_smmu_master_build_invs() call.
> + */
> +static struct arm_smmu_invs *
> +arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
> +			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain)
> +{
> +	const bool e2h = master->smmu->features & ARM_SMMU_FEAT_E2H;
> +	struct arm_smmu_invs *build_invs = master->build_invs;
> +	const bool nesting = smmu_domain->nest_parent;
> +	struct arm_smmu_inv *cur;
> +
> +	iommu_group_mutex_assert(master->dev);
> +
> +	cur = build_invs->inv;
> +
> +	switch (smmu_domain->stage) {
> +	case ARM_SMMU_DOMAIN_SVA:
> +	case ARM_SMMU_DOMAIN_S1:
> +		*cur = (struct arm_smmu_inv){
> +			.smmu = master->smmu,
> +			.type = INV_TYPE_S1_ASID,
> +			.id = smmu_domain->cd.asid,
> +			.size_opcode = e2h ? CMDQ_OP_TLBI_EL2_VA :
> +					     CMDQ_OP_TLBI_NH_VA,
> +			.nsize_opcode = e2h ? CMDQ_OP_TLBI_EL2_ASID :
> +					      CMDQ_OP_TLBI_NH_ASID
> +		};
> +		break;
> +	case ARM_SMMU_DOMAIN_S2:
> +		*cur = (struct arm_smmu_inv){
> +			.smmu = master->smmu,
> +			.type = INV_TYPE_S2_VMID,
> +			.id = smmu_domain->s2_cfg.vmid,
> +			.size_opcode = CMDQ_OP_TLBI_S2_IPA,
> +			.nsize_opcode = CMDQ_OP_TLBI_S12_VMALL,
> +		};
> +		break;

Having a helper to add an invalidation command would make this a little
more compact and you could also check against the size of the array.

> +	default:
> +		WARN_ON(true);
> +		return NULL;
> +	}
> +
> +	/* Range-based invalidation requires the leaf pgsize for calculation */
> +	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
> +		cur->pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
> +	cur++;
> +
> +	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
> +	if (nesting) {
> +		*cur = (struct arm_smmu_inv){
> +			.smmu = master->smmu,
> +			.type = INV_TYPE_S2_VMID_S1_CLEAR,
> +			.id = smmu_domain->s2_cfg.vmid,
> +			.size_opcode = CMDQ_OP_TLBI_NH_ALL,
> +			.nsize_opcode = CMDQ_OP_TLBI_NH_ALL,
> +		};
> +		cur++;
> +	}
> +
> +	if (ats_enabled) {
> +		size_t i;
> +
> +		for (i = 0; i < master->num_streams; i++) {
> +			/*
> +			 * If an S2 used as a nesting parent is changed we have
> +			 * no option but to completely flush the ATC.
> +			 */
> +			*cur = (struct arm_smmu_inv){
> +				.smmu = master->smmu,
> +				.type = nesting ? INV_TYPE_ATS_FULL :
> +						  INV_TYPE_ATS,
> +				.id = master->streams[i].id,
> +				.ssid = ssid,
> +				.size_opcode = CMDQ_OP_ATC_INV,
> +				.nsize_opcode = CMDQ_OP_ATC_INV,
> +			};
> +			cur++;
> +		}
> +	}
> +
> +	/* Note this build_invs must have been sorted */
> +
> +	build_invs->num_invs = cur - build_invs->inv;
> +	return build_invs;
> +}
> +
>  static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  					  struct iommu_domain *domain,
>  					  ioasid_t ssid)
> @@ -3087,6 +3178,146 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	kfree(master_domain);
>  }
>  
> +/*
> + * During attachment, the updates of the two domain->invs arrays are sequenced:
> + *  1. new domain updates its invs array, merging master->build_invs
> + *  2. new domain starts to include the master during its invalidation
> + *  3. master updates its STE switching from the old domain to the new domain
> + *  4. old domain still includes the master during its invalidation
> + *  5. old domain updates its invs array, unreferencing master->build_invs
> + *
> + * For 1 and 5, prepare the two updated arrays in advance, handling any changes
> + * that can possibly failure. So the actual update of either 1 or 5 won't fail.
> + * arm_smmu_asid_lock ensures that the old invs in the domains are intact while
> + * we are sequencing to update them.
> + */
> +static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
> +					struct arm_smmu_domain *new_smmu_domain)
> +{
> +	struct arm_smmu_domain *old_smmu_domain =
> +		to_smmu_domain_devices(state->old_domain);
> +	struct arm_smmu_master *master = state->master;
> +	ioasid_t ssid = state->ssid;
> +
> +	/* A re-attach case doesn't need to update invs array */
> +	if (new_smmu_domain == old_smmu_domain)
> +		return 0;
> +
> +	/*
> +	 * At this point a NULL domain indicates the domain doesn't use the
> +	 * IOTLB, see to_smmu_domain_devices().
> +	 */
> +	if (new_smmu_domain) {
> +		struct arm_smmu_inv_state *invst = &state->new_domain_invst;
> +		struct arm_smmu_invs *build_invs;
> +
> +		invst->invs_ptr = &new_smmu_domain->invs;
> +		invst->old_invs = rcu_dereference_protected(
> +			new_smmu_domain->invs,
> +			lockdep_is_held(&arm_smmu_asid_lock));
> +		build_invs = arm_smmu_master_build_invs(
> +			master, state->ats_enabled, ssid, new_smmu_domain);
> +		if (!build_invs)
> +			return -EINVAL;
> +
> +		invst->new_invs =
> +			arm_smmu_invs_merge(invst->old_invs, build_invs);
> +		if (IS_ERR(invst->new_invs))
> +			return PTR_ERR(invst->new_invs);
> +	}
> +
> +	if (old_smmu_domain) {
> +		struct arm_smmu_inv_state *invst = &state->old_domain_invst;
> +
> +		invst->invs_ptr = &old_smmu_domain->invs;
> +		invst->old_invs = rcu_dereference_protected(
> +			old_smmu_domain->invs,
> +			lockdep_is_held(&arm_smmu_asid_lock));
> +		/* For old_smmu_domain, new_invs points to master->build_invs */
> +		invst->new_invs = arm_smmu_master_build_invs(
> +			master, master->ats_enabled, ssid, old_smmu_domain);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Must be installed before arm_smmu_install_ste_for_dev() */
> +static void
> +arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
> +{
> +	struct arm_smmu_inv_state *invst = &state->new_domain_invst;
> +
> +	if (!invst->invs_ptr)
> +		return;
> +
> +	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> +	/*
> +	 * We are committed to updating the STE. Ensure the invalidation array
> +	 * is visable to concurrent map/unmap threads, and acquire any racying
> +	 * IOPTE updates.
> +	 */
> +	smp_mb();

Sorry, but the comment hasn't really helped me here. We're ordering the
publishing of the invalidation array above before ... what?

> +	kfree_rcu(invst->old_invs, rcu);
> +}
> +
> +/*
> + * When an array entry's users count reaches zero, it means the ASID/VMID is no
> + * longer being invalidated by map/unmap and must be cleaned. The rule is that
> + * all ASIDs/VMIDs not in an invalidation array are left cleared in the IOTLB.
> + */
> +static void arm_smmu_invs_flush_iotlb_tags(struct arm_smmu_inv *inv)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {};
> +
> +	switch (inv->type) {
> +	case INV_TYPE_S1_ASID:
> +		cmd.tlbi.asid = inv->id;
> +		break;
> +	case INV_TYPE_S2_VMID:
> +		/* S2_VMID using nsize_opcode covers S2_VMID_S1_CLEAR */
> +		cmd.tlbi.vmid = inv->id;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	cmd.opcode = inv->nsize_opcode;
> +	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
> +}
> +
> +/* Should be installed after arm_smmu_install_ste_for_dev() */
> +static void
> +arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
> +{
> +	struct arm_smmu_inv_state *invst = &state->old_domain_invst;
> +	struct arm_smmu_invs *old_invs = invst->old_invs;
> +	struct arm_smmu_invs *new_invs;
> +	size_t num_trashes;
> +
> +	lockdep_assert_held(&arm_smmu_asid_lock);
> +
> +	if (!invst->invs_ptr)
> +		return;
> +
> +	num_trashes = arm_smmu_invs_unref(old_invs, invst->new_invs,
> +					  arm_smmu_invs_flush_iotlb_tags);
> +	if (!num_trashes)
> +		return;
> +
> +	new_invs = arm_smmu_invs_purge(old_invs, num_trashes);
> +	if (!new_invs)
> +		return;
> +
> +	rcu_assign_pointer(*invst->invs_ptr, new_invs);
> +	/*
> +	 * We are committed to updating the STE. Ensure the invalidation array
> +	 * is visable to concurrent map/unmap threads, and acquire any racying
> +	 * IOPTE updates.
> +	 */
> +	smp_mb();

(same here)

Will
