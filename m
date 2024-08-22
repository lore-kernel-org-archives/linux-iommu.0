Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE943AC4;
	Thu, 22 Aug 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724303313; cv=none; b=Jt/HkhnNtvLnMAWFH6Aw+uKv/ZiwVuFQDi8VV7b3EFRZXQEnmCY0MnY5Zv4XIj+LipJJprDZUOMyYQCGcSywES033DlGnh/V1NRP/9Cr5cpdCY7cR5Tch2tJMfwykLMw4gfpMMjrSzWFZ8QJ9Tw6yQQ1y4BN+hjY6odkQB1lNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724303313; c=relaxed/simple;
	bh=9s8j/0U1Jhir7fV9eKqMzHlUJDO/aJdbFozQaf90hPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcaBXfaIRLDEqm2mpnPbxMvkZsEZrPmiJ2pIaV+EEteo8lseyo7wXuEDlzx0BBCOdXNVszFnFTEnm2fo7yjbSGBxdA8AZT10d7hKvEXNDL9HUjyE0iO9dgZcEifxO9RT/1lSo3Yi2U+4Adph0Dcrr7SDEE3Pzi/DPm/bf3HmCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLduqfUa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLduqfUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724303312; x=1755839312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9s8j/0U1Jhir7fV9eKqMzHlUJDO/aJdbFozQaf90hPI=;
  b=lLduqfUaUU37U3BCRjKZp4H5QQWkBuMPw3yf7wdDRXoMXyKTJowegEq9
   3Z1JnYKLYlHQMXUyuAcLubZthYGqTnKfJtXUmZ6iM6KWLXzxYwsoWCEGo
   29f6Tgf+HVLBYVsKMjc0BPE3/4xuqgBoy3AfzXdOVtl1eiLJPk5MTYveg
   xyS3hw6WT938jjJvOGIdUZpbNXTMfM+5zg0fXSGm3f+UWL50cxb40+kDj
   LqGSi+YiImjX9V8sZk2TzsQVwjV912/WuXqMh4DIV5GC9jbQrSO0ZHZpJ
   Pd+ewKLmsJsKhBTOarB5BMG+xt9bNyR3RYLlq3tb4t0WX7alGV7oCxEZJ
   A==;
X-CSE-ConnectionGUID: 53oYOAs3QmmdP9byByLHTg==
X-CSE-MsgGUID: fHTnwZQ8S6a9BelZb4FYXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22220598"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22220598"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 22:08:31 -0700
X-CSE-ConnectionGUID: Ll+V9ESJSYa5NnhmDzMx+g==
X-CSE-MsgGUID: jJlpNQm4SfmByS0djTzCYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66135195"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Aug 2024 22:08:29 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh03e-000CP8-0r;
	Thu, 22 Aug 2024 05:08:26 +0000
Date: Thu, 22 Aug 2024 13:07:49 +0800
From: kernel test robot <lkp@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org
Cc: oe-kbuild-all@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <202408221237.HWmdmfvc-lkp@intel.com>
References: <20240821133554.7405-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133554.7405-2-vasant.hegde@amd.com>

Hi Vasant,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc4 next-20240821]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasant-Hegde/iommu-Enhance-domain-allocation-code-to-take-additional-flags/20240821-214124
base:   linus/master
patch link:    https://lore.kernel.org/r/20240821133554.7405-2-vasant.hegde%40amd.com
patch subject: [PATCH 1/5] iommu: Enhance domain allocation code to take additional flags
config: x86_64-randconfig-075-20240822 (https://download.01.org/0day-ci/archive/20240822/202408221237.HWmdmfvc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221237.HWmdmfvc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221237.HWmdmfvc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <command-line>:
   include/linux/compiler_types.h:236:16: error: expected '{' before 'inline'
     236 | #define inline inline __gnu_inline __inline_maybe_unused notrace
         |                ^~~~~~
   include/linux/iommu.h:1103:8: note: in expansion of macro 'inline'
    1103 | struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
         |        ^~~~~~
>> include/linux/compiler_types.h:236:16: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     236 | #define inline inline __gnu_inline __inline_maybe_unused notrace
         |                ^~~~~~
   include/linux/iommu.h:1103:8: note: in expansion of macro 'inline'
    1103 | struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
         |        ^~~~~~


vim +/inline +236 include/linux/compiler_types.h

71391bdd2e9aab Xiaozhou Liu    2018-12-14  228  
71391bdd2e9aab Xiaozhou Liu    2018-12-14  229  /*
71391bdd2e9aab Xiaozhou Liu    2018-12-14  230   * Prefer gnu_inline, so that extern inline functions do not emit an
71391bdd2e9aab Xiaozhou Liu    2018-12-14  231   * externally visible function. This makes extern inline behave as per gnu89
71391bdd2e9aab Xiaozhou Liu    2018-12-14  232   * semantics rather than c99. This prevents multiple symbol definition errors
71391bdd2e9aab Xiaozhou Liu    2018-12-14  233   * of extern inline functions at link time.
71391bdd2e9aab Xiaozhou Liu    2018-12-14  234   * A lot of inline functions can cause havoc with function tracing.
71391bdd2e9aab Xiaozhou Liu    2018-12-14  235   */
889b3c1245de48 Masahiro Yamada 2020-04-06 @236  #define inline inline __gnu_inline __inline_maybe_unused notrace
71391bdd2e9aab Xiaozhou Liu    2018-12-14  237  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
