Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1F2C0F6E;
	Fri,  5 Dec 2025 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905341; cv=none; b=R64/55DPsWcYXyG+gAqxg2rpzrL6NYyAHUOcRjtkl/K8V4Caih+TAQLtMh4FmPadCtWKhREVvxg1oOPYuRiusSRU2q9TRRGmPssVM5SeoZOKt8IVIjRyfGgAip70OvzArDxRdDbUl3r4vJG7mm0vi7IHfe36Ux3VrEznTNyeru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905341; c=relaxed/simple;
	bh=F6ilXg3TdBlq4gfN3QvHvjybxvknYMzlpZU/ZPeitsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvue4jcp2Ngz/0IQ+YIXNtJ+2VYmIrVzzlmJDIM21m6eKS2Jn0wsLfVgBMScOTGDY7sj4S8hLm1j8TJEEOCWbhGRRKXPrqGFor374EiYpmX7QA5cPNbyKvWWkFlreh5Vm5nuO7JwqpS7kBd2tN1UEfHt8y9i68GBrRqT5wtXda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tn3eN8E7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tn3eN8E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764905339; x=1796441339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6ilXg3TdBlq4gfN3QvHvjybxvknYMzlpZU/ZPeitsg=;
  b=Tn3eN8E7ob7trcQqFymYHQoiNB8bcc7LCbcQF8W+U1umqi+OLEjo2m8Y
   MRnSb2QA7JxZ+CC2TVLew21RktKK3kJeAiPgD8+IZAZ4zBnfUAV0WghFA
   YXEKjXf0Q+vo562D7FhEqtQsRvw3YXbK6pyU29kQON2x7iEF7R/DQ80iq
   SgDfv8id123yi6gxfPEEI3JHjxaoBa6Y9Ag4DNwbQnSIwd50Xbt2ETLp2
   l2Ebyg1MIbd/uvOuxchgBIW/uOUOgeCYsKvtJu4EiR2EDvAGbRULoktS6
   t0uNsgf357skhWFEW/rQyuZki4rmDf/96okTswRm2vpZqie4dhRleb3ux
   w==;
X-CSE-ConnectionGUID: MTNSpiybQWWj342FIOzdMw==
X-CSE-MsgGUID: 0rZ80edgQHClkwv1NTXemA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="65938337"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="65938337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:28:58 -0800
X-CSE-ConnectionGUID: NMeR+TCYRwSHy8H/VIjQiw==
X-CSE-MsgGUID: 7xmNLtkAQd+/kDSWmMZ+CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="194239431"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2025 19:28:54 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRMV1-00000000EXh-1BRC;
	Fri, 05 Dec 2025 03:28:51 +0000
Date: Fri, 5 Dec 2025 11:28:36 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: Re: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <202512051152.PJ6mf512-lkp@intel.com>
References: <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>

Hi Vijayanand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[also build test WARNING on v6.18]
[cannot apply to robh/for-next pci/next pci/for-linus linus/master next-20251204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20251204-180719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20251204095530.8627-4-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251205/202512051152.PJ6mf512-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d8b43edf552840e59a22a7f3cc332697bd434782)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251205/202512051152.PJ6mf512-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512051152.PJ6mf512-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/base.c:2144:7: warning: variable 'cells' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
    2144 |                 if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
         |                     ^~~~~~~~
   drivers/of/base.c:2149:30: note: uninitialized use occurs here
    2149 |                 if (map_len - offset < 3 + cells)
         |                                            ^~~~~
   drivers/of/base.c:2144:7: note: remove the '&&' if its condition is always true
    2144 |                 if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
         |                     ^~~~~~~~~~~
   drivers/of/base.c:2125:30: note: initialize the variable 'cells' to silence this warning
    2125 |                 u32 id_base, phandle, cells, id_len, id_off;
         |                                            ^
         |                                             = 0
   1 warning generated.


vim +2144 drivers/of/base.c

  2065	
  2066	/**
  2067	 * of_map_id - Translate an ID through a downstream mapping.
  2068	 * @np: root complex device node.
  2069	 * @id: device ID to map.
  2070	 * @map_name: property name of the map to use.
  2071	 * @cells_name: property name of target specifier cells.
  2072	 * @map_mask_name: optional property name of the mask to use.
  2073	 * @arg: contains the optional params, @target which is a pointer
  2074	 *	to the target device node and id_out which is a pointer
  2075	 *	to receive the translated ID.
  2076	 *
  2077	 * Given a device ID, look up the appropriate implementation-defined
  2078	 * platform ID and/or the target device which receives transactions on that
  2079	 * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  2080	 * @id_out may be NULL if only the other is required. If @target points to
  2081	 * a non-NULL device node pointer, only entries targeting that node will be
  2082	 * matched; if it points to a NULL value, it will receive the device node of
  2083	 * the first matching target phandle, with a reference held.
  2084	 *
  2085	 * Return: 0 on success or a standard error code on failure.
  2086	 */
  2087	int of_map_id(const struct device_node *np, u32 id, const char *map_name,
  2088		      const char *cells_name, const char *map_mask_name,
  2089		      struct of_map_id_arg *arg)
  2090	{
  2091		u32 map_mask, masked_id;
  2092		int map_bytes, map_len, offset = 0;
  2093		bool bad_map = false;
  2094		const __be32 *map = NULL;
  2095	
  2096		if (!np || !map_name || !arg || (!arg->target && !arg->id_out))
  2097			return -EINVAL;
  2098	
  2099		map = of_get_property(np, map_name, &map_bytes);
  2100		if (!map) {
  2101			if (arg->target)
  2102				return -ENODEV;
  2103			/* Otherwise, no map implies no translation */
  2104			*arg->id_out = id;
  2105			return 0;
  2106		}
  2107	
  2108		if (map_bytes % sizeof(*map))
  2109			goto err_map_len;
  2110		map_len = map_bytes / sizeof(*map);
  2111	
  2112		/* The default is to select all bits. */
  2113		map_mask = 0xffffffff;
  2114	
  2115		/*
  2116		 * Can be overridden by "{iommu,msi}-map-mask" property.
  2117		 * If of_property_read_u32() fails, the default is used.
  2118		 */
  2119		if (map_mask_name)
  2120			of_property_read_u32(np, map_mask_name, &map_mask);
  2121	
  2122		masked_id = map_mask & id;
  2123		while (offset < map_len) {
  2124			struct device_node *phandle_node;
  2125			u32 id_base, phandle, cells, id_len, id_off;
  2126			const __be32 *out_base;
  2127	
  2128			if (map_len - offset < 2)
  2129				goto err_map_len;
  2130	
  2131			id_base = be32_to_cpup(map + offset);
  2132			if (id_base & ~map_mask) {
  2133				pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
  2134					np, map_name, map_mask_name,
  2135					map_mask, id_base);
  2136				return -EFAULT;
  2137			}
  2138	
  2139			phandle = be32_to_cpup(map + offset + 1);
  2140			phandle_node = of_find_node_by_phandle(phandle);
  2141			if (!phandle_node)
  2142				return -ENODEV;
  2143	
> 2144			if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
