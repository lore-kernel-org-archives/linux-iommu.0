Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FD272E51;
	Fri, 15 Aug 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249342; cv=none; b=JMvGGlNGq8oE1OY/zCVnZx0GVy6CTI7fN9gZjT3OKCSuL6YQPLoYW1ubfaBKCeuxQ1ZtK2SqgKRHdAJpSblTKRNuaxVdx0TeMqODvNnI9mmVRU1CO11eoLMjEUEm1g75K898PDkNPYVvEHta/AKrEXTgXa96YUMvgbEjekQHGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249342; c=relaxed/simple;
	bh=hfZcgn0nzW9uuIxs2763lW2p3DkRL5Fx4+ceg0IC1a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARMWKfsDAH7QvgiAeCY2VvRh0d0XnzumLQUQ0KQ9RnQyTL9ff5Go4NjBkc+Mevc/5wqjNW/b86XumpxflBgJYTnaTyGo1QFeSNFsTpOZP2k1w1HP7WQnDxNUSK+yxNjgMRzLq5acc9j4dBMTbebO2lk6ruCVBnJRTm/aP7USJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5ZVmyll; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5ZVmyll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249341; x=1786785341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hfZcgn0nzW9uuIxs2763lW2p3DkRL5Fx4+ceg0IC1a0=;
  b=e5ZVmyllPvFXKOZhBuQaXHUDkzmZbwkwGnmnSEbL8iIHzpyBOzKJZdqr
   qfPwJNZgSjMcTbbFBzcDMfFn5V5yx11a0zvU454N/6fM44nMH93DcLiIO
   xzXIIGst9DAg6XJ4ZPWzM55CQFNMZcmI6p9/5K4aVV1s4xmciniG8NrHl
   j4kXpKixuyqfHYi/YQjPDqzXCd6MDtvOmqJNW5h3aZ/gQ6plxMhOm7LrW
   /SVVzf9CZ+WNqHwxP/fwru0l3NhpLsupmHPn1lDn/muzklQQHZqe/7Wx5
   v2bwR0i+JMGz+mekyA8fGur6a3ESaGpvbH5luPEWHRIG1l5ccfbxv1HJp
   Q==;
X-CSE-ConnectionGUID: ZkpoSVscQuaRr9vv8CFS+g==
X-CSE-MsgGUID: PqOD5Ix+SYuOqiBE3GgIMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57528787"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57528787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:15:41 -0700
X-CSE-ConnectionGUID: ZJZH2PX4RoeJ1J/lxbGQOA==
X-CSE-MsgGUID: I0vJDqLSS+eG3dAfYgKucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172199692"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Aug 2025 02:15:37 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umqX9-000BnI-0P;
	Fri, 15 Aug 2025 09:15:35 +0000
Date: Fri, 15 Aug 2025 17:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, xiaqinxin@huawei.com, yangyicong@huawei.com,
	wangzhou1@hisilicon.com, prime.zeng@hisilicon.com,
	xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 2/2] iommu/io-pgtable: Add ARM SMMUv3 page table dump
 support
Message-ID: <202508151641.JHlhcDRk-lkp@intel.com>
References: <20250814093005.2040511-3-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-3-xiaqinxin@huawei.com>

Hi Qinxin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qinxin-Xia/iommu-debug-Add-IOMMU-page-table-dump-debug-facility/20250814-173720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250814093005.2040511-3-xiaqinxin%40huawei.com
patch subject: [PATCH 2/2] iommu/io-pgtable: Add ARM SMMUv3 page table dump support
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250815/202508151641.JHlhcDRk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151641.JHlhcDRk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151641.JHlhcDRk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/s390/include/asm/bug.h:69,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from arch/s390/include/asm/cmpxchg.h:11,
                    from arch/s390/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from drivers/iommu/io-pgtable-arm.c:12:
   drivers/iommu/io-pgtable-arm.c: In function 'dump_prot':
>> include/linux/kern_levels.h:5:25: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:486:25: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:557:9: note: in expansion of macro 'printk'
     557 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:557:16: note: in expansion of macro 'KERN_ERR'
     557 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:882:25: note: in expansion of macro 'pr_err'
     882 |                         pr_err("len = %zu, attr = %s, i =%d\n", length, attr, i);
         |                         ^~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:486:25: note: in definition of macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:557:9: note: in expansion of macro 'printk'
     557 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:557:16: note: in expansion of macro 'KERN_ERR'
     557 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/iommu/io-pgtable-arm.c:882:25: note: in expansion of macro 'pr_err'
     882 |                         pr_err("len = %zu, attr = %s, i =%d\n", length, attr, i);
         |                         ^~~~~~
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_dump_iova_prot':
>> drivers/iommu/io-pgtable-arm.c:911:32: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long unsigned int' [-Wformat=]
     911 |         seq_printf(s, "%lx - %lx    lvl %d  stage %s ",
         |                              ~~^
         |                                |
         |                                long unsigned int
         |                              %llx


vim +911 drivers/iommu/io-pgtable-arm.c

   891	
   892	static size_t arm_lpae_dump_iova_prot(struct seq_file *s, struct io_pgtable_ops *ops,
   893									   unsigned long iova)
   894	{
   895		struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
   896		struct iova_to_phys_data d;
   897		int ret;
   898	
   899		struct io_pgtable_walk_data walk_data = {
   900			.data = &d,
   901			.visit = visit_iova_to_phys,
   902			.addr = iova,
   903			.end = iova + 1,
   904		};
   905	
   906		/* Only the mapped iova will be output */
   907		ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
   908		if (ret)
   909			return ARM_LPAE_GRANULE(data);
   910	
 > 911		seq_printf(s, "%lx - %lx    lvl %d  stage %s ",
   912				   iova, iova + ARM_LPAE_BLOCK_SIZE(d.lvl, data),
   913				   d.lvl, io_pgtable_fmt_names[data->iop.fmt]);
   914	
   915		/* TODO: The dump prot is incomplete and will be supplemented later... */
   916		dump_prot(s, d.pte);
   917		seq_puts(s, "\n");
   918	
   919		return ARM_LPAE_BLOCK_SIZE(d.lvl, data);
   920	}
   921	#endif
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
