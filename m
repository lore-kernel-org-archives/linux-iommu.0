Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2ED1EBFF7;
	Mon, 12 Jan 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179987; cv=none; b=JiGI30ljNxJJUuY/2QnEsWGkRtmEU/fInOvDJjCSJuu4SKsdtBWb+eJbqKWXMaxIDRLSvYyrC4z1curhknQ5ZboSFEmIVkFs0fUivN+hbrEIYQUYPwN10bpARc/dZwCj/8HXt+Dts9zNDZln03hWn9iCQmqsu0vsZI0D4Z3TpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179987; c=relaxed/simple;
	bh=bJscLIX8YNa0pTLBuMKLUe5HuNdRKcxMYkcucIl5i8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poDoTox5ekP4cUMmDGwQInc9al9f55DrYLln+rAFjMZNtbH6muV3lKvoMI/HfwdO0wwd1tSGlZKetcIV+7MoWejNeMZ1q/07Pc/ZOzg1QyRywphU/1xeZcG6IOOJ/TfGFUocB6jMRxCqbozd4OSBnyVy5KFsekEUb0DTRplTPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ay7vIrFS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ay7vIrFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768179986; x=1799715986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bJscLIX8YNa0pTLBuMKLUe5HuNdRKcxMYkcucIl5i8o=;
  b=Ay7vIrFSI1Ouf6Z5r1ZKYoLtxddHn5kniwupjUMlxIdf5OYgPZzqnaMo
   djkev/7rC6rp6jpACS+khgHmQKSrgQR5+Hd0QgMkHNmAImmjkvojtGq52
   o2t+izk4WrKy0VNhRiPIOd/3v6YjWbb2tDnmkNxrocnHCwLaERURMb4xg
   QADlTBqD4HGvZcWmpswrQhv/4pF5eaml7Vvll/+Izr4hW5sqJMebjzpLS
   z1Tk4U9GH1HZFJIFHLu+rnhwvZOAHbEflvrSlCensOwAC5rjWj+mLIU8o
   DN3k5GwhKBE3Tl7P4duRcgNzkLqlCn7hjBjQBE1qAFGjbYea7di1brDl0
   g==;
X-CSE-ConnectionGUID: 1D1feuCrTfSBp3ienIxhLg==
X-CSE-MsgGUID: x8+6RGGLQZOscehKqa2l8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="72033551"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="72033551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 17:06:25 -0800
X-CSE-ConnectionGUID: FWjlspKDTsiCiYhhRMiAVQ==
X-CSE-MsgGUID: 7O1Mx+4lRaqh+tGfM3OHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="209023701"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jan 2026 17:06:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vf6Nw-00000000Coy-3zTF;
	Mon, 12 Jan 2026 01:06:20 +0000
Date: Mon, 12 Jan 2026 09:05:52 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: don't allocate DMA32 pool if no 32-bit memory
Message-ID: <202601120747.TAMpIDnI-lkp@intel.com>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260112/202601120747.TAMpIDnI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601120747.TAMpIDnI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601120747.TAMpIDnI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/dma/pool.c:212:39: error: use of undeclared identifier 'phys_ram_base'; did you mean 'phys_base'?
     212 |         if (IS_ENABLED(CONFIG_ZONE_DMA32) && phys_ram_base < BIT_ULL(32)) {
         |                                              ^~~~~~~~~~~~~
         |                                              phys_base
   arch/x86/include/asm/page_64.h:15:22: note: 'phys_base' declared here
      15 | extern unsigned long phys_base;
         |                      ^
   1 error generated.


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
