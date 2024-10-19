Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3113C682;
	Sat, 19 Oct 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729363376; cv=none; b=O3t1WHttDIGec68DOXhLlgpwpJqcUidkn8WqDN7otySTzm3yVOrJI97K7hflhJEMBdE5VcLQmeK0EF2RJiS57q8hOtcCA6nPtKItc0MeCEa5KpX71JXgJD01oCebdf55jz4kNYFhEPJspdYR5UUMdfku+jxvaSOlLVFOxZa8W5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729363376; c=relaxed/simple;
	bh=FXSuO3b4NxEtMsI5CXXfnk89nMhmsvd4lNTyl2o1u5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBLtFYi7Ed5oNC/bNNgNi7nPUowEnzWk/PeUsiSoRuqArwjJ/1sxa7LqDEow03gHOA1N7pEOoUXMFglZQ5uXVb+Hi9kqqxWLAB2uCt1aSlTsrDior3NhWI9oJvEiG0WfsQKz0Xj1frHNSU9HE0a5snNv2uT17yUoc0RR8Hw3O+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eK//fGcA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eK//fGcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729363374; x=1760899374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXSuO3b4NxEtMsI5CXXfnk89nMhmsvd4lNTyl2o1u5Q=;
  b=eK//fGcAdVb4TiDqNyBJ20wT1asnhu/c3Xehhc+Y8cacA2Le5GZBBGi1
   y1GgkZbCee3qlox7rbmr1AT9mfDgpHo4NBNNj7LaloKh5YCmelXuT7yW3
   UhaLYlDc0BDvxm4RexnL8MZJg3jYnNifnNa93jychGRb8oz1B0H8F0W/L
   G1vzpdSg98hnbNFPaj1VrKyBYtSrlUs7hfTck2HvMHAbhr7LdOIk29tvC
   gyrrTW9PvSGIi8Iu5PW0Rmye/yVtgbnjQeN++APxxWtcGc9BAPioaogJc
   TlYeptL3uqpyqEazbNJfqdfa4Vlc6bGEX3pAyVxmbu5zNd6aTD1JxiJx8
   A==;
X-CSE-ConnectionGUID: nj+1Ir3uTqSpXuQrl9vOeg==
X-CSE-MsgGUID: qR+JnIabQHmpZ7FVftHDhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28837160"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28837160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 11:42:53 -0700
X-CSE-ConnectionGUID: h1f0RtyuS9ultywJks+2bg==
X-CSE-MsgGUID: vuCYtW8hQF6KecNxONarkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79111734"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2024 11:42:52 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2EPZ-000PQF-0x;
	Sat, 19 Oct 2024 18:42:49 +0000
Date: Sun, 20 Oct 2024 02:41:57 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V4 6/9] iommufd: pfn reader for file mappings
Message-ID: <202410200205.mriS8xuS-lkp@intel.com>
References: <1729286856-127844-7-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729286856-127844-7-git-send-email-steven.sistare@oracle.com>

Hi Steve,

kernel test robot noticed the following build errors:

[auto build test ERROR on e2d8fe9148b79ed1cbf0663edc988db7769173dc]

url:    https://github.com/intel-lab-lkp/linux/commits/Steve-Sistare/mm-gup-folio_add_pins/20241019-053644
base:   e2d8fe9148b79ed1cbf0663edc988db7769173dc
patch link:    https://lore.kernel.org/r/1729286856-127844-7-git-send-email-steven.sistare%40oracle.com
patch subject: [PATCH V4 6/9] iommufd: pfn reader for file mappings
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241020/202410200205.mriS8xuS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200205.mriS8xuS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410200205.mriS8xuS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/iommufd/pages.c: In function 'pfn_reader_user_pin':
>> drivers/iommu/iommufd/pages.c:886:46: error: passing argument 1 of 'temp_kmalloc' from incompatible pointer type [-Wincompatible-pointer-types]
     886 |                 user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
         |                                              ^~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              long unsigned int *
   drivers/iommu/iommufd/pages.c:74:35: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      74 | static void *temp_kmalloc(size_t *size, void *backup, size_t backup_len)
         |                           ~~~~~~~~^~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/temp_kmalloc +886 drivers/iommu/iommufd/pages.c

   859	
   860	static int pfn_reader_user_pin(struct pfn_reader_user *user,
   861				       struct iopt_pages *pages,
   862				       unsigned long start_index,
   863				       unsigned long last_index)
   864	{
   865		bool remote_mm = pages->source_mm != current->mm;
   866		unsigned long npages = last_index - start_index + 1;
   867		unsigned long start;
   868		unsigned long unum;
   869		uintptr_t uptr;
   870		long rc;
   871	
   872		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
   873		    WARN_ON(last_index < start_index))
   874			return -EINVAL;
   875	
   876		if (!user->file && !user->upages) {
   877			/* All undone in pfn_reader_destroy() */
   878			user->upages_len = npages * sizeof(*user->upages);
   879			user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
   880			if (!user->upages)
   881				return -ENOMEM;
   882		}
   883	
   884		if (user->file && !user->ufolios) {
   885			user->ufolios_len = npages * sizeof(*user->ufolios);
 > 886			user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
   887			if (!user->ufolios)
   888				return -ENOMEM;
   889		}
   890	
   891		if (user->locked == -1) {
   892			/*
   893			 * The majority of usages will run the map task within the mm
   894			 * providing the pages, so we can optimize into
   895			 * get_user_pages_fast()
   896			 */
   897			if (!user->file && remote_mm) {
   898				if (!mmget_not_zero(pages->source_mm))
   899					return -EFAULT;
   900			}
   901			user->locked = 0;
   902		}
   903	
   904		unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
   905				    user->upages_len / sizeof(*user->upages);
   906		npages = min_t(unsigned long, npages, unum);
   907	
   908		if (iommufd_should_fail())
   909			return -EFAULT;
   910	
   911		if (user->file) {
   912			start = pages->start + (start_index * PAGE_SIZE);
   913			rc = pin_memfd_pages(user, start, npages);
   914		} else if (!remote_mm) {
   915			uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
   916			rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
   917						 user->upages);
   918		} else {
   919			uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
   920			if (!user->locked) {
   921				mmap_read_lock(pages->source_mm);
   922				user->locked = 1;
   923			}
   924			rc = pin_user_pages_remote(pages->source_mm, uptr, npages,
   925						   user->gup_flags, user->upages,
   926						   &user->locked);
   927		}
   928		if (rc <= 0) {
   929			if (WARN_ON(!rc))
   930				return -EFAULT;
   931			return rc;
   932		}
   933		iopt_pages_add_npinned(pages, rc);
   934		user->upages_start = start_index;
   935		user->upages_end = start_index + rc;
   936		return 0;
   937	}
   938	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
