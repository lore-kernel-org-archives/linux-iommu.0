Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7A946F;
	Wed, 25 Sep 2024 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727231028; cv=none; b=NPLkHQ11TLRPzMR32iTZWYRrpbgHxDB8Y5zX6OHHb8Pg+WjLt1c03FTJec0Eq+VLAQNAi2CYJv6Hk2jHayoktJbMhu3SVjvk116UiAtpKAX+2qJkTEvZ/yjahCzQcZXTQJgbwYh6wbM42+QDLysOHKZ5oTl+6WUBtOFqrKCAEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727231028; c=relaxed/simple;
	bh=/YlGWyulUM98izQIes2mLPmt8hy/HU85Sy5hLTCEIU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx8gFD4mnM7iRXeRofIVJs3d0giAVWhqHJuHzY8rTrc1Ws2MPFw38s5nmPpwiOcAnFPwg35/dfpc1IDziZ7mjHnI20r7zvyn9UAGjLl/VxTX8bEZfmkDKAvuJF9X36zIy+17n/Q4VDxp/slzPwSDNgqQgBZIsgz18EYN2fXcXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDwuVqYh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDwuVqYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727231026; x=1758767026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YlGWyulUM98izQIes2mLPmt8hy/HU85Sy5hLTCEIU8=;
  b=gDwuVqYhxUSBAs+et0Ne5PYscOkeDzAB/Xo3GCbqEXQHBh6xfRo4ZDXR
   lB2+nhadMqxkuODiciEM4sd1GT+fN8Mq7I+HxhrUttitWYbmkFeyLdP0B
   ZTyt7qeznxzt/lcaid5fiLxgvkghpivNM9FKsfQ7P6hkxTJV9kt2a92i3
   UabIBiaQjmyQzw245m5BZyTKWo7NYRXSj43ussDr/rLecMkopva0+5/mN
   I6l8IhSQcBAtMk5Fxl2+q6load7xlxnSq8dIvCgKMDfvqwtPHmSOqodSs
   8xXcK1gOFwuMwB0ntugz0at6zTrpqiN4fwoYETCDKvCPztutflqvfU8+E
   A==;
X-CSE-ConnectionGUID: /vUWdHFORd+IozFUyHPmYA==
X-CSE-MsgGUID: 8DMlf35BTuS5RycteQ0VoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37634844"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="37634844"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:23:45 -0700
X-CSE-ConnectionGUID: NBfBahSVQAyje0HDo6yTXA==
X-CSE-MsgGUID: ia0rOS/CQFmuWswycvmQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71914301"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Sep 2024 18:55:50 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stHFs-000J21-0r;
	Wed, 25 Sep 2024 01:55:48 +0000
Date: Wed, 25 Sep 2024 09:55:18 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 3/9] iommufd: pfn reader for file mappings
Message-ID: <202409250951.qvaDPgeE-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250951.qvaDPgeE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250951.qvaDPgeE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250951.qvaDPgeE-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/iommufd/pages.c:772:4: error: call to undeclared function 'folio_split_user_page_pin'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     772 |                         folio_split_user_page_pin(folio, npin);
         |                         ^
>> drivers/iommu/iommufd/pages.c:809:32: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'size_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
     809 |                 user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
         |                                              ^~~~~~~~~~~~~~~~~~
   drivers/iommu/iommufd/pages.c:74:35: note: passing argument to parameter 'size' here
      74 | static void *temp_kmalloc(size_t *size, void *backup, size_t backup_len)
         |                                   ^
   2 errors generated.


vim +809 drivers/iommu/iommufd/pages.c

   746	
   747	static long pin_memfd_pages(struct pfn_reader_user *user,
   748				    unsigned long start,
   749				    unsigned long npages)
   750	{
   751		unsigned long end, nr, i, j, npin, offset, npages_out;
   752		long nfolios;
   753		struct folio *folio;
   754		struct page **upages = user->upages;
   755	
   756		nfolios = user->ufolios_len / sizeof(*user->ufolios);
   757		end = start + (npages << PAGE_SHIFT) - 1;
   758	
   759		nfolios = memfd_pin_folios(user->file, start, end,
   760					   user->ufolios, nfolios, &offset);
   761		if (nfolios <= 0)
   762			return nfolios;
   763	
   764		offset >>= PAGE_SHIFT;
   765		npages_out = 0;
   766	
   767		for (i = 0; i < nfolios; i++) {
   768			folio = user->ufolios[i];
   769			nr = folio_nr_pages(folio);
   770			npin = min(nr - offset, npages);
   771			if (nr > 1) {
 > 772				folio_split_user_page_pin(folio, npin);
   773			}
   774			for (j = offset; j < offset + npin; j++)
   775				*upages++ = folio_page(folio, j);
   776			npages -= npin;
   777			npages_out += npin;
   778			offset = 0;
   779		}
   780	
   781		return npages_out;
   782	}
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
