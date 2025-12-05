Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AA158535;
	Fri,  5 Dec 2025 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907320; cv=none; b=CcvtXaNXcbwEgVdwZmZFtukhExlX/sr5bM9xV/xJYY51UzU0HE23nUuPWyWmxViNTZhH5LP6DHLnKz2OKaFpkv9JNMyq0xz2R2H8Julwckq9DNUnyZJ5osN9bLN4riXlD6jqa4Fb3hGgrDKtpsuBIe9vokhZNIHXTIVDRIAi6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907320; c=relaxed/simple;
	bh=/HYSq2q8FIz1wnGGNePYMUnGmk31R61gQ3VbZFQprkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNihyfoooJ56XjDUo1Wytu6JdGLxGrJo9qIwoL7Ur0F0dHpuAyBqti5yq4MICEGnGVYM42kLv159ZhUIXPLoox/dgn16KDTclt2E3RzKFWgYKbrp625/z/glfSkJma4EPnK6gR1Xn0aqVPr2tAPpZrJI0NluGCsXeU35MqnrzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+XpWqi8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+XpWqi8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764907319; x=1796443319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HYSq2q8FIz1wnGGNePYMUnGmk31R61gQ3VbZFQprkI=;
  b=k+XpWqi85RsnonlwhUXarwL7/M0flJhi4o+V3VEAeFOkUTJwDat/lXel
   +i2bUsoEvyxUpo40N2BNjPnTRhLUpn7B+8NU4enrsFlchH5bKc2aUPZEQ
   gSSLT5HK97OEiPtZ/0MzbefatdVTyhLfs29nwSZdB6Urma9SSoU78eTCo
   6CIGmzGPPC0F389JDZ4625Zra6rI7jm9gVW152DTPH9E9mvr6hD2jez88
   THTYQjA7uyyXBuRPvq46bkQrw4daQ2+UN4dEY4RkMyEtAJRcxIQyftWcW
   wXSmuM66L3yHWT9vFphAFWXueGDst3+WXg3vzao4c6kQAgJjXVnozZhvK
   A==;
X-CSE-ConnectionGUID: sHF8qDHwQzuaeydlJdfi2A==
X-CSE-MsgGUID: cVEJMAzsSWC9ywGkPWz60g==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77558372"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="77558372"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 20:01:59 -0800
X-CSE-ConnectionGUID: VM1ts6KRROOxQ4VmbQSegw==
X-CSE-MsgGUID: epgX+wDHRP6/T/3YhI2TCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="199663552"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Dec 2025 20:01:54 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRN0y-00000000EZJ-2Fku;
	Fri, 05 Dec 2025 04:01:52 +0000
Date: Fri, 5 Dec 2025 12:01:41 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	vijayanand.jitta@oss.qualcomm.com
Subject: Re: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <202512051121.ivp77JHU-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on xen-tip/linux-next]
[also build test ERROR on v6.18]
[cannot apply to robh/for-next pci/next pci/for-linus linus/master next-20251204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20251204-180719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20251204095530.8627-4-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251205/202512051121.ivp77JHU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251205/202512051121.ivp77JHU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512051121.ivp77JHU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:17,
                    from kernel/sched/sched.h:31,
                    from kernel/sched/rq-offsets.c:5:
>> include/linux/of.h:918:1: error: expected identifier or '(' before '{' token
     918 | {
         | ^
>> include/linux/of.h:915:19: warning: 'of_map_id' used but never defined
     915 | static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
         |                   ^~~~~~~~~
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +918 include/linux/of.h

0384e8c6c6fa49d Pantelis Antoniou 2015-01-21  914  
c56888c32d643b3 Robin Murphy      2025-12-04 @915  static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
c56888c32d643b3 Robin Murphy      2025-12-04  916  			    const char *cells_name, const char *map_mask_name,
c56888c32d643b3 Robin Murphy      2025-12-04  917  			    struct of_map_id_arg *arg);
2a6db719c92dbfe Nipun Gupta       2018-09-10 @918  {
2a6db719c92dbfe Nipun Gupta       2018-09-10  919  	return -EINVAL;
2a6db719c92dbfe Nipun Gupta       2018-09-10  920  }
2a6db719c92dbfe Nipun Gupta       2018-09-10  921  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
