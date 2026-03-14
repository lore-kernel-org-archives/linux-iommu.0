Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C030B508;
	Sat, 14 Mar 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475107; cv=none; b=oJN8s4PtMcqqvEO7C9iD0r26tY4SipR6NbgK7lt/Zf+evnXuP0dbn+zdYBChk1h/nSzcPWggCAI9cMFt7Q2sfcQCvvCiWiY+FaWkS/xUN3IeqA0smzsqZ6zXJs3Icvn3hXZyHovprZPTmccHNN7n+AoOhJMCBSoYYmqNlXPAg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475107; c=relaxed/simple;
	bh=/4mO55ZscN1eFQLHdQLwOS7Gxe9h8uCnujezTmQwxyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCG8UDnWT6ZV7dxZ54WXipSMgyDpTApgRqrPNIhuPHPeXl65SVr27HjK3+aNdj6M/BOJypX0AhjkcckRTWwxFwWD1Qf78rKTYbUkvpzkjiWxNtM0wXYiJGwRp3j8Jwt1YLnfb28cXa5E7PvBOUqkO6XeAXDzca59lxV+n1nsJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwvCe+B7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwvCe+B7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773475103; x=1805011103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/4mO55ZscN1eFQLHdQLwOS7Gxe9h8uCnujezTmQwxyE=;
  b=RwvCe+B7l5ou0DV1UwUAUNt81Abh37sSNJaIQZPiqRO2CEeHC1Db2n5V
   O5x72RZSbsX+7/Z9bYdlbfFYwGldRpOqLhVo0TwjvsiEE1wSDwe0iBUrV
   IybI/fbkJpBUG85aW07Dal3foyjcfQ5oSEkk0rx4tCxG63plIDOLOUny6
   EhnkdeYoKZ7KfYpXr/wEU9T4RbWPj3gVL6B/O7609EwlhMcOBycV1HWZy
   F81vN5xDJtKCKapf7I1FH3ls1CkedGndAX5Dtbh7P0Rl3zQQrCid5P2Js
   TxFoWsmL0eAFk4KN56XEhTcKMjjArRxWGCuSaLp55WHoDY7Rp5FADV7aB
   g==;
X-CSE-ConnectionGUID: k12C4VFxSjWqj+pVyHhzXg==
X-CSE-MsgGUID: 4L9fSt7YQiqOH9psSYkAhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="62140689"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="62140689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 00:58:22 -0700
X-CSE-ConnectionGUID: XV8nd9QKRpqyf1cdyxEXxQ==
X-CSE-MsgGUID: K3AoNwyMRBOBlrzhjAovxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="218691536"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 14 Mar 2026 00:58:20 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1Jt3-000000003ld-2H34;
	Sat, 14 Mar 2026 07:58:17 +0000
Date: Sat, 14 Mar 2026 08:57:54 +0100
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
Message-ID: <202603140843.vdpZ0bgs-lkp@intel.com>
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
[also build test WARNING on akpm-mm/mm-everything next-20260313]
[cannot apply to tegra/for-next linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Szyprowski/of-reserved_mem-remove-fdt-node-from-the-structure/20260314-023123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260313150802.1121442-8-m.szyprowski%40samsung.com
patch subject: [PATCH 7/7] of: reserved_mem: rework fdt_init_reserved_mem_node()
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260314/202603140843.vdpZ0bgs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603140843.vdpZ0bgs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603140843.vdpZ0bgs-lkp@intel.com/

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
