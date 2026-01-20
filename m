Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FA3ED11A;
	Tue, 20 Jan 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906802; cv=none; b=cbPAqZBhiOZq6jD8u5ew0YtPgp/KEKFCv1zS44bER4zyWybqoWiqaKfbRMs9ACN5VCWvkQbm8gPBxSYqDeNPYy5UB12EZLY7fRWuCxyzIKILEPKq5/oIoWWiQbCqNuR7XhaI4oSP0yneUmVmDR39lqZKKXLuxeMjyiQVF8k5lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906802; c=relaxed/simple;
	bh=lY4JeADarjlp9LvVA1IUcRgL0c8f7WJjiZIQ38czuho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRBj0g00ZpP4ydmOjpu7jSs8mPg/K0xZPxZ2Y96KZFbY3rnVr4kNitjTo06SFflSQ2ZUC+h5c2v/8YHhSuK6mzAI+vSzir7Zfp5XxsSwd/gYJ8Q7jL+eapRH81WQnsFPTd5y0fEkBlyT0AZZR1fusLpSz9RD/2zzbQ/y5zToftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks7sFK1N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks7sFK1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768906801; x=1800442801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lY4JeADarjlp9LvVA1IUcRgL0c8f7WJjiZIQ38czuho=;
  b=Ks7sFK1Nur4LM+OjDzdEQg+TQDNjH9/Kp1v0lYkO5C7DywZ5+lZdBAwy
   /GN03Apdd3TReksTaId9eGSeskbFlYjhd2WV/oyFIZxilBcQNoui32cea
   Q0a26OKVPR1+wxe1YAXW0a2wMUS/rPVs5uZg+7pOX8H77mPi/dwZnujcs
   Cb0DIa/8Sun+sD0n5eKuOktEUWSNa/SxUDmKjiCWCCv8VP8FsPUFOtN4K
   U+ZcwZyMDmDURLGpIw5ZGCSSSTdxZF21Hy5APRkrjOGV+iR8x9u9u6WIN
   NVhfXu1wI4pIvVgOdMCzHHbnbR8KAxbvVWl+2UhB0/GclEsr5VvsbPVei
   Q==;
X-CSE-ConnectionGUID: cWi0FG4YSi2a2m532pFx3g==
X-CSE-MsgGUID: nZG2z/f+QcStZxUK30IerQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80744710"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80744710"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:00:00 -0800
X-CSE-ConnectionGUID: apOSSKeMRDOj8vy3BB7/jg==
X-CSE-MsgGUID: IiFLw6HiRDOMkap+J+T3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205892918"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Jan 2026 02:59:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi9Sj-00000000OrV-3JHz;
	Tue, 20 Jan 2026 10:59:53 +0000
Date: Tue, 20 Jan 2026 18:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, jgg@ziepe.ca,
	steven.price@arm.com, Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
Message-ID: <202601201822.0I4WAqVW-lkp@intel.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064255.179425-1-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/dma-direct-Make-phys_to_dma-pick-encrypted-vs-unencrypted-per-device/20260120-145025
base:   linus/master
patch link:    https://lore.kernel.org/r/20260120064255.179425-1-aneesh.kumar%40kernel.org
patch subject: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA addresses
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20260120/202601201822.0I4WAqVW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201822.0I4WAqVW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201822.0I4WAqVW-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/dma/direct.c: In function 'dma_direct_supported':
>> kernel/dma/direct.c:564:24: error: implicit declaration of function '__phys_to_dma'; did you mean 'phys_to_dma'? [-Wimplicit-function-declaration]
     564 |         return mask >= __phys_to_dma(dev, min_mask);
         |                        ^~~~~~~~~~~~~
         |                        phys_to_dma


vim +564 kernel/dma/direct.c

   543	
   544	int dma_direct_supported(struct device *dev, u64 mask)
   545	{
   546		u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
   547	
   548		/*
   549		 * Because 32-bit DMA masks are so common we expect every architecture
   550		 * to be able to satisfy them - either by not supporting more physical
   551		 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
   552		 * architecture needs to use an IOMMU instead of the direct mapping.
   553		 */
   554		if (mask >= DMA_BIT_MASK(32))
   555			return 1;
   556	
   557		/*
   558		 * This check needs to be against the actual bit mask value, so use
   559		 * __phys_to_dma() here so that the arch specific encryption mask isn't
   560		 * part of the check.
   561		 */
   562		if (IS_ENABLED(CONFIG_ZONE_DMA))
   563			min_mask = min_t(u64, min_mask, zone_dma_limit);
 > 564		return mask >= __phys_to_dma(dev, min_mask);
   565	}
   566	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
