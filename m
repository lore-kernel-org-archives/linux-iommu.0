Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535752DBF4B;
	Wed, 21 Jan 2026 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956862; cv=none; b=Q9rMxQOb+LVZ4f2MeZTNypWbQjaDUL5EMfMJ4vnjNuliJOVk+eaQR8ifOKQBupmW3M2vlpmipTiZ5+fbebMcvEB3pfGfy9crJVHJbTJhCwpNub7pOYJzUCndcyD60eASYBDqE8aRPK1KXO8+YaUrfbT2aA2v/QTqaenmripUcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956862; c=relaxed/simple;
	bh=69IQMwe9upLzgpC2oBZtZFsOB+a5jIJ7cJY12DniSbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mihTInssFszNXj3hBBOOOsInBGmJx9lFoPyUke4l/ajw0/P77MrA5poK1s3BVQUUfjICUZHApFxPXQ3h2vrM13IqgpCUzSNEXPA6E2Yc//C/CQI82RWusMbEFrT2dNdLxVPQ4FjnvanMbWEuXMQ6MC9Vhda3FrBF8EQOahQwDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVmxOzzb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVmxOzzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768956861; x=1800492861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=69IQMwe9upLzgpC2oBZtZFsOB+a5jIJ7cJY12DniSbA=;
  b=cVmxOzzbRJsvp3lT0uG7FH0KBUizXnEzybEPy+WFAkeXtqjR9Mvj5yJX
   V2A7yVBXuYMb4DBoF1KKHrknDnepapxew6qm934LkM4UNTbSGj7ActFNJ
   RjIKNMPUfnzO6TXA0SD6SWs/CFaYwJwkyULHu0wdnM8D4uvK8Qc71pXyJ
   pHNJ+PGpZ8UvCGHAk08FXSYnHX5sYXtp3MYMktn2bu5zgOOEO8ZsYu1yY
   lSviPGvpmc+ws4IQKHxn//MFXpi2/2UEROFvTQT1+3L/477abjapC1K9t
   0X4AKafr7Yi2RuXw4VvThIIJrJJeBbQmekU+F6QWwEmPmWBih3SPlz3kT
   w==;
X-CSE-ConnectionGUID: TyNtRZmwRJ20R6Vs74rrOA==
X-CSE-MsgGUID: 0PU+2Oc3TXy1ESwIOD11oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70083917"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70083917"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:54:21 -0800
X-CSE-ConnectionGUID: cZWcoejfSjeisQa/O17UuQ==
X-CSE-MsgGUID: m8tR31AxS6mJ9HycUVnXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="236942661"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 16:54:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viMU7-00000000Pmv-2DUO;
	Wed, 21 Jan 2026 00:54:11 +0000
Date: Wed, 21 Jan 2026 08:53:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 03/15] x86/hyperv: add insufficient memory support in
 irqdomain.c
Message-ID: <202601210731.f1WLdgcO-lkp@intel.com>
References: <20260120064230.3602565-4-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-4-mrathor@linux.microsoft.com>

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on pci/next pci/for-linus arm64/for-next/core clk/clk-next soc/for-next linus/master v6.19-rc6 next-20260120]
[cannot apply to arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-R/iommu-hyperv-rename-hyperv-iommu-c-to-hyperv-irq-c/20260120-145832
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260120064230.3602565-4-mrathor%40linux.microsoft.com
patch subject: [PATCH v0 03/15] x86/hyperv: add insufficient memory support in irqdomain.c
config: i386-randconfig-053-20260120 (https://download.01.org/0day-ci/archive/20260121/202601210731.f1WLdgcO-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601210731.f1WLdgcO-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/x86/hyperv/irqdomain.c:90:2-3: Unneeded semicolon

vim +90 arch/x86/hyperv/irqdomain.c

    72	
    73	static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
    74				    int cpu, int vector,
    75				    struct hv_interrupt_entry *ret_entry)
    76	{
    77		u64 status;
    78		int rc, deposit_pgs = 16;		/* don't loop forever */
    79	
    80		while (deposit_pgs--) {
    81			status = hv_map_interrupt_hcall(ptid, device_id, level, cpu,
    82							vector, ret_entry);
    83	
    84			if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
    85				break;
    86	
    87			rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);
    88			if (rc)
    89				break;
  > 90		};
    91	
    92		if (!hv_result_success(status))
    93			hv_status_err(status, "\n");
    94	
    95		return hv_result_to_errno(status);
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
