Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F01E89C;
	Fri, 23 Jan 2026 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187796; cv=none; b=cA1xZ8IIGghGoSl6sAyR2ctR6Jb4newcvgxjHDMFIx0IMobOxs571/1WUcPjwCXZNbGVTegtUmUAxi+rTD/v+eMFvyFZHbRYDMd40zyUMXA8HsYb8CkPBUsBx3gyqOhfcn/nKhPJWu/3KC3DKDCHOG2nM21hh5s2fRL8CPDP0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187796; c=relaxed/simple;
	bh=++CroNrmSwOjW47UPCMhDrdl4yld08QCBp1Dv1BzKUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQaH9J0kYEbOvsF+QblTqdHMVwh1t0rVBii91UgnJU7XOTPdqfAR+OkCpGz8ImfPOVSihoZLTUYFnd1GqgYKpDaQugZSq+yQxguK4PZZ5VGHHsllq11jmxNi2uHLHSHdr515A46EIJx1P8pdK2aTGuhH/OOe4rsT5wAxHbAMXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkagO7jQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkagO7jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED4C4CEF1;
	Fri, 23 Jan 2026 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769187796;
	bh=++CroNrmSwOjW47UPCMhDrdl4yld08QCBp1Dv1BzKUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkagO7jQxsmP4A2l3NsWIo6BQjAIIDHdIcpxn4zhab5WW/6MKpyKyyZt9OtJ7Po3G
	 IRA6ppCtj9s/JtBFRJlug/3w/XsaskfyW2u5M6THfcsz9vD+vjzSpBfBCf1NoLlUdi
	 oLWRVDTJQVUfV7k4o6fs87TY9lgyraXAj9JySGlBnRFZgy22Hi9SbB/ir7cTH3G73s
	 hQbzuF0Mdu/Pdpb0b9d4cQdDeVjAcVhdOwpCrZSzWC+8CCRSrkOdZJF8gtmx4wwVkg
	 2PUzBoa3WTTrxUjW7xW/sBdGztFaqJVg4U/OWIP1zCcjK6MoWXz0dpFAZgN1mJUW/n
	 aTo4Iow6bYgkg==
Date: Fri, 23 Jan 2026 17:03:10 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXOpzjkAgODnh2HU@willie-the-truck>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  98 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 +++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 258 ++++++++++++++++++
>  3 files changed, 448 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96a23ca633cb..a9441dc9070e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -649,6 +649,93 @@ struct arm_smmu_cmdq_batch {
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

The refcount_t API uses atomics with barrier semantics. Do we actually
need those properties when updating the refcounts here? The ASID lock
gives us pretty strong serialisation even after this patch series and
we rely heavily on that.

> +static void arm_smmu_v3_invs_test(struct kunit *test)
> +{
> +	const int results1[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
> +	const int results2[2][5] = { { 1, 1, 3, 4, 5, }, { 2, 1, 1, 1, 1, }, };
> +	const int results3[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
> +	const int results4[2][5] = { { 1, 1, 3, 5, 6, }, { 2, 1, 1, 1, 1, }, };
> +	const int results5[2][5] = { { 1, 1, 3, 5, 6, }, { 1, 0, 0, 1, 1, }, };
> +	const int results6[2][3] = { { 1, 5, 6, }, { 1, 1, 1, }, };
> +	struct arm_smmu_invs *test_a, *test_b;
> +
> +	/* New array */
> +	test_a = arm_smmu_invs_alloc(0);
> +	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
> +
> +	/* Test1: merge invs1 (new array) */
> +	test_b = arm_smmu_invs_merge(test_a, &invs1);
> +	kfree(test_a);
> +	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results1[0]),
> +				     results1[0], results1[1]);
> +
> +	/* Test2: merge invs2 (new array) */
> +	test_a = arm_smmu_invs_merge(test_b, &invs2);
> +	kfree(test_b);
> +	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results2[0]),
> +				     results2[0], results2[1]);
> +
> +	/* Test3: unref invs2 (same array) */
> +	arm_smmu_invs_unref(test_a, &invs2, NULL);
> +	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results3[0]),
> +				     results3[0], results3[1]);
> +	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);
> +
> +	/* Test4: merge invs3 (new array) */
> +	test_b = arm_smmu_invs_merge(test_a, &invs3);
> +	kfree(test_a);
> +	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]),
> +				     results4[0], results4[1]);
> +
> +	/* Test5: unref invs1 (same array) */
> +	arm_smmu_invs_unref(test_b, &invs1, NULL);
> +	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results5[0]),
> +				     results5[0], results5[1]);
> +	KUNIT_EXPECT_EQ(test, test_b->num_trashes, 2);
> +
> +	/* Test6: purge test_b (new array) */
> +	test_a = arm_smmu_invs_purge(test_b);
> +	kfree(test_b);
> +	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]),
> +				     results6[0], results6[1]);
> +
> +	/* Test7: unref invs3 (same array) */
> +	arm_smmu_invs_unref(test_a, &invs3, NULL);
> +	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
> +	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);

Wouldn't we be better off testing num_trashes == 0 after test 6 has
completed?

> +/**
> + * arm_smmu_invs_for_each_entry - Iterate over two sorted arrays computing for
> + *                                arm_smmu_invs_merge() or arm_smmu_invs_unref()
> + * @invs_l: the base invalidation array
> + * @idx_l: a stack variable of 'size_t', to store the base array index
> + * @invs_r: the build_invs array as to_merge or to_unref
> + * @idx_r: a stack variable of 'size_t', to store the build_invs index
> + * @cmp: a stack variable of 'int', to store return value (-1, 0, or 1)
> + */
> +#define arm_smmu_invs_for_each_cmp(invs_l, idx_l, invs_r, idx_r, cmp)          \

nit: the kerneldoc comment doesn't match the name of this function.

Will
