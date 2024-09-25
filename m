Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3D8C13;
	Wed, 25 Sep 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227974; cv=none; b=liF2tJpJJMuEyWrUvOL0ki6f14lb+aacX0FMRzf8+sdeMdOe43qDhUKX0OdjKYVvUi0qNvCrwZyYwXLropnzt5n1Fj6a+9kXxsogLhlYdy6uh2ozISXA1i/ojCrJt9UZwhIsdtTtnh5qcEMbs1eIY0eEqjsC4m4KTXFjiY2lLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227974; c=relaxed/simple;
	bh=QHOhV4l/sSpY+xvgR+Aub/1IH+vrgOXo1BazWbBABZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPj44MvwFNgjeUn/HRR7sJtI7KNfMVsxyA6yCLW2GdMEqekAnJ4SA3C4H5Qn+hRCQ82+jKmeJ/+D4JKCYJ7dD3QVGe9eUidVFJMVeNmJoTbb5uK+zcOeliuvb2TbFySrzJ/yLON2qQ21JTBOKoHuMFqFh0tCi+pzr7jVhNZreFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nObxoDSs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nObxoDSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727227972; x=1758763972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHOhV4l/sSpY+xvgR+Aub/1IH+vrgOXo1BazWbBABZ0=;
  b=nObxoDSsTPCP2wUK1vZQ1HACE5IKsv/hfTYsxGf/tSo6cwvNMeRMUuID
   BKvJxoiagKEHKTRacpxnK3iPyDFXyfe8Tiehxv3J7SomcjWxqY5UjwiyD
   HxJGwsclhKkVDk7OAFbElgMMh7OVqSya85xOH46w7VfAAD2RwMBCleRu2
   5IUoXZLU3UzC5ZC8/y6s2AsUDpd1QEHMdVeEyI89Vt3+bgs4ZVfbbmYmg
   kQLjyhZgIkRZGUf+1s5+GCPQVQLuy4KDHujkffrBAEIKMwv9Wu3YWhGVn
   JmJ+0TaK3jYVfi6DEIOVYKrR1aKNbScC6nUP73FMNI1FyF8nn86e54Wwb
   w==;
X-CSE-ConnectionGUID: +XAGu6h5SoWCsAzkTflTgg==
X-CSE-MsgGUID: V/gsWC9XQ+WzXI+197+wrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26407464"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26407464"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 18:32:51 -0700
X-CSE-ConnectionGUID: goYXT0mZRTSlObor4H/w7g==
X-CSE-MsgGUID: Jdx69vpLRT+kdRjOeKK7WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71237342"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2024 18:32:50 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stGtb-000J1P-2B;
	Wed, 25 Sep 2024 01:32:47 +0000
Date: Wed, 25 Sep 2024 09:32:32 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 3/9] iommufd: pfn reader for file mappings
Message-ID: <202409250945.31YjGALI-lkp@intel.com>
References: <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>

Hi Steve,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steve-Sistare/iommufd-rename-uptr-in-iopt_alloc_iova/20240924-231223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/1727190338-385692-4-git-send-email-steven.sistare%40oracle.com
patch subject: [PATCH V2 3/9] iommufd: pfn reader for file mappings
config: arc-randconfig-001-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250945.31YjGALI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250945.31YjGALI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250945.31YjGALI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/iommufd/pages.c: In function 'pin_memfd_pages':
   drivers/iommu/iommufd/pages.c:772:25: error: implicit declaration of function 'folio_split_user_page_pin' [-Werror=implicit-function-declaration]
     772 |                         folio_split_user_page_pin(folio, npin);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/pages.c: In function 'pfn_reader_user_pin':
>> drivers/iommu/iommufd/pages.c:809:46: error: passing argument 1 of 'temp_kmalloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
     809 |                 user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
         |                                              ^~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              long unsigned int *
   drivers/iommu/iommufd/pages.c:74:35: note: expected 'size_t *' {aka 'unsigned int *'} but argument is of type 'long unsigned int *'
      74 | static void *temp_kmalloc(size_t *size, void *backup, size_t backup_len)
         |                           ~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/temp_kmalloc +809 drivers/iommu/iommufd/pages.c

   783	
   784	static int pfn_reader_user_pin(struct pfn_reader_user *user,
   785				       struct iopt_pages *pages,
   786				       unsigned long start_index,
   787				       unsigned long last_index)
   788	{
   789		bool remote_mm = pages->source_mm != current->mm;
   790		unsigned long npages = last_index - start_index + 1;
   791		unsigned long start, unum;
   792		uintptr_t uptr;
   793		long rc;
   794	
   795		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
   796		    WARN_ON(last_index < start_index))
   797			return -EINVAL;
   798	
   799		if (!user->upages) {
   800			/* All undone in pfn_reader_destroy() */
   801			user->upages_len = npages * sizeof(*user->upages);
   802			user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
   803			if (!user->upages)
   804				return -ENOMEM;
   805		}
   806	
   807		if (user->file && !user->ufolios) {
   808			user->ufolios_len = npages * sizeof(*user->ufolios);
 > 809			user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
   810			if (!user->ufolios)
   811				return -ENOMEM;
   812	
   813			/* Bail for now.  Be more robust when we optimize for folios. */
   814			if (user->ufolios_len / sizeof(*user->ufolios) <
   815			    user->upages_len / sizeof(*user->upages))
   816				return -ENOMEM;
   817		}
   818	
   819		if (!user->file && user->locked == -1) {
   820			/*
   821			 * The majority of usages will run the map task within the mm
   822			 * providing the pages, so we can optimize into
   823			 * get_user_pages_fast()
   824			 */
   825			if (remote_mm) {
   826				if (!mmget_not_zero(pages->source_mm))
   827					return -EFAULT;
   828			}
   829			user->locked = 0;
   830		}
   831	
   832		unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
   833				    user->upages_len / sizeof(*user->upages);
   834		npages = min_t(unsigned long, npages, unum);
   835	
   836		if (iommufd_should_fail())
   837			return -EFAULT;
   838	
   839		if (user->file) {
   840			start = pages->start + (start_index * PAGE_SIZE);
   841			rc = pin_memfd_pages(user, start, npages);
   842		} else if (!remote_mm) {
   843			uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
   844			rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
   845						 user->upages);
   846		} else {
   847			uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
   848			if (!user->locked) {
   849				mmap_read_lock(pages->source_mm);
   850				user->locked = 1;
   851			}
   852			rc = pin_user_pages_remote(pages->source_mm, uptr, npages,
   853						   user->gup_flags, user->upages,
   854						   &user->locked);
   855		}
   856		if (rc <= 0) {
   857			if (WARN_ON(!rc))
   858				return -EFAULT;
   859			return rc;
   860		}
   861		iopt_pages_add_npinned(pages, rc);
   862		user->upages_start = start_index;
   863		user->upages_end = start_index + rc;
   864		return 0;
   865	}
   866	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
