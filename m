Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BC1B582F;
	Tue, 18 Jun 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700826; cv=none; b=PXHdEQ0n6DVbOioUAbdXttct4Xsu+KpBCm8XL6uycL/f8yIkDmAgamfKxIVlLBKZKhZiHEEQIWEFdeDj0CPermDHeLOca7jt7idAi0IzpxkMXh0u/5txDyjxJrLXqepgvE1Dy0g5pgKJwRsXQ53n6ZEMRHkAzWCuyp/OUuJlZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700826; c=relaxed/simple;
	bh=inLr6KbNt1wpmZgzN3mepJkqLnEzfLgSGYhEPkdbx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USOQfHSuagyWY5LOWMjaWhIQHpZy1DlL1VDTEAWQDwVeFwOqEL4J/TFIw2VSPFlTEHOGwI6DJnrAMXUWhviOPQjlb1TzbgDSmd8sjepVXzd9//95gL5DT4lprZRvgX5kv6WnT+AjegKDc09yd0tMTZnOA0URTidoF2rSIWQyZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkHidpyr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkHidpyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718700825; x=1750236825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=inLr6KbNt1wpmZgzN3mepJkqLnEzfLgSGYhEPkdbx3k=;
  b=LkHidpyrFFcmB/zUkNQ01+hnERxOceurz/faaq3kwn+EvAdh1z2AxPEg
   GBrZ5p1c5fQOp1ecZVaNR5tnlG85j7em0GvzoByVKK0hmBhyRn9oJkI+C
   37VB+UL2oSm05tYaAvBuigc8yf8+7Ah4xwqsBwz1bjh69ghzcpcTgozNQ
   5mFIiUOu42sbJsqHyxrKSd3pX5TrHeAHYRAYSZlrKmDAEsTzBoJmdKD1w
   5G7rIEWIfXJsvwxpzc1EkIAUZYGEiSGWI1jbYI9IvNGOl7IZJqfF6QoMO
   XFWz2+NSqbbfpR4gUV+BlFqwjvQHm7vaBiGj8njB8j6O8pq0JIYGG6Mg/
   A==;
X-CSE-ConnectionGUID: Q8rMcLATR5Sr+tEZ3XoywA==
X-CSE-MsgGUID: OWdjBxvBTW2w9FN3C617bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19381976"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19381976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:53:44 -0700
X-CSE-ConnectionGUID: ofTvMbN6RG+m3RtFFOMdwg==
X-CSE-MsgGUID: ghl7bUNaRCi9CD8O20IdFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46605639"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 01:53:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJUav-0005LJ-2z;
	Tue, 18 Jun 2024 08:53:37 +0000
Date: Tue, 18 Jun 2024 16:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robin.murphy@arm.com,
	broonie@kernel.org, conor@kernel.org, nathan@kernel.org,
	robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com,
	devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
	kernel@quicinc.com, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, quic_obabatun@quicinc.com,
	saravanak@google.com, will@kernel.org
Subject: Re: [PATCH] of: reserved_mem: Restructure code to call reserved mem
 init functions earlier
Message-ID: <202406181626.126X1Nbz-lkp@intel.com>
References: <20240617193357.3929092-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617193357.3929092-1-quic_obabatun@quicinc.com>

Hi Oreoluwa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on next-20240617]
[cannot apply to linus/master v6.10-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Restructure-code-to-call-reserved-mem-init-functions-earlier/20240618-033815
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240617193357.3929092-1-quic_obabatun%40quicinc.com
patch subject: [PATCH] of: reserved_mem: Restructure code to call reserved mem init functions earlier
config: i386-buildonly-randconfig-001-20240618 (https://download.01.org/0day-ci/archive/20240618/202406181626.126X1Nbz-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181626.126X1Nbz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406181626.126X1Nbz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/of_reserved_mem.c:551: warning: Function parameter or struct member 'rmem' not described in 'of_init_reserved_mem_node'


vim +551 drivers/of/of_reserved_mem.c

ae1add247bf8c2 Mitchel Humpherys  2015-09-15  546  
3f0c8206644836 Marek Szyprowski   2014-02-28  547  /**
cb40a192099698 Oreoluwa Babatunde 2024-06-17  548   * of_init_reserved_mem_node() - Initialize a saved reserved memory region.
3f0c8206644836 Marek Szyprowski   2014-02-28  549   */
cb40a192099698 Oreoluwa Babatunde 2024-06-17  550  static void __init of_init_reserved_mem_node(struct reserved_mem *rmem)
3f0c8206644836 Marek Szyprowski   2014-02-28 @551  {
cb40a192099698 Oreoluwa Babatunde 2024-06-17  552  	int err;
6f1188b4ac7577 Yue Hu             2020-07-30  553  	bool nomap;
cb40a192099698 Oreoluwa Babatunde 2024-06-17  554  	struct device_node *node = rmem->dev_node;
3f0c8206644836 Marek Szyprowski   2014-02-28  555  
59d2c3cbcb5a47 Oreoluwa Babatunde 2024-05-28  556  	nomap = of_property_present(node, "no-map");
9dcfee01930e6c Marek Szyprowski   2014-07-14  557  
d0b8ed47e83a22 pierre Kuo         2019-02-19  558  	err = __reserved_mem_init_node(rmem);
d0b8ed47e83a22 pierre Kuo         2019-02-19  559  	if (err != 0 && err != -ENOENT) {
a46cccb0ee2d62 Oreoluwa Babatunde 2024-05-28  560  		pr_info("node %s compatible matching fail\n", rmem->name);
d0b8ed47e83a22 pierre Kuo         2019-02-19  561  		if (nomap)
7b25995f5319ad Dong Aisheng       2021-06-11  562  			memblock_clear_nomap(rmem->base, rmem->size);
3c6867a12a224d Dong Aisheng       2021-06-11  563  		else
a46cccb0ee2d62 Oreoluwa Babatunde 2024-05-28  564  			memblock_phys_free(rmem->base, rmem->size);
aeb9267eb6b1df Martin Liu         2023-02-10  565  	} else {
aeb9267eb6b1df Martin Liu         2023-02-10  566  		phys_addr_t end = rmem->base + rmem->size - 1;
59d2c3cbcb5a47 Oreoluwa Babatunde 2024-05-28  567  		bool reusable = of_property_present(node, "reusable");
aeb9267eb6b1df Martin Liu         2023-02-10  568  
6ee7afbabcee4d Geert Uytterhoeven 2023-02-16  569  		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
aeb9267eb6b1df Martin Liu         2023-02-10  570  			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
aeb9267eb6b1df Martin Liu         2023-02-10  571  			nomap ? "nomap" : "map",
aeb9267eb6b1df Martin Liu         2023-02-10  572  			reusable ? "reusable" : "non-reusable",
aeb9267eb6b1df Martin Liu         2023-02-10  573  			rmem->name ? rmem->name : "unknown");
d0b8ed47e83a22 pierre Kuo         2019-02-19  574  	}
d0b8ed47e83a22 pierre Kuo         2019-02-19  575  }
9dcfee01930e6c Marek Szyprowski   2014-07-14  576  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
