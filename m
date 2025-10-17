Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920334AAEE;
	Fri, 17 Oct 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708946; cv=none; b=oE+o7IHuxNtXceqdCQVsjU5DW4bCT3WL44K+iTOdHJhOgW+OwUgLAThkPn92mKmwVdrZyzQuYYqB5y17FWxdBgPtvQu5d9ahkErINGgyb1vXO16L21C5JrHfJBRDfMxcG9yYqzR0WFFyvxDHf7RGboHBoRjEr9isfLVBEfw8B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708946; c=relaxed/simple;
	bh=Zi09GkycV22dT8wm57/LcjjsOT5fAWiZE/vyzw5z4N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0P2Ky1MBYJTP6cww/Pf1+dwWejAbbE8WpGN9rx7zUIDySowcOCmZBMOBxnZPWwBCp7psqTbYCqAjLAgnS/Uvsssw/ZfMGeTIUuCWtv8I9GO1tN+NjIpUg7XHFdNgpufr/df0ZaZfTGccB+wXsf9vk+J+5WATQ8tJGstyrlo5Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjeR+N/6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjeR+N/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760708944; x=1792244944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zi09GkycV22dT8wm57/LcjjsOT5fAWiZE/vyzw5z4N8=;
  b=hjeR+N/6uhqSjf2+gQQhIMkKNihLPOqR3WzESgK6LGz4geGfQyjR6cte
   4dI+uH8rEBd6T4pPvoG1ymBJoQAN5iux5Vf/TvpckjF2Ge0U6g46d1ELk
   Pv5pUy+Q0E0BUMrdKvSBE6REycBHSoxApgbo6QPHzNexmJ+4dMSCqC+Wk
   8nKsZIqxezRmVneHEK+e9euUXsq5kPmoR8FK4EckYjjTI+50DiARyYZW1
   39s7qbHe3FpCqthcffw4VXceF0rSHv0JLJhCMArp5YCZAXH17ggcwamDl
   004vL8L8N14tar9CetmzqRRegS4tlqy33hJocNkXKwL6gQgGLaTbQlCqM
   A==;
X-CSE-ConnectionGUID: S75PMGkFQJGib/OZpaYPkQ==
X-CSE-MsgGUID: xJfdCZBoSe20in+8VYVTyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="85536051"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="85536051"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:49:04 -0700
X-CSE-ConnectionGUID: TUlmEQZ6R7S3EFzMCTd7uQ==
X-CSE-MsgGUID: rby14u31Tvqwz37AjO2YBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182438446"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Oct 2025 06:48:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9koW-0005zZ-34;
	Fri, 17 Oct 2025 13:48:24 +0000
Date: Fri, 17 Oct 2025 21:47:07 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <202510172156.WHU485ad-lkp@intel.com>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Explicitly-set-smmu_domain-stage-for-SVA/20251016-034754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
config: arm64-randconfig-r123-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172156.WHU485ad-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172156.WHU485ad-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172156.WHU485ad-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c: note: in included file:
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression
--
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
   arch/arm64/include/asm/cmpxchg.h:168:1: sparse: sparse: cast truncates bits from constant value (ffffffff80000000 becomes 0)
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: note: in included file:
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] __rcu * @@
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     expected struct callback_head *head
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse:     got struct callback_head [noderef] __rcu *
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h:1048:9: sparse: sparse: cast removes address space '__rcu' of expression

vim +1048 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h

  1045	
  1046	static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
  1047	{
> 1048		kfree_rcu(smmu_domain->invs, rcu);
  1049		kfree(smmu_domain);
  1050	}
  1051	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
