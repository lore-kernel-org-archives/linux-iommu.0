Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E81FFC48;
	Sat, 14 Mar 2026 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501652; cv=none; b=czXfHw5nIAB9n41KqzURvT9RkQs5X1tgXCoDWmnIRHVSeDzUJtMON4T7X6k2RfIJvg4gMw/OL9Fbj65dm3Cu27hYdtOqrviJcIVvPOXTFkTnO59pqXeZWdnuHz1qzvvjAMfZdncXPDMjqnthujiUX/XIJUABgGPRzubm0bbt/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501652; c=relaxed/simple;
	bh=1FtGcHaPzohD23/qb3jPURbq6HHqLOzLRiH5ow2x+iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM39KE2EsEeATu09phiYYhWzEn+DItBeHuZozUSLJBRMbg2siYSYsrVAQD8KV4ysvcGux9BkJ+pPV3UHPycHBibcruevBeCU9Ysaz89o6kEkai5Ra2PDqu8Xgw+TQwXaux+k9hbE4d+A9Ldahh2l5EX6b/FNAdykU/x7+FRtzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrZ+8Tw5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrZ+8Tw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773501649; x=1805037649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FtGcHaPzohD23/qb3jPURbq6HHqLOzLRiH5ow2x+iE=;
  b=NrZ+8Tw52c6j1AgcNiy2ThC7Va7ZKRT6t8r5oyvrGzi4+P5GJBktspKW
   HGCeAJvFZAxfmS/QugkjcaWgDOVAXnhSYO4ajdgQzisNdvd+oxQY+9LBu
   5L3rvIaHqMhV+sJ4lB9Njth/ywUn+9uj5W8bPEt3GJ1+YdYBPAg9jczZU
   eJxy1aCOMoaqK5Nn2oVeTmCdfCft9U1aw9BA8VctQXFaXLhLTss9PaHDd
   32Sh4/K6rVpuLJ3GEQ7vWsRR0gBcmXJOvbnZTCyuvxGGpdkLpP2PDRB0n
   MjNdDTKSDBoA3uKudxJN7UJuFwrq6Q+BUfjJfsSrK9ssfsuGOl5cm5fqb
   w==;
X-CSE-ConnectionGUID: Z3vg6CA3RZikPNCeArv8vg==
X-CSE-MsgGUID: fIZNuoBHSNOQeiTobayc4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="78476194"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="78476194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 08:20:48 -0700
X-CSE-ConnectionGUID: qNbf0hHhQhu2DsmAtre4nA==
X-CSE-MsgGUID: RSSzsBKMTTmMexgmUNZJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="221663544"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Mar 2026 08:20:45 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1QnC-000000005I7-1ruy;
	Sat, 14 Mar 2026 15:20:42 +0000
Date: Sat, 14 Mar 2026 23:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/7] of: reserved_mem: switch to ops based OF_DECLARE()
Message-ID: <202603142347.aops46Bf-lkp@intel.com>
References: <20260313150802.1121442-4-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313150802.1121442-4-m.szyprowski@samsung.com>

Hi Marek,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on tegra/for-next akpm-mm/mm-everything linus/master v7.0-rc3 next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Szyprowski/of-reserved_mem-remove-fdt-node-from-the-structure/20260314-023123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260313150802.1121442-4-m.szyprowski%40samsung.com
patch subject: [PATCH 3/7] of: reserved_mem: switch to ops based OF_DECLARE()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260314/202603142347.aops46Bf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603142347.aops46Bf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603142347.aops46Bf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/memory/tegra/tegra210-emc-table.c: In function 'tegra210_emc_table_init':
>> drivers/memory/tegra/tegra210-emc-table.c:79:22: error: 'tegra210_emc_table_ops' undeclared (first use in this function); did you mean 'tegra210_emc_table_init'?
      79 |         rmem->ops = &tegra210_emc_table_ops;
         |                      ^~~~~~~~~~~~~~~~~~~~~~
         |                      tegra210_emc_table_init
   drivers/memory/tegra/tegra210-emc-table.c:79:22: note: each undeclared identifier is reported only once for each function it appears in


vim +79 drivers/memory/tegra/tegra210-emc-table.c

10de21148f7d28 Joseph Lo        2019-05-29  72  
6888259214366b Marek Szyprowski 2026-03-13  73  static int tegra210_emc_table_init(unsigned long node,
6888259214366b Marek Szyprowski 2026-03-13  74  				   struct reserved_mem *rmem)
10de21148f7d28 Joseph Lo        2019-05-29  75  {
10de21148f7d28 Joseph Lo        2019-05-29  76  	pr_debug("Tegra210 EMC table at %pa, size %lu bytes\n", &rmem->base,
10de21148f7d28 Joseph Lo        2019-05-29  77  		 (unsigned long)rmem->size);
10de21148f7d28 Joseph Lo        2019-05-29  78  
10de21148f7d28 Joseph Lo        2019-05-29 @79  	rmem->ops = &tegra210_emc_table_ops;
10de21148f7d28 Joseph Lo        2019-05-29  80  
10de21148f7d28 Joseph Lo        2019-05-29  81  	return 0;
10de21148f7d28 Joseph Lo        2019-05-29  82  }
f954eaa20bd915 Marek Szyprowski 2026-03-13  83  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
