Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53A15ADB4;
	Tue,  6 Jan 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707950; cv=none; b=GlAjolafAFt619KbkoO+48JkOEEq4ZvSSqU74NFOAAOv3KuvslCqPF6hT+rCCweGqUo4OWYuqbUQqkuX41c6PT6i4J6mr4I7IEDzGB09kQCoopmCESpaLxLbNKUPrOGBIt4HIoUvaWCiP6LaXi+eFQ4JLI+yP2aWg9hk8sm1pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707950; c=relaxed/simple;
	bh=bATSEUYjKeNS7e/OIXZYGlu3IzOGHEmM0mmg91Ubd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhZWhRADfeKfWturCjo9BFwJRlrsKlF2Hvx8IctqxbJKSOdwIDrOraQH6zJlo4+U5P6lYOf0WjEeDTG2He7+X2AB3f9jejqZB92niDV7igqsErvANpkRJEq+T5cQHujQbGnl4CLPgOgt8fwr3J8qCvhk7NGBsy+iIBU795sj/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC06cU5w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC06cU5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767707949; x=1799243949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bATSEUYjKeNS7e/OIXZYGlu3IzOGHEmM0mmg91Ubd6Y=;
  b=XC06cU5wKTzRM0RE3tGgKGRon4VkTF6eQvGoCkD+PWtb3UwhnoAfVUN0
   bx8arBfkGBWMt8pXFomLY4J/v2Zs1zekAD/Vn6eImxBUSenWf12F0VNmM
   lHLiM5vHI2cPML/3hhMvP+dWzTGJFp0j/K8UsI0T6pLIMdkYiCAVI0paF
   vo2Rl7WbBBLTPN9h3iRR/c2eTerxIftlG5LmbMNbIyQudaLXwPJKwYTeG
   Ed+MiG4UajQ8EGY1s0w1KizJbMKeNg113Ph9eA3r3vg0BE/vDO4ZzAMJl
   i4ESR1Q2lx7q0AYelwCDoqoRErz3ux3V/pldgN7qOaGkuPfaGJn4r6XCE
   g==;
X-CSE-ConnectionGUID: MzOGQRSfQmKY5iMyy18z3g==
X-CSE-MsgGUID: KZHDcwuFS/qx5Ki9MxX9eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72701211"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="72701211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 05:59:08 -0800
X-CSE-ConnectionGUID: Kq4pX/UHTr+BztI2ExfctQ==
X-CSE-MsgGUID: y6VDX6r9SaOkYhyKcKs3pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="226198576"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jan 2026 05:59:04 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vd7aP-000000001zl-18zv;
	Tue, 06 Jan 2026 13:59:01 +0000
Date: Tue, 6 Jan 2026 21:58:53 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	saravanak@google.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <202601062128.BCmw1wNO-lkp@intel.com>
References: <20251231114257.2382820-3-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231114257.2382820-3-vijayanand.jitta@oss.qualcomm.com>

Hi Vijayanand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xen-tip/linux-next]
[cannot apply to robh/for-next pci/next pci/for-linus linus/master v6.19-rc4 next-20260106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20251231-194928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20251231114257.2382820-3-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v4 2/3] of: factor arguments passed to of_map_id() into a struct
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260106/202601062128.BCmw1wNO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260106/202601062128.BCmw1wNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601062128.BCmw1wNO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cdx/cdx_msi.c:8:
   In function 'of_map_msi_id',
       inlined from 'cdx_msi_prepare' at drivers/cdx/cdx_msi.c:131:8:
>> include/linux/of.h:1451:30: warning: 'dev_id' is used uninitialized [-Wuninitialized]
    1451 |         struct of_map_id_arg arg = {
         |                              ^~~
   drivers/cdx/cdx_msi.c: In function 'cdx_msi_prepare':
   drivers/cdx/cdx_msi.c:127:13: note: 'dev_id' was declared here
     127 |         u32 dev_id;
         |             ^~~~~~
--
   drivers/pci/controller/dwc/pci-imx6.c: In function 'imx_pcie_add_lut_by_rid':
>> drivers/pci/controller/dwc/pci-imx6.c:1112:30: warning: 'sid_i' is used uninitialized [-Wuninitialized]
    1112 |         arg.map_args.args[0] = sid_i;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   drivers/pci/controller/dwc/pci-imx6.c:1105:13: note: 'sid_i' was declared here
    1105 |         u32 sid_i, sid_m;
         |             ^~~~~
>> drivers/pci/controller/dwc/pci-imx6.c:1126:17: warning: 'sid_m' is used uninitialized [-Wuninitialized]
    1126 |         err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pci-imx6.c:1105:20: note: 'sid_m' was declared here
    1105 |         u32 sid_i, sid_m;
         |                    ^~~~~


vim +/dev_id +1451 include/linux/of.h

  1447	
  1448	static inline int of_map_msi_id(const struct device_node *np, u32 id,
  1449					struct device_node **target, u32 *id_out)
  1450	{
> 1451		struct of_map_id_arg arg = {
  1452			.map_args = {
  1453				.np = *target,
  1454				.args_count = 1,
  1455				.args = { *id_out },
  1456			},
  1457		};
  1458	
  1459		return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
  1460	}
  1461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
