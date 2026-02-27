Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927562DA749;
	Fri, 27 Feb 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229909; cv=none; b=agikgToP0/OCar0XUTye/niS8N7gi+bvRDJYpaJ19LataZChzcd3sPn3cA3EUFV6SK7Nvjo7FrgFSnstDhG8CHKGBvavyE1ADIHc5A6QKiCEYtUxFbjJ8Y2iCd+xFsq0tbnXh9+Mi3TPTFnW4a1g7/b6hX1ag5Xv/p1DmPxu6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229909; c=relaxed/simple;
	bh=OqC1qVonI3zooIRbnQOaB86/3JV6TnHargoagHhcWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXlqA9zYvUk7B2N4IX/BrWKtZksK8UaMjKNc3NdQuj3606OdjzK9pX16LfY2k6jbnul/T9z2Jfo2mvTvMCiAU04kfj4BWaVni8wxAnnIUa9F6gZk5SuEEaqYB9X6oqMOaCgiBROzriWjP6LhLsi/GClgPWWfWQnobj+p4ErAPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLjABu7k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLjABu7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772229908; x=1803765908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OqC1qVonI3zooIRbnQOaB86/3JV6TnHargoagHhcWYg=;
  b=MLjABu7kwFTwpVm9nh6JH3WRN9SCDwbZq46PCwSSb+itQr3znTmhZUU9
   joPlAVFzSavZ13dicMuu2OKWfYV45hAjTGU+u6rkVon6PT43UNpuezr39
   EUmBxc7Ws2DmAhWcCUEiWyO7CcjkILxuzxx3yAoW3uhWvdX5RQpcMavBY
   /rUXYwzQ7ju4Coqd/FNaqdQCoDJBgrE/ZQX1iOxyeMhrWvDfexI9i3ADP
   2ILa52k1DfPYeG3DF6y+mnFec9ouebxSRbbyC80abTBXUmtdMpWkQ9JdN
   J6Kq9GT4tg4H2vZ6LaxxdhkBdpdUsH8CZS5lCklYrdLK3JQEzV1vbYJUd
   A==;
X-CSE-ConnectionGUID: mO8r/veHQlGumbqr4bhwgQ==
X-CSE-MsgGUID: wn7EzqFGS1SAG82IMLYYYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73191580"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73191580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 14:05:07 -0800
X-CSE-ConnectionGUID: /Pw3yY2aTlayek20ToBb9A==
X-CSE-MsgGUID: WhXEGy70Q1yQAmg2taSFfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="247522477"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2026 14:05:02 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw5wp-00000000B6X-0lcN;
	Fri, 27 Feb 2026 22:04:44 +0000
Date: Sat, 28 Feb 2026 06:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <202602280557.4SdsBbeJ-lkp@intel.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>

Hi Jacob,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc1 next-20260227]
[cannot apply to awilliam-vfio/next awilliam-vfio/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommufd-Support-a-HWPT-without-an-iommu-driver-for-noiommu/20260228-020145
base:   linus/master
patch link:    https://lore.kernel.org/r/20260227175247.26103-9-jacob.pan%40linux.microsoft.com
patch subject: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
config: sh-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260228/202602280557.4SdsBbeJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280557.4SdsBbeJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280557.4SdsBbeJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/iommu/generic_pt/fmt/iommu_template.h:36,
                    from drivers/iommu/generic_pt/fmt/iommu_amdv1.c:15:
   drivers/iommu/generic_pt/fmt/amdv1.h: In function 'amdv1pt_install_table':
>> drivers/iommu/generic_pt/fmt/amdv1.h:255:16: error: implicit declaration of function 'pt_table_install64'; did you mean 'pt_table_install32'? [-Wimplicit-function-declaration]
     255 |         return pt_table_install64(pts, entry);
         |                ^~~~~~~~~~~~~~~~~~
         |                pt_table_install32
   In file included from include/linux/atomic.h:80,
                    from drivers/iommu/generic_pt/fmt/../pt_defs.h:17,
                    from drivers/iommu/generic_pt/fmt/iommu_template.h:35:
   drivers/iommu/generic_pt/fmt/amdv1.h: In function 'amdv1pt_entry_make_write_dirty':
>> include/linux/atomic/atomic-arch-fallback.h:259:14: error: invalid use of void expression
     259 |         ___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
         |              ^
   include/linux/atomic/atomic-instrumented.h:4918:9: note: in expansion of macro 'raw_try_cmpxchg64'
    4918 |         raw_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~
   drivers/iommu/generic_pt/fmt/amdv1.h:318:16: note: in expansion of macro 'try_cmpxchg64'
     318 |         return try_cmpxchg64(tablep, &pts->entry, new);
         |                ^~~~~~~~~~~~~
>> drivers/iommu/generic_pt/fmt/amdv1.h:316:13: warning: unused variable 'new' [-Wunused-variable]
     316 |         u64 new = pts->entry | AMDV1PT_FMT_D;
         |             ^~~
--
   In file included from generic_pt/fmt/iommu_template.h:36,
                    from generic_pt/fmt/iommu_amdv1.c:15:
   generic_pt/fmt/amdv1.h: In function 'amdv1pt_install_table':
   generic_pt/fmt/amdv1.h:255:16: error: implicit declaration of function 'pt_table_install64'; did you mean 'pt_table_install32'? [-Wimplicit-function-declaration]
     255 |         return pt_table_install64(pts, entry);
         |                ^~~~~~~~~~~~~~~~~~
         |                pt_table_install32
   In file included from include/linux/atomic.h:80,
                    from generic_pt/fmt/../pt_defs.h:17,
                    from generic_pt/fmt/iommu_template.h:35:
   generic_pt/fmt/amdv1.h: In function 'amdv1pt_entry_make_write_dirty':
>> include/linux/atomic/atomic-arch-fallback.h:259:14: error: invalid use of void expression
     259 |         ___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
         |              ^
   include/linux/atomic/atomic-instrumented.h:4918:9: note: in expansion of macro 'raw_try_cmpxchg64'
    4918 |         raw_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~
   generic_pt/fmt/amdv1.h:318:16: note: in expansion of macro 'try_cmpxchg64'
     318 |         return try_cmpxchg64(tablep, &pts->entry, new);
         |                ^~~~~~~~~~~~~
   generic_pt/fmt/amdv1.h:316:13: warning: unused variable 'new' [-Wunused-variable]
     316 |         u64 new = pts->entry | AMDV1PT_FMT_D;
         |             ^~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_PT
   Depends on [n]: IOMMU_SUPPORT [=n] && GENERIC_PT [=y]
   Selected by [y]:
   - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]
   WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
   Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y] && !GENERIC_ATOMIC64 [=y]
   Selected by [y]:
   - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]


vim +255 drivers/iommu/generic_pt/fmt/amdv1.h

879ced2bab1ba9 Jason Gunthorpe 2025-11-04  236  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  237  static inline bool amdv1pt_install_table(struct pt_state *pts,
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  238  					 pt_oaddr_t table_pa,
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  239  					 const struct pt_write_attrs *attrs)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  240  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  241  	u64 entry;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  242  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  243  	/*
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  244  	 * IR and IW are ANDed from the table levels along with the PTE. We
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  245  	 * always control permissions from the PTE, so always set IR and IW for
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  246  	 * tables.
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  247  	 */
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  248  	entry = AMDV1PT_FMT_PR |
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  249  		FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL, pts->level) |
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  250  		FIELD_PREP(AMDV1PT_FMT_OA,
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  251  			   log2_div(table_pa, PT_GRANULE_LG2SZ)) |
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  252  		AMDV1PT_FMT_IR | AMDV1PT_FMT_IW;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  253  	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  254  		entry = __sme_set(entry);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04 @255  	return pt_table_install64(pts, entry);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  256  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  257  #define pt_install_table amdv1pt_install_table
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  258  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  259  static inline void amdv1pt_attr_from_entry(const struct pt_state *pts,
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  260  					   struct pt_write_attrs *attrs)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  261  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  262  	attrs->descriptor_bits =
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  263  		pts->entry & (AMDV1PT_FMT_FC | AMDV1PT_FMT_IR | AMDV1PT_FMT_IW);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  264  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  265  #define pt_attr_from_entry amdv1pt_attr_from_entry
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  266  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  267  static inline void amdv1pt_clear_entries(struct pt_state *pts,
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  268  					 unsigned int num_contig_lg2)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  269  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  270  	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  271  	u64 *end = tablep + log2_to_int(num_contig_lg2);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  272  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  273  	/*
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  274  	 * gcc generates rep stos for the io-pgtable code, and this difference
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  275  	 * can show in microbenchmarks with larger contiguous page sizes.
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  276  	 * rep is slower for small cases.
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  277  	 */
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  278  	if (num_contig_lg2 <= ilog2(32)) {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  279  		for (; tablep != end; tablep++)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  280  			WRITE_ONCE(*tablep, 0);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  281  	} else {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  282  		memset64(tablep, 0, log2_to_int(num_contig_lg2));
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  283  	}
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  284  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  285  #define pt_clear_entries amdv1pt_clear_entries
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  286  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  287  static inline bool amdv1pt_entry_is_write_dirty(const struct pt_state *pts)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  288  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  289  	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  290  	u64 *tablep = pt_cur_table(pts, u64) +
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  291  		      log2_set_mod(pts->index, 0, num_contig_lg2);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  292  	u64 *end = tablep + log2_to_int(num_contig_lg2);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  293  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  294  	for (; tablep != end; tablep++)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  295  		if (READ_ONCE(*tablep) & AMDV1PT_FMT_D)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  296  			return true;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  297  	return false;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  298  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  299  #define pt_entry_is_write_dirty amdv1pt_entry_is_write_dirty
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  300  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  301  static inline void amdv1pt_entry_make_write_clean(struct pt_state *pts)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  302  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  303  	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  304  	u64 *tablep = pt_cur_table(pts, u64) +
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  305  		      log2_set_mod(pts->index, 0, num_contig_lg2);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  306  	u64 *end = tablep + log2_to_int(num_contig_lg2);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  307  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  308  	for (; tablep != end; tablep++)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  309  		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(u64)AMDV1PT_FMT_D);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  310  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  311  #define pt_entry_make_write_clean amdv1pt_entry_make_write_clean
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  312  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  313  static inline bool amdv1pt_entry_make_write_dirty(struct pt_state *pts)
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  314  {
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  315  	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04 @316  	u64 new = pts->entry | AMDV1PT_FMT_D;
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  317  
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  318  	return try_cmpxchg64(tablep, &pts->entry, new);
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  319  }
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  320  #define pt_entry_make_write_dirty amdv1pt_entry_make_write_dirty
879ced2bab1ba9 Jason Gunthorpe 2025-11-04  321  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
