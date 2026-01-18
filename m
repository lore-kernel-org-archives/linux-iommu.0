Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74429E0E6;
	Sun, 18 Jan 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768773449; cv=none; b=C0kOOAA7lvMhQCiInpHV0uldZW2hd84UfS2H1JZi9nq4BfEXir0TFZgG7E47n9fD4bS1O4jO+GcUHMQaYoUzMqnYOyN9rBYj3XhdiMnIWhctS9lrakJ14Ar7N7YCo75rjUf20rx+VdeWXT27U3+Cp7xa8aOyUwcbpBpaoRE5tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768773449; c=relaxed/simple;
	bh=1Fk03iryRzs/uSuAuslbL6hkCiD1JGaxyBQe/j3bSk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyCAMGNqWVgqt+3fT/UKJscTHf+4QyCeKCQdqE63Fe7fn/DeCwfxO7f53e82S9zu13ZPVslJ7O3zCOOm55YnvKAY/qn4hTqp8prGXkEv6EQCfAEzHFykz1TzLisHmtWXU11OtCwlhjrEnh5+jvY9u5d4kbzD8QtZb0tf6qpmJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU1qGvrM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU1qGvrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768773449; x=1800309449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Fk03iryRzs/uSuAuslbL6hkCiD1JGaxyBQe/j3bSk0=;
  b=BU1qGvrMEQ/9eOoP6PK/ol0zOcO8/UX+z8qGhfJq31wMTXep8EBDeRQY
   R7UHwcocoI9zwSYUVHlaai1pXub5+B2E1NO2qOa/F0YV+c5YYGGwg2Waq
   z3CYGnV2hoFp+99Oq/Wt0onRMXPJ0YKHSZceoSU6E9DQOquwtvq0+9mnD
   li32hV8YXw/npvRQs/yRRobKIauvKhMuamW6ItUse2HRzMPEkJNQ9kXcQ
   d2qb2F2saFRJh1iy6iIZUuT9VQPWXNuuWO1PzvZO5eisqeZuLHXGnE8iS
   rHj3Suk7/IqmcmoCvBenHviq0G1Kh+NjDe5dpVVnBFtJBs+TsiOY4xWQz
   A==;
X-CSE-ConnectionGUID: f4y34Io6T5uuQyIOPSFkVA==
X-CSE-MsgGUID: Q/RynfXLQ5qQIbNxnkVklA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69726474"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="69726474"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 13:57:28 -0800
X-CSE-ConnectionGUID: kRo8DRNmQm+iQW+OHmYyJA==
X-CSE-MsgGUID: AadYBTAQTyuKL8IwDUP6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="210195281"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Jan 2026 13:57:23 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhalt-00000000NF3-06b5;
	Sun, 18 Jan 2026 21:57:21 +0000
Date: Mon, 19 Jan 2026 05:57:11 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, vijayanand.jitta@oss.qualcomm.com
Subject: Re: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <202601190548.wFIEEgJC-lkp@intel.com>
References: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>

Hi Vijayanand,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on pci/next pci/for-linus xen-tip/linux-next linus/master v6.19-rc5 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20260119-021706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260118181125.1436036-4-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20260119/202601190548.wFIEEgJC-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190548.wFIEEgJC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190548.wFIEEgJC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/rq-offsets.c:5:
   In file included from kernel/sched/sched.h:31:
   In file included from include/linux/cpufreq.h:17:
>> include/linux/of.h:937:1: error: expected identifier or '('
     937 | {
         | ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1314: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +937 include/linux/of.h

0384e8c6c6fa49 Pantelis Antoniou 2015-01-21  933  
eb8f695e71ec36 Robin Murphy      2026-01-18  934  static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
eb8f695e71ec36 Robin Murphy      2026-01-18  935  			    const char *cells_name, const char *map_mask_name,
eb8f695e71ec36 Robin Murphy      2026-01-18  936  			    struct of_map_id_arg *arg);
2a6db719c92dbf Nipun Gupta       2018-09-10 @937  {
2a6db719c92dbf Nipun Gupta       2018-09-10  938  	return -EINVAL;
2a6db719c92dbf Nipun Gupta       2018-09-10  939  }
2a6db719c92dbf Nipun Gupta       2018-09-10  940  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
