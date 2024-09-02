Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733711A4E64
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725315268; cv=none; b=VKmuCzttMDIpxHSTShmxNc4AhVTPhx6Ug43G9JK1OoyHLNRe3wa1/LN+0hfQEKXR3oGVlkF7Oq0K6mVyqQd2JJI7kZ0i1pFLELG5HhSIlyIt6YKadKCj774gth3R2hp0HAVOao636qu4ly+yNYdFGs/ua9YZ1mZ8TUX03VV3Mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725315268; c=relaxed/simple;
	bh=bfyM8LCzYKPcTv2GkADgGG3UH9YqZRnEe6dm6Lsq5X8=;
	h=Date:From:To:Subject:Message-ID; b=M/KeXEOGdodTPZcvh4kiTKvFUjTe8gcRkrx8vx2rEeDTfzUuUkyqX0tEtm4a6MDggZnJNVJb4YHncON4zZNIjio7AJWowDPr4VtCTxSLu4rqlZZZhTejtW24/5l9mfA4MveXdjQS08UwTiB0rxBV0KvBC8H07xJ1//QOBdazorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI+jZR2b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI+jZR2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725315266; x=1756851266;
  h=date:from:to:subject:message-id;
  bh=bfyM8LCzYKPcTv2GkADgGG3UH9YqZRnEe6dm6Lsq5X8=;
  b=KI+jZR2bluJ1F4XRZ4VPeoIqRnsr1HyOe0iBWDGilD3uFIGhoU9hIkU4
   Rt+5NOZjo7WvtDtFpfF1RIPcjhGJJ/JVlj+pzpLbo5Utd/tbA4BxW0kud
   frsBTGd7n2TQ56qi0mt7RuqXp8QlT/1jFj9YWnoO9QLCNn6QYGIc16XSU
   +n2qPe+Z5g6Yv2CRtCmLWJRqRYNr4BETJtQvXbEJSeO0E+5kOvQjPCIPE
   Iv0+OVQKJLhEmvXJkmz692Xu0Y37i0j9pWX7+Y0NfYo3W5G+T/dS91KLZ
   3dRiuYb4d5P2ow9/5LVlW3K1i7y2XOJPIdzYcObX4m+t6bdtGJUXtagKv
   g==;
X-CSE-ConnectionGUID: LigjzN9VS6eZoqgpTcleCA==
X-CSE-MsgGUID: J1QQpnTZRHqV/i9sBMJx+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23760868"
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="23760868"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 15:14:24 -0700
X-CSE-ConnectionGUID: n+wzqXy9SwqDovMwYcBpYQ==
X-CSE-MsgGUID: UcfIAJJCTFW1wrLntCTTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,196,1719903600"; 
   d="scan'208";a="64711023"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2024 15:14:23 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slFJU-0005xw-3A
	for iommu@lists.linux.dev;
	Mon, 02 Sep 2024 22:14:20 +0000
Date: Tue, 03 Sep 2024 06:13:44 +0800
From: kernel test robot <lkp@intel.com>
To: iommu@lists.linux.dev
Subject: [BUILD SUCCESS] LAST PATCH: [PATCH 14/14] iommu/vt-d:
 Introduce batched cache invalidation
Message-ID: <202409030642.JuZf3AXF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Baolu/iommu-vt-d-Remove-identity-mappings-from-si_domain/20240902-112727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
patch link:    https://lore.kernel.org/r/20240902022724.67059-15-baolu.lu%40linux.intel.com
patch subject: [PATCH 14/14] iommu/vt-d: Introduce batched cache invalidation

[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

elapsed time: 1104m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                          axs103_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                       imx_v4_v5_defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         vf610m4_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240902   clang-18
i386         buildonly-randconfig-002-20240902   clang-18
i386         buildonly-randconfig-003-20240902   clang-18
i386         buildonly-randconfig-004-20240902   clang-18
i386         buildonly-randconfig-005-20240902   clang-18
i386         buildonly-randconfig-006-20240902   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240902   clang-18
i386                  randconfig-002-20240902   clang-18
i386                  randconfig-003-20240902   clang-18
i386                  randconfig-004-20240902   clang-18
i386                  randconfig-005-20240902   clang-18
i386                  randconfig-006-20240902   clang-18
i386                  randconfig-011-20240902   clang-18
i386                  randconfig-012-20240902   clang-18
i386                  randconfig-013-20240902   clang-18
i386                  randconfig-014-20240902   clang-18
i386                  randconfig-015-20240902   clang-18
i386                  randconfig-016-20240902   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                       m5249evb_defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                 decstation_r4k_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-14.1.0
mips                       rbtx49xx_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       ebony_defconfig   gcc-14.1.0
powerpc                     powernv_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
