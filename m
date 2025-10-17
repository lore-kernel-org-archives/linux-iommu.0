Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4223EABB;
	Fri, 17 Oct 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717171; cv=none; b=QjRBrtmAwOcezQN4CjJsWzIhQUAqbW4xhUwJ1miq5jqBu29a7zpe+eGDQkKw7M6jeM9/A0yW++3tE/mrqBrnNPDnHVqFXDVeExcRXU8AlaLQJAbMRxul0YzkMzqKC6EtL0sLzD3NRgkANVI7N5BNWvosfLT3Tat1IheLfX9dlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717171; c=relaxed/simple;
	bh=u/8UedODI14grkfwwWOFNMbWTEn9jS5mcEENOEapc78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS5dxIylXkLBdDXWWftHBWag5MnRwQU/+dR2XZmJoJ408RCXToBuuP4wcslpddiaPPqCkQAVgePgyTwiLmmQg3+evTnFHUUGz4lyx11+7AyWbKLaKTga3JYrSgMzsZAH7hMYY3OM9PyMCspRLHz6YyXmOyTA0v+fSzyTdBoXZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8w9RHVs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8w9RHVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760717170; x=1792253170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/8UedODI14grkfwwWOFNMbWTEn9jS5mcEENOEapc78=;
  b=D8w9RHVswAoCoTjWEqGB1GeTuycL7FhNc5AtqRWmgvdoAkUwnEmHAoDh
   HHRXd5eAA2Hum7kaOKDF3o9vWqgPLs8fRU3+4VP1i0TgIDIfeKynLT7gq
   6ilLZYEQbLFuM4zfn5x5vl4VU/ejDAyb36ALz8EzhtZh5DFnx8+QqL6pL
   8ra+Q1IC5uxl8z1c6pelE7VOQItCHRdCXpkVYCwWf3YY1JyGlqJGstI+0
   1BArR9JvGmMzppxVTayBQs6hdMOG9LMOG3DRRgnuPkvB7m35MIBJbLbKv
   y6hc8wm3eGwmk3YAjilMDw6UgHZcjZCA8/cY29rwSRH43ExVFGSEFgTzQ
   A==;
X-CSE-ConnectionGUID: Ciiwcc8DQo6oIA1FltoYyQ==
X-CSE-MsgGUID: uQOGSahdSXykFAq/kLwI3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="74371929"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="74371929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:06:09 -0700
X-CSE-ConnectionGUID: RQC/0mwiTaGwQgz5XVF8Sw==
X-CSE-MsgGUID: tVXrX28pSfS6W+gJYu95eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="183190080"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 17 Oct 2025 09:06:04 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9mxu-0007Fx-0f;
	Fri, 17 Oct 2025 16:06:02 +0000
Date: Sat, 18 Oct 2025 00:03:27 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <202510172340.XyneWIPI-lkp@intel.com>
References: <14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Explicitly-set-smmu_domain-stage-for-SVA/20251016-034754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
config: arm64-randconfig-r123-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172340.XyneWIPI-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172340.XyneWIPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172340.XyneWIPI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_invs **invs_ptr @@     got struct arm_smmu_invs [noderef] __rcu ** @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     expected struct arm_smmu_invs **invs_ptr
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     got struct arm_smmu_invs [noderef] __rcu **
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3226:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_invs **invs_ptr @@     got struct arm_smmu_invs [noderef] __rcu ** @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3226:33: sparse:     expected struct arm_smmu_invs **invs_ptr
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3226:33: sparse:     got struct arm_smmu_invs [noderef] __rcu **
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3247:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3247:9: sparse:    struct arm_smmu_invs [noderef] __rcu *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3247:9: sparse:    struct arm_smmu_invs *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3305:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3305:9: sparse:    struct arm_smmu_invs [noderef] __rcu *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3305:9: sparse:    struct arm_smmu_invs *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file:
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse:     expected struct callback_head *head
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse:     got struct callback_head [noderef] __rcu *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse: sparse: cast removes address space '__rcu' of expression
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse:     expected struct callback_head *head
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse:     got struct callback_head [noderef] __rcu *
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1056:9: sparse: sparse: cast removes address space '__rcu' of expression

vim +3208 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  3174	
  3175	/*
  3176	 * During attachment, the updates of the two domain->invs arrays are sequenced:
  3177	 *  1. new domain updates its invs array, merging master->build_invs
  3178	 *  2. new domain starts to include the master during its invalidation
  3179	 *  3. master updates its STE switching from the old domain to the new domain
  3180	 *  4. old domain still includes the master during its invalidation
  3181	 *  5. old domain updates its invs array, unreferencing master->build_invs
  3182	 *
  3183	 * For 1 and 5, prepare the two updated arrays in advance, handling any changes
  3184	 * that can possibly failure. So the actual update of either 1 or 5 won't fail.
  3185	 * arm_smmu_asid_lock ensures that the old invs in the domains are intact while
  3186	 * we are sequencing to update them.
  3187	 */
  3188	static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
  3189						struct arm_smmu_domain *new_smmu_domain)
  3190	{
  3191		struct arm_smmu_domain *old_smmu_domain =
  3192			to_smmu_domain_devices(state->old_domain);
  3193		struct arm_smmu_master *master = state->master;
  3194		ioasid_t ssid = state->ssid;
  3195	
  3196		/* A re-attach case doesn't need to update invs array */
  3197		if (new_smmu_domain == old_smmu_domain)
  3198			return 0;
  3199	
  3200		/*
  3201		 * At this point a NULL domain indicates the domain doesn't use the
  3202		 * IOTLB, see to_smmu_domain_devices().
  3203		 */
  3204		if (new_smmu_domain) {
  3205			struct arm_smmu_inv_state *invst = &state->new_domain_invst;
  3206			struct arm_smmu_invs *build_invs;
  3207	
> 3208			invst->invs_ptr = &new_smmu_domain->invs;
  3209			invst->old_invs = rcu_dereference_protected(
  3210				new_smmu_domain->invs,
  3211				lockdep_is_held(&arm_smmu_asid_lock));
  3212			build_invs = arm_smmu_master_build_invs(
  3213				master, state->ats_enabled, ssid, new_smmu_domain);
  3214			if (!build_invs)
  3215				return -EINVAL;
  3216	
  3217			invst->new_invs =
  3218				arm_smmu_invs_merge(invst->old_invs, build_invs);
  3219			if (IS_ERR(invst->new_invs))
  3220				return PTR_ERR(invst->new_invs);
  3221		}
  3222	
  3223		if (old_smmu_domain) {
  3224			struct arm_smmu_inv_state *invst = &state->old_domain_invst;
  3225	
  3226			invst->invs_ptr = &old_smmu_domain->invs;
  3227			invst->old_invs = rcu_dereference_protected(
  3228				old_smmu_domain->invs,
  3229				lockdep_is_held(&arm_smmu_asid_lock));
  3230			/* For old_smmu_domain, new_invs points to master->build_invs */
  3231			invst->new_invs = arm_smmu_master_build_invs(
  3232				master, master->ats_enabled, ssid, old_smmu_domain);
  3233		}
  3234	
  3235		return 0;
  3236	}
  3237	
  3238	/* Must be installed before arm_smmu_install_ste_for_dev() */
  3239	static void
  3240	arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
  3241	{
  3242		struct arm_smmu_inv_state *invst = &state->new_domain_invst;
  3243	
  3244		if (!invst->invs_ptr)
  3245			return;
  3246	
> 3247		rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
  3248		/*
  3249		 * We are committed to updating the STE. Ensure the invalidation array
  3250		 * is visable to concurrent map/unmap threads, and acquire any racying
  3251		 * IOPTE updates.
  3252		 */
  3253		smp_mb();
  3254		kfree_rcu(invst->old_invs, rcu);
  3255	}
  3256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
