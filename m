Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745622FE561;
	Sat, 20 Sep 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369432; cv=none; b=sh3mQPC3H5LX36wsz43/3SFtEV1FE+9NGwY2kAJ8veDkD3BStMqVLHOlQ5JhrJ1saejM0Nq1NArAaiI39YOLBmRn8s1rcoRM+bEuuyoQkDe/x/Q7of/8Re9eZlvGAerwEN3+dB1a80qnhTNYaE3KhWmY5Hx+/7QbtKfv7Izevd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369432; c=relaxed/simple;
	bh=8eIVJEoHUAIRvD1gg14WYcW9cJd5BsuqTZpTJujtgI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4UcRaYWbSoj54CTvBCo0R+kXnU+5aegKbyViXF8FJl4Ss7uqdGJ0EII01GSZf/gyHo6Q/6M6ToNg2hVw6f5lsVfHb5UlWQJVyFa/huoqMVb79pKgGAsr3ykOKlSw9ozuv2hZcddLzIcllyBYfu3RlvJNMFu/7f6w4IONu4YmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHV1ZolW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHV1ZolW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758369430; x=1789905430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eIVJEoHUAIRvD1gg14WYcW9cJd5BsuqTZpTJujtgI8=;
  b=DHV1ZolWQATtvGp4UCaRlG2+Vu+pnSqjITxIu1BzrBv6bRFu3Ct5QPg1
   z5OC1Pq+zOgpXi0JMVMn7bTO8a7S9pjDMrtn+oVTX5ZpZ6P7wAhVRV0Hs
   l4krzIr/P9NnIwg9PDxechhwiOydWIegpZ0rT56lNufgoqr5U3T2WiXWn
   Kzq9vHlNgyP7q1jqu9g1vrqSKnTr7tPgoHTbCMfn5na48n60LR7ifdnyG
   QBCFVw216ywEx/j4SplPYrWe2LXjF6JOVySI6A4h4PDZ8PNAt+Z1pdiVK
   RBb8wKUja5jpqSWTRJlTHjxk3cBb7Cv+0R5DP6LSOCRL+2J+cAcqN6RTj
   A==;
X-CSE-ConnectionGUID: KT7AckI9RaasTuliCWSffw==
X-CSE-MsgGUID: o/SkmFBaSg69kXifEBXf5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="63328306"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="63328306"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 04:56:54 -0700
X-CSE-ConnectionGUID: GdGMHqegT/ekI/kvtyvU7Q==
X-CSE-MsgGUID: yhVq0D/mS1S/k52k8buX+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="176872093"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Sep 2025 04:56:52 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzwCw-0005J9-06;
	Sat, 20 Sep 2025 11:56:50 +0000
Date: Sat, 20 Sep 2025 19:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, praan@google.com,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <202509201953.E4CkTm6w-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.17-rc6 next-20250919]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mostafa-Saleh/iommu-io-pgtable-arm-Simplify-error-prints-for-selftests/20250919-213912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250919133316.2741279-5-smostafa%40google.com
patch subject: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
config: xtensa-randconfig-002-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201953.E4CkTm6w-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201953.E4CkTm6w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201953.E4CkTm6w-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: 0x84 (section: .text.unlikely) -> arm_lpae_dump_ops (section: .init.text)
>> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: arm_lpae_run_tests+0xa6 (section: .text.unlikely) -> arm_lpae_dump_ops (section: .init.text)
ERROR: modpost: "alloc_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
ERROR: modpost: "free_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y]) && !GENERIC_ATOMIC64 [=y]
   Selected by [m]:
   - IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST [=m] && IOMMU_SUPPORT [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
