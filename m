Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7F24DD09;
	Wed,  3 Dec 2025 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750991; cv=none; b=sltUf+gPaSql6YOpq7gRTTjT5HbyRP2yy2C4L/I/IrhU4wbqFBlxYHGr69CAsG7/koKUUJN6hvZwmtM0wP2LbhmBYru2Qlq8Jts8uBuqGyu9Gb9gwTRwzoPH2cjwSIdKJ+bNWUrSMTJaE8f6Td8CaeUXsDBLsikLVtpFCl+mKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750991; c=relaxed/simple;
	bh=GEUohRqpfGWfGxxAeDp85DOIF/6IRcyN4akhZA/M6lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/jqkQakoZWC69IinaP0XU0a6dF1geXZuhXCKLuqvdG/C+oFwnonxwHWBiNlWSdro6JhblrlM/mKXNJI6Jslw/2p5OJCgQwlq9gAJ33+c7NBFdugw4R3bw5yepJrjX02tRSpyAMm/SYXnpWhBf9bUfqjnwmuklM9sct/qOAHZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjDw492t; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjDw492t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764750990; x=1796286990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GEUohRqpfGWfGxxAeDp85DOIF/6IRcyN4akhZA/M6lI=;
  b=FjDw492tru62tPGtHECejdbnoBobT4ini61//MfXXNf1SEoGzbdHSwQ0
   GiGSi8Sc/UpArChkmBU8UuENX7qcqZAbzqGYu66zNHlL2jpUG5EvVYhzP
   GfC5Ojs3Cxhf5zVZ67fJBrixBkrPLIbcuYebdtyKJr83RI8kje4P9hmI2
   XLRxdZoYhWRx0p9ULEdLsUilSmLAALgUV8Inh9a6yRvp2s1sncrBfD1lE
   8eBDBXnZmuS0+ob5qfXgDb9jVw1EzyeLJ3crGMTQoO4Kr71rcVeLSerws
   0gHfQFo8hqGszvNIVJs+/QjTcDl0blmh21chX0NO0bzZhg5TSeu1b5F9c
   Q==;
X-CSE-ConnectionGUID: xeaVIPrUQHOGUXuIH8zOZg==
X-CSE-MsgGUID: 2Fp+QJNKR7+xnz5YuU5e1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77056833"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="77056833"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 00:36:29 -0800
X-CSE-ConnectionGUID: AZFrEOdTRSat84/xefRi/w==
X-CSE-MsgGUID: EtfrlZziTHCvXPaiXay1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="194842233"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Dec 2025 00:36:25 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQiLW-00000000AlR-3fn0;
	Wed, 03 Dec 2025 08:36:22 +0000
Date: Wed, 3 Dec 2025 16:35:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nicolinc@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
	jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
Message-ID: <202512031601.IpliwbHW-lkp@intel.com>
References: <20251201163219.3237266-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201163219.3237266-2-amhetre@nvidia.com>

Hi Ashish,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251201]
[also build test ERROR on v6.18]
[cannot apply to robh/for-next linus/master v6.18 v6.18-rc7 v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/iommu-arm-smmu-v3-Add-device-tree-support-for-CMDQV-driver/20251202-003517
base:   next-20251201
patch link:    https://lore.kernel.org/r/20251201163219.3237266-2-amhetre%40nvidia.com
patch subject: [PATCH V3 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251203/202512031601.IpliwbHW-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251203/202512031601.IpliwbHW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512031601.IpliwbHW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: init_module
   >>> defined at arm-smmu-v3.c
   >>>            drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:(init_module)
   >>> defined at tegra241-cmdqv.c
   >>>            drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:(.init.text+0x4)
--
>> ld.lld: error: duplicate symbol: cleanup_module
   >>> defined at arm-smmu-v3.c
   >>>            drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o:(cleanup_module)
   >>> defined at tegra241-cmdqv.c
   >>>            drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o:(.exit.text+0x4)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
