Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED731EEC3;
	Fri,  1 May 2026 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777615114; cv=none; b=e+vpgEUUt++Qg0XIk+K2C8D8Wa8hWKb8XnjKDGRSrkvexh5UiM4XvlHzSxupWk5zF4gbRnCf58Qy8C5hcudJ5EFzS+W0c6FW56a48O1h2rGcseDYw2y6u/zW7cn7aqrEUtA9sdSXNTa8i0YtS6ZaopUac0+6PuKBfAwACeujggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777615114; c=relaxed/simple;
	bh=yAcfkxfbR2la1pdfQAuJBKYDWqtlUkcS9+Sx+Dtk6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHNTZDX7C+SEi1v5XiP2hKgoiqPNTkGikmuyZi2IMDniEJ5imrvk3qxAleX2oBywYzIlnfSDbq9gWekvhzVI6WLMj8yskE4iICHvxEvbLqXvCbo5dQQ4nDSyb8lhETpbS+Ljut5PINvYsAnIr3saTCdq7ISIS5MC3ZY0NCSUBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFXqKAJW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFXqKAJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777615113; x=1809151113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yAcfkxfbR2la1pdfQAuJBKYDWqtlUkcS9+Sx+Dtk6WE=;
  b=JFXqKAJW8row9fpDCE9KrPNgMu59wbDRkjK1oM/imZa4oQOcighZE3pB
   KyZZHXRz8filDDTYcYcZg7U4IxG7cXlTRxJ4WSxMZYpuxTUJfF1k1NlnL
   UMnJY1OrOyepbNfkgLzOdqloNOCBQVYtBsDfyZ7gl/SaPrG/RtIlDAOUT
   DjzDucbY56SULq5zpDk3WqddcoPx9cQztz1p0qsMDalFl4nAue90MeiFe
   isHlOiVmImSolaLLln+7A3ekwJou9PdZN0r63QK4wOVXIJL6bP37YQNJR
   lJrmyzi7fclv0JYjzYfg4/vLCMPdGIJc/ITVn2avkfHegeaZ7201py4vo
   A==;
X-CSE-ConnectionGUID: AhBJfMTNSAaBOwLSJkhMQg==
X-CSE-MsgGUID: UCOgdKwVRbCJMGEX8ueRJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="66112812"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="66112812"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 22:58:32 -0700
X-CSE-ConnectionGUID: AXnJJ+04T3eT2pp35tH8sg==
X-CSE-MsgGUID: t0eMZvkhQCKmdnSeyLrGjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="258376842"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2026 22:58:28 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIgtN-000000000EX-13VW;
	Fri, 01 May 2026 05:58:25 +0000
Date: Fri, 1 May 2026 13:57:47 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Subject: Re: [PATCH v3] dma-contiguous: setup default numa cma area if not
 configured explicitly
Message-ID: <202605011354.YrrRWXdx-lkp@intel.com>
References: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428060550.7167-1-feng.tang@linux.alibaba.com>

Hi Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/dma-contiguous-setup-default-numa-cma-area-if-not-configured-explicitly/20260430-073422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260428060550.7167-1-feng.tang%40linux.alibaba.com
patch subject: [PATCH v3] dma-contiguous: setup default numa cma area if not configured explicitly
config: x86_64-randconfig-r112-20260501 (https://download.01.org/0day-ci/archive/20260501/202605011354.YrrRWXdx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260501/202605011354.YrrRWXdx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605011354.YrrRWXdx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/cma.c:57:12: sparse: sparse: function 'cma_get_nid' with external linkage has definition

vim +/cma_get_nid +57 mm/cma.c

    56	
  > 57	extern int cma_get_nid(const struct cma *cma)
    58	{
    59		return cma->nid;
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
