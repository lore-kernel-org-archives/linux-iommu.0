Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC718C002;
	Sat, 11 Jan 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592277; cv=none; b=ZmeUhc6FPg7gTSu+tubB8pdxXMytNrIYRQDnR4ZrWDBzImuaif7M6caD5O8aqtsID7TJRu//qKy1kaGJLRULYwYocMoPZOaW/LeKPVTlskO2iu5mWQj4Mn4FcF0gG9mvxhRzfBBT2KKHFX8B6fFbGMZjaErKtOWeMwzjxeNHApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592277; c=relaxed/simple;
	bh=k53UvnXOx/G3Q0f+sZRsqAkJgIpoPizB5KvAGnxQfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdL+TZB7ZGDDDuswBNrh8zzTK02HTIjuxm2IVs5bWAC4IZizlCaRTnUN6cjJ1f7MB4rwPto6+REvOL7Pxx6D5EbZ4x5QE21wb7gRoYgwQoeQR7wliNWttZQwXkPr91J6qLLEEXWwRWYvvtJAZSQ4MpY7X1yAKDYguWkuhiuh9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGBHaBo5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGBHaBo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736592276; x=1768128276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k53UvnXOx/G3Q0f+sZRsqAkJgIpoPizB5KvAGnxQfSw=;
  b=dGBHaBo5CTrzK1VInMDZSPZM0/jSH5iILr8xcB2LLimtDFTKb6667TVx
   BD+Um5mm5cn/7cTtFRdfGHqiFVXCk7zgBBZVln1aduu//N34IcVLrxLRF
   5gV7o+YFBS8i1XqVIAs0+Xgja/p7eO8RX40f0GBN0dKDp/hWJUn9JEohn
   qRhSJZ/GjHyKVcinHqcFDhZg2DN36vcWXKnPsghgQVthaAfnNkPrkI1jh
   wrza2xrwxB+KtGm3LNH2RNmV8PPfU8vYD3Y4+3Z/iM/39+w2NfAKAvA6x
   VMhvtvrF713iUHPugQrB+cv4CBlG5WWguwVDUyz8eZXqF+iZeTSSNtCw+
   A==;
X-CSE-ConnectionGUID: mZmZp0AgTJOYYRq+L+BK9g==
X-CSE-MsgGUID: uK9T+9I2RaebQ7bUJPJVOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40823156"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="40823156"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 02:44:35 -0800
X-CSE-ConnectionGUID: zBWcrZmFRaibzSH9seaBfA==
X-CSE-MsgGUID: a1JtxI6yTomU1pIhOr/GDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="108869450"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jan 2025 02:44:33 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWYyk-000KVL-2m;
	Sat, 11 Jan 2025 10:44:30 +0000
Date: Sat, 11 Jan 2025 18:43:37 +0800
From: kernel test robot <lkp@intel.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Wencheng Yang <east.moutain.yang@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drviers/iommu/amd: support P2P access through IOMMU when
 SME is enabled
Message-ID: <202501111847.N7CwntR4-lkp@intel.com>
References: <20250110130756.333265-1-east.moutain.yang@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110130756.333265-1-east.moutain.yang@gmail.com>

Hi Wencheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on linus/master joro-iommu/next v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wencheng-Yang/drviers-iommu-amd-support-P2P-access-through-IOMMU-when-SME-is-enabled/20250110-210948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20250110130756.333265-1-east.moutain.yang%40gmail.com
patch subject: [PATCH] drviers/iommu/amd: support P2P access through IOMMU when SME is enabled
config: x86_64-buildonly-randconfig-001-20250111 (https://download.01.org/0day-ci/archive/20250111/202501111847.N7CwntR4-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111847.N7CwntR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111847.N7CwntR4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iommu/amd/io_pgtable_v2.c:14:
   In file included from include/linux/io-pgtable.h:6:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iommu/amd/io_pgtable_v2.c:68:6: warning: variable 'pte' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      68 |         if (!(prot & IOMMU_PROT_MMIO))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/amd/io_pgtable_v2.c:71:2: note: uninitialized use occurs here
      71 |         pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
         |         ^~~
   drivers/iommu/amd/io_pgtable_v2.c:68:2: note: remove the 'if' if its condition is always true
      68 |         if (!(prot & IOMMU_PROT_MMIO))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      69 |                 pte = __sme_set(paddr & PM_ADDR_MASK);
   drivers/iommu/amd/io_pgtable_v2.c:66:9: note: initialize the variable 'pte' to silence this warning
      66 |         u64 pte;
         |                ^
         |                 = 0
   2 warnings generated.


vim +68 drivers/iommu/amd/io_pgtable_v2.c

    63	
    64	static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
    65	{
    66		u64 pte;
    67	
  > 68		if (!(prot & IOMMU_PROT_MMIO))
    69			pte = __sme_set(paddr & PM_ADDR_MASK);
    70	
    71		pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
    72		pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
    73	
    74		if (prot & IOMMU_PROT_IW)
    75			pte |= IOMMU_PAGE_RW;
    76	
    77		/* Large page */
    78		if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
    79			pte |= IOMMU_PAGE_PSE;
    80	
    81		return pte;
    82	}
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
