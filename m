Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F618C930;
	Fri, 25 Oct 2024 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835750; cv=none; b=KGyhUow9E+v6cqx1LNeNZzc3caalnKJL9bZx0EQbAN5AgGc3V+gTNuRDE8BTOeMi90cNuxuZVDjVp6RLfnfnO2KiQVYdTkM44YR+zYcIrss1pJ+gsVOepswSz401HsrDan1cfIwBqgtP9o73BawjhPKltH7b/GQKzsIOT+Wwbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835750; c=relaxed/simple;
	bh=ihN9tLagLqN+X4m2rDGdBN+nxGXvbHRzDHkz4gXlS7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBxM3cKOkFyGMIwhdsmGW+GnENTwzDT0nj8QTihpebx6x95SdKw3UaljM/zcIieihoanrVHxQDMw0E6+8HwhvgcuBkngWABvUlYFpE52vrzF13UGptHJ0DDzlsyPWghZBMQOQlMB6wB8sHgXSttcfD2qCc4J5ziZLYmi6scM+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAjRalvl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAjRalvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729835747; x=1761371747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ihN9tLagLqN+X4m2rDGdBN+nxGXvbHRzDHkz4gXlS7I=;
  b=dAjRalvluPUE5BvNTpCtFgdmGoReBXKySgOrtBCq5yDNa0D51HZ8O5MI
   flycwP+PRva/oR0o1slmwONxbWzKfR986+56qrniEt28HgiI6eRyDdknl
   iT0KdOdNOqIZa0eFRZ6LJuGubvu8V99Zer+x7SWunENLTpT2Q5t/tc46/
   aWUSLNLIedtG6m0XBy5O+JYDyuEE/EA0dzRvCj2OQ8lASdwwShz3Jc9iT
   bcErpfMzeWvvqgpnozKLJuzgewoTOPaGU+E4994EejBeQ2kMy1MO1Z83e
   bQtaNdBvMsN/WGHpCI0NkD5ByknIHbsvVgEVova+tYFDp/FyKSAYLnEXS
   w==;
X-CSE-ConnectionGUID: lsdttGlPQvKAEuq4NqpIPg==
X-CSE-MsgGUID: T51gxwS2Q+OldrTxWpAeyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29434825"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29434825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 22:55:47 -0700
X-CSE-ConnectionGUID: zTGlRI0mTFy3nvanWu1jeQ==
X-CSE-MsgGUID: 4Gef3XNkSBGEFn/4Gq6+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81651364"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Oct 2024 22:55:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4DIT-000Xeo-07;
	Fri, 25 Oct 2024 05:55:41 +0000
Date: Fri, 25 Oct 2024 13:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: goutongchen <goutongchen@uniontech.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Rob Clark <robdclark@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, goutongchen <goutongchen@uniontech.com>,
	=?utf-8?B?6Iuf5rWp?= <gouhao@uniontech.com>
Subject: Re: [PATCH] iommu/arm-smmu: Add judgment on the size and granule
 parameters passed in
Message-ID: <202410251314.KllYat7L-lkp@intel.com>
References: <20241024100224.62942-1-goutongchen@uniontech.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024100224.62942-1-goutongchen@uniontech.com>

Hi goutongchen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on arm-perf/for-next/perf linus/master joro-iommu/next v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/goutongchen/iommu-arm-smmu-Add-judgment-on-the-size-and-granule-parameters-passed-in/20241024-181048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241024100224.62942-1-goutongchen%40uniontech.com
patch subject: [PATCH] iommu/arm-smmu: Add judgment on the size and granule parameters passed in
config: i386-buildonly-randconfig-005-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251314.KllYat7L-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251314.KllYat7L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251314.KllYat7L-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/iommu/arm/arm-smmu/arm-smmu.c:20:
   drivers/iommu/arm/arm-smmu/arm-smmu.c: In function 'arm_smmu_tlb_inv_range_s1':
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:287:34: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     287 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:286:17: note: in expansion of macro 'dev_err'
     286 |                 dev_err(smmu->dev,
         |                 ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:287:80: note: format string is defined here
     287 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                                                              ~~^
         |                                                                                |
         |                                                                                long unsigned int
         |                                                                              %u
   drivers/iommu/arm/arm-smmu/arm-smmu.c:287:34: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     287 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:286:17: note: in expansion of macro 'dev_err'
     286 |                 dev_err(smmu->dev,
         |                 ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:287:93: note: format string is defined here
     287 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                                                                           ~~^
         |                                                                                             |
         |                                                                                             long unsigned int
         |                                                                                           %u
   drivers/iommu/arm/arm-smmu/arm-smmu.c: In function 'arm_smmu_tlb_inv_range_s2':
   drivers/iommu/arm/arm-smmu/arm-smmu.c:321:34: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     321 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:320:17: note: in expansion of macro 'dev_err'
     320 |                 dev_err(smmu->dev,
         |                 ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:321:80: note: format string is defined here
     321 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                                                              ~~^
         |                                                                                |
         |                                                                                long unsigned int
         |                                                                              %u
   drivers/iommu/arm/arm-smmu/arm-smmu.c:321:34: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     321 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:320:17: note: in expansion of macro 'dev_err'
     320 |                 dev_err(smmu->dev,
         |                 ^~~~~~~
   drivers/iommu/arm/arm-smmu/arm-smmu.c:321:93: note: format string is defined here
     321 |                                  "The size or granule passed in is err. size=%lu, granule=%lu\n",
         |                                                                                           ~~^
         |                                                                                             |
         |                                                                                             long unsigned int
         |                                                                                           %u

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +287 drivers/iommu/arm/arm-smmu/arm-smmu.c

   276	
   277	static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
   278					      size_t granule, void *cookie, int reg)
   279	{
   280		struct arm_smmu_domain *smmu_domain = cookie;
   281		struct arm_smmu_device *smmu = smmu_domain->smmu;
   282		struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
   283		int idx = cfg->cbndx;
   284	
   285		if (size == 0 || granule == 0 || (size % granule) != 0) {
   286			dev_err(smmu->dev,
 > 287					 "The size or granule passed in is err. size=%lu, granule=%lu\n",
   288					 size, granule);
   289			return;
   290		}
   291	
   292		if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
   293			wmb();
   294	
   295		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
   296			iova = (iova >> 12) << 12;
   297			iova |= cfg->asid;
   298			do {
   299				arm_smmu_cb_write(smmu, idx, reg, iova);
   300				iova += granule;
   301			} while (size -= granule);
   302		} else {
   303			iova >>= 12;
   304			iova |= (u64)cfg->asid << 48;
   305			do {
   306				arm_smmu_cb_writeq(smmu, idx, reg, iova);
   307				iova += granule >> 12;
   308			} while (size -= granule);
   309		}
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
