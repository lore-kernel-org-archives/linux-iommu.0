Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AB261B96;
	Wed, 24 Dec 2025 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547502; cv=none; b=LDJMPLyZjutP6vD+hMJduzY5bsxKcMVwhFuvaqdO14OMaXDb/VT6ya8Wgptu7BKdSRPZPBPm2rlF+qe0XitFxO7Jq6KEzOir/vhq7aIDat3NqYaNfcGXOva1RTozE5qsZ4xR2VIBBqWii8kIUG3sq4LQe5mpNnZceWGTJRsK0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547502; c=relaxed/simple;
	bh=jx5eP+3enRBdEWoLER6u8Qy1rbmoTd1TulfxzryzJJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRT/RHtymUf3WuzdArPqmoAWow3tbzzuK21EoJovy0Ps7B/8G4Z+MDsemMoRrG/9GxAvGu9t5sRrCxQONB8tw07H9fospxjS0ZFSzQtQ4SkqWAGL7d7hL2Log75nfBZ5NY+Ga0QvIe4q4iLtRZ/r2IJLkZQIzsuMopWOmS4ZQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4iKlMnS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4iKlMnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766547501; x=1798083501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jx5eP+3enRBdEWoLER6u8Qy1rbmoTd1TulfxzryzJJM=;
  b=g4iKlMnSO/w/RH/fqwgoPWiGsDgDSctXNuyVSR35X89eqnXQWs1r+hG/
   dx1vs+p/ga9VE8G/0w9bY7CwnyZqKZkWYJfrDbYgchdisbxkxb5c+JbaT
   OBNy4P9lY31adPjBvfkDfh47Xl1QQ+sVZ0RUq+oeV6mc0k59CEG/nF0Pd
   ujtzzvK/TTlRHCgwUJuRG6Jj13uKTmW8YXYsN+Xvzxq+n+fdS4VXqDo8+
   QSjV4U7nF293k5R3Ov4oC0M+AitMz6vPBNbspUSYkr61OQiZSLp+ZkcX8
   Ffov3eDEumb03SWbb+NVrzC6xIDbVQQSViK62ak0PeEES3zx6iAtPS6nf
   w==;
X-CSE-ConnectionGUID: ld+GLDV9TNalVwgF6c2bpA==
X-CSE-MsgGUID: HdX5IS2eQY6IiuU2bdxeWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="67586961"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="67586961"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 19:38:20 -0800
X-CSE-ConnectionGUID: k3rlYyJiQF69AY+B9kf+0Q==
X-CSE-MsgGUID: +y3vX6QCQEucg3pwulKRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="204428705"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Dec 2025 19:38:15 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYFhI-000000002dN-1iSv;
	Wed, 24 Dec 2025 03:38:04 +0000
Date: Wed, 24 Dec 2025 11:37:15 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	saravanak@google.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <202512241124.Tl95CT1C-lkp@intel.com>
References: <20251221213602.2413124-3-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221213602.2413124-3-vijayanand.jitta@oss.qualcomm.com>

Hi Vijayanand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[cannot apply to robh/for-next pci/next pci/for-linus linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20251222-053941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20251221213602.2413124-3-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v3 2/3] of: factor arguments passed to of_map_id() into a struct
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251224/202512241124.Tl95CT1C-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512241124.Tl95CT1C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512241124.Tl95CT1C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/base.c:2078:71: warning: address of array 'arg->map_args.args' will always evaluate to 'true' [-Wpointer-bool-conversion]
    2078 |         if (!np || !map_name || !arg || (!arg->map_args.np && !arg->map_args.args))
         |                                                               ~~~~~~~~~~~~~~~^~~~
   drivers/of/base.c:2136:21: warning: address of array 'arg->map_args.args' will always evaluate to 'true' [-Wpointer-bool-conversion]
    2136 |                 if (arg->map_args.args)
         |                 ~~  ~~~~~~~~~~~~~~^~~~
   drivers/of/base.c:2149:20: warning: address of array 'arg->map_args.args' will always evaluate to 'true' [-Wpointer-bool-conversion]
    2149 |         if (arg->map_args.args)
         |         ~~  ~~~~~~~~~~~~~~^~~~
   3 warnings generated.


vim +2078 drivers/of/base.c

  2047	
  2048	/**
  2049	 * of_map_id - Translate an ID through a downstream mapping.
  2050	 * @np: root complex device node.
  2051	 * @id: device ID to map.
  2052	 * @map_name: property name of the map to use.
  2053	 * @map_mask_name: optional property name of the mask to use.
  2054	 * @arg: contains the optional params, wrapped in a struct of_phandle_args,
  2055	 *	which includes:
  2056	 *	np: pointer to the target device node
  2057	 *	args_count: number of arguments
  2058	 *	args[]: array to receive the translated ID(s).
  2059	 *
  2060	 * Given a device ID, look up the appropriate implementation-defined
  2061	 * platform ID and/or the target device which receives transactions on that
  2062	 * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
  2063	 * @id_out may be NULL if only the other is required. If @target points to
  2064	 * a non-NULL device node pointer, only entries targeting that node will be
  2065	 * matched; if it points to a NULL value, it will receive the device node of
  2066	 * the first matching target phandle, with a reference held.
  2067	 *
  2068	 * Return: 0 on success or a standard error code on failure.
  2069	 */
  2070	int of_map_id(const struct device_node *np, u32 id,
  2071		       const char *map_name, const char *map_mask_name,
  2072		       struct of_map_id_arg *arg)
  2073	{
  2074		u32 map_mask, masked_id;
  2075		int map_len;
  2076		const __be32 *map = NULL;
  2077	
> 2078		if (!np || !map_name || !arg || (!arg->map_args.np && !arg->map_args.args))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
