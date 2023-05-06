Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8417A92A;
	Sat,  6 May 2023 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683387626; x=1714923626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8bmvEMZXEd/jqIv4QtaFnZW5u2NmJk4Cjd5qGZv4oTU=;
  b=Lnjan3az0np5U8/s2f5TrBbFCC6VMY1UbSllE28BIm1kbZX05MkXPb2B
   Du/2lljAwoto88Yws+baQpW22AeNq48QpRmMd1KC4beWFcnTs0UVze97F
   XMhW2qeTE1rD8w4IMCrZmuBWb75Vfzt2AxzwEz1KG37cuGXf/uoPLWnU8
   tD/QM/nniZ7LqH3wZz+Nnfv1A9ADzY0gfqXPuRSjoCE0aUyGgw1dar4/R
   SxrqiTXA7RpIr/6rP5rB4j03TyET3Y8Cx2xr5wuAP39wFDBWYzWgylTnb
   zTooetA8cJ9Tvlr6ON39IJyD1d4fvBzIQLlrQxnkXegyln3Vm1TNcpXHt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="333824901"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="333824901"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 08:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730746346"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="730746346"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 08:40:19 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pvK1C-0000NB-1b;
	Sat, 06 May 2023 15:40:18 +0000
Date: Sat, 6 May 2023 23:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>, torvalds@linux-foundation.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <202305062339.d6Rnj38E-lkp@intel.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>

Hi Jacob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230505]
[also build test WARNING on linus/master]
[cannot apply to joro-iommu/next v6.3 v6.3-rc7 v6.3-rc6 v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommu-Add-Kconfig-help-text-for-IOMMU_SVA/20230506-212836
base:   next-20230505
patch link:    https://lore.kernel.org/r/20230506133134.1492395-1-jacob.jun.pan%40linux.intel.com
patch subject: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
config: sparc-defconfig (https://download.01.org/0day-ci/archive/20230506/202305062339.d6Rnj38E-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7a9fdfc3792c64278f1950f3880278b989749944
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacob-Pan/iommu-Add-Kconfig-help-text-for-IOMMU_SVA/20230506-212836
        git checkout 7a9fdfc3792c64278f1950f3880278b989749944
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305062339.d6Rnj38E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/mmu_context_32.h:7,
                    from arch/sparc/include/asm/mmu_context.h:7,
                    from include/linux/mmu_context.h:5,
                    from drivers/iommu/iommu-sva.c:5:
   include/asm-generic/mm_hooks.h:10:40: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      10 | static inline int arch_dup_mmap(struct mm_struct *oldmm,
         |                                        ^~~~~~~~~
   include/asm-generic/mm_hooks.h:16:42: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      16 | static inline void arch_exit_mmap(struct mm_struct *mm)
         |                                          ^~~~~~~~~
   include/asm-generic/mm_hooks.h:20:38: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      20 | static inline void arch_unmap(struct mm_struct *mm,
         |                                      ^~~~~~~~~
   include/asm-generic/mm_hooks.h:25:15: error: unknown type name 'bool'
      25 | static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
         |               ^~~~
   include/asm-generic/mm_hooks.h:26:17: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                 ^~~~
   include/asm-generic/mm_hooks.h:1:1: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
     +++ |+#include <stdbool.h>
       1 | /* SPDX-License-Identifier: GPL-2.0 */
   include/asm-generic/mm_hooks.h:26:29: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                             ^~~~
   include/asm-generic/mm_hooks.h:26:29: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
   include/asm-generic/mm_hooks.h:26:43: error: unknown type name 'bool'
      26 |                 bool write, bool execute, bool foreign)
         |                                           ^~~~
   include/asm-generic/mm_hooks.h:26:43: note: 'bool' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
>> arch/sparc/include/asm/mmu_context_32.h:13:54: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      13 | int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
         |                                                      ^~~~~~~~~
>> arch/sparc/include/asm/mmu_context_32.h:13:29: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
      13 | int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
         |                             ^~~~~~~~~~~
   arch/sparc/include/asm/mmu_context_32.h:21:29: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      21 | void destroy_context(struct mm_struct *mm);
         |                             ^~~~~~~~~
   arch/sparc/include/asm/mmu_context_32.h:25:23: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
      25 |                struct task_struct *tsk);
         |                       ^~~~~~~~~~~
   arch/sparc/include/asm/mmu_context_32.h:24:23: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration
      24 | void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
         |                       ^~~~~~~~~
   In file included from arch/sparc/include/asm/mmu.h:7,
                    from include/linux/mmu_context.h:6:
   arch/sparc/include/asm/mmu_32.h:9:8: error: unknown type name 'ctxd_t'
       9 | extern ctxd_t *srmmu_ctx_table_phys;
         |        ^~~~~~
   include/linux/mmu_context.h:39:15: error: unknown type name 'bool'
      39 | static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
         |               ^~~~
   include/linux/mmu_context.h: In function 'arch_pgtable_dma_compat':
   include/linux/mmu_context.h:41:16: error: 'true' undeclared (first use in this function)
      41 |         return true;
         |                ^~~~
   include/linux/mmu_context.h:7:1: note: 'true' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
       6 | #include <asm/mmu.h>
     +++ |+#include <stdbool.h>
       7 | 
   include/linux/mmu_context.h:41:16: note: each undeclared identifier is reported only once for each function it appears in
      41 |         return true;
         |                ^~~~
   drivers/iommu/iommu-sva.c: In function 'iommu_sva_bind_device':
   drivers/iommu/iommu-sva.c:69:32: error: invalid use of undefined type 'struct dev_iommu'
      69 |         max_pasids = dev->iommu->max_pasids;
         |                                ^~
   drivers/iommu/iommu-sva.c:78:32: error: invalid application of 'sizeof' to incomplete type 'struct iommu_sva'
      78 |         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
         |                                ^
   drivers/iommu/iommu-sva.c:109:15: error: invalid use of undefined type 'struct iommu_sva'
     109 |         handle->dev = dev;
         |               ^~
   drivers/iommu/iommu-sva.c:110:15: error: invalid use of undefined type 'struct iommu_sva'
     110 |         handle->domain = domain;
         |               ^~
   drivers/iommu/iommu-sva.c: In function 'iommu_sva_unbind_device':
   drivers/iommu/iommu-sva.c:134:45: error: invalid use of undefined type 'struct iommu_sva'
     134 |         struct iommu_domain *domain = handle->domain;
         |                                             ^~
   drivers/iommu/iommu-sva.c:136:36: error: invalid use of undefined type 'struct iommu_sva'
     136 |         struct device *dev = handle->dev;
         |                                    ^~
   drivers/iommu/iommu-sva.c: In function 'iommu_sva_get_pasid':
   drivers/iommu/iommu-sva.c:150:45: error: invalid use of undefined type 'struct iommu_sva'
     150 |         struct iommu_domain *domain = handle->domain;
         |                                             ^~
   include/linux/mmu_context.h: In function 'arch_pgtable_dma_compat':
   include/linux/mmu_context.h:42:1: error: control reaches end of non-void function [-Werror=return-type]
      42 | }
         | ^
   cc1: some warnings being treated as errors


vim +13 arch/sparc/include/asm/mmu_context_32.h

f5e706ad886b6a include/asm-sparc/mmu_context_32.h      Sam Ravnborg    2008-07-17   8  
b585e8551b352c arch/sparc/include/asm/mmu_context_32.h Sam Ravnborg    2012-07-26   9  /* Initialize a new mmu context.  This is invoked when a new
f5e706ad886b6a include/asm-sparc/mmu_context_32.h      Sam Ravnborg    2008-07-17  10   * address space instance (unique or shared) is instantiated.
f5e706ad886b6a include/asm-sparc/mmu_context_32.h      Sam Ravnborg    2008-07-17  11   */
ca0f34b575ade0 arch/sparc/include/asm/mmu_context_32.h Nicholas Piggin 2020-09-02  12  #define init_new_context init_new_context
b585e8551b352c arch/sparc/include/asm/mmu_context_32.h Sam Ravnborg    2012-07-26 @13  int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
f5e706ad886b6a include/asm-sparc/mmu_context_32.h      Sam Ravnborg    2008-07-17  14  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
