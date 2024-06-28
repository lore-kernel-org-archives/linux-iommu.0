Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97237225D4;
	Fri, 28 Jun 2024 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719551923; cv=none; b=dWffUlAw7A/IltG4MUPJzvcEvDObvRX6BttXRQGBeX2Mo3Q5oFfymr0GcshqqE7Hlq9q79r2Kh0S8yFfcPl4WdrhTetc2XYtYvTg8/FJKbjw+skXndPtyY9/SOewoSGY3RffOAtT6ygBoaxKHv0EeGrZZnuwY7TGbk/ZJ5xwKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719551923; c=relaxed/simple;
	bh=EsBjbl1L0ItHWLuJt6/SzDFQkncBAJfJVa3VjM2Xvcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFCXzSyjrSoZcO7EjQlzwr+knvwvIU9bwjVMeQlk2pCZH906X0/ixVfxOWeq+1WlMD5lVqKQPIy4rJYhNxhfy0mChA+CZajrcW7FoJYK5iLI9XMhFLyWJn3zYki5VeA/V8TzNukWLl6mpROd30Uj0/4KZbn2BccEFWtiwEKFMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLL9Seaq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLL9Seaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719551922; x=1751087922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EsBjbl1L0ItHWLuJt6/SzDFQkncBAJfJVa3VjM2Xvcg=;
  b=YLL9SeaqZcFliqinc6nNTXuykOyo3w0Tb9gRiMQ5qjIr+UKsnGc4rYYH
   l7QZORzTivBakBPuO92UUuQNMY8xXWo3WxCEJyG5ZWZYPU3zfrLg79O5o
   NN0NFuRr2WYLuRvO2aX4xfQaxXb2hwj7fs58WSLoGewcq5QEk1pTUBzpG
   ZjCz2ksTH8oVjdvXkFG7AOxHkI7d7aio4FyXT3W9nPEQSlYh3jZsDOIUk
   lPxbXZXApuVdrbD7hVP6tfMLrwHy7Kza/WgdhT/x6NfrHFX2RPa9bUP0g
   tQBQkRDifYEZVwjgvM/+rC0VntskzWVUntqetPsSp/KSi8y6hwoN1L0Oj
   A==;
X-CSE-ConnectionGUID: eeEhlz/IT1ajtagKhw5xNA==
X-CSE-MsgGUID: 1mYCKVZHRdi43LaI/GykKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27340533"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="27340533"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:18:41 -0700
X-CSE-ConnectionGUID: PKoepgiDSSyTrsIjQx5f9Q==
X-CSE-MsgGUID: sSeuRvK7T5S4L+nd0hgoSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45367562"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2024 22:18:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN40I-000Gp8-2o;
	Fri, 28 Jun 2024 05:18:34 +0000
Date: Fri, 28 Jun 2024 13:18:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, robdclark@gmail.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org,
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: Re: [PATCH v12 6/6] iommu/arm-smmu: add support for PRR bit setup
Message-ID: <202406281241.xEX0TWjt-lkp@intel.com>
References: <20240626143020.3682243-7-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626143020.3682243-7-quic_bibekkum@quicinc.com>

Hi Bibek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibek-Kumar-Patro/iommu-arm-smmu-re-enable-context-caching-in-smmu-reset-operation/20240627-074037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
patch link:    https://lore.kernel.org/r/20240626143020.3682243-7-quic_bibekkum%40quicinc.com
patch subject: [PATCH v12 6/6] iommu/arm-smmu: add support for PRR bit setup
config: arm64-randconfig-r113-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281241.xEX0TWjt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240628/202406281241.xEX0TWjt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281241.xEX0TWjt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:247:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:247:54: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:247:54: sparse:     got void *
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:250:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:250:54: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:250:54: sparse:     got void *
   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +247 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c

   238	
   239	static void qcom_adreno_smmu_set_prr(const void *cookie, phys_addr_t page_addr, bool set)
   240	{
   241		struct arm_smmu_domain *smmu_domain = (void *)cookie;
   242		struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
   243		struct arm_smmu_device *smmu = smmu_domain->smmu;
   244		u32 reg = 0;
   245	
   246		writel_relaxed(lower_32_bits(page_addr),
 > 247					(void *)smmu->ioaddr + ARM_SMMU_GFX_PRR_CFG_LADDR);
   248	
   249		writel_relaxed(upper_32_bits(page_addr),
   250					(void *)smmu->ioaddr + ARM_SMMU_GFX_PRR_CFG_UADDR);
   251	
   252		reg =  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
   253		reg &= ~GFX_ACTLR_PRR;
   254		if (set)
   255			reg |= FIELD_PREP(GFX_ACTLR_PRR, 1);
   256		arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
