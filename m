Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DB429814;
	Sat, 28 Feb 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276225; cv=none; b=AWQ3S92knh5CVMSMfzzQ0Mzuek1BUeg8rf24uXL3SAAs9VFoTMCwE7PRC1+Uj8YVyKwaChyDZsfgSXq7wvybv962HF9RgKcKBVlPbo3R2Srf7x9+wUAP46aor+2GmZt7smlddk5zJg4TK3IuoU78xVlhMcQ1MFyFEVHKUZWc3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276225; c=relaxed/simple;
	bh=gyKSskGdhjjwQeex3oN5MrHUMIsbXLRxIWLXycP202k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRiqCFkrH4MZXMqa4zMm3yyERaXG48xO2lGw3IPNtEtQI/GrzRWMt+sM9o1uONKX4jRRqyvx8q5s7GgP7jDzjszWSyqT8hxmDNxpJLlk3T5H9GxgPtlbcRXc1R6xJkkX+ATZ7bBEQNZnMSgPrJYIwO+odJXAQxrQG0xsgp+yDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6cEmTz2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6cEmTz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772276223; x=1803812223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyKSskGdhjjwQeex3oN5MrHUMIsbXLRxIWLXycP202k=;
  b=h6cEmTz2T5XlooUZwcohJZDRqWfdpvowFKxiZscFddGb31zqecHICp2q
   FvwqkVZ2nUZ4sJOCOYxvLBB0F3zSmOObAMRVaR6TyaBEjoV+YDV5P1kMn
   aBlq2KwRGR/xxqBvO+DCMQznGCci+erJ3WQpBQ/8Bsbvi653/Xm3nrSae
   TOp5/l5o9+XLY2bfhahCtI69DuV3Uqjnv4+QO+jqEcal7rZbaPP5CzGqP
   //FqBjmT1tZH37wuqbBWZir657gutcIaVay7bR/Rqyq3zu4HAJRd57dfi
   5Po7DxQbbhrFMplr75bkYPd0tfq27mUj9mJW/aWiM0TI1zaxoZvZbznp2
   g==;
X-CSE-ConnectionGUID: YRFv2R55TF6d7dxFt9ohaA==
X-CSE-MsgGUID: kErfQ5acQCe+HE1wfTLnnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84055354"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="84055354"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:57:03 -0800
X-CSE-ConnectionGUID: QCASG40uQpWUtGdOlznaHQ==
X-CSE-MsgGUID: ZEFmp9z7RAazHDCT+wEIAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="215718074"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2026 02:57:00 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwI0H-00000000BTX-31YE;
	Sat, 28 Feb 2026 10:56:57 +0000
Date: Sat, 28 Feb 2026 18:56:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <202602281837.QQl5six6-lkp@intel.com>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>

Hi Ankit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc1 next-20260227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankit-Soni/iommu-amd-Adhere-to-IVINFO-VASIZE-for-address-limits/20260228-010009
base:   linus/master
patch link:    https://lore.kernel.org/r/cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni%40amd.com
patch subject: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260228/202602281837.QQl5six6-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281837.QQl5six6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281837.QQl5six6-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: ivinfo_vasize_bits+0x8 (section: .text) -> amd_iommu_disabled (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
