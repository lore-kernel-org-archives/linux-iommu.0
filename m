Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A3188582;
	Tue, 24 Sep 2024 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220591; cv=none; b=nAUomVDCFT1B1aR0NnXd7HTTENSWj2xLblNRIkPjTViprO+JIKzPd0RM2MObXQ19gmDP/yBgANpWhJdtm6DZJaieKEkpsMEXCLM5BDLSo1JE7B37qwcyFgTbQ4tv82FN06wWd5rkvJMKzVJFOtYU/aV8ngeynjhx6jF9cFcnjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220591; c=relaxed/simple;
	bh=BL9wQg3EmpqGkCRLh57Z/pLM+zsTDky+PprLB+vZR20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jocthDeblTQskRhD2hMgPEoYpKSMXoQBFkzErW1Sj02SeBmtwY5x85vmSykK0LK82LDZ/bI4c4mWN9DijOU9gHXO1jIk1yOEzhQU3baol1eM5rHWYOYXSbPn2f9mjMwnA9rj7xZfs84n1/T9ai1vINZolr3PEhrEwH7uRYN+oSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9wCQg0w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9wCQg0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727220589; x=1758756589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BL9wQg3EmpqGkCRLh57Z/pLM+zsTDky+PprLB+vZR20=;
  b=L9wCQg0wIAjIjnXpAFmlYqg10Dz8ULAeJql18TKmuQ/0tDlxh94/Agsa
   PizAZTHdp2ZGrQCCO61SYOEtAxDQfWlRrxBdpjMsMLGgywwAVmfZ56UwF
   XQJrDmbZegNgmYn27Rtm5O7SHUFV3Ro/kev07CQdeUsuXUCs6SX05/Xu7
   mpBDtJQbRerRTFZbngnOv0rrSlhVXTnH3n8Hu5WpnpJ99JPqHDZq3mLTC
   vOUZhANoU0N2ULwvGnIK+QTKFR+AoZMIoOGNR4etT1oYEQ/i9eMOsSB9w
   wSkHoE3CrjjMwvpQeWyd1Ur3NakoK1/QV+yJ6+0phC5PKaiBcIzQCYQzy
   g==;
X-CSE-ConnectionGUID: hgrFYKqSTgue+qsWNxxcbw==
X-CSE-MsgGUID: 8C1JF7i7Qrq10InAO5wZRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43765129"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="43765129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:29:49 -0700
X-CSE-ConnectionGUID: YLJXeP3UQfe3KrMKz35BkA==
X-CSE-MsgGUID: +RKT5L9lThKb4rhsCHrfxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="94915419"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Sep 2024 16:29:46 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stEyW-000IwD-1b;
	Tue, 24 Sep 2024 23:29:44 +0000
Date: Wed, 25 Sep 2024 07:29:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, Dipendra Khadka <kdipendra88@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR
 in arm_smmu_domain_alloc_user()
Message-ID: <202409250753.7q3zl3b8-lkp@intel.com>
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
config: arm64-randconfig-001-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250753.7q3zl3b8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250753.7q3zl3b8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250753.7q3zl3b8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function 'arm_smmu_domain_alloc_user':
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3066:24: error: returning 'struct arm_smmu_domain *' from a function with incompatible return type 'struct iommu_domain *' [-Wincompatible-pointer-types]
    3066 |                 return smmu_domain;
         |                        ^~~~~~~~~~~


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
