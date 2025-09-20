Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA4189;
	Sat, 20 Sep 2025 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365029; cv=none; b=hWfPTeQLGtNdECth28+MUKYUyNvIT1Ir+miZnV16Twf5CXtVF9ksRV4LEIFWPBNEhqrCdgJ3v7h2HX2b6w9j8hNs6DCuPoKvcPRH3D1Q0YQiupE8SwN6unxeJ1Xybt5N+EKpwfbhEApuIeHFIECrloCaVvxh02zF8fnx+IbFZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365029; c=relaxed/simple;
	bh=GGcqmDnzpkqL527dvwmPXxPejn0tRqSqA9TUjS43tF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nskA3uEHcnh1OBobFiqmIDeK60nq1kx2btKsYc94zQlHex3ojFVVmaQS8MdvUJSWjo+28uFgXtqstJx+coX38EJ1y4LoxF8Iuin1uj9L2AaeQRFUWAZ+E3XHXvcbgtq3xflXpebmi1XdbN/6mmQH4TrNfqYOL7DpVBq7f0K/7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvwsPLUG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvwsPLUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758365027; x=1789901027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GGcqmDnzpkqL527dvwmPXxPejn0tRqSqA9TUjS43tF4=;
  b=RvwsPLUGGkpas4Af9x/r5HlwLWaJtYoTajlTw+LgxyDkU95+s9wvQl8Y
   rO/UBIS8JevIbajVuSE0s0RgQhRBoeO4vU3HsaX4yTda8VWak+ZIuzDWd
   keSgo7CLHFTZhJSL5lmUBQ9MPLY3h1iNpBh6odlHeGP6uon0M508jzzVn
   HS9l6dJ2KHdxpJO2vDR3RWPk0DWwF1m5LWwxS1zWQLSwhRTrYKbb4Bs0D
   dBI0nsr9ZbJ0x/mXMsualDaXTjH0PAachautfB1zyf0ImHu6LFujjc7I5
   zMFHYbB7HMImaqVmGL+aU07wUuEP92n+OqcjFL3F/+FL3zwEmmACp/0FH
   w==;
X-CSE-ConnectionGUID: GYRtlDgQR6aNp0NU96TPng==
X-CSE-MsgGUID: sby7IT5ZQ8CWZK7/2ml9xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="64334371"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="64334371"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 03:43:47 -0700
X-CSE-ConnectionGUID: ka3svwETTDyUeiqFLjtQ7A==
X-CSE-MsgGUID: KLR2Z4G+SdK4f8cCYhbYAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="180446374"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Sep 2025 03:43:44 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzv49-0005EB-1x;
	Sat, 20 Sep 2025 10:43:41 +0000
Date: Sat, 20 Sep 2025 18:42:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, praan@google.com,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <202509201819.f369wBHc-lkp@intel.com>
References: <20250919133316.2741279-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919133316.2741279-5-smostafa@google.com>

Hi Mostafa,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.17-rc6 next-20250919]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mostafa-Saleh/iommu-io-pgtable-arm-Simplify-error-prints-for-selftests/20250919-213912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250919133316.2741279-5-smostafa%40google.com
patch subject: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
config: i386-randconfig-013-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201819.f369wBHc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201819.f369wBHc-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: arm_lpae_run_tests+0x100 (section: .text) -> arm_lpae_dump_ops (section: .init.text)
>> ERROR: modpost: "alloc_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
>> ERROR: modpost: "free_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
   Selected by [m]:
   - IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST [=m] && IOMMU_SUPPORT [=y] && KUNIT [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
