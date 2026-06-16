Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF53B14B4;
	Tue, 16 Jun 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608940; cv=none; b=NHqOCjegpvve4lpp/GaAKTfJ/HZnxQ+SMU7VAmlw/QwDE4Fm7kIX5ZQRL+2uvM2NVs7PzofqMGVYzI/6nBAGNt8T9Q5ekepcJpPnA9xC0O2285HUJElNC3mlNTjuZr2Rjt2a+3pfLz4U6J1lJcbGEQ30z9omoslrZWRbLMOALjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608940; c=relaxed/simple;
	bh=nohL65ROZIqtmEJOb8WOvehUuPoWHPtjZtI1TlTx0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKe8G9uxoMf2eBp8phREcf98Bx8tbqUOUCS2BP76KtZociG1xEJLVGWgo84xqaq7t896ejiA+FmvaIWM6lOKBTfSZx0tdVTPp0lm1x3n80ktErnxl5PNiRC3qb6l3aAfwyJIYDTEGd+VMA/xxHq5UwQUUDSqUqYiJq9pJYBTf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYVH7dtK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYVH7dtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781608939; x=1813144939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nohL65ROZIqtmEJOb8WOvehUuPoWHPtjZtI1TlTx0/Y=;
  b=gYVH7dtKfdgg3Eo22nsb/iHWy0tGFgJjCp7cgmXALfVh6mrmv71da5o6
   env9lj7QaJmZEws/3zYKV2X1taZYCUoOLfGZHmy0tNSAOJ6UYoZi2OoOu
   qZxzPWPQoZBuDYa0RcNx0lNO+uH/UjYE0HnQieYKtP48rWovtTit0jnxA
   HfmNWH/5ZLudKhxENwICwsJZdxr3LEza/eR7bZyANDWNeFpokO0mGa6iX
   h7mMvjRZCqBSKnyxDL2Gpf7kttdOh26FDL1MPTaIHlvD6PvwSd06atiQI
   fyDDLbaHrWYcf29pJrzKHvpWjWz0VuP/sU0f+daAAjjB/ITr7QXzrCqrS
   w==;
X-CSE-ConnectionGUID: GOw9ThizQ12brdW69eTWyA==
X-CSE-MsgGUID: ilfeQifjSEeYdQUsM+ev2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82271780"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82271780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:22:18 -0700
X-CSE-ConnectionGUID: yuoDe4CTQU+HO5V73soi0g==
X-CSE-MsgGUID: ccB/ruOPR8KdguyS4qxCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="244860539"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2026 04:22:14 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZRrv-00000000T66-2F3Z;
	Tue, 16 Jun 2026 11:22:11 +0000
Date: Tue, 16 Jun 2026 19:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <202606161921.OPkgBApm-lkp@intel.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.1 next-20260615]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/swiotlb-avoid-double-copy-with-swiotlb-on-tx-socket/20260616-074655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260615234220.3946885-1-lrizzo%40google.com
patch subject: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
config: arm-randconfig-r122-20260616 (https://download.01.org/0day-ci/archive/20260616/202606161921.OPkgBApm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161921.OPkgBApm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161921.OPkgBApm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/dma/swiotlb.c: note: in included file (through include/linux/dma-direct.h):
>> include/linux/swiotlb.h:229:65: sparse: sparse: Using plain integer as NULL pointer
>> include/linux/swiotlb.h:229:65: sparse: sparse: Using plain integer as NULL pointer

vim +229 include/linux/swiotlb.h

   224	
   225	static inline bool is_zerocopy_swiotlb_folio(struct page *page)
   226	{
   227		struct folio *folio = page_folio(page);
   228	
 > 229		return folio_test_zcswiotlb(folio) && folio->private != 0;
   230	}
   231	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
