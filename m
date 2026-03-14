Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AF29ACDD;
	Sat, 14 Mar 2026 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773459829; cv=none; b=DWTdXphDycWGaJq+nIYuenDRYv+zKJRERRbDWHJmGbXqr0CnIEO+opmtYyIyEj04R4BB8h325PUjiVC8HZuaClTIOwEUCANdvxj2nvCtpk81Uty2osdOG+NhxwoJ7pw6YuiBwmeCWjmUjnlBjR5YWI6Uq6C/7VaFtGW4BgpRgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773459829; c=relaxed/simple;
	bh=kS+cBmQC7gM1gNSUurbOOTzzOTiUZdBmnUD9OtT30Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYxZjFdE9LmpT7FpblWXBpq/LGBmrP2uMsTBKg7niR9aznNdEtdgvjMNJiPsxpxvzcBqtjAkqUQz1saeAeGnoasgD4ztVcGFIJzmztFJFJQHwKz7otfOTOGFXj0OcZvJmuus1ICizKcu2o9cfGW/XWeCndPaJ/M5DyiyA/1ZWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6Bjyn1F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6Bjyn1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773459827; x=1804995827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kS+cBmQC7gM1gNSUurbOOTzzOTiUZdBmnUD9OtT30Lo=;
  b=f6Bjyn1FRX4NMED05V7OyqEOAT2RTIXisJ7nutsVI/HaaIv6GkcwV06C
   QyqLbEu1/n7Cx5P5bcC5eE8x0L6zfmtzUI6F/Mxx31bekj6ACTzZM2Xp+
   a9o65Z55pz7T8BIPYoph6wISMkJxui4wmJWjoSOHYVNjJvRRGPjcYsQAg
   YbT455x1mUWM+7bKi9xXQcJd3Zj6Dsc7XzOIMKcv4aDIvq6LPi0bBwS9Z
   J5OsdiFptoT+pMNiZC7s1FhCwfv9S53w2s+J3GBfChsKINC1lbJLS5qWC
   RHyJX/CATrveQs80av/vPGKceUpShOqzxxuFfAuU3V8KvPYEVcPJuGJFH
   w==;
X-CSE-ConnectionGUID: 1Es5zYFaQ9qWACjpnf+atA==
X-CSE-MsgGUID: rt1rno8MQbSUjvQkaGqKYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74481696"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74481696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 20:43:46 -0700
X-CSE-ConnectionGUID: UKSJurcGQnWhOrTi8Ezv7Q==
X-CSE-MsgGUID: talYbqnkSdie1UjmS14HqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="226026513"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Mar 2026 20:43:44 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1Fuf-000000004c7-0vqk;
	Sat, 14 Mar 2026 03:43:41 +0000
Date: Sat, 14 Mar 2026 11:43:24 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 7/7] of: reserved_mem: rework fdt_init_reserved_mem_node()
Message-ID: <202603141108.XvqRlNaY-lkp@intel.com>
References: <20260313150802.1121442-8-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313150802.1121442-8-m.szyprowski@samsung.com>

Hi Marek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on akpm-mm/mm-everything linus/master v7.0-rc3 next-20260311]
[cannot apply to tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Szyprowski/of-reserved_mem-remove-fdt-node-from-the-structure/20260314-023123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260313150802.1121442-8-m.szyprowski%40samsung.com
patch subject: [PATCH 7/7] of: reserved_mem: rework fdt_init_reserved_mem_node()
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20260314/202603141108.XvqRlNaY-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141108.XvqRlNaY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141108.XvqRlNaY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'uname' not described in 'fdt_init_reserved_mem_node'
>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'base' not described in 'fdt_init_reserved_mem_node'
>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'size' not described in 'fdt_init_reserved_mem_node'
>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'uname' not described in 'fdt_init_reserved_mem_node'
>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'base' not described in 'fdt_init_reserved_mem_node'
>> Warning: drivers/of/of_reserved_mem.c:580 function parameter 'size' not described in 'fdt_init_reserved_mem_node'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
