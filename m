Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F330333;
	Wed,  6 Dec 2023 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bn6ijy6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701859412; x=1733395412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xi/Tvlsu8RZu+OF2u1C2q0qQLAQ8vl2Z9OL3pG5pHY0=;
  b=Bn6ijy6Kt5aDwAYCsuXPlrZRI/yK5efvewNX2hl2DYGVvBlEDrF15py+
   Hy23Fuynlokr2aoEvLd2PYfk84gjJogjj3p5uuxhV1dmciLHL3IDcVkH9
   Z/9jCJ57kHlKrCbaJZJIf4WDj44AnzOvykjvwwDc5OZTrCF2R3vW/y792
   +Dv1oSJF+bIoNKwHZYIijgYo5JFIFXeaKyDsmfit7/+k8t7bAvcXc+P9J
   JTqid6rw4NnMHVBAselTy07+8yhL5Yo57eOIbXV9bQGHBCAta69HXutZP
   L+QgTof5jgFwaUXjX4HYQIg8DfI3Dmj+d5PEnYbFWKuCP62yqZrEHc1AZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391213754"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391213754"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 02:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018524737"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018524737"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2023 02:43:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rApNI-000AeK-1L;
	Wed, 06 Dec 2023 10:43:28 +0000
Date: Wed, 6 Dec 2023 18:42:37 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <202312061821.knvqS2Hz-lkp@intel.com>
References: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>

Hi Robin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231128]
[cannot apply to joro-iommu/next v6.7-rc3 v6.7-rc2 v6.7-rc1 linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommufd-selftest-Use-a-fwnode-to-distinguish-devices/20231128-185058
base:   next-20231128
patch link:    https://lore.kernel.org/r/44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231206/202312061821.knvqS2Hz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061821.knvqS2Hz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061821.knvqS2Hz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/selftest.c:1323:12: warning: no previous prototype for function 'iommufd_bus_init' [-Wmissing-prototypes]
   int __init iommufd_bus_init(void)
              ^
   drivers/iommu/iommufd/selftest.c:1323:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init iommufd_bus_init(void)
   ^
   static 
   drivers/iommu/iommufd/selftest.c:515:1: warning: unused function 'get_md_pagetable_nested' [-Wunused-function]
   get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
   ^
   2 warnings generated.


vim +/iommufd_bus_init +1323 drivers/iommu/iommufd/selftest.c

  1322	
> 1323	int __init iommufd_bus_init(void)
  1324	{
  1325		return bus_register(&iommufd_mock_bus_type);
  1326	}
  1327	subsys_initcall(iommufd_bus_init);
  1328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
