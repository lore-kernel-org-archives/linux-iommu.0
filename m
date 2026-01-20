Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21923A641A;
	Tue, 20 Jan 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938841; cv=none; b=qMbZj9zieF9YWDGfLQ2vfV8Sbvi1iQaTW/LndZK7njB/l+Oyhw3YSGamJ/7ELNswWTddL+FgEwCF4EYuk7c8xXiZ4Ahgn4rUAf+1OOl6F5b+jRAg56Y6ZkRlfWTrSeBlWYGqWpKzKDdG+vDZeoU/Bm3OGsxn4tj6eXy8DhMbTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938841; c=relaxed/simple;
	bh=kfSaGevMQFowY+aKVSV83hPV0nA0s1ZbBBUZe878q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQYRWP/0S2hGXdUxcVTI6jskRtEQ/ncwP6zJzWbGwWKLsAKaJQadrcV8VV2uONG9J8sVSvLGaP1cGVfkYe16iUQ9jPbfgdstJiV88ZM5WubpG2n97vw1ePMOuyrYT14IvyO/rs6OUf/OOW8di1ZAIOrpbpt1eCU4JXgGahwdpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDBdD237; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDBdD237"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768938840; x=1800474840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfSaGevMQFowY+aKVSV83hPV0nA0s1ZbBBUZe878q3Q=;
  b=UDBdD237EWEIzw85YRHFXvaNuS3GG4hCPKC1WjM5vhDgu3JNH9At2QkU
   OW+25nqNIsZgWQX0ftEcozWSSeIgDUlvBaAToFdz/qadtW++cpbOyOQm/
   D7XWPru67sBxYYOwKeZ1k5ncFqUYCZ+3SnnpE8q/AeUaYnXJnzTZNuuwD
   s5O9ZS8kKMV9GgEeCM8oY8scOoNWkmvfWlQTZn+uqeWcOPob00bvSIhAx
   p3TgrxVPEFrQf0HUNC/RHpoUNy7GqllliwIS2SgC5xPjfvs5CCKPbpp6Y
   MTVopG7tEv9cVjWDdThwSm5qW/sgxlfO7rfAwmN2YfZx3CoiCQBQV4uh9
   A==;
X-CSE-ConnectionGUID: n3zHfes0RiyVnvgl3pUC7w==
X-CSE-MsgGUID: bSqKsNY+SZOb0RGgFVAKJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80881365"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="80881365"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:53:55 -0800
X-CSE-ConnectionGUID: ij5CQKEaTmqLtcKeWjAPfw==
X-CSE-MsgGUID: 3aSxQKx6TVefUIwROoJlkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206130616"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2026 11:53:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viHnO-00000000PSX-1Fbu;
	Tue, 20 Jan 2026 19:53:46 +0000
Date: Wed, 21 Jan 2026 03:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Message-ID: <202601210255.2ZZOLtMV-lkp@intel.com>
References: <20260120064230.3602565-16-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-16-mrathor@linux.microsoft.com>

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on pci/next pci/for-linus arm64/for-next/core soc/for-next linus/master v6.19-rc6]
[cannot apply to clk/clk-next arnd-asm-generic/master next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/iommu-hyperv-rename-hyperv-iommu-c-to-hyperv-irq-c/20260120-145832
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260120064230.3602565-16-mrathor%40linux.microsoft.com
patch subject: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
config: x86_64-randconfig-003-20260120 (https://download.01.org/0day-ci/archive/20260121/202601210255.2ZZOLtMV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210255.2ZZOLtMV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210255.2ZZOLtMV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:60:19: warning: 'setup_hv_full_mmio' defined but not used [-Wunused-function]
      60 | static int __init setup_hv_full_mmio(char *str)
         |                   ^~~~~~~~~~~~~~~~~~


vim +/setup_hv_full_mmio +60 drivers/hv/mshv_root_main.c

    58	
    59	bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
  > 60	static int __init setup_hv_full_mmio(char *str)
    61	{
    62		hv_nofull_mmio = true;
    63		return 0;
    64	}
    65	__setup("hv_nofull_mmio", setup_hv_full_mmio);
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
