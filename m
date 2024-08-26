Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA319D074;
	Mon, 26 Aug 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711918; cv=none; b=q/+0oNGu2+zrphCDvkNjTMGjc5HK1sI2RV2gcR2EifTIABWIDUluLdQN9pcALIG1dzBEPkZQr9M/VfsnfrQuun9s7+N6KBAzcEGujPKOsP0umuzOvBwThxnSC91gX/mdCoQwv0INmm4rXhx4mtqK83uIH2Or/DhWbOwnotgDBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711918; c=relaxed/simple;
	bh=sGYNWyOH1CghbLg8bcfIII/QyfEhcnZ+2s06PiUOs2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXDBZL5eaL2rAFQvqnCUpBRwmIzi7GNhHyvhGFAZfLstWqqgoua+fDk9Z8CGrE50LIRUIlFWgpUTs4IxXulEYLz7B7eTDBVL9vZl83RlIHvW9knstYDHsJxvD+Vrm6GrT4Ysqv7Dx+xBurljClHGkJZ6sP6rPor3t3e6+YSLlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmXkDa/p; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmXkDa/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724711917; x=1756247917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sGYNWyOH1CghbLg8bcfIII/QyfEhcnZ+2s06PiUOs2g=;
  b=nmXkDa/pBsuzttiIeciegeAjQhISzOC904cQWupcEuYtQVMW/XX7SwCY
   IkH9fgw6wEhRls9qAJU7IBTcC1mlvdmtSEuPqiXkOzn0AY8C0C3RVh/GT
   /zb9JlMTongw/gfMFbOfvkEBZEg7DSTWYJXqOdIobv9coCdwYOj6oTOcJ
   HoDSkBGrudutZ63BMImfPS8B+irYRgRhyEWsTwc8f/85i98NpolFXfTtw
   /iFrnSmYjt12rJjJFcH0cwOKMRVW3X6o8WdGU656JNik18Eds3BRcx97H
   fdh0y/wAoZ0Kbgtm3pXGrFmFKKX7JcQ2MsIZ+9kzrSEH7RFqTki2yINmD
   A==;
X-CSE-ConnectionGUID: Z93BMSoWQXuSL22t15acng==
X-CSE-MsgGUID: esoQ+B9gTKGdl4UyUqw0lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26956215"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="26956215"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:38:36 -0700
X-CSE-ConnectionGUID: 90MxcbMcS7mFHJJdrZE2Yw==
X-CSE-MsgGUID: /PRYL0HGSLSOnHw4npvl3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="63382602"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2024 15:38:32 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siiM1-000HfK-39;
	Mon, 26 Aug 2024 22:38:30 +0000
Date: Tue, 27 Aug 2024 06:38:25 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: oe-kbuild-all@lists.linux.dev, jgg@ziepe.ca, baolu.lu@linux.intel.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, jroedel@suse.de, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] iommu/s390: Implement blocking domain
Message-ID: <202408270611.sr21RBzy-lkp@intel.com>
References: <20240823203108.304054-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823203108.304054-1-mjrosato@linux.ibm.com>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Rosato/iommu-s390-Implement-blocking-domain/20240826-163744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240823203108.304054-1-mjrosato%40linux.ibm.com
patch subject: [PATCH v3] iommu/s390: Implement blocking domain
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240827/202408270611.sr21RBzy-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270611.sr21RBzy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270611.sr21RBzy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:374,
                    from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from include/linux/pci.h:27,
                    from drivers/iommu/s390-iommu.c:9:
   drivers/iommu/s390-iommu.c: In function 'zpci_get_iommu_ctrs':
>> include/linux/lockdep.h:252:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     252 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   arch/s390/include/asm/bug.h:54:32: note: in definition of macro 'WARN_ON'
      54 |         int __ret_warn_on = !!(x);                      \
         |                                ^
   include/linux/lockdep.h:285:9: note: in expansion of macro 'lockdep_assert'
     285 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:285:24: note: in expansion of macro 'lockdep_is_held'
     285 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/iommu/s390-iommu.c:707:9: note: in expansion of macro 'lockdep_assert_held'
     707 |         lockdep_assert_held(zdev->dom_lock);
         |         ^~~~~~~~~~~~~~~~~~~


vim +252 include/linux/lockdep.h

f607c668577481 Peter Zijlstra 2009-07-20  251  
f8319483f57f1c Peter Zijlstra 2016-11-30 @252  #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)
f8319483f57f1c Peter Zijlstra 2016-11-30  253  #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
f607c668577481 Peter Zijlstra 2009-07-20  254  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
