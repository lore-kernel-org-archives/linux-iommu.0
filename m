Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D4396B9D;
	Fri, 16 Oct 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139147; cv=none; b=qffEZL3swmZYK3hv8FnA8thR3JEYKhdGHfq73JO9FV0yn+xq96jLC+u2yHr3JxF6or2j+O5LCOqAN535BemW2wE2+yNkOonKnugiQjjtdyB+TwehlPMWV+DZQxHcmvVHh5PIIFeeg/WmlMS1Yp1nrmkJP4r+7ioo8/u3Te6baW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139147; c=relaxed/simple;
	bh=KAfd8tRH2E+vvJpLkFEh63/NAmBOZN4lDvDMX9uzf5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi/XvUgdEax3kCdfGILZS4OA+sW3AG0qu5VhsyWkxCt8fnzM8UmnlSC5+696oSQlNnGcs90M0zCBVTcau6fegMZGsZ/1jTk+SdvLN/acJrIfwz5UeswCvr4P+qVfKu9cXkZeJ+RZUcVRtl7+ZZGY5fy4LplvXuu91Pxfv4fUEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoR2383t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoR2383t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792139146; x=1823675146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAfd8tRH2E+vvJpLkFEh63/NAmBOZN4lDvDMX9uzf5s=;
  b=AoR2383tIJnDYyU0qzY3sDPTyeKQOpgfCgFPtjKL4/lNhDCP580XnG+U
   Sohew1udjwNOdLkyE17mvquC0a1wePHYSy67fUowHCWaXylNw9GBgr48O
   C97ngCow8v7TC1EIp/sj0By3znjYii9RVpkfKiZgIjlDIc5miv6pUT9dh
   qiKeb4rgbm5xEddgJ5/14SA0BMigBOacifGvWtV+NruHdqfNITXpLj1wX
   3+UJh3N0shlYeEQiZW8Tw0HCP4oRQBYdAPijJfMBIxemzv30IG8PWJrvp
   sWXEj9/gNJvtrpRy5ZGDlsCQ6fqCK0+oLZZYsmxVrFTOOHr8YK8Qtp5xa
   Q==;
X-CSE-ConnectionGUID: xCkuKGpfR2GMF8K5hslBXw==
X-CSE-MsgGUID: /FX5izdURLWXpsPi5RZMrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="812315"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="812315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 01:23:27 -0700
X-CSE-ConnectionGUID: u5J2rt91RgyRRrpNhQby/w==
X-CSE-MsgGUID: kNfHIRW4RAm85ARoSZ/D7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2143052"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2026 01:23:20 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHdDg-00000000HtS-105i;
	Fri, 16 Oct 2026 08:23:16 +0000
Date: Fri, 16 Oct 2026 16:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Kiryl Shutsemau <kas@kernel.org>,
	Li RongQing <lirongqing@baidu.com>, Marco Elver <elver@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v5 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Message-ID: <202610161625.7iSczyVo-lkp@intel.com>
References: <20261015064515.10700-8-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015064515.10700-8-sarunkod@amd.com>

Hi Sairaj,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4056b3c9d3c92ea45955641dbafeb9b960e146ef]

url:    https://github.com/intel-lab-lkp/linux/commits/Sairaj-Kodilkar/iommu-amd-KVM-SVM-Rename-cpu-to-apicid-in-IOMMU-interface/20261015-121509
base:   4056b3c9d3c92ea45955641dbafeb9b960e146ef
patch link:    https://lore.kernel.org/r/20261015064515.10700-8-sarunkod%40amd.com
patch subject: [PATCH v5 7/7] iommu/amd: Provide kernel command line option to enable GAPPI
config: x86_64-randconfig-1017-20261016 (https://download.01.org/0day-ci/archive/20261016/202610161625.7iSczyVo-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610161625.7iSczyVo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610161625.7iSczyVo-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/amd/init.c:163:6: error: redefinition of 'false' as different kind of symbol
     163 | bool amd_iommu_gappi;
         |      ^
   include/linux/amd-iommu.h:65:25: note: expanded from macro 'amd_iommu_gappi'
      65 | #define amd_iommu_gappi false
         |                         ^
   include/linux/stddef.h:11:2: note: previous definition is here
      11 |         false   = 0,
         |         ^
   drivers/iommu/amd/init.c:164:15: error: redefinition of 'false' as different kind of symbol
     164 | EXPORT_SYMBOL(amd_iommu_gappi);
         |               ^
   include/linux/amd-iommu.h:65:25: note: expanded from macro 'amd_iommu_gappi'
      65 | #define amd_iommu_gappi false
         |                         ^
   include/linux/stddef.h:11:2: note: previous definition is here
      11 |         false   = 0,
         |         ^
   drivers/iommu/amd/init.c:164:1: error: cannot take the address of an rvalue of type 'int'
     164 | EXPORT_SYMBOL(amd_iommu_gappi);
         | ^             ~~~~~~~~~~~~~~~
   include/linux/export.h:89:29: note: expanded from macro 'EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^              ~~~
   include/linux/export.h:86:38: note: expanded from macro '_EXPORT_SYMBOL'
      86 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^               ~~~
   include/linux/export.h:77:2: note: expanded from macro '__EXPORT_SYMBOL'
      77 |         __ADDRESSABLE(sym)                                      \
         |         ^             ~~~
   include/linux/compiler.h:276:2: note: expanded from macro '__ADDRESSABLE'
     276 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^              ~~~
   include/linux/compiler.h:273:63: note: expanded from macro '___ADDRESSABLE'
     273 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |                                                                      ^~~~
>> drivers/iommu/amd/init.c:3804:20: error: expression is not assignable
    3804 |                         amd_iommu_gappi = true;
         |                         ~~~~~~~~~~~~~~~ ^
   4 errors generated.


vim +3804 drivers/iommu/amd/init.c

  3775	
  3776	static int __init parse_amd_iommu_options(char *str)
  3777	{
  3778		if (!str)
  3779			return -EINVAL;
  3780	
  3781		while (*str) {
  3782			if (strncmp(str, "fullflush", 9) == 0) {
  3783				pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
  3784				iommu_set_dma_strict();
  3785			} else if (strncmp(str, "force_enable", 12) == 0) {
  3786				amd_iommu_force_enable = true;
  3787			} else if (strncmp(str, "off", 3) == 0) {
  3788				amd_iommu_disabled = true;
  3789			} else if (strncmp(str, "force_isolation", 15) == 0) {
  3790				amd_iommu_force_isolation = true;
  3791			} else if (strncmp(str, "pgtbl_v1", 8) == 0) {
  3792				amd_iommu_pgtable = PD_MODE_V1;
  3793			} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
  3794				amd_iommu_pgtable = PD_MODE_V2;
  3795			} else if (strncmp(str, "irtcachedis", 11) == 0) {
  3796				amd_iommu_irtcachedis = true;
  3797			} else if (strncmp(str, "nohugepages", 11) == 0) {
  3798				pr_info("Restricting V1 page-sizes to 4KiB");
  3799				amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
  3800			} else if (strncmp(str, "v2_pgsizes_only", 15) == 0) {
  3801				pr_info("Restricting V1 page-sizes to 4KiB/2MiB/1GiB");
  3802				amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
  3803			} else if (strncmp(str, "gappi", 5) == 0) {
> 3804				amd_iommu_gappi = true;
  3805			} else {
  3806				pr_notice("Unknown option - '%s'\n", str);
  3807			}
  3808	
  3809			str += strcspn(str, ",");
  3810			while (*str == ',')
  3811				str++;
  3812		}
  3813	
  3814		return 1;
  3815	}
  3816	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
