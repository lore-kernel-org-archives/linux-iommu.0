Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAD1E285A;
	Tue, 16 Sep 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987277; cv=none; b=WDY3kMnGD2AoMCut4loEMI/Q10sEIMjdze4ML0iRohOI5Gbj3A0FLWTqDNUXUcRDJL1QQsrSTjb4O8irEYxK8bueGwFrN+mumSweZ4cRLwCtpfYJ44dmvpnU/Qz3l0exOqVj8KcvqM9bfVEX/ExeLYtNpw9FHz2c3sWJ9FvPDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987277; c=relaxed/simple;
	bh=Uzk0zM0Sv9BPqYaD/fclWwxs8iEByGp20gyqw+q/3QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhucmkaEce6W7dm9v5ddbqwXFW22VVUtXYgigKOO+BQ4cXkDnRUAQjNZnNq8syZwnLPcb0ff/CPb/8O8r7YudNixvF3e91xECFkLsbftaG/cj6n1GNhxTj1mZyNRogcVqEua3OnuDzSLFvPJJHCbj5Bw8Rw6rW1avN1VUUWzvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijzQD2wY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijzQD2wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757987276; x=1789523276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uzk0zM0Sv9BPqYaD/fclWwxs8iEByGp20gyqw+q/3QE=;
  b=ijzQD2wYtDqo1EEN/v7RsfLo/gGcX2Tj518RcUNBP9oiui7CfDIV9p1R
   nc1Hjn5XkuvGN44DlPyHnh2maUnmj5xPAFHK2NSb1Gz8B7CYqf5w2hJo6
   cPcnzirVvoliR0IuWdMtqnHeydFPSuuVi35dENN6A7b7ztg+3L42tXNgZ
   RInJHpSKvVlB30P4Yk/EtdCrLCsufHxgAtG+kI6s4wXPpghkJG0vmNNjh
   pwqqYY88AMtaNeQXNtYjnfj3bIjUD9oiYQFlhBZyEBMaqvLkxgfL+dNmt
   BGRdZEr65Gqn6xcRffE4XCxJfuuG9VtRF/bqXiiF/cw2aFL7TrhDtfqvC
   g==;
X-CSE-ConnectionGUID: nH90tz+/RceUhkekX6EkAg==
X-CSE-MsgGUID: rU14R6BPSwKsTV70aohdjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="47829888"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="47829888"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 18:47:54 -0700
X-CSE-ConnectionGUID: XE/uw4eBRPOzozjJHBpHbQ==
X-CSE-MsgGUID: vgAiQquBQyKKwPzeeHY03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="174618035"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Sep 2025 18:47:51 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyKnM-0000tz-0F;
	Tue, 16 Sep 2025 01:47:48 +0000
Date: Tue, 16 Sep 2025 09:47:34 +0800
From: kernel test robot <lkp@intel.com>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-riscv@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, tjeznach@rivosinc.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	anxu@bosc.ac.cn, wangran@bosc.ac.cn,
	Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
Message-ID: <202509160926.OINmzlTz-lkp@intel.com>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>

Hi Yaxing,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc6 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yaxing-Guo/iommu-riscv-Add-Makefile-support-for-RISC-V-IOMMU-perf-driver/20250915-101640
base:   linus/master
patch link:    https://lore.kernel.org/r/20250915020911.1313-1-guoyaxing%40bosc.ac.cn
patch subject: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
config: riscv-randconfig-001-20250916 (https://download.01.org/0day-ci/archive/20250916/202509160926.OINmzlTz-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 65ad21d730d25789454d18e811f8ff5db79cb5d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509160926.OINmzlTz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509160926.OINmzlTz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/riscv/iommu-pci.c:21:
   In file included from drivers/iommu/riscv/iommu.h:20:
>> drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
   3 errors generated.


vim +68 drivers/iommu/riscv/iommu-perf.h

    65	
    66	static inline struct riscv_iommu_pmu *riscv_iommu_event_to_pmu(struct perf_event *event)
    67	{
  > 68		return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
