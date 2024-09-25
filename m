Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD62F5E;
	Wed, 25 Sep 2024 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222453; cv=none; b=buBmKyhIbizUJDbMBplPcQ5v2RAdFIewn2KABTqpDU2Hqumn4YP3IGzcwqMVMDFb+ysvpFr03lV7Bp+KfUB8DO8d6mMVaR2NwGQdvn/AiSfrUBJv0T8eJYGn8DnyHcfWT6WgWy4InFc5LjAGvQ2xEtTLEEGZ3heZrwd/C3O8ANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222453; c=relaxed/simple;
	bh=xrDiBntnkYADoF8Z2z96ru7m5IezmardL6OOcKZEkRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6si5ZzQ5J/g+ol9C5891JBSXzYjJXNQxBwromGP0C1TjxLjmRufTyulh0rzZTkGGd5WA1HWpwD9Z2xxESZLcT8JAex70jpN3U7Aza4lREQFDPb+VfsDL0MfewnmHA6LBfdXPASCTIn/Ch5XfKMu8NWhw9C2juxHAKhpxI3qXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmeTM33+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmeTM33+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727222451; x=1758758451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xrDiBntnkYADoF8Z2z96ru7m5IezmardL6OOcKZEkRQ=;
  b=cmeTM33+fgtCeWYTcRmLVKmGBi/RNCqoBRj+Bgczr0XQarfw6Cvj/LgV
   5R30PGaCX3Ff6PxQNKLNaq0DvAbc/MripL41zBsCcCdadn5Yb2MK0PFAv
   h3T8G2p6e+AR8E5OjcmnWCcpkWs/RBmjrkuEcDpDn9Czu85nPzJFAcZZZ
   a6j4g8dV6X/MPlBEwqWHLZrg4/AcYYUNNLutAGqj7V6YmEF10yRwIOg/H
   GxZWsubBLchPfh5b6jjPSE/UyHK3bCHZozR02ajO9c/i3aTqrTkM4F3SQ
   wIYF1/JY6AQl1Fc7udDBhOKB8pPxNcJelQbV/9owEV/det0ui7/Eh37IO
   A==;
X-CSE-ConnectionGUID: f4HeF/OaQHy8yJioVAEd6A==
X-CSE-MsgGUID: NvyV8+9HRySlt+ghepE5NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30037221"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="30037221"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 17:00:50 -0700
X-CSE-ConnectionGUID: C5zgOdcWQy6HlX7MjgduhA==
X-CSE-MsgGUID: MvFO1ljCQuSw85pjwxKGYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71216609"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2024 17:00:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stFSX-000Ixa-1G;
	Wed, 25 Sep 2024 00:00:45 +0000
Date: Wed, 25 Sep 2024 08:00:23 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR
 in arm_smmu_domain_alloc_user()
Message-ID: <202409250755.nLQtNlCf-lkp@intel.com>
References: <20240922155621.49432-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922155621.49432-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/Staging-iommu-Replace-null-pointer-check-with-IS_ERR-in-arm_smmu_domain_alloc_user/20240922-235756
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240922155621.49432-1-kdipendra88%40gmail.com
patch subject: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR in arm_smmu_domain_alloc_user()
config: arm64-randconfig-003-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250755.nLQtNlCf-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250755.nLQtNlCf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250755.nLQtNlCf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:15:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:18:
   In file included from include/linux/vmcore_info.h:6:
   In file included from include/linux/elfcore.h:11:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3066:10: error: incompatible pointer types returning 'struct arm_smmu_domain *' from a function with result type 'struct iommu_domain *' [-Werror,-Wincompatible-pointer-types]
    3066 |                 return smmu_domain;
         |                        ^~~~~~~~~~~
   1 warning and 1 error generated.


vim +3066 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  3048	
  3049	static struct iommu_domain *
  3050	arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
  3051				   struct iommu_domain *parent,
  3052				   const struct iommu_user_data *user_data)
  3053	{
  3054		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
  3055		const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
  3056		struct arm_smmu_domain *smmu_domain;
  3057		int ret;
  3058	
  3059		if (flags & ~PAGING_FLAGS)
  3060			return ERR_PTR(-EOPNOTSUPP);
  3061		if (parent || user_data)
  3062			return ERR_PTR(-EOPNOTSUPP);
  3063	
  3064		smmu_domain = arm_smmu_domain_alloc();
  3065		if (IS_ERR(smmu_domain))
> 3066			return smmu_domain;
  3067	
  3068		smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
  3069		smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
  3070		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
  3071		if (ret)
  3072			goto err_free;
  3073		return &smmu_domain->domain;
  3074	
  3075	err_free:
  3076		kfree(smmu_domain);
  3077		return ERR_PTR(ret);
  3078	}
  3079	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
