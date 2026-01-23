Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE3238C2F
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161739; cv=none; b=a8nMYtAesWkVPS4bCppAUyRAmaGufP2Y5oqlOzI6yylgwti8wvFJbBApS0de1OwOxEzaQevbCLFBFgj7hVygZWbm0wWxmJlGwAgjKXXP+MiEfi9O+WQPhGVKFNOKAM4Xlotlr0T7esh+27qwnIecTqVz3oDLjOmEP5MxBfdwfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161739; c=relaxed/simple;
	bh=/6nxxQU4OJO1e3GUjj1M5rD7cdgGwPOPiGFwn5oev8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ4bB+VvYbFNCIhONEs7vgYjuhjLyzSHBV/gOIFvGHLj2ZV09t54YAowZ4MKbEzcTUfoYwC7ExYDZrtgNI3l4m3YTsIRvcRVScgShns0Uit+x/jiC3tdcBPt4/rcO94wDij3LvZVYDgn30To6BlwxoFtYfF5VUfcX6ZcGWpD+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fai7H7w0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fai7H7w0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a35ae38bdfso98955ad.1
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769161725; x=1769766525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WduvPbclkt+XJxEjDiSJE0UN6koAij5CYcDCN1IFG3k=;
        b=Fai7H7w0iQRALyHIHlUb4DbrEL62m1yD5rH9HenQoSoLeNtzBk/QaKWrbkpu4flIjJ
         oU3JJxhnWH4jNJBWWYwLewn+FindE8fc1o9vMZQiDc8cXjsotjbIiKlOEUIbg170KpuR
         /m/c92+hY/MXUMVmatXzfX81ilt05mCoNf5dzpfgp4SsW6mMS/d/4i7eyc2v6cwCA5Y9
         EgWl5sws5922l6pDTsT1TWR5We1uaivd/tbZMyMx4D/nV6YOvJVUALwg4Gl27eGVpDlR
         dWJnkr3BE+6T3n4fglwQV508J0pmFzeaEGgIE3PJ6ie0WnfaPSFhPBp2BlSOx65XCldi
         29tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161725; x=1769766525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WduvPbclkt+XJxEjDiSJE0UN6koAij5CYcDCN1IFG3k=;
        b=lWl3gUwkYzwlKx+r2QUe+BbgWJNHQFOn8oc9XDCZAF/vXU38mTdtRyjToXQoVFI7UQ
         K/+RXppxqburmZEZy2SPkgTjpdicCO/Mc6HpQKxSs6JyNhZu0/BIdkVNaW12Y9URtMF8
         VO4SGM0kYxnmzFFTkws/vz1SBKmqolaJ0Fuv0M73kdg7XyRVEDy2V8bddtPlRhPpmlia
         Q2t20zHw2uSt052dtzTf1ewu8WPFMbeK2yArUGMfwo+KiXYeC1xM8z5nOCbgoz1BRlCn
         2KrPbUMyNQDhhqppP3F1DFM06C4+pSSi6sRqq8zSYd02+THKpz7u8vv8t58zL7jyhiUM
         s71A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1onEGYrTsnb/xWt4uF3+Kf07bQg2yWeLLFdr5LlwM11Vhc+r+d2dAsji5av+NvUFMK3Bfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhLvP+C3uYZcaKI+9K8RIIK8U06nQYpLmIEH+Gt5oAi/kmtbl0
	Qb/l0dNYz/l2DfPuvN3GC2I3Rk/288DjACOVWk9BlQYWc39c44PwekvrbyDeIXhPVA==
X-Gm-Gg: AZuq6aIeood7GyMcanWp8kT29hIuv+QPOZa/4qcf0OBeqcycreERJlUFM0vhifX7okZ
	T48i4gGe18jRZ2jYUbytKDLPlgWn1P8zji1bSKe3vq52eA5jBkWwYsSa/QBJkzRWDFfcd7PUCP7
	fSMKDSb6eNc+kzx5UrtaW3ZXl0g83zUBGSNPycqUDdXgtw/4LzzVPesnFFYXpdvHPno4oDUH8X6
	+UgHq9ZS85JaIdBEmWltQsbaiVtdd1RJPkUyMl3x6phm4WXFAgvaABxgx5QNUJ58F9n+6z/kHR1
	5+NDeuAbvgeAgSQ1wE+erspKCKEujgIx9HMeWHjfa4Fwkdp4b5Z4/6PHul3lJovVV3viAvpnaOa
	RhhBCg35zVd/sKUzE+zHgHcRAqdP9B5dFJpMSh5d77Z4w02C2ckwj7xSFLtfg8IVcEGW4vOHIe4
	iE5JTcAuMs1HIEEkIG5DqtOZF/ur0Kw/6IpmrAxObhqMzv4NPHwJ0gYCgwFn8=
X-Received: by 2002:a17:903:1b2b:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2a80221cdf3mr2939255ad.6.1769161724232;
        Fri, 23 Jan 2026 01:48:44 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f978d2sm15529995ad.52.2026.01.23.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:48:43 -0800 (PST)
Date: Fri, 23 Jan 2026 09:48:37 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <aXND9YJTwm6om689@google.com>
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
> Each smmu_domain now has an arm_smmu_invs that specifies the invalidation
> steps to perform after any change the IOPTEs. This includes supports for
> basic ASID/VMID, the special case for nesting, and ATC invalidations.
> 
> Introduce a new arm_smmu_domain_inv helper iterating smmu_domain->invs to
> convert the invalidation array to commands. Any invalidation request with
> no size specified means an entire flush over a range based one.
> 
> Take advantage of the sorted array to compatible batch operations together
> to the same SMMU. For instance, ATC invaliations for multiple SIDs can be
> pushed as a batch.
> 
> ATC invalidations must be completed before the driver disables ATS. Or the
> device is permitted to ignore any racing invalidation that would cause an
> SMMU timeout. The sequencing is done with a rwlock where holding the write
> side of the rwlock means that there are no outstanding ATC invalidations.
> If ATS is not used the rwlock is ignored, similar to the existing code.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   9 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 258 +++++++++++++++++++-
>  2 files changed, 254 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index f8dc96476c43..c3fee7f14480 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1086,6 +1086,15 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
>  int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  			    unsigned long iova, size_t size);
>  
> +void arm_smmu_domain_inv_range(struct arm_smmu_domain *smmu_domain,
> +			       unsigned long iova, size_t size,
> +			       unsigned int granule, bool leaf);
> +
> +static inline void arm_smmu_domain_inv(struct arm_smmu_domain *smmu_domain)
> +{
> +	arm_smmu_domain_inv_range(smmu_domain, 0, 0, 0, false);
> +}
> +
>  void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
>  			      struct arm_smmu_cmdq *cmdq);
>  int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index fb45359680d2..6e1082e6d164 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2516,23 +2516,19 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
>  }
>  
> -static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> -				     unsigned long iova, size_t size,
> -				     size_t granule,
> -				     struct arm_smmu_domain *smmu_domain)
> +static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
> +					  struct arm_smmu_cmdq_batch *cmds,
> +					  struct arm_smmu_cmdq_ent *cmd,
> +					  unsigned long iova, size_t size,
> +					  size_t granule, size_t pgsize)
>  {
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	unsigned long end = iova + size, num_pages = 0, tg = 0;
> +	unsigned long end = iova + size, num_pages = 0, tg = pgsize;
>  	size_t inv_range = granule;
> -	struct arm_smmu_cmdq_batch cmds;
>  
>  	if (!size)
>  		return;
>  
>  	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> -		/* Get the leaf page size */
> -		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> -
>  		num_pages = size >> tg;
>  
>  		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
> @@ -2552,8 +2548,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  			num_pages++;
>  	}
>  
> -	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
> -
>  	while (iova < end) {
>  		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
>  			/*
> @@ -2581,9 +2575,26 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>  		}
>  
>  		cmd->tlbi.addr = iova;
> -		arm_smmu_cmdq_batch_add(smmu, &cmds, cmd);
> +		arm_smmu_cmdq_batch_add(smmu, cmds, cmd);
>  		iova += inv_range;
>  	}
> +}
> +
> +static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> +				     unsigned long iova, size_t size,
> +				     size_t granule,
> +				     struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_cmdq_batch cmds;
> +	size_t pgsize;
> +
> +	/* Get the leaf page size */
> +	pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
> +
> +	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd);
> +	arm_smmu_cmdq_batch_add_range(smmu, &cmds, cmd, iova, size, granule,
> +				      pgsize);
>  	arm_smmu_cmdq_batch_submit(smmu, &cmds);
>  }
>  
> @@ -2639,6 +2650,193 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
>  	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>  }
>  
> +static bool arm_smmu_inv_size_too_big(struct arm_smmu_device *smmu, size_t size,
> +				      size_t granule)
> +{
> +	size_t max_tlbi_ops;
> +
> +	/* 0 size means invalidate all */
> +	if (!size || size == SIZE_MAX)
> +		return true;
> +
> +	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
> +		return false;
> +
> +	/*
> +	 * Borrowed from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h,
> +	 * this is used as a threshold to replace "size_opcode" commands with a
> +	 * single "nsize_opcode" command, when SMMU doesn't implement the range
> +	 * invalidation feature, where there can be too many per-granule TLBIs,
> +	 * resulting in a soft lockup.
> +	 */
> +	max_tlbi_ops = 1 << (ilog2(granule) - 3);
> +	return size >= max_tlbi_ops * granule;
> +}
> +
> +/* Used by non INV_TYPE_ATS* invalidations */
> +static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
> +				       struct arm_smmu_cmdq_batch *cmds,
> +				       struct arm_smmu_cmdq_ent *cmd,
> +				       unsigned long iova, size_t size,
> +				       unsigned int granule)
> +{
> +	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
> +		cmd->opcode = inv->nsize_opcode;
> +		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
> +		return;
> +	}
> +
> +	cmd->opcode = inv->size_opcode;
> +	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
> +				      inv->pgsize);
> +}
> +
> +static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
> +					   struct arm_smmu_inv *next)
> +{
> +	/* Changing smmu means changing command queue */
> +	if (cur->smmu != next->smmu)
> +		return true;
> +	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
> +	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
> +	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
> +		return true;
> +	/* ATS must be after a sync of the S1/S2 invalidations */
> +	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
> +		return true;
> +	return false;
> +}
> +
> +static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
> +					unsigned long iova, size_t size,
> +					unsigned int granule, bool leaf)
> +{
> +	struct arm_smmu_cmdq_batch cmds = {};
> +	struct arm_smmu_inv *cur;
> +	struct arm_smmu_inv *end;
> +
> +	cur = invs->inv;
> +	end = cur + READ_ONCE(invs->num_invs);
> +	/* Skip any leading entry marked as a trash */
> +	for (; cur != end; cur++)
> +		if (refcount_read(&cur->users))
> +			break;
> +	while (cur != end) {
> +		struct arm_smmu_device *smmu = cur->smmu;
> +		struct arm_smmu_cmdq_ent cmd = {
> +			/*
> +			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
> +			 * be changed to nsize_opcode, which would result in the
> +			 * same CMDQ pointer.
> +			 */
> +			.opcode = cur->size_opcode,
> +		};
> +		struct arm_smmu_inv *next;
> +
> +		if (!cmds.num)
> +			arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
> +
> +		switch (cur->type) {
> +		case INV_TYPE_S1_ASID:
> +			cmd.tlbi.asid = cur->id;
> +			cmd.tlbi.leaf = leaf;
> +			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
> +						   granule);
> +			break;
> +		case INV_TYPE_S2_VMID:
> +			cmd.tlbi.vmid = cur->id;
> +			cmd.tlbi.leaf = leaf;
> +			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
> +						   granule);
> +			break;
> +		case INV_TYPE_S2_VMID_S1_CLEAR:
> +			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
> +			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
> +				continue;
> +			cmd.tlbi.vmid = cur->id;
> +			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +			break;
> +		case INV_TYPE_ATS:
> +			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
> +			cmd.atc.sid = cur->id;
> +			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +			break;
> +		case INV_TYPE_ATS_FULL:
> +			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
> +			cmd.atc.sid = cur->id;
> +			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			continue;
> +		}
> +
> +		/* Skip any trash entry in-between */
> +		for (next = cur + 1; next != end; next++)
> +			if (refcount_read(&next->users))
> +				break;
> +
> +		if (cmds.num &&
> +		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
> +			arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +			cmds.num = 0;
> +		}
> +		cur = next;
> +	}
> +}
> +
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

Shouldn't these be read_lock_irqsave for all rwlock variants here? 
Invalidations might happen in IRQ context as well..

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
>  	kfree_rcu(old_invs, rcu);
>  }
>

For INV_TYPE_S1_ASID, the new code loops and checks size_too_big 
via arm_smmu_inv_to_cmdq_batch. However, for INV_TYPE_ATS, it issues
a single command for the entire range. While this matches the current
driver, are we confident arm_smmu_atc_inv_to_cmd handles all massive
sizes correctly without needing a similar loop or "too big" fallback?

Thanks,
Praan
