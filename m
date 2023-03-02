Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98135EC4;
	Thu,  2 Mar 2023 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677726433; x=1709262433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShesbyNrXCmnE5x/WCFn2XeFR0xUOirn7589vr8VSJQ=;
  b=diMjbHat6qLm3ncr3P9R5AWAt6akGIQZzq4V5gtG6n8yCXilma2vZBZQ
   NrdxzNkHrrQIvQ6vH0MerUYk85hVodP9N//K5zKBMWNwWqzUMjWwtxYfy
   RIinJkIlzVL0oHilXXft/cfhsfsTLqCOVEoKrRcxVVKulArow+NMAiMb2
   6Q/6okmZUP7ZyrU62NBN8QX//w58rE2PLQJelfbGEJJ9EifHTU23AlgBB
   fScbz3jOXaadoUncIUsYBPNecvZ9wEKnTlrx5CzQTDXq9dAq9TmxC+Egr
   STGJw8qUC9w85N2lnPbUWjq6XqgkL2dvQ78+7192fcTEF3DynXo0JqnGJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336895362"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336895362"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 19:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817819177"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="817819177"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2023 19:06:57 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pXZHV-000080-0X;
	Thu, 02 Mar 2023 03:06:57 +0000
Date: Thu, 2 Mar 2023 11:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org, vkoul@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <202303021016.avd8l1rJ-lkp@intel.com>
References: <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on v6.2]
[cannot apply to joro-iommu/next linus/master next-20230302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommu-vt-d-Implement-set-device-pasid-op-for-default-domain/20230302-085748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230302005959.2695267-4-jacob.jun.pan%40linux.intel.com
patch subject: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
config: arm64-randconfig-r013-20230302 (https://download.01.org/0day-ci/archive/20230302/202303021016.avd8l1rJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b27170369658e99a0aafd84985de0ce48c1b2539
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacob-Pan/iommu-vt-d-Implement-set-device-pasid-op-for-default-domain/20230302-085748
        git checkout b27170369658e99a0aafd84985de0ce48c1b2539
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/exynos/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303021016.avd8l1rJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/exynos/exynos_drm_dma.c:8:
>> include/linux/iommu.h:1215:1: error: expected identifier or '('
   {
   ^
   drivers/gpu/drm/exynos/exynos_drm_dma.c:54:35: warning: implicit conversion from 'unsigned long long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
           dma_set_max_seg_size(subdrv_dev, DMA_BIT_MASK(32));
           ~~~~~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:40: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                          ^~~~~
   1 warning and 1 error generated.


vim +1215 include/linux/iommu.h

  1213	
  1214	static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
> 1215	{
  1216		return IOMMU_PASID_INVALID;
  1217	}
  1218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
