Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF12820A3;
	Fri, 22 Aug 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841225; cv=none; b=VNFn4jrLnEBBwxuOXLDc3sqlIPkdw73ZJNdSYWRhRsIDk+vpr1OJXMavgJj4CjBhI290WOatACdI3dHmIv5r4jQpD/mCTmS+hbHXhglvVgvwGfd+dIDTddxOh+IoQbun6TFx/3XWlnKzyi7wZj2dX6JdLSDkRpIvCKNqtX9uM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841225; c=relaxed/simple;
	bh=giiH4kxOB5O1aaGhMf2GAHfxmjpaNjKzcQzCzzwlRTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq4KlYgQp69a2ZlGmz8FEUqm92G9QGEDVLiRkq2keHXv89gkyJ/MHt/k2RHD+NPSQF6F5iigj4mf1yT7jnH/gMBk2mdzkjqX1lo9pQWQ5APWyx9PmPNn7cLvmIHr/6vXqLq1q7gUG3syJK/dw4tHpnttHMcsvtN62KgMs2H7Rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZL2wfSI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZL2wfSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755841224; x=1787377224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=giiH4kxOB5O1aaGhMf2GAHfxmjpaNjKzcQzCzzwlRTQ=;
  b=SZL2wfSI4ttUECtp5qc2BDuo0dP021Le5FXcpXoN3XFFx5JPh3RfbRmw
   5Q9Su4Iq/7RaCKBJ/lIFFXHnPewWD4eF6VB4ysJw7bhuaHnXIkW02pvHM
   csCLZCaesrNy066aMdnfZsP5eeFtGEC1d7CEfZmeKyvWW3oXzfa3tyVyz
   uL9z6SKn3cpxpLITQi/2rF4HGTaell+8hRInl4CUXTGMfCMVzn4BG9WT7
   1g/LBmfN0Qu6Dpa+HZZnyS7CpCpT/g7PFnXU5tzLYN9wl5/bFwIT3jly2
   mImjKLieiMLa75bU5Fxplj16Ttm9zheVpdE7Bf0oCNXtVPpwNb0lmu6Vq
   A==;
X-CSE-ConnectionGUID: 5eR9s4GDSjaY4DVu9pBtog==
X-CSE-MsgGUID: JnK3jyxzT1qzhUlup+D4gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61957112"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61957112"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:40:23 -0700
X-CSE-ConnectionGUID: yw8Vv2dBSnKmAP4JpykI4g==
X-CSE-MsgGUID: l52Zd7HYRBCYxn3rr3/onw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173896595"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2025 22:40:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upKVd-000Kwx-0C;
	Fri, 22 Aug 2025 05:40:17 +0000
Date: Fri, 22 Aug 2025 13:39:38 +0800
From: kernel test robot <lkp@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
	nicolinc@nvidia.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, vasant.hegde@amd.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <202508221308.4CwLNeZw-lkp@intel.com>
References: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>

Hi Suravee,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc2 next-20250821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suravee-Suthikulpanit/iommu-amd-Make-amd_iommu_pdom_id_alloc-non-static/20250820-194937
base:   linus/master
patch link:    https://lore.kernel.org/r/20250820113009.5233-8-suravee.suthikulpanit%40amd.com
patch subject: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
config: x86_64-randconfig-123-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221308.4CwLNeZw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221308.4CwLNeZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221308.4CwLNeZw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/amd/nested.c:15:31: sparse: sparse: symbol 'nested_domain_ops' was not declared. Should it be static?

vim +/nested_domain_ops +15 drivers/iommu/amd/nested.c

    14	
  > 15	const struct iommu_domain_ops nested_domain_ops = {
    16		.free = amd_iommu_domain_free,
    17	};
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
