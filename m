Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73E20C477;
	Thu, 23 Jan 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634581; cv=none; b=jRAdzmueMWOTKR3YVm1hG9A5kcqOe1vRB+NmiQQmscea1tsy4f1dXSlzFMTlMFEBDq9IMjTeJVdbAD+Z27hMwvk4Kuca/oWi4qlw8q8Tnu29/Lp6YXveb5CHOsCnBsmtdtMsOsITaN8UQ5xxvY04zGOZZznW78eNaikjhlAIz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634581; c=relaxed/simple;
	bh=yJx41nxWQqXvdZ4jM5QwMJB+yrG9cAwxnm9UNLOvU+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOjg61p2dK/xrPEZibBZxkRSGhjysmuIZsRSa4zXzIsJ+mtWC40dithVCzBbP69mSXejE9W8S4ta2snOpcrLs2IpcWtOMAn/DPlVsSfLgqxkO7gs6ZNGGcng+PrhveL7Hy4NcoJm7Te/9WgU0aeGphNkakRz4KMDyaGtnC0CETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI9B9W3o; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI9B9W3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737634579; x=1769170579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yJx41nxWQqXvdZ4jM5QwMJB+yrG9cAwxnm9UNLOvU+4=;
  b=OI9B9W3oN52WfJec7B5BUtWVphUMakjAGYOezZ6n2uK4kqgb0nQ0b2ja
   dRMHO0rAoloWsHGPbVlMpXtNDmw+8Ld0HJ/q/2OAkSxx28g0vsLuWk49R
   Oxk1T/PS3vmOyqrbuTcTL1+rAyU2SbWnc0W+5OrYcSqOEsZcPHrM2/TS9
   M9fCYBw3p0XOT4/+qcZG6dgHJIsUTxy7EvNUjqV5mbDoPeZxpM8lXOXsm
   j/kV5LPKaq8EUWTwRa7bPNajKIZJv0aST0Fa46Fg7CIgjklLc4wRY42lD
   vlXgkQh8OYP548F2pKKRs2iwm6guHJpUSgNgca+5mwlJ23UiWybDmE1uw
   Q==;
X-CSE-ConnectionGUID: KiE22NpySMG75E+ooLqzrA==
X-CSE-MsgGUID: Chf6JoZ8SISSGW03zDWjeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48627261"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="48627261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 04:16:19 -0800
X-CSE-ConnectionGUID: SRYI3lifS8mJ35Lgu/oD8A==
X-CSE-MsgGUID: 0QWccIEfQZGUugFOBniN0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144681480"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2025 04:16:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taw84-000b9j-2a;
	Thu, 23 Jan 2025 12:16:12 +0000
Date: Thu, 23 Jan 2025 20:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
Message-ID: <202501231928.CmUsMTXF-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.13 next-20250123]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zong-Li/iommu-riscv-add-RISC-V-IOMMU-PMU-support/20250115-110456
base:   linus/master
patch link:    https://lore.kernel.org/r/20250115030306.29735-2-zong.li%40sifive.com
patch subject: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
config: riscv-randconfig-r062-20250123 (https://download.01.org/0day-ci/archive/20250123/202501231928.CmUsMTXF-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250123/202501231928.CmUsMTXF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501231928.CmUsMTXF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_event':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:22:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      22 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fortify-string.h:5,
                    from include/linux/string.h:389,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/riscv/include/asm/processor.h:55,
                    from arch/riscv/include/asm/thread_info.h:42,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from arch/riscv/include/asm/pgtable.h:9,
                    from include/linux/pgtable.h:6,
                    from arch/riscv/include/asm/io.h:15,
                    from include/linux/io.h:14,
                    from include/linux/io-64-nonatomic-hi-lo.h:5,
                    from drivers/iommu/riscv/iommu-pmu.c:9:
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:22:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      22 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_partial_matching':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:23:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      23 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:23:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      23 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_pid_pscid':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:24:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      24 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:24:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      24 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_did_gscid':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:25:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      25 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:25:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      25 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_filter_pid_pscid':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:26:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      26 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:26:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      26 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_filter_did_gscid':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:27:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      27 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:27:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      27 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c: In function 'get_filter_id_type':
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:73:34: note: in expansion of macro '__bf_cast_unsigned'
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:19:24: note: in expansion of macro 'FIELD_GET'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                        ^~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:28:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      28 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:19:46: error: 'struct perf_event' has no member named 'attr'
      19 |                 return FIELD_GET(_mask, event->attr.config);            \
         |                                              ^~
   include/linux/bitfield.h:156:35: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/iommu/riscv/iommu-pmu.c:28:1: note: in expansion of macro 'RISCV_IOMMU_PMU_ATTR_EXTRACTOR'
      28 | RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:22,
                    from include/linux/cpumask.h:11:
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_set_period':
>> drivers/iommu/riscv/iommu-pmu.c:235:63: error: 'struct perf_event' has no member named 'pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                                               ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/iommu/riscv/iommu-pmu.c:235:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/io.h:11:
>> drivers/iommu/riscv/iommu-pmu.c:235:63: error: 'struct perf_event' has no member named 'pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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
   drivers/iommu/riscv/iommu-pmu.c:235:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:235:63: error: 'struct perf_event' has no member named 'pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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
   drivers/iommu/riscv/iommu-pmu.c:235:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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
   drivers/iommu/riscv/iommu-pmu.c:235:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     235 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:236:43: error: 'struct perf_event' has no member named 'hw'
     236 |         struct hw_perf_event *hwc = &event->hw;
         |                                           ^~
   In file included from ./arch/riscv/include/generated/asm/local.h:1,
                    from include/asm-generic/local64.h:22,
                    from ./arch/riscv/include/generated/asm/local64.h:1,
                    from include/linux/u64_stats_sync.h:71,
                    from include/linux/cgroup-defs.h:20,
                    from include/linux/cgroup.h:28,
                    from include/linux/perf_event.h:60,
                    from drivers/iommu/riscv/iommu-bits.h:20,
                    from drivers/iommu/riscv/iommu.h:18,
                    from drivers/iommu/riscv/iommu-pmu.c:11:
>> drivers/iommu/riscv/iommu-pmu.c:237:37: error: 'struct hw_perf_event' has no member named 'period_left'
     237 |         s64 left = local64_read(&hwc->period_left);
         |                                     ^~
   include/asm-generic/local.h:29:44: note: in definition of macro 'local_read'
      29 | #define local_read(l)   atomic_long_read(&(l)->a)
         |                                            ^
   drivers/iommu/riscv/iommu-pmu.c:237:20: note: in expansion of macro 'local64_read'
     237 |         s64 left = local64_read(&hwc->period_left);
         |                    ^~~~~~~~~~~~
>> drivers/iommu/riscv/iommu-pmu.c:238:25: error: 'struct hw_perf_event' has no member named 'sample_period'
     238 |         s64 period = hwc->sample_period;
         |                         ^~
   drivers/iommu/riscv/iommu-pmu.c:244:33: error: 'struct hw_perf_event' has no member named 'period_left'
     244 |                 local64_set(&hwc->period_left, left);
         |                                 ^~
   include/asm-generic/local.h:30:44: note: in definition of macro 'local_set'
      30 | #define local_set(l,i)  atomic_long_set((&(l)->a),(i))
         |                                            ^
   drivers/iommu/riscv/iommu-pmu.c:244:17: note: in expansion of macro 'local64_set'
     244 |                 local64_set(&hwc->period_left, left);
         |                 ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:245:20: error: 'struct hw_perf_event' has no member named 'last_period'
     245 |                 hwc->last_period = period;
         |                    ^~
   drivers/iommu/riscv/iommu-pmu.c:251:33: error: 'struct hw_perf_event' has no member named 'period_left'
     251 |                 local64_set(&hwc->period_left, left);
         |                                 ^~
   include/asm-generic/local.h:30:44: note: in definition of macro 'local_set'
      30 | #define local_set(l,i)  atomic_long_set((&(l)->a),(i))
         |                                            ^
   drivers/iommu/riscv/iommu-pmu.c:251:17: note: in expansion of macro 'local64_set'
     251 |                 local64_set(&hwc->period_left, left);
         |                 ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:252:20: error: 'struct hw_perf_event' has no member named 'last_period'
     252 |                 hwc->last_period = period;
         |                    ^~
   drivers/iommu/riscv/iommu-pmu.c:265:25: error: 'struct hw_perf_event' has no member named 'prev_count'
     265 |         local64_set(&hwc->prev_count, (u64)-left);
         |                         ^~
   include/asm-generic/local.h:30:44: note: in definition of macro 'local_set'
      30 | #define local_set(l,i)  atomic_long_set((&(l)->a),(i))
         |                                            ^
   drivers/iommu/riscv/iommu-pmu.c:265:9: note: in expansion of macro 'local64_set'
     265 |         local64_set(&hwc->prev_count, (u64)-left);
         |         ^~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:266:45: error: 'struct hw_perf_event' has no member named 'idx'
     266 |         riscv_iommu_pmu_set_counter(pmu, hwc->idx, (u64)(-left) & max_period);
         |                                             ^~
   drivers/iommu/riscv/iommu-pmu.c:267:9: error: implicit declaration of function 'perf_event_update_userpage'; did you mean 'arch_perf_update_userpage'? [-Wimplicit-function-declaration]
     267 |         perf_event_update_userpage(event);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         arch_perf_update_userpage
   drivers/iommu/riscv/iommu-pmu.c: In function 'riscv_iommu_pmu_event_init':
   drivers/iommu/riscv/iommu-pmu.c:274:63: error: 'struct perf_event' has no member named 'pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                                               ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/iommu/riscv/iommu-pmu.c:274:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:274:63: error: 'struct perf_event' has no member named 'pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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
   drivers/iommu/riscv/iommu-pmu.c:274:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
         |                                       ^~~~~~~~~~~~~~~~~~
   drivers/iommu/riscv/iommu-pmu.c:274:63: error: 'struct perf_event' has no member named 'pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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
   drivers/iommu/riscv/iommu-pmu.c:274:39: note: in expansion of macro 'to_riscv_iommu_pmu'
     274 |         struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
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


vim +19 drivers/iommu/riscv/iommu-pmu.c

    15	
    16	#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)			\
    17		static inline u32 get_##_name(struct perf_event *event)		\
    18		{								\
  > 19			return FIELD_GET(_mask, event->attr.config);		\
    20		}								\
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
