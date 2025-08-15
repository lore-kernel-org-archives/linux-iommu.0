Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7326D4E3;
	Fri, 15 Aug 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240484; cv=none; b=sJpjsy1mce2xqUjAkkB1c1M13fcvdsETrudN7b+DmmUiN2uc9rnAxk38AVYb5lsDabyQgDHk4mZaJyq6ngzgV8s2Oon9Z5OcqyXglniEJjqHyoKwTAbpNILqvbung4sj2QOuTzYlvhTCiw/7IfsqwE6lgsS6O5shNW+j3eLMyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240484; c=relaxed/simple;
	bh=JoZn79aBzPPrDDr0xHM5IQgwaowZCOkP1rtnzUXddyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDvvssa/gQqr/ysPJDyIMLJ4EL+95OIB8XQE8bZtt/Kb1M/hMDG2ydS7gzaqeiRCVvrfrGU88210I8f00z1oXHEZDQaGRF7QG2qHdwkSJyVqdZsWHk0Wto4w0NJUcFEKFK8twFole8qkkWgkohQ17+QBB2wEoaDIw0T45CsIOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU0zIpuF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU0zIpuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755240482; x=1786776482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JoZn79aBzPPrDDr0xHM5IQgwaowZCOkP1rtnzUXddyI=;
  b=kU0zIpuFbQc8r+vVMKXSkFK2GjUakMFtkRwD+wCaR9LxHorXJ82hzKvt
   YKUSQGoiRKo2uHABhwZwv//UwGteiHgfFQVDUg4kKjN8no1N8QK3FKjC3
   JPiJcjEpyq1wxhYOrpfN1itypElITKn4XOEWSzWvoGWwhacIuYvYVQNiT
   wQ/FmzmVQtpvZEfh7ho56QXTcEmCIyp1lDHbIxgEhwyjdWTSTLrRmeQRL
   udGdi6uL6ZxhScR451v3a9q/7XQC4dljLRhSlJbaj6YJJ5eTw4mdbTtoL
   gA2rlPTQO28E0D+egg2pC/NlQ3QswufaUbWjeedAHSITLW3F6muJN/9ZA
   A==;
X-CSE-ConnectionGUID: ovOQmZ1ZS9yrCINLMKRtnw==
X-CSE-MsgGUID: u31sYK83Q1a9d8hNcE7jIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57714255"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57714255"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 23:48:01 -0700
X-CSE-ConnectionGUID: q5kEDUGMRySi7HKMbuH4gA==
X-CSE-MsgGUID: nDLocVRPTjaBabj3cOv3kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171083464"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 14 Aug 2025 23:47:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umoEG-000Bea-1u;
	Fri, 15 Aug 2025 06:47:56 +0000
Date: Fri, 15 Aug 2025 14:47:39 +0800
From: kernel test robot <lkp@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, xiaqinxin@huawei.com, yangyicong@huawei.com,
	wangzhou1@hisilicon.com, prime.zeng@hisilicon.com,
	xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
Message-ID: <202508151456.FmgCiCK4-lkp@intel.com>
References: <20250814093005.2040511-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-2-xiaqinxin@huawei.com>

Hi Qinxin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.17-rc1 next-20250814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qinxin-Xia/iommu-debug-Add-IOMMU-page-table-dump-debug-facility/20250814-173720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250814093005.2040511-2-xiaqinxin%40huawei.com
patch subject: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250815/202508151456.FmgCiCK4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151456.FmgCiCK4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151456.FmgCiCK4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/io_ptdump_debugfs.c:14:13: warning: no previous prototype for 'io_ptdump_debugfs_register' [-Wmissing-prototypes]
      14 | void __init io_ptdump_debugfs_register(const char *name)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/io_ptdump_debugfs_register +14 mm/io_ptdump_debugfs.c

    13	
  > 14	void __init io_ptdump_debugfs_register(const char *name)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
