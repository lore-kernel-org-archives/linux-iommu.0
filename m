Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023512E1E9;
	Wed,  7 Aug 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048870; cv=none; b=apVkN2pEZnLGBjrrvSPBTXOmo6Rc5q7JjTuYfDJTlw34wM2GnGsurXqfqRFlCWPVIit+DU/QjftGw/zNxqhyRaq+Z1vHs6hpBmoe6LEYCQiP+OoNlC0+nf5wRkRWJxYsrddApdC+OWJvMYworvCvS4AiQhpRV7j8vwexHmzYb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048870; c=relaxed/simple;
	bh=4h5RvzUHfWFOedWWLMmqE+khKK848X9NVyUEjTPnYMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB8U8WWGJrNWOGXy2oAYkvD2lKRJl2y7C62HtpNdCFeXWNbEMCLGtZf0uRLruh2mikxOKPUboajC7e560LlN2tNLRlbXo6y5PsBWahu8IOamjXhMTaxiegyqdrU9Md5R+FO0kvIZr3zICEmF1FVvAYxp9nonmh8Yxm38YWcsx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZ4aW0fT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZ4aW0fT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723048868; x=1754584868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4h5RvzUHfWFOedWWLMmqE+khKK848X9NVyUEjTPnYMo=;
  b=FZ4aW0fTVqZn3KANUghB1WV+jGFOC3CodFczOHdapt6+UrRr6O+eK3fv
   RRxukjaqaS5b8+AEX9EVCLvBYwahFJQCAVy6GCRgtNAvVanCx55rI2jDe
   2PjklpOnzfA0wMGo858Cc2k9vjkvFjFZUcPyldxyOKRtJSs3KGpmzjoRI
   aj+wQuy7UWfMuYtI8ep0oQBhFn5gj1KDUb/7tOkCZ/YxiLEtemrJwZ8jq
   G4hjcdGX3omM4/EACoMu/iEbXP48q/0e+lhMN6KB84weCFTlq6rznhgLM
   DcZY3Xzf5Z8jEAJgyuxnSZfW9u97kIZ+uwYdtE/rKasNMIYeOIwuQg1aa
   Q==;
X-CSE-ConnectionGUID: 2hdij+PrQ8iV13mhwi87+w==
X-CSE-MsgGUID: YMfEEtRuTPSbvIOwrP+5rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32534695"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32534695"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:41:07 -0700
X-CSE-ConnectionGUID: oje+9h1LQQ6ES8HD5dwD4g==
X-CSE-MsgGUID: 8xgeh91mSDq9bHZDnaf5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56581731"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 07 Aug 2024 09:41:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbjif-0005Ye-2d;
	Wed, 07 Aug 2024 16:41:01 +0000
Date: Thu, 8 Aug 2024 00:40:54 +0800
From: kernel test robot <lkp@intel.com>
To: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/3] dma: improve DMA zone selection
Message-ID: <202408080035.rXXbb5Yc-lkp@intel.com>
References: <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>

Hi Baruch,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Baruch-Siach/dma-improve-DMA-zone-selection/20240803-074651
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch%40tkos.co.il
patch subject: [PATCH v5 1/3] dma: improve DMA zone selection
config: csky-randconfig-001-20240807 (https://download.01.org/0day-ci/archive/20240808/202408080035.rXXbb5Yc-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080035.rXXbb5Yc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080035.rXXbb5Yc-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: dma_direct_optimal_gfp_mask+0x46 (section: .text) -> memblock_end_of_DRAM (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: sg_page.isra.0+0x1c (section: .text) -> memblock_end_of_DRAM (section: .init.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
