Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1501EBFF7;
	Sun, 11 Jan 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158537; cv=none; b=CAANyMmMvBwJPmbDZUwuywBANW2uNHN44cmBxHtI2eZ3/ZCWiDDqYCvLO7CVDzB69ADInVwOks0OEVHXj0gZHSbUYXyGfNaslLbXg9gFlCfqmPZ56jfkYByzIiYmwrpp/zBu85YNHpcYPmfQsEdKnNOhpSaAl0hyTtiipPxv8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158537; c=relaxed/simple;
	bh=zs9/X34UCjwV8bFsafnWUa1DBqKEiu2YwcITL57ckvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQgWdx6khC1o5+4feBHrK/0YOhfyjExXfUg6qgWVt/cvd7MgFB4Di8nMrpGWxLHL+Lq3gGPBSvqUzanxikWLL/Dw+X6pmqpLUlsQFeOBZiCEpHxpxjrcxsyDj1XTJCFqM+QT18GDylB36b1im1RiBFFzKo9vdF4goNj/TzX688A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQj76FX6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQj76FX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768158535; x=1799694535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zs9/X34UCjwV8bFsafnWUa1DBqKEiu2YwcITL57ckvo=;
  b=KQj76FX68+fIN3iSWqRmtUvsnKr9XwaAS8PfSPhmm6HOXMjdyOhgix+j
   iBpcWXM2tbqI3Xxs+JYi2WFGUJDHJgobuDTzwTS/Zjyc7F0fdR965P6d6
   sp9fXKowsz139Go1gupukUCiRdz1agJuLLcZPO+8UIoG47xYVLpmc/ycy
   R1pUGLPD3uBg57Oqk6mVkgVO4/U/+aT4eyyRVDHvstTYkT1phSgl1GV9A
   ud+DuzUBelFj8sP8U0Cdz6Ei8GsD9a3gpVAvk3/N3sZAR7TjPwTMazNUk
   QxgYTG1jgq/R7fbiWrwGqcThYX3rJUMreY8UImqhCo0VyyLjX7xjvhoBS
   w==;
X-CSE-ConnectionGUID: om4p7WnpRTS4F6nwO5luyA==
X-CSE-MsgGUID: BTRk3ZiPSvS5PtRRH5i7vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80901994"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80901994"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 11:08:55 -0800
X-CSE-ConnectionGUID: QS+41tJ2Ssa96H4+AiuNJg==
X-CSE-MsgGUID: rXOqrG9KQTSW2xYkkqTLOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208757941"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jan 2026 11:08:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vf0ny-00000000CdE-1yjp;
	Sun, 11 Jan 2026 19:08:50 +0000
Date: Mon, 12 Jan 2026 03:08:41 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: don't allocate DMA32 pool if no 32-bit memory
Message-ID: <202601120212.Wm3uFeKw-lkp@intel.com>
References: <20260111152632.2133580-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111152632.2133580-1-vladimir.kondratiev@mobileye.com>

Hi Vladimir,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7d0a66e4bb9081d75c82ec4957c50034cb0ea449]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Kondratiev/dma-pool-don-t-allocate-DMA32-pool-if-no-32-bit-memory/20260111-232732
base:   7d0a66e4bb9081d75c82ec4957c50034cb0ea449
patch link:    https://lore.kernel.org/r/20260111152632.2133580-1-vladimir.kondratiev%40mobileye.com
patch subject: [PATCH] dma-pool: don't allocate DMA32 pool if no 32-bit memory
config: arc-randconfig-001-20260111 (https://download.01.org/0day-ci/archive/20260112/202601120212.Wm3uFeKw-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601120212.Wm3uFeKw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601120212.Wm3uFeKw-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/dma/pool.c: In function 'dma_atomic_pool_init':
>> kernel/dma/pool.c:212:39: error: 'phys_ram_base' undeclared (first use in this function); did you mean 'phys_to_page'?
     if (IS_ENABLED(CONFIG_ZONE_DMA32) && phys_ram_base < BIT_ULL(32)) {
                                          ^~~~~~~~~~~~~
                                          phys_to_page
   kernel/dma/pool.c:212:39: note: each undeclared identifier is reported only once for each function it appears in


vim +212 kernel/dma/pool.c

   186	
   187	static int __init dma_atomic_pool_init(void)
   188	{
   189		int ret = 0;
   190	
   191		/*
   192		 * If coherent_pool was not used on the command line, default the pool
   193		 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_PAGE_ORDER.
   194		 */
   195		if (!atomic_pool_size) {
   196			unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
   197			pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
   198			atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
   199		}
   200		INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
   201	
   202		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
   203							    GFP_KERNEL);
   204		if (!atomic_pool_kernel)
   205			ret = -ENOMEM;
   206		if (has_managed_dma()) {
   207			atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
   208							GFP_KERNEL | GFP_DMA);
   209			if (!atomic_pool_dma)
   210				ret = -ENOMEM;
   211		}
 > 212		if (IS_ENABLED(CONFIG_ZONE_DMA32) && phys_ram_base < BIT_ULL(32)) {
   213			atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
   214							GFP_KERNEL | GFP_DMA32);
   215			if (!atomic_pool_dma32)
   216				ret = -ENOMEM;
   217		}
   218	
   219		dma_atomic_pool_debugfs_init();
   220		return ret;
   221	}
   222	postcore_initcall(dma_atomic_pool_init);
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
