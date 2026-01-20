Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0943DA7E0;
	Tue, 20 Jan 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906203; cv=none; b=MaivNdoAZGHXhqnqUBvfCYWBiXuEKdK6g2y1yJrpVuV0Mxb4zXKNi9M/A7+sGUQZ1UJF4mbCheyl0O2Lqo7SjUVXV8MWqOMWdx/m313c0j7QVflgDFpOrCBRQe++si+IZf2MiL4WoiTlHsC/v/KP5wFrN2dnzbnzrHRXLrz5lQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906203; c=relaxed/simple;
	bh=MwynAAQAluum4MC4e4RB1MZB5tHetTmeywmdNHtAE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgLtmRPhModhQqkPL4kDPoYqXx7UbyoqzAqNU8dSgv/VZ9exsECpioIyUT8QO5PmtJ9RvXF/rMLk0SH3Ll2IoczSO1RGvyrT7L4OPq4tNR2Y5E1Q/lC/JvRm43kQGop6wmvIuNFCB6NZ0Edjss+qt8BSiLWC/8NgC+cug364cwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3EGUfFu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3EGUfFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768906200; x=1800442200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwynAAQAluum4MC4e4RB1MZB5tHetTmeywmdNHtAE+I=;
  b=G3EGUfFuXK0fRacJO79qYzOOsiZwW5vWZJENiD6XUoHebYdGvhydE5Yo
   SJ99+tTYeSqqTpe18RTBMSXbYO3dOlGT737ECKcJoZA07USlagxgvCqgY
   ybj1Yfi35pwkxJ7ZHUuDQI3WKoKTIe64kE9PGtJeiwwhuyPT7PALu6NFs
   gpHdqvsw1axBbDPnTswNcwrsL4x+c4tissuujUFmz5L4oQJEvV4kKoj3M
   dh41cZk3Bt/rN8ZNThZBlD9i4Cd1aUaPHpCBKu9g4Q2VB8+Ds4+i4+MrP
   hWxmoESZLpE0SfPmeCziB7sYD3039nkyN8wD5RpldN+c7o8hNrhiiBWbi
   A==;
X-CSE-ConnectionGUID: 9EChl8gUS+S7I/M5voB/DA==
X-CSE-MsgGUID: tRa5B23xRa+rb7HW7NC14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87691992"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="87691992"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:49:59 -0800
X-CSE-ConnectionGUID: u5IY2F4hRbWyMLTkZ61jrQ==
X-CSE-MsgGUID: yonfwMKISciBNoXmKg4UPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210581981"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jan 2026 02:49:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi9J3-00000000Oqj-1UIB;
	Tue, 20 Jan 2026 10:49:53 +0000
Date: Tue, 20 Jan 2026 18:49:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, jgg@ziepe.ca,
	steven.price@arm.com, Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH 2/2] dma-direct: Make phys_to_dma() pick encrypted vs
 unencrypted per device
Message-ID: <202601201857.7LKBY5dB-lkp@intel.com>
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
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260120/202601201857.7LKBY5dB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201857.7LKBY5dB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201857.7LKBY5dB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/dma/direct.h:10,
                    from kernel/dma/mapping.c:19:
   include/linux/dma-direct.h: In function 'phys_to_dma':
>> include/linux/dma-direct.h:103:13: error: implicit declaration of function 'force_dma_unencrypted'; did you mean 'phys_to_dma_unencrypted'? [-Wimplicit-function-declaration]
     103 |         if (force_dma_unencrypted(dev))
         |             ^~~~~~~~~~~~~~~~~~~~~
         |             phys_to_dma_unencrypted
   include/linux/dma-direct.h: At top level:
>> include/linux/dma-direct.h:125:20: error: conflicting types for 'force_dma_unencrypted'; have 'bool(struct device *)' {aka '_Bool(struct device *)'}
     125 | static inline bool force_dma_unencrypted(struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-direct.h:103:13: note: previous implicit declaration of 'force_dma_unencrypted' with type 'int()'
     103 |         if (force_dma_unencrypted(dev))
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +103 include/linux/dma-direct.h

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
