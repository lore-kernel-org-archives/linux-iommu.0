Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE3315AF;
	Wed,  6 Dec 2023 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bT7WXRk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701862578; x=1733398578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBamYsiYKUMX5S/MYM4VPzYsx3uU17y8l+V5FKdfObI=;
  b=bT7WXRk6OSZ/hhnfgQoJLb2c2OYumP+n5In564+MME80mKgDyj+MRQmj
   uIQS1JyTEP7XgwZcLguq8KgScWHpyVQPmqHHN2C/kWDvQfpr94V/f0TR/
   kDewCpdZFy0RTN4x6JB20eJYj4q62J238QapCYZYpZrsVSqM81nNRIEnY
   3BzC6ybXHpMGI5TH3RtvWYgzVzYm31FxMfAG44yvbe1XFRFYjHNGnm41N
   VrEwMNgPk+3eAzV0mvLTGDZXwdN4j3BoX0eyoYVIwJkQKKu/VlpKXDaEw
   m8CqzY5e/FEr0OmrUXruJQ0lOHm1ku9oFPZihOwVW026bxS7c7DvA2pQp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="379065751"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="379065751"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 03:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889313656"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="889313656"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 03:36:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAqCL-000AiQ-06;
	Wed, 06 Dec 2023 11:36:13 +0000
Date: Wed, 6 Dec 2023 19:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: oe-kbuild-all@lists.linux.dev, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <202312061934.2WuVvBEi-lkp@intel.com>
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
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312061934.2WuVvBEi-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061934.2WuVvBEi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061934.2WuVvBEi-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/iommu/iommufd/selftest.o: in function `iommufd_bus_init':
>> (.init.text+0x0): multiple definition of `init_module'; drivers/iommu/iommufd/main.o:main.o:(.init.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
