Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058626AC1;
	Sun, 22 Sep 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727026449; cv=none; b=RrSC+1Mpmoy2qSoqOVLJXy29mimKgqfLP78IpYC4BxZKd3RrHyfupXgiptEA/am3WaQNAwWDdDt5Y4b1I7ia8qJMZmJJcrYj5wucbZc2FvH4GlQIT85+z8s3iV+rMCRYzicuHr5b9rPu2uX47eOI3iNDvSAm0wGtd9Wy7F2dr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727026449; c=relaxed/simple;
	bh=q+nY30eSQi8XhpsS8mansxxUAG2eTX42CgjWvRxksGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svlfcUkK2qqei0SUGRRSxA8GNEBL7gHYt+MAbcKcJ6/H1ZuGzwfkGFgMLIYy6BEOb1s8lKXUwJWU6gUoGIpeVbKonR7+zGiCe8CgFIHNAA7S71dNEbI5NwMDVex5HltXqO/ia1PHjHvlMoYiyh73X0wEkF3k3N4cajtcfXwGvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMNn8DL8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMNn8DL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727026447; x=1758562447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+nY30eSQi8XhpsS8mansxxUAG2eTX42CgjWvRxksGM=;
  b=WMNn8DL8cSJ+WcLdQPDEP7UsWeHdd+jumg2ww5HPbw53sbUTagit+8mh
   SwllYv9eoamvcDJ2XQPb1qnjzBbpnYAZnMYkm2yZtODgRNYQugFVKkZEc
   Ql604dLsCZVh3NWzmK0U1pbj0Uspivr/NhrrVVObCkzKm8VfF8K9NSzeu
   IcIgTfTPUhnkHZY0BsOAkNqFusOM6zR/4hdMaIPAn8Pwd/qy2vmu+Rvj6
   nqaLqI0f3eQ6ECEl6TQNiNmQapc8GCZEvOo6gaLzwkTgTDIuSpS0oYGFr
   Cx6rSQkXZnYoejuMtBuKycztWrqPu0jx/xwZ+57aqWT/uT733FQZviWlC
   A==;
X-CSE-ConnectionGUID: +6PtPCVDQESfpeNgWiR9HQ==
X-CSE-MsgGUID: s8NZBlX4SpmAuYZ/2HHOCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="51392055"
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="51392055"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 10:34:06 -0700
X-CSE-ConnectionGUID: 7ae7EIceRbWpguvBDWASWA==
X-CSE-MsgGUID: JdQfHlWjR6Slgp8P8Ek8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="70437983"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Sep 2024 10:34:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssQTC-000GXn-0P;
	Sun, 22 Sep 2024 17:34:02 +0000
Date: Mon, 23 Sep 2024 01:34:00 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH] dma-mapping: report unlimited DMA addressing in IOMMU
 DMA path
Message-ID: <202409230154.l43KmO8q-lkp@intel.com>
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
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240923/202409230154.l43KmO8q-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230154.l43KmO8q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409230154.l43KmO8q-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/dma/mapping.c: In function 'dma_addressing_limited':
>> kernel/dma/mapping.c:929:48: error: expected ')' before 'return'
     929 |         if (unlikely(ops) || use_dma_iommu(dev)
         |            ~                                   ^
         |                                                )
     930 |                 return false;
         |                 ~~~~~~                          
>> kernel/dma/mapping.c:932:1: error: expected expression before '}' token
     932 | }
         | ^
>> kernel/dma/mapping.c:932:1: warning: control reaches end of non-void function [-Wreturn-type]
     932 | }
         | ^


vim +929 kernel/dma/mapping.c

   912	
   913	/**
   914	 * dma_addressing_limited - return if the device is addressing limited
   915	 * @dev:	device to check
   916	 *
   917	 * Return %true if the devices DMA mask is too small to address all memory in
   918	 * the system, else %false.  Lack of addressing bits is the prime reason for
   919	 * bounce buffering, but might not be the only one.
   920	 */
   921	bool dma_addressing_limited(struct device *dev)
   922	{
   923		const struct dma_map_ops *ops = get_dma_ops(dev);
   924	
   925		if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
   926				 dma_get_required_mask(dev))
   927			return true;
   928	
 > 929		if (unlikely(ops) || use_dma_iommu(dev)
   930			return false;
   931		return !dma_direct_all_ram_mapped(dev);
 > 932	}
   933	EXPORT_SYMBOL_GPL(dma_addressing_limited);
   934	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
