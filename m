Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAC20B7E0;
	Thu, 23 Jan 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621331; cv=none; b=oiKC1dWEmJ4vxyRGb9jtPqcG6NV8NOxMTRnS+eDGBZkSJCF3HQ0yIK0OIUXv2SQhqM45FWjXE8DqjlHbaxCurlwbsKyewCB8lZOgGLHKfM5vvUkqYK3dga7JZ1BLOEZDstt05CSoGrXia6l8GsWjZ1QMWBMMAkMjut4OPQWKKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621331; c=relaxed/simple;
	bh=/1d/6Z7TuwVupbO9YBCQC73Ztb7Nj+5N4NrrWQZZg34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlnrPlBn5MaWw2iGJi8rDoid8Vy64wkNbOJOyK3H49yVMEcqBZzbnpIDhjld89/TVNTxcFPqJ85s5NmP5/1+7FMIycUTt7WDlf1bpUqqrEM6gSddduewYbPqNgQIR6ngO8k4U39RC8MgnVhwY6Ql4V/Dg7LawLAjSTLfrpharsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cicyGAZb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cicyGAZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737621329; x=1769157329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1d/6Z7TuwVupbO9YBCQC73Ztb7Nj+5N4NrrWQZZg34=;
  b=cicyGAZbHVci1A//aggaF7IOW0Tb72Wz8N7oYicjhk3qp+0fFqKs3rX+
   iskQ9pJeRKaT6wqOJx7JGJgFpDgDcDlXFOpXDwlvFVL1ktK/h5OCf+RYt
   tzPRqUkcDu05oUHqS8Ek8ylfvjP3Gd61kNRiWbLe2LeYP3jTeansyqWRP
   YNelAHLqNhH4OfgOcv4zB38SP8VID/0wf1yRsSJchTvL2amuipaX9OHXy
   gaLK/033O5b+/+ij7zw5MEBasV5sEMVQekpNmAwwegOhOSNxDNZtixqfa
   viSuR9+qLMeCL05SRnmlh8oAYcCE9AjXDpJlqPWYCr34dZB67o7pd+KsL
   w==;
X-CSE-ConnectionGUID: /UmB8NOtSlCjgcYBDhj4og==
X-CSE-MsgGUID: 8dPWAqpMT8+S8fL1fguGcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55525305"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55525305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 00:35:29 -0800
X-CSE-ConnectionGUID: 1Kr0ND6fQPqXXXXdvrH2cw==
X-CSE-MsgGUID: 2i6kyOf3RYeEJIpGrzZX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107825838"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jan 2025 00:35:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tasgN-000awZ-1F;
	Thu, 23 Jan 2025 08:35:23 +0000
Date: Thu, 23 Jan 2025 16:35:17 +0800
From: kernel test robot <lkp@intel.com>
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
Message-ID: <202501231613.OiXGj7hO-lkp@intel.com>
References: <20250115030306.29735-2-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115030306.29735-2-zong.li@sifive.com>

Hi Zong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13 next-20250122]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zong-Li/iommu-riscv-add-RISC-V-IOMMU-PMU-support/20250115-110456
base:   linus/master
patch link:    https://lore.kernel.org/r/20250115030306.29735-2-zong.li%40sifive.com
patch subject: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
config: riscv-randconfig-r062-20250123 (https://download.01.org/0day-ci/archive/20250123/202501231613.OiXGj7hO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250123/202501231613.OiXGj7hO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501231613.OiXGj7hO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/riscv/iommu-pmu.c:368:12: error: 'struct hw_perf_event' has no member named 'idx'
     368 |         hwc->idx = idx;
         |            ^~
   drivers/iommu/riscv/iommu-pmu.c:369:12: error: 'struct hw_perf_event' has no member named 'state'
     369 |         hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
         |            ^~
   drivers/iommu/riscv/iommu-pmu.c:369:22: error: 'PERF_HES_STOPPED' undeclared (first use in this function)
     369 |         hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
         |                      ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:369:41: error: 'PERF_HES_UPTODATE' undeclared (first use in this function); did you mean 'PERF_EF_UPDATE'?
     369 |         hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
         |                                         ^~~~~~~~~~~~~~~~~
         |                                         PERF_EF_UPDATE
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_del':
   drivers/iommu/riscv/iommu-pmu.c:387:43: error: 'struct perf_event' has no member named 'hw'
     387 |         struct hw_perf_event *hwc = &event->hw;
         |                                           ^~
   drivers/iommu/riscv/iommu-pmu.c:388:63: error: 'struct perf_event' has no member named 'pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                                               ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/iommu/riscv/iommu-pmu.c:388:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:388:63: error: 'struct perf_event' has no member named 'pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                                               ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:14:32: note: in expansion of macro 'container_of'
      14 | #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
         |                                ^~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:388:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:388:63: error: 'struct perf_event' has no member named 'pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                                               ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:14:32: note: in expansion of macro 'container_of'
      14 | #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
         |                                ^~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:388:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:483:27: error: expression in static assertion is not an integer
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:14:32: note: in expansion of macro 'container_of'
      14 | #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
         |                                ^~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:388:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     388 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:389:22: error: 'struct hw_perf_event' has no member named 'idx'
     389 |         int idx = hwc->idx;
         |                      ^~
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_handle_irq':
   drivers/iommu/riscv/iommu-pmu.c:399:33: error: storage size of 'data' isn't known
     399 |         struct perf_sample_data data;
         |                                 ^~~~
   drivers/iommu/riscv/iommu-pmu.c:418:29: error: 'struct perf_event' has no member named 'hw'
     418 |                 hwc = &event->hw;
         |                             ^~
   drivers/iommu/riscv/iommu-pmu.c:421:17: error: implicit declaration of function 'perf_sample_data_init' [-Wimplicit-function-declaration]
     421 |                 perf_sample_data_init(&data, 0, hwc->last_period);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:421:52: error: 'struct hw_perf_event' has no member named 'last_period'
     421 |                 perf_sample_data_init(&data, 0, hwc->last_period);
         |                                                    ^~
   drivers/iommu/riscv/iommu-pmu.c:425:21: error: implicit declaration of function 'perf_event_overflow'; did you mean 'perf_event_period'? [-Wimplicit-function-declaration]
     425 |                 if (perf_event_overflow(event, &data, regs))
         |                     ^~~~~~~~~~~~~~~~~~~
         |                     perf_event_period
>> drivers/iommu/riscv/iommu-pmu.c:399:33: warning: unused variable 'data' [-Wunused-variable]
     399 |         struct perf_sample_data data;
         |                                 ^~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_init':
   drivers/iommu/riscv/iommu-pmu.c:459:15: error: implicit declaration of function 'perf_pmu_register' [-Wimplicit-function-declaration]
     459 |         ret = perf_pmu_register(&pmu->pmu, name, -1);
         |               ^~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_uninit':
   drivers/iommu/riscv/iommu-pmu.c:485:9: error: implicit declaration of function 'perf_pmu_unregister'; did you mean 'device_unregister'? [-Wimplicit-function-declaration]
     485 |         perf_pmu_unregister(&pmu->pmu);
         |         ^~~~~~~~~~~~~~~~~~~
         |         device_unregister
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_event':
>> drivers/iommu/riscv/iommu-pmu.c:20:9: warning: control reaches end of non-void function [-Wreturn-type]
      20 |         }                                                               \
         |         ^
   drivers/iommu/riscv/iommu-pmu.c:22:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      22 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/data +399 drivers/iommu/riscv/iommu-pmu.c

   396	
   397	irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
   398	{
 > 399		struct perf_sample_data data;
   400		struct pt_regs *regs;
   401		u32 ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
   402		int idx;
   403	
   404		if (!ovf)
   405			return IRQ_NONE;
   406	
   407		riscv_iommu_pmu_stop_all(pmu);
   408	
   409		regs = get_irq_regs();
   410	
   411		for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
   412			struct perf_event *event = pmu->events[idx];
   413			struct hw_perf_event *hwc;
   414	
   415			if (WARN_ON_ONCE(!event) || !is_sampling_event(event))
   416				continue;
   417	
   418			hwc = &event->hw;
   419	
   420			riscv_iommu_pmu_update(event);
   421			perf_sample_data_init(&data, 0, hwc->last_period);
   422			if (!riscv_iommu_pmu_set_period(event))
   423				continue;
   424	
   425			if (perf_event_overflow(event, &data, regs))
   426				riscv_iommu_pmu_stop(event, 0);
   427		}
   428	
   429		riscv_iommu_pmu_start_all(pmu);
   430	
   431		return IRQ_HANDLED;
   432	}
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
