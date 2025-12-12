Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1331691C;
	Fri, 12 Dec 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538396; cv=none; b=PEcUrROU5Jj+VHGFfQuf7y8PgzkR7wFBxAUF86P82bEWmdgdIhOpmcpEonhrVEfptze/E67Jfzlkler/Q9pSKLjA7k9HuGc9zn8tEcqe4ff+9AAw6fs9TgfYfuOLpWpo3oEUQHQr37km3EByGeBaWXXzi3SCcnOhN4aw9z/xwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538396; c=relaxed/simple;
	bh=EdVCtB2iBvhcT8kAVicT/eJPLJyC3Q8G7MCNhAvQuvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXS2Rpap2295TL8/l18rJPR8qplxp2G+ALBcYoSIedvMe/VeSdrv3SSAdYZsGcF2Mmg7/cYBzZunGVB4MaKSJX/UfAFuUoOp0S4vuwbRmV4HK4vmO7jYEqGmnm/fWAXvdZtnpwSqFPM3Smwa6Z5klZ2J8A32bjPicCDeNDoS/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrfgUNaN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrfgUNaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765538395; x=1797074395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdVCtB2iBvhcT8kAVicT/eJPLJyC3Q8G7MCNhAvQuvs=;
  b=KrfgUNaN8+IpHUV3aYHf8rfixGOt/P+Wg3JDDFz5s/tdDz3MA6GoavO0
   3eAGd4dtx8Mfh2RtI6faxhJIejahegbXnHY/DysSOAT7vubGd2JcVLr7h
   oRwKpYOGYHqX+SM0aGufi6LgQrkv+lGJtM3CzQ8n6CJrz+U5Mw3TqpQWZ
   Nnkyoovi7Cq1aSgJkw1VYGkDCpY3IyCSOXladf5Xh8rx6bWgp/vGQUzFi
   4ijpOG8zcbZwoZS8voQSwZe+z59P2r5DSEe/2+sYDfPbGsMO5FvmNssjs
   kNDcHquipHUwyv0FlUYm/77B5zZBRj5YnpduFyrkPexQT/GOr5D42Cn/q
   w==;
X-CSE-ConnectionGUID: 7UCD9eibTO6SHEpckFj+aA==
X-CSE-MsgGUID: vrqTx+PuQBi2gQkEUSzCdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78908862"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="78908862"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:19:54 -0800
X-CSE-ConnectionGUID: qJI1cXddTlCXNr/oOR58Sg==
X-CSE-MsgGUID: nS3unyGGQ8uyAJys3jLiqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196666572"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Dec 2025 03:19:49 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vU1Bb-000000005yZ-1Ard;
	Fri, 12 Dec 2025 11:19:47 +0000
Date: Fri, 12 Dec 2025 19:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	robh@kernel.org, m.szyprowski@samsung.com, ye.li@oss.nxp.com
Cc: oe-kbuild-all@lists.linux.dev, oreoluwa.babatunde@oss.qualcomm.com,
	kernel@oss.qualcomm.com, saravanak@google.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, quic_c_gdjako@quicinc.com
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
Message-ID: <202512121807.G5FMUgvU-lkp@intel.com>
References: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>

Hi Oreoluwa,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on v6.18]
[cannot apply to robh/for-next linus/master next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Allow-reserved_mem-framework-detect-cma-kernel-param/20251210-082127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251210002027.1171519-1-oreoluwa.babatunde%40oss.qualcomm.com
patch subject: [PATCH] of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param
config: nios2-randconfig-r073-20251212 (https://download.01.org/0day-ci/archive/20251212/202512121807.G5FMUgvU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121807.G5FMUgvU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512121807.G5FMUgvU-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/of/of_reserved_mem.o: in function `__reserved_mem_reserve_reg':
>> drivers/of/of_reserved_mem.c:176: undefined reference to `cma_skip_dt_default_reserved_mem'
>> drivers/of/of_reserved_mem.c:176:(.init.text+0x5b8): relocation truncated to fit: R_NIOS2_CALL26 against `cma_skip_dt_default_reserved_mem'
   nios2-linux-ld: drivers/of/of_reserved_mem.o: in function `__reserved_mem_alloc_size':
   drivers/of/of_reserved_mem.c:444: undefined reference to `cma_skip_dt_default_reserved_mem'
   drivers/of/of_reserved_mem.c:444:(.init.text+0x8a4): relocation truncated to fit: R_NIOS2_CALL26 against `cma_skip_dt_default_reserved_mem'
   nios2-linux-ld: drivers/of/of_reserved_mem.o: in function `fdt_scan_reserved_mem_reg_nodes':
   drivers/of/of_reserved_mem.c:272: undefined reference to `cma_skip_dt_default_reserved_mem'
   drivers/of/of_reserved_mem.c:272:(.init.text+0xbb0): relocation truncated to fit: R_NIOS2_CALL26 against `cma_skip_dt_default_reserved_mem'


vim +176 drivers/of/of_reserved_mem.c

   150	
   151	/*
   152	 * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
   153	 */
   154	static int __init __reserved_mem_reserve_reg(unsigned long node,
   155						     const char *uname)
   156	{
   157		int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
   158		phys_addr_t base, size;
   159		int len;
   160		const __be32 *prop;
   161		bool nomap, default_cma;
   162	
   163		prop = of_get_flat_dt_prop(node, "reg", &len);
   164		if (!prop)
   165			return -ENOENT;
   166	
   167		if (len && len % t_len != 0) {
   168			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
   169			       uname);
   170			return -EINVAL;
   171		}
   172	
   173		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
   174		default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
   175	
 > 176		if (default_cma && cma_skip_dt_default_reserved_mem()) {
   177			pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
   178			return -EINVAL;
   179		}
   180	
   181		while (len >= t_len) {
   182			base = dt_mem_next_cell(dt_root_addr_cells, &prop);
   183			size = dt_mem_next_cell(dt_root_size_cells, &prop);
   184	
   185			if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
   186				/* Architecture specific contiguous memory fixup. */
   187				if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
   188				    of_get_flat_dt_prop(node, "reusable", NULL))
   189					dma_contiguous_early_fixup(base, size);
   190				pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
   191					uname, &base, (unsigned long)(size / SZ_1M));
   192			} else {
   193				pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
   194				       uname, &base, (unsigned long)(size / SZ_1M));
   195			}
   196	
   197			len -= t_len;
   198		}
   199		return 0;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
