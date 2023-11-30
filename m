Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002D47A59;
	Thu, 30 Nov 2023 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyV6AI5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701353099; x=1732889099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqtTZvY053veljR4ETMpWFPpHyKU0+OBKnIK2FZ1Hl0=;
  b=EyV6AI5hfysbAzEWlu9fsR0fLWM/ymcj3X8QrYRi3JvuKw8+tHfpWZRO
   Dw6LdMfXI/Bn0CvxNljBYtKM9BYV/hWmwTihY2h3hGnnpXD2IIfNviaGw
   hvnuzxh1bnXT0IXdtefaIPIRdp1S/2oHip0jKKGKl3rvXYiCJF1BXyaZZ
   rDu5THYi2Oo7dWxaTIqyg3PZNl6MsbFEl7PcDc2imrzpaQ6vR05LTQTMc
   Tn6VR8RR/WarN+L6pl0vGTWRcb8OmMDIu/JL6hC3pWnhrxlPPufL0YP97
   P1rD919daZtkwSzEtCLR60LQ8uz1tRQ0hjuuOVG2it4MWmD1+jrdW+VuG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="226594"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="226594"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016636131"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="1016636131"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2023 06:03:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8hdz-00025l-1H;
	Thu, 30 Nov 2023 14:03:55 +0000
Date: Thu, 30 Nov 2023 22:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
	joro@8bytes.org, kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 13/16] iommu: observability of the IOMMU allocations
Message-ID: <202311302108.WERv9oSO-lkp@intel.com>
References: <20231128204938.1453583-14-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128204938.1453583-14-pasha.tatashin@soleen.com>

Hi Pasha,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on awilliam-vfio/for-linus linus/master v6.7-rc3]
[cannot apply to joro-iommu/next awilliam-vfio/next next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/iommu-vt-d-add-wrapper-functions-for-page-allocations/20231129-054908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231128204938.1453583-14-pasha.tatashin%40soleen.com
patch subject: [PATCH 13/16] iommu: observability of the IOMMU allocations
config: sparc64-randconfig-r054-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302108.WERv9oSO-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302108.WERv9oSO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311302108.WERv9oSO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/iommufd/iova_bitmap.c:11:
   drivers/iommu/iommufd/../iommu-pages.h: In function '__iommu_alloc_account':
>> drivers/iommu/iommufd/../iommu-pages.h:29:48: error: 'NR_IOMMU_PAGES' undeclared (first use in this function)
      29 |         mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
         |                                                ^~~~~~~~~~~~~~
   drivers/iommu/iommufd/../iommu-pages.h:29:48: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/iommufd/../iommu-pages.h: In function '__iommu_free_account':
   drivers/iommu/iommufd/../iommu-pages.h:41:48: error: 'NR_IOMMU_PAGES' undeclared (first use in this function)
      41 |         mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
         |                                                ^~~~~~~~~~~~~~


vim +/NR_IOMMU_PAGES +29 drivers/iommu/iommufd/../iommu-pages.h

    13	
    14	/*
    15	 * All page allocation that are performed in the IOMMU subsystem must use one of
    16	 * the functions below.  This is necessary for the proper accounting as IOMMU
    17	 * state can be rather large, i.e. multiple gigabytes in size.
    18	 */
    19	
    20	/**
    21	 * __iommu_alloc_account - account for newly allocated page.
    22	 * @pages: head struct page of the page.
    23	 * @order: order of the page
    24	 */
    25	static inline void __iommu_alloc_account(struct page *pages, int order)
    26	{
    27		const long pgcnt = 1l << order;
    28	
  > 29		mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
