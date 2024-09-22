Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6DE56E;
	Sun, 22 Sep 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024586; cv=none; b=MW3/AjIFix1qyK2ldw5TSaZupk6dgkJB7+5bLEdwQUravnBaEPvDepZ2/HvxTCLcvBTejcXRvqp4BhUTeTKBAMiSYQuVC1GCeY30qeBr9dsMLIVym+jMNJp5hTU3COHNpIWvyNeI4IU8lXp2VBUrTS1tv3hvjj1EbuW9QVFaf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024586; c=relaxed/simple;
	bh=mh2HeKE0WnLISAnekW9FWUDRpLFghSKUkG+82RSqAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrkg35fOMBDi8fKwEKw5lWGfOCfUJWByJGk06bdooJLJnCJZQsgwCtSwYtu0eP78+7PXki1KY21qP45WI8oBAXlTCD2gvZpGyNZ0/e5Y4+9KtSk/YkXTi4mP+qGu8hFnS+vDo/MQ8SvrH9ofcV3sznbFZY+xPIsD2msP/uFvFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9GP6PMU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9GP6PMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727024585; x=1758560585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mh2HeKE0WnLISAnekW9FWUDRpLFghSKUkG+82RSqAHk=;
  b=H9GP6PMU16KoWHsZcTu2qwTu4d64kZzu911r00YeS6GFPSjwWVLdfAvm
   cmpXhkQlWeRAsCKcTL46bPOetv6e3b0hSbn1wet7ihOjRpsRwLzNAWufM
   iNyum0M5xkF6rlrQFqM9j4idQrHlgv6SE+BNlkJcFaSbB5j8j9gGkpZoG
   ATonbmImyDlYjqj7IumDFbBHqG/v9X2IOHlnaPQo45yPQnt5E+jYVFoYG
   HiM18vdviObq95VZ0a8rsIbLTPObuzAHfAUl19LRBZIXyK+iNDV4GuMxf
   cQ1XwolsDtbOB7nvfEWu95LVmyUd4OiM6B45v5X8N6VpLjc3N89ZOsBmf
   g==;
X-CSE-ConnectionGUID: q8UyS4fSReyn52fBGvesqQ==
X-CSE-MsgGUID: 9UJfEmyfQv2X0ca6k1Hpqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29762201"
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="29762201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 10:03:04 -0700
X-CSE-ConnectionGUID: Y6syb9qGROSXbfP5p1JF3w==
X-CSE-MsgGUID: HTODBENaQPeLwf4NOFBg3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="108271558"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Sep 2024 10:03:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssPz8-000GWE-2W;
	Sun, 22 Sep 2024 17:02:58 +0000
Date: Mon, 23 Sep 2024 01:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] dma-mapping: report unlimited DMA addressing in IOMMU
 DMA path
Message-ID: <202409230026.u9gtxAOt-lkp@intel.com>
References: <92f61e9627003eeeee1bc5fc8b32e59d7c932a33.1727015030.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f61e9627003eeeee1bc5fc8b32e59d7c932a33.1727015030.git.leon@kernel.org>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Romanovsky/dma-mapping-report-unlimited-DMA-addressing-in-IOMMU-DMA-path/20240922-222704
base:   linus/master
patch link:    https://lore.kernel.org/r/92f61e9627003eeeee1bc5fc8b32e59d7c932a33.1727015030.git.leon%40kernel.org
patch subject: [PATCH] dma-mapping: report unlimited DMA addressing in IOMMU DMA path
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240923/202409230026.u9gtxAOt-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230026.u9gtxAOt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409230026.u9gtxAOt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/dma/mapping.c:930:3: error: expected ')'
     930 |                 return false;
         |                 ^
   kernel/dma/mapping.c:929:5: note: to match this '('
     929 |         if (unlikely(ops) || use_dma_iommu(dev)
         |            ^
   1 error generated.


vim +930 kernel/dma/mapping.c

8ddbe5943c0b12 Christoph Hellwig 2018-12-06  912  
8ae0e970319ac0 Jia He            2023-10-28  913  /**
8ae0e970319ac0 Jia He            2023-10-28  914   * dma_addressing_limited - return if the device is addressing limited
8ae0e970319ac0 Jia He            2023-10-28  915   * @dev:	device to check
8ae0e970319ac0 Jia He            2023-10-28  916   *
8ae0e970319ac0 Jia He            2023-10-28  917   * Return %true if the devices DMA mask is too small to address all memory in
8ae0e970319ac0 Jia He            2023-10-28  918   * the system, else %false.  Lack of addressing bits is the prime reason for
8ae0e970319ac0 Jia He            2023-10-28  919   * bounce buffering, but might not be the only one.
8ae0e970319ac0 Jia He            2023-10-28  920   */
8ae0e970319ac0 Jia He            2023-10-28  921  bool dma_addressing_limited(struct device *dev)
8ae0e970319ac0 Jia He            2023-10-28  922  {
a409d9600959f3 Jia He            2023-10-28  923  	const struct dma_map_ops *ops = get_dma_ops(dev);
a409d9600959f3 Jia He            2023-10-28  924  
a409d9600959f3 Jia He            2023-10-28  925  	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
a409d9600959f3 Jia He            2023-10-28  926  			 dma_get_required_mask(dev))
a409d9600959f3 Jia He            2023-10-28  927  		return true;
a409d9600959f3 Jia He            2023-10-28  928  
cc55895d61e71f Leon Romanovsky   2024-09-22  929  	if (unlikely(ops) || use_dma_iommu(dev)
a409d9600959f3 Jia He            2023-10-28 @930  		return false;
a409d9600959f3 Jia He            2023-10-28  931  	return !dma_direct_all_ram_mapped(dev);
8ae0e970319ac0 Jia He            2023-10-28  932  }
8ae0e970319ac0 Jia He            2023-10-28  933  EXPORT_SYMBOL_GPL(dma_addressing_limited);
8ae0e970319ac0 Jia He            2023-10-28  934  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
