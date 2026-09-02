Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AE3A6F10;
	Wed,  2 Sep 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346083; cv=none; b=pkgld1YYsQ0O6eHrLNUtD8eqGjaCVDkyye5+GZjimCPMCqIpzWgr/bDCaKpYDs+aVrhLd2oAraAEbN9f6m+dB5Q7OoJ49xdLgha5bG0mfHkUdAGoU75QPNIfp22Hr8d7NshaF0iONGp8CNzvVyVAkMfheqrRcGsWlRYvGdN91Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346083; c=relaxed/simple;
	bh=vZlG5m1ZAQCyWaYN4HLngxXQ5Pq996ykeeql5eKTPlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUcvK6sPZ67ZW2vg3HzyHKssgM//FIjtulTfQiuQhazyEZz2DTSkM9vyFu6Bl+Y5IL0vVHtECz7YlQhncCv7VlyKO01ZqEPer4M4wKuG5T0tQNPl/xlFdBVoYpkSvICt2G2MT1zUbAUZK3JskodyTpdL4pXf9OVj00IfUVZQYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb4ZwIvU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb4ZwIvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788346078; x=1819882078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZlG5m1ZAQCyWaYN4HLngxXQ5Pq996ykeeql5eKTPlw=;
  b=Hb4ZwIvU9a2MP8owNhp3NCO6mMMrhs8IuPXhr/InHuqmHKcUl1HkqEFr
   Hr7vA64RKQ7fy+L0tV14uvNgxMETl6N96u/qONfv+VtxQx3j3LGEc4V5T
   X3Ul3s1ug8FOFUlY4XCBTG5IgXFqY+q+/EhU7icKaGdLMDWHBqdBG2aAK
   2MCtKXCCCcZ6k4ZMjrny1q7ItG9ou33XqQnx1XaW8XTH68kjNXESO+yBR
   EsGm/PSo2nuL/UL6kfcNC/PTaoNmZ6QBD2qYxfyRpGMDOwbmen7XRb+t7
   QCWbCNigeOSz+tImIufOyc/8L7rqoHh9wsPRBryPQqRzqwhk7SEeMTuTC
   A==;
X-CSE-ConnectionGUID: fxrDzmZKRmaTjPsU6RXGPQ==
X-CSE-MsgGUID: WkiPe7UqSZe7G9ognTz6VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88726018"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88726018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:47:54 -0700
X-CSE-ConnectionGUID: OAkEpfk3SP6H+5N8rxKlbg==
X-CSE-MsgGUID: 98th5GGNQhWMXTtoR3GliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="292884431"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2026 03:47:52 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1iVR-000000002Qk-1U2L;
	Wed, 02 Sep 2026 10:47:49 +0000
Date: Wed, 2 Sep 2026 18:47:14 +0800
From: kernel test robot <lkp@intel.com>
To: Qingfang Deng <qingfang.deng@linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH] dma-mapping: use exact allocation for DMA pages
Message-ID: <202609021852.48BS9Wph-lkp@intel.com>
References: <20260901085348.53140-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901085348.53140-1-qingfang.deng@linux.dev>

Hi Qingfang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.3-rc1 next-20260901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qingfang-Deng/dma-mapping-use-exact-allocation-for-DMA-pages/20260901-165347
base:   linus/master
patch link:    https://lore.kernel.org/r/20260901085348.53140-1-qingfang.deng%40linux.dev
patch subject: [PATCH] dma-mapping: use exact allocation for DMA pages
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20260902/202609021852.48BS9Wph-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021852.48BS9Wph-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021852.48BS9Wph-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: check_ram_in_range_map+0xc0 (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages.isra.0+0xab (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: try_to_run_init_process+0x24 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
