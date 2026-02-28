Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C51DE2C9;
	Sat, 28 Feb 2026 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772237957; cv=none; b=Ns/ogFuq73EJonckrzG9H8kdE3vc7a3vjuCGYHT8l38cC6pcLgeb3/dHAVdju08wAcIYnyvhRtYbS2KKjaHNN0dcUB79eqS/tCLUC3wwrENzwyI2rlxEOmXx6xy/A+5X53MAmCLr5gj0jY0WHjIjR7tTmIOYSRlP6hd8p052Y/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772237957; c=relaxed/simple;
	bh=oB71pr3p+SPnfGj2w0EGGZr3XAcxnfP18+UE9zUzAFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0/UaFvdA0RPEbQ/nRV7VuKZkzuKuvnPBOyMaLT4czIOamkVVFyzI73PpQUbol/wHZWJVw34o86+k+OK/hYZaBgTRpFsKtYitpVXmZPlUbeCcfa/Z7N4Q2HEKRoeQ7KqHdJ7vwLqayCH9gUrRLW7GFL7XiZYTEuLj5nj+HSdeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk0fokIw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk0fokIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772237954; x=1803773954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oB71pr3p+SPnfGj2w0EGGZr3XAcxnfP18+UE9zUzAFY=;
  b=Nk0fokIwIRn5w8gtiPDc17haZ93Cs/vW0Uzuh97rDvsPCo31X0p+h+DK
   Kn0sU+rBx1CMcFeR/PfVI4XkvMwKvphE41CdxKhSgBSAkj+QDf3H9kr2z
   cLSGay/u9LDUeSAWkh7fTSqXRzVrdv03dXjCdm/HdZUrGMaVMJdlDzsJW
   /0+888Dgie454qzg0kg93KYzue0kmm6fpRrorTRzWfQvcXzF+vVrAKv+k
   +CTAfDk0XGFJGr1mu22+QqS2ustCOTcZ7/xUzvcI1gKiCjJhLHPJtnnWM
   +20OrBgyfYpm6O4PBnrEfWsKkbde6o9AOT1EtvFPclt0Fdwdw3wJCBUl0
   A==;
X-CSE-ConnectionGUID: ijl6c+VrSnaSQ6VoOMYlaQ==
X-CSE-MsgGUID: zD3M83NcR8O+uEWnYBdwog==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73435982"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="73435982"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 16:19:14 -0800
X-CSE-ConnectionGUID: lC2N043PQniljb3OPBQ8WA==
X-CSE-MsgGUID: QtB3KE9UQOiEsww2tvnWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221673880"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 27 Feb 2026 16:19:10 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw831-00000000BC7-1DD8;
	Sat, 28 Feb 2026 00:19:07 +0000
Date: Sat, 28 Feb 2026 08:18:41 +0800
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
Message-ID: <202602280855.WxyIHCy5-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc1 next-20260227]
[cannot apply to awilliam-vfio/next awilliam-vfio/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommufd-Support-a-HWPT-without-an-iommu-driver-for-noiommu/20260228-020145
base:   linus/master
patch link:    https://lore.kernel.org/r/20260227175247.26103-9-jacob.pan%40linux.microsoft.com
patch subject: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
config: riscv-randconfig-r134-20260228 (https://download.01.org/0day-ci/archive/20260228/202602280855.WxyIHCy5-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280855.WxyIHCy5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280855.WxyIHCy5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iommu/generic_pt/fmt/iommu_template.h:36,
                    from drivers/iommu/generic_pt/fmt/iommu_amdv1.c:15:
   drivers/iommu/generic_pt/fmt/amdv1.h: In function 'amdv1pt_install_table':
   drivers/iommu/generic_pt/fmt/amdv1.h:255:9: error: implicit declaration of function 'pt_table_install64'; did you mean 'pt_table_install32'? [-Werror=implicit-function-declaration]
     return pt_table_install64(pts, entry);
            ^~~~~~~~~~~~~~~~~~
            pt_table_install32
   In file included from include/linux/generic_pt/common.h:10,
                    from drivers/iommu/generic_pt/fmt/iommu_template.h:33,
                    from drivers/iommu/generic_pt/fmt/iommu_amdv1.c:15:
   drivers/iommu/generic_pt/fmt/amdv1.h: In function 'amdv1pt_entry_make_write_dirty':
>> include/linux/bits.h:49:20: warning: right shift count >= width of type [-Wshift-count-overflow]
           type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
                       ^~
   include/linux/bits.h:51:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:152:18: note: in expansion of macro 'GENMASK'
      ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0) \
                     ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:224:3: note: in expansion of macro '__arch_cmpxchg_masked'
      __arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,  \
      ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:283:2: note: in expansion of macro '_arch_cmpxchg'
     _arch_cmpxchg((ptr), (o), (n),     \
     ^~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:294:2: note: in expansion of macro 'arch_cmpxchg'
     arch_cmpxchg((ptr), (o), (n));     \
     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:98:23: note: in expansion of macro 'arch_cmpxchg64'
    #define raw_cmpxchg64 arch_cmpxchg64
                          ^~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:259:9: note: in expansion of macro 'raw_cmpxchg64'
     ___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
            ^~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4918:2: note: in expansion of macro 'raw_try_cmpxchg64'
     raw_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
     ^~~~~~~~~~~~~~~~~
   drivers/iommu/generic_pt/fmt/amdv1.h:318:9: note: in expansion of macro 'try_cmpxchg64'
     return try_cmpxchg64(tablep, &pts->entry, new);
            ^~~~~~~~~~~~~
>> include/linux/bits.h:49:20: warning: right shift count >= width of type [-Wshift-count-overflow]
           type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
                       ^~
   include/linux/bits.h:51:24: note: in expansion of macro 'GENMASK_TYPE'
    #define GENMASK(h, l)  GENMASK_TYPE(unsigned long, h, l)
                           ^~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:152:18: note: in expansion of macro 'GENMASK'
      ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0) \
                     ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:230:3: note: in expansion of macro '__arch_cmpxchg_masked'
      __arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,  \
      ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:283:2: note: in expansion of macro '_arch_cmpxchg'
     _arch_cmpxchg((ptr), (o), (n),     \
     ^~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:294:2: note: in expansion of macro 'arch_cmpxchg'
     arch_cmpxchg((ptr), (o), (n));     \
     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:98:23: note: in expansion of macro 'arch_cmpxchg64'
    #define raw_cmpxchg64 arch_cmpxchg64
                          ^~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:259:9: note: in expansion of macro 'raw_cmpxchg64'
     ___r = raw_cmpxchg64((_ptr), ___o, (_new)); \
            ^~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4918:2: note: in expansion of macro 'raw_try_cmpxchg64'
     raw_try_cmpxchg64(__ai_ptr, __ai_oldp, __VA_ARGS__); \
     ^~~~~~~~~~~~~~~~~
   drivers/iommu/generic_pt/fmt/amdv1.h:318:9: note: in expansion of macro 'try_cmpxchg64'
     return try_cmpxchg64(tablep, &pts->entry, new);
            ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
   Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y] && !GENERIC_ATOMIC64 [=y]
   Selected by [y]:
   - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]


vim +49 include/linux/bits.h

31299a5e021124 Vincent Mailhol 2025-03-26  35  
19408200c09485 Vincent Mailhol 2025-03-26  36  /*
19408200c09485 Vincent Mailhol 2025-03-26  37   * Generate a mask for the specified type @t. Additional checks are made to
19408200c09485 Vincent Mailhol 2025-03-26  38   * guarantee the value returned fits in that type, relying on
19408200c09485 Vincent Mailhol 2025-03-26  39   * -Wshift-count-overflow compiler check to detect incompatible arguments.
19408200c09485 Vincent Mailhol 2025-03-26  40   * For example, all these create build errors or warnings:
19408200c09485 Vincent Mailhol 2025-03-26  41   *
19408200c09485 Vincent Mailhol 2025-03-26  42   * - GENMASK(15, 20): wrong argument order
19408200c09485 Vincent Mailhol 2025-03-26  43   * - GENMASK(72, 15): doesn't fit unsigned long
19408200c09485 Vincent Mailhol 2025-03-26  44   * - GENMASK_U32(33, 15): doesn't fit in a u32
19408200c09485 Vincent Mailhol 2025-03-26  45   */
19408200c09485 Vincent Mailhol 2025-03-26  46  #define GENMASK_TYPE(t, h, l)					\
19408200c09485 Vincent Mailhol 2025-03-26  47  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
19408200c09485 Vincent Mailhol 2025-03-26  48  	     (type_max(t) << (l) &				\
19408200c09485 Vincent Mailhol 2025-03-26 @49  	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
19408200c09485 Vincent Mailhol 2025-03-26  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
