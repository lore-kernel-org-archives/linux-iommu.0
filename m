Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5B3D7D7C;
	Tue, 20 Jan 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901635; cv=none; b=YlrAvZsGEerB00/F3Cm1GOmpnCNB9ZR7nsPBJpcyiaWZlnkOXTdQoRYJmYeABKOlhTK022ihosMiLqoLTPravCEWfcBymlPykiNRGF8eO7IxMDxJvDBxpxrbBkOU5504kJVICUqaSJEqUACHPAWpc33dioRjk+GCOrBYHPUwZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901635; c=relaxed/simple;
	bh=i2MBKKc4voAU01sjEwDSFw1LLrzbqEwLRymkIJ/6vOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5ylNudbqrdflC/edipXOEFCdzf10oDzXOg8n705MnIyoCGQW0enYenyCsd2OJ8a6wtTRSbTePyYlDLkbkWGfcsplPXyW3Eh36vvtT0IBwjs2549+SYf2XFKTXLsEwjDtgHjAKANks6vFCfDaUwDrXv4Ui8JgXqd0AdneYPaK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlJHSzz5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlJHSzz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768901635; x=1800437635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2MBKKc4voAU01sjEwDSFw1LLrzbqEwLRymkIJ/6vOI=;
  b=ZlJHSzz5hOFGm/+ypEc4Qsp0QBTXUHeVmVzorhz6EBajzqOiX87gMZcV
   gNA0+EOXo+wdPpN8H1fgJwuXj3D7hZ6Fpviu+wgNrg++UbptOkMUMErnG
   BrjVySHrhvZh4f+LrHRlJe4Oohdi1cUneVEWZMonsMRhHYaaX/rams2jW
   xnaZnhiDQAtnQdqtb9MN+hZgXHlsoq5LKL+sokES68qw8WcAHgtkEcnDx
   hwaQXb7Is+fndw94u3n2FPPB77+QeAbYIzN4pZXVD+t2OFTNFZm2f9qVY
   NOK6XA/0b6hmAgOkGgKBXa00/XFq7cruY+ae/tcADqXACHkRfgtJhnzSx
   w==;
X-CSE-ConnectionGUID: ppwQvf/nT4qzEOPVaF6NUA==
X-CSE-MsgGUID: HrqPuTy8S8ueiZkv8L9rdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70077061"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70077061"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 01:33:54 -0800
X-CSE-ConnectionGUID: WWfqSC3ISgW8D9Q2FGTxpw==
X-CSE-MsgGUID: Zqvi37gDQoi/XaoNFcGMvw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Jan 2026 01:33:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi87P-00000000Olp-3egN;
	Tue, 20 Jan 2026 09:33:47 +0000
Date: Tue, 20 Jan 2026 17:33:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, jgg@ziepe.ca,
	steven.price@arm.com, Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH 2/2] dma-direct: Make phys_to_dma() pick encrypted vs
 unencrypted per device
Message-ID: <202601201747.22JsrCCp-lkp@intel.com>
References: <20260120064255.179425-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064255.179425-2-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/dma-direct-Make-phys_to_dma-pick-encrypted-vs-unencrypted-per-device/20260120-145025
base:   linus/master
patch link:    https://lore.kernel.org/r/20260120064255.179425-2-aneesh.kumar%40kernel.org
patch subject: [PATCH 2/2] dma-direct: Make phys_to_dma() pick encrypted vs unencrypted per device
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260120/202601201747.22JsrCCp-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201747.22JsrCCp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201747.22JsrCCp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/dma/mapping.c:19:
   In file included from kernel/dma/direct.h:10:
>> include/linux/dma-direct.h:103:6: error: call to undeclared function 'force_dma_unencrypted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     103 |         if (force_dma_unencrypted(dev))
         |             ^
   include/linux/dma-direct.h:103:6: note: did you mean 'phys_to_dma_unencrypted'?
   include/linux/dma-direct.h:88:26: note: 'phys_to_dma_unencrypted' declared here
      88 | static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
         |                          ^
      89 |                                                 phys_addr_t paddr)
      90 | {
      91 |         return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
      92 | }
      93 | 
      94 | static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
      95 |                                                phys_addr_t paddr)
      96 | {
      97 |         return dma_addr_encrypted(__phys_to_dma(dev, paddr));
      98 | }
      99 | 
     100 | static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
     101 | {
     102 | 
     103 |         if (force_dma_unencrypted(dev))
         |             ~~~~~~~~~~~~~~~~~~~~~
         |             phys_to_dma_unencrypted
>> include/linux/dma-direct.h:125:20: error: conflicting types for 'force_dma_unencrypted'
     125 | static inline bool force_dma_unencrypted(struct device *dev)
         |                    ^
   include/linux/dma-direct.h:103:6: note: previous implicit declaration is here
     103 |         if (force_dma_unencrypted(dev))
         |             ^
   2 errors generated.


vim +/force_dma_unencrypted +103 include/linux/dma-direct.h

   102	
 > 103		if (force_dma_unencrypted(dev))
   104			return phys_to_dma_unencrypted(dev, paddr);
   105		return phys_to_dma_encrypted(dev, paddr);
   106	}
   107	
   108	static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
   109	{
   110		phys_addr_t paddr;
   111	
   112		dma_addr = dma_addr_canonical(dma_addr);
   113		if (dev->dma_range_map)
   114			paddr = translate_dma_to_phys(dev, dma_addr);
   115		else
   116			paddr = dma_addr;
   117	
   118		return paddr;
   119	}
   120	#endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
   121	
   122	#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
   123	bool force_dma_unencrypted(struct device *dev);
   124	#else
 > 125	static inline bool force_dma_unencrypted(struct device *dev)
   126	{
   127		return false;
   128	}
   129	#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
