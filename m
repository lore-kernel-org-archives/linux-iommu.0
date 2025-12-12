Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2A2DCBF3;
	Fri, 12 Dec 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538396; cv=none; b=j017ACnG/EaUFXzf6KalW5WV5htytAuotjrMghB9OA46S9/zwrFituZgwxt+CR9PTLwAi2OCzIQeGAeivHRfBa0VcCdtH2aCq/FxV8IW5mRtXjFxM0M6qNDmO9frB6KszvRNSnSN8aBWJZXH2+baYhwsnhHqbkoPHVFXJS5yEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538396; c=relaxed/simple;
	bh=CzkX7/2sczqJ1sgcOtvNNN48WRCDW89fEac9ZCuUoB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL/wKSGF2EelF178xLwTDHEKazy40YhB4b9WBIljNxY4FiXY1O8esCSvaGET145WU4q392eor3p/B+Ys64cup3z55VMBc7FJLnO+t90IlKIOpVXi0eztr6+HLCz870fmM3J9AB07mXnKiZg9EYLLAIKK1ns/1vcbX0dPA/nNHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYpFxxBQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYpFxxBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765538394; x=1797074394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CzkX7/2sczqJ1sgcOtvNNN48WRCDW89fEac9ZCuUoB8=;
  b=XYpFxxBQZQpkKBHhnzZ1eS4pDMILpsQG4cRPWnVuH7JdCS4vlqjXfN8B
   Agx1nh9EiRwl2sX6Le/07AAPQPbiKswhqATItr/4eTDBUaM9/Xl0JEOFT
   O2BOMFiedcX94O4FwzNgQwdT/T2fPThioBdujbTwZaydlA3hMXoIE/buf
   obawvgkHdZk4Ujg5Gzhj1UQFVdIuLIQWQSQY4tFnhGO9LSKoXN85mMvt+
   VPHujRYN/RmGvL3ZaKKtPvwQ4gDdvGqIIQg42oohDrMAT93b1xsx/VpVw
   yV508VMzapMaK4zhLw5OshIgia6wtcg6MxiBnpEAXFEstPPWoWQqjh+Cy
   A==;
X-CSE-ConnectionGUID: +JMgOgwgRsCP5CgE8P987Q==
X-CSE-MsgGUID: M7LEQWGZRwmm41OBzRSSmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67610630"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="67610630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:19:53 -0800
X-CSE-ConnectionGUID: mT+4uXErRRq1FjpMxirWOg==
X-CSE-MsgGUID: dnNHcK4HQSWzUsqgeHM2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196969288"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Dec 2025 03:19:49 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vU1Bb-000000005yX-13Y4;
	Fri, 12 Dec 2025 11:19:47 +0000
Date: Fri, 12 Dec 2025 19:19:08 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	robh@kernel.org, m.szyprowski@samsung.com, ye.li@oss.nxp.com
Cc: oe-kbuild-all@lists.linux.dev, oreoluwa.babatunde@oss.qualcomm.com,
	kernel@oss.qualcomm.com, saravanak@google.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, quic_c_gdjako@quicinc.com
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
Message-ID: <202512121907.gdTOodx3-lkp@intel.com>
References: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>

Hi Oreoluwa,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on v6.18]
[cannot apply to robh/for-next linus/master next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Allow-reserved_mem-framework-detect-cma-kernel-param/20251210-082127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251210002027.1171519-1-oreoluwa.babatunde%40oss.qualcomm.com
patch subject: [PATCH] of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param
config: arc-randconfig-001-20251212 (https://download.01.org/0day-ci/archive/20251212/202512121907.gdTOodx3-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121907.gdTOodx3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512121907.gdTOodx3-lkp@intel.com/

All errors (new ones prefixed by >>):

   arc-linux-ld: drivers/of/of_reserved_mem.o: in function `fdt_scan_reserved_mem_reg_nodes':
>> of_reserved_mem.c:(.init.text+0x46e): undefined reference to `cma_skip_dt_default_reserved_mem'
>> arc-linux-ld: of_reserved_mem.c:(.init.text+0x46e): undefined reference to `cma_skip_dt_default_reserved_mem'
   arc-linux-ld: drivers/of/of_reserved_mem.o: in function `fdt_scan_reserved_mem':
   of_reserved_mem.c:(.init.text+0x618): undefined reference to `cma_skip_dt_default_reserved_mem'
   arc-linux-ld: of_reserved_mem.c:(.init.text+0x618): undefined reference to `cma_skip_dt_default_reserved_mem'
   arc-linux-ld: of_reserved_mem.c:(.init.text+0x77c): undefined reference to `cma_skip_dt_default_reserved_mem'
   arc-linux-ld: drivers/of/of_reserved_mem.o:of_reserved_mem.c:(.init.text+0x77c): more undefined references to `cma_skip_dt_default_reserved_mem' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
