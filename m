Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57A143734;
	Mon, 26 Aug 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708757; cv=none; b=Jfi58O8z6mNKLh5QZqhjH6fiQxhrxFcsf9sDzOVRJMXoxg5Wq3WTF7hxRktoHafja21AGf1zmcUKMPrmlq2LdMaGs6F82vBPJz2+wEB6J1M4QDaCeqaO1IsmdoascwipjOhL2xQYcNCdvhmjoo+4gCOMR2GyxLXy8T9KnzN2MwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708757; c=relaxed/simple;
	bh=ENNjClLiM5+wUU5vUKs06COtYYCZdT2wrs6lUHEtJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw/mxiu3uhpKJ+dWnKgy0pen8KYNCvtA45VwRJYZShc+d83ihfBMq3+FQh8DimPgkf0hglZ269QtOmaiJS/PXzG8CIVMABbYMG+T5JG8UIcV4M8VzlpnZx4hfuxViuEBXCjyZGayvnfd5lkU+38GgLuyDlCunFE8MdUqHJpfPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBkBj2d5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBkBj2d5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724708755; x=1756244755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ENNjClLiM5+wUU5vUKs06COtYYCZdT2wrs6lUHEtJIs=;
  b=ZBkBj2d52QjFk8FaqZd9BZZf85gK5UwDd9Q+fQeKYc/ETXZtQ0sVIfeg
   HDRrSALXObbbllGLM687aoNhpWdOaiLximBqpaI96t90pjyEOWqPtixFM
   96sc4fJM2QqOJMuKkC54Ttf7+N8Tdn6WNf733OoBwGqQiHKwzcEUahHRo
   pklA3v3HSPciFlIHgbd7bmTXG3+54BLEch0Jm/0p7I1fDGaYka4Fozb/8
   YQ8Fc7eB7GoMYpnpxNjL70qLqOAiKcszBGje6FlsLNO/93rL4cDagXYWD
   6Uq7KB/bsXkOVC3fMnehFnXjONo2EV2i1K3UXXubSa5tT47iprtWDtUKT
   A==;
X-CSE-ConnectionGUID: GSePgRk7TNGogAQPBW158A==
X-CSE-MsgGUID: QXiMOwRBQfSWi5qdFZkdjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40627382"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40627382"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:45:34 -0700
X-CSE-ConnectionGUID: W6TRxfyRRCiMnTMplczNxw==
X-CSE-MsgGUID: EPOZg8JnSBmOGvoqXeSbag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="100146014"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Aug 2024 14:45:31 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sihWi-000Hcw-2I;
	Mon, 26 Aug 2024 21:45:28 +0000
Date: Tue, 27 Aug 2024 05:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <202408270546.xsCRcuPC-lkp@intel.com>
References: <77da90f2e9c0352ae254825e5ec788589bacc780.1724453781.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77da90f2e9c0352ae254825e5ec788589bacc780.1724453781.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc5 next-20240826]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Issue-a-batch-of-commands-to-the-same-cmdq/20240826-150025
base:   linus/master
patch link:    https://lore.kernel.org/r/77da90f2e9c0352ae254825e5ec788589bacc780.1724453781.git.nicolinc%40nvidia.com
patch subject: [PATCH v13 08/10] iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408270546.xsCRcuPC-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270546.xsCRcuPC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270546.xsCRcuPC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:186: warning: Function parameter or struct member 'dev' not described in 'tegra241_cmdqv'


vim +186 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

   159	
   160	/**
   161	 * struct tegra241_cmdqv - CMDQ-V for SMMUv3
   162	 * @smmu: SMMUv3 device
   163	 * @base: MMIO base address
   164	 * @irq: IRQ number
   165	 * @num_vintfs: Total number of VINTFs
   166	 * @num_vcmdqs: Total number of VCMDQs
   167	 * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
   168	 * @vintf_ids: VINTF id allocator
   169	 * @vintfs: List of VINTFs
   170	 */
   171	struct tegra241_cmdqv {
   172		struct arm_smmu_device smmu;
   173		struct device *dev;
   174	
   175		void __iomem *base;
   176		int irq;
   177	
   178		/* CMDQV Hardware Params */
   179		u16 num_vintfs;
   180		u16 num_vcmdqs;
   181		u16 num_lvcmdqs_per_vintf;
   182	
   183		struct ida vintf_ids;
   184	
   185		struct tegra241_vintf **vintfs;
 > 186	};
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
