Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67427E07A;
	Thu, 31 Jul 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001584; cv=none; b=UCq5uvbYeM9kL6XFNxlcAs0Bl/kvxMFg9vfq2RGtr06UZJvkFmORUV4j99cEW5FSaoM5Szr4qqaxqtDGlVCDLdtppvWUpEUDFasl0+FaivgHwKVGlInxg5DkvxaxIjL8NmANoUaY1PuQWmGli53Zuk0KEzDOkQ6udugfnRZhfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001584; c=relaxed/simple;
	bh=BJoQKqc8dEBmAiO5Z8FV2c3vOLUzvgwK/3DHeDxEL9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6qGx4OA7fAa4oiJP+MyeDgbDJCdbZYn710dD5vGvUJvyRQV4OJ6b7R8v/49yE0Lip0cx9BOagxKYHHhoPgA3AbTK7R5DtnTHbG0nbGqNh/CcH4PojWIT2Lms40azuuKxy9lSGOTeA5UU1huZZ5MUPWbQMon5nrkee9/3k2pMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJAByOYq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJAByOYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754001583; x=1785537583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJoQKqc8dEBmAiO5Z8FV2c3vOLUzvgwK/3DHeDxEL9s=;
  b=LJAByOYqb3Bxa/w+fdLFl0IMpOyNLRdRrF+O/cJXu8IPI0ngk71VOzwl
   6ObqjeM/pM8kPGvCwXNv7nzgp6yyuo0NprOKLV2/eqO4CnWYVn05FaQsX
   Qn7GNkkNz1/+6i/KxLMlhu6UkZs8MduMPe8Nu5flzOZjv3VeXJJPg/kqh
   HszoKu1ZoZzFZHaVs48x2RHHtpQzKoOKg2AwZvcWG0KDTKoBrAFkPPL8F
   oozmTgCih/JFNQoNGE4tizZ/I/wlnUFI01zfak9M23n8s9PycjOCa4XOw
   jArDbLESb/Z6IWUpKBFZl/gp0fwzhu20OcfwRMiC2CqSTBox4OJ59Hh/u
   A==;
X-CSE-ConnectionGUID: DIsU7+4KRX2CTEiaIDQ7EA==
X-CSE-MsgGUID: BPp+cqqzQgu3qcOwRnu0bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="59988066"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="59988066"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 15:39:42 -0700
X-CSE-ConnectionGUID: lTTSyCyYRXmfpVdt1t6HEw==
X-CSE-MsgGUID: lHqoQGulSQil2iREuf5zqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163096466"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2025 15:39:40 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhbw1-0004AC-1l;
	Thu, 31 Jul 2025 22:39:37 +0000
Date: Fri, 1 Aug 2025 06:39:18 +0800
From: kernel test robot <lkp@intel.com>
To: Seyediman Seyedarab <imandevel@gmail.com>, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: Re: [PATCH v3] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <202508010632.WB0CM5Bz-lkp@intel.com>
References: <20250730205046.29719-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730205046.29719-1-ImanDevel@gmail.com>

Hi Seyediman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16 next-20250731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seyediman-Seyedarab/iommu-vt-d-replace-snprintf-with-scnprintf-in-dmar_latency_snapshot/20250731-045248
base:   linus/master
patch link:    https://lore.kernel.org/r/20250730205046.29719-1-ImanDevel%40gmail.com
patch subject: [PATCH v3] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250801/202508010632.WB0CM5Bz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010632.WB0CM5Bz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508010632.WB0CM5Bz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/intel/debugfs.c: In function 'latency_show_one':
>> drivers/iommu/intel/debugfs.c:651:13: warning: unused variable 'ret' [-Wunused-variable]
     651 |         int ret;
         |             ^~~


vim +/ret +651 drivers/iommu/intel/debugfs.c

a6d268c619d6765 drivers/iommu/intel-iommu-debugfs.c Sohil Mehta         2018-09-11  647  
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  648  static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  649  			     struct dmar_drhd_unit *drhd)
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  650  {
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10 @651  	int ret;
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  652  
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  653  	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  654  		   iommu->name, drhd->reg_base_addr);
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  655  
a6210a36bda1ca1 drivers/iommu/intel/debugfs.c       Seyediman Seyedarab 2025-07-30  656  	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
a6210a36bda1ca1 drivers/iommu/intel/debugfs.c       Seyediman Seyedarab 2025-07-30  657  	seq_printf(m, "%s\n", debug_buf);
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  658  }
456bb0b97f00fe8 drivers/iommu/intel/debugfs.c       Lu Baolu            2021-06-10  659  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
