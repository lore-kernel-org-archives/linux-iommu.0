Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF89101C4;
	Wed,  6 Dec 2023 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knCBnzdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701841769; x=1733377769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpX/geHnpmimsq733O3OkvfmwoF/8EDiPR7c4SR7YHI=;
  b=knCBnzdhaaYpAe0elT9w+s4SGoaAfARxzacRNBLjA+iVy8WUKUQoUUSP
   e+hh2DeImX/TtvbR40Ghk8HY8BVNlbyTVFeAnV4Pc5py36vkuLjkRrrYr
   vWRUyABR2Y9cd/kHMfgUa70W/VG9WCc6J5VXJYDt6Rgw61EcXCTYHEtVx
   Uk2HYbux4nXTx/UmBmr9yp9fJw2Jo2eC+EbPeDsi3w7grPWGwEdgvBw85
   4nOgvnVlXMMal4ISYsRG3GeGwlUDSUFGL8EQNoHhvxhLYlbhzw3hAqcA+
   4F8Je23GKVugN9P3WlPNYnMoAeTsL3GzbjiC+154kYL+IxrScPcaHzEfp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396800531"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396800531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889224283"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="889224283"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 21:49:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAkmh-000AL8-1y;
	Wed, 06 Dec 2023 05:49:23 +0000
Date: Wed, 6 Dec 2023 13:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: oe-kbuild-all@lists.linux.dev, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <202312061310.UufAZ5vQ-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231128]
[cannot apply to joro-iommu/next v6.7-rc3 v6.7-rc2 v6.7-rc1 linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommufd-selftest-Use-a-fwnode-to-distinguish-devices/20231128-185058
base:   next-20231128
patch link:    https://lore.kernel.org/r/44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061310.UufAZ5vQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061310.UufAZ5vQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061310.UufAZ5vQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/iommu/iommufd/selftest.o: in function `iommufd_bus_init':
>> (.init.text+0x10): multiple definition of `init_module'; drivers/iommu/iommufd/main.o:(.init.text+0x10): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
