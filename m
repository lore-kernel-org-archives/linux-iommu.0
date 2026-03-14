Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315FE31E853;
	Sat, 14 Mar 2026 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475806; cv=none; b=ZHpm871LKG3+Sj7+DxHsUiDIg8Ywib8pcw+hoX1TFtJLjss9pA3oLMBOSwmrnKY2HD/kYH4/m3MwuczkSfSVI3bNmx3ZyMUiLufatXEdRi80eH5y9aVDSfIcNCcfV1u7WK7wScKISz1ILX7qVc+UUvqqCWnmUnc7uQJjc70Weso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475806; c=relaxed/simple;
	bh=AlyU0hvkwaYRYsimbN6xKCxmyRYWsUONDRQDR1fUSrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otEaDKL7jg2acd8/72vnhOKEvSAxI6kHGeZMeFUwR8al0ogaYxJxp7Rcx5CrSjhWPER6gsxVk3oJr50R2fg70LQj5fIXO8VgxRx4W4BuDxlCGZsm5jPg+tXx23MnTXkrcM1O/4q81B9PeFWQXsy2iHnqxpOLPRN2TpLVTHDxliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hs/wnLPN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs/wnLPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773475805; x=1805011805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlyU0hvkwaYRYsimbN6xKCxmyRYWsUONDRQDR1fUSrQ=;
  b=Hs/wnLPNArzcdfmN+XDcTqDzzZ1sEXu/MwX6GaVYSE2KfrPYWrcc4oSR
   AKociDm8bv8LCh7cqaSYQrklGrkPl/RftbC/yz8f8cHsR3EHN1tWcOMHF
   CPYo7qdzu+p4uMPhnA5gipTq4fUW0svzv/+3f2M5mpBpnVA+o0sluKVvG
   ltUM4N/u0Wg5W6mv6oUPZYKTw+2mt8gZODzXc/eb0PPJRNz7b2VKLqycp
   bvQ8IWR2yds5lxFyNbiLwtnN+os+ApSJqQxws6zS2cRk/MQK/mUNzbPBf
   FU0IJkJr68N3FGjK0fWxuLw86s+wxKhs5KuRh1sLwJgFddbthD8DcENKj
   g==;
X-CSE-ConnectionGUID: TbgoWs5KRDC8LuvXjanvmw==
X-CSE-MsgGUID: MdDGw4PeQcGEfx0WXRc1sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85276220"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85276220"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 01:10:05 -0700
X-CSE-ConnectionGUID: /+FuZmYJT4iACVDWjkexyg==
X-CSE-MsgGUID: bqnmYQRgQl2cUPauIHFBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="225851485"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Mar 2026 01:10:01 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1K4K-000000004qP-3uUK;
	Sat, 14 Mar 2026 08:09:56 +0000
Date: Sat, 14 Mar 2026 16:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <202603141655.DaMKZr7a-lkp@intel.com>
References: <20260312155637.376854-9-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-9-jacob.pan@linux.microsoft.com>

Hi Jacob,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc3 next-20260311]
[cannot apply to awilliam-vfio/next awilliam-vfio/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommufd-Support-a-HWPT-without-an-iommu-driver-for-noiommu/20260313-182818
base:   linus/master
patch link:    https://lore.kernel.org/r/20260312155637.376854-9-jacob.pan%40linux.microsoft.com
patch subject: [PATCH V2 08/11] vfio: Enable cdev noiommu mode under iommufd
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260314/202603141655.DaMKZr7a-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141655.DaMKZr7a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141655.DaMKZr7a-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/generic_pt/fmt/iommu_template.h:36,
                    from drivers/iommu/generic_pt/fmt/iommu_mock.c:10:
   drivers/iommu/generic_pt/fmt/amdv1.h: In function 'amdv1pt_install_table':
>> drivers/iommu/generic_pt/fmt/amdv1.h:255:16: error: implicit declaration of function 'pt_table_install64'; did you mean 'pt_table_install32'? [-Wimplicit-function-declaration]
     255 |         return pt_table_install64(pts, entry);
         |                ^~~~~~~~~~~~~~~~~~
         |                pt_table_install32

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
   Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=m] && !GENERIC_ATOMIC64 [=y]
   Selected by [m]:
   - VFIO_NOIOMMU [=y] && VFIO [=m] && VFIO_GROUP [=y] && IOMMU_SUPPORT [=y]


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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
