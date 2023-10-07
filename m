Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315669CA69;
	Sat,  7 Oct 2023 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQIp3iiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696648851; x=1728184851;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E7NPgMH3nk5eGz5wfiAfR+KrfoWZOzjEL2W/fJBzvPU=;
  b=cQIp3iiv8c6Ls1hAGtqnH+yr1UWsIPncZI2LeycUtKoyt+tcIi0bGZvi
   EI0VVVnpPPNP/1QqkwinLNMVS2OZBGkumrpnKg+uyR8zcLNIq4euyva0U
   mkN7Dpi0SzAWAr3A2sU1229NkcThuJv+qPWpCVRYZTZmXb4CSh3aEeYC3
   ULPANp7LrC9qW3UYrItaoCmJnSDLGJ3VlYt2xz1ulPOyJx4Xkncjnko6k
   QdEJdFybCZgM0VbJD7tXWMFyUWvHWJb+Qdior2J3aWY5pzZ2U6/3rCWzY
   IEWjAt+XYESMmpW3KDPp5sMgWAS3SRXcmeRVSK3+BkV/SNgJM89c2GN6t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470152998"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470152998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 20:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702266475"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="702266475"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2023 20:20:43 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoxrt-0003uj-0Y;
	Sat, 07 Oct 2023 03:20:41 +0000
Date: Sat, 7 Oct 2023 11:20:35 +0800
From: kernel test robot <lkp@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [joro-iommu:x86/amd 16/19] drivers/iommu/amd/iommu.c:829:21:
 warning: variable 'entry' set but not used
Message-ID: <202310071103.BYatoc0b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/amd
head:   189116d5ad54eee2bab82c5f12e837912fc0b4c4
commit: d55b0d2e075ad32d560cdd35a2016973fda52ed6 [16/19] iommu/amd: Remove PPR support
config: x86_64-randconfig-003-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071103.BYatoc0b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/amd/iommu.c: In function 'iommu_poll_ppr_log':
>> drivers/iommu/amd/iommu.c:829:21: warning: variable 'entry' set but not used [-Wunused-but-set-variable]
     829 |                 u64 entry[2];
         |                     ^~~~~


vim +/entry +829 drivers/iommu/amd/iommu.c

90008ee4b811c9 arch/x86/kernel/amd_iommu.c Joerg Roedel 2008-09-09  816  
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  817  static void iommu_poll_ppr_log(struct amd_iommu *iommu)
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  818  {
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  819  	u32 head, tail;
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  820  
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  821  	if (iommu->ppr_log == NULL)
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  822  		return;
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  823  
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  824  	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  825  	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  826  
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  827  	while (head != tail) {
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  828  		volatile u64 *raw;
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01 @829  		u64 entry[2];
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  830  		int i;
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  831  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  832  		raw = (u64 *)(iommu->ppr_log + head);
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  833  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  834  		/*
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  835  		 * Hardware bug: Interrupt may arrive before the entry is
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  836  		 * written to memory. If this happens we need to wait for the
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  837  		 * entry to arrive.
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  838  		 */
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  839  		for (i = 0; i < LOOP_TIMEOUT; ++i) {
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  840  			if (PPR_REQ_TYPE(raw[0]) != 0)
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  841  				break;
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  842  			udelay(1);
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  843  		}
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  844  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  845  		/* Avoid memcpy function-call overhead */
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  846  		entry[0] = raw[0];
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  847  		entry[1] = raw[1];
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  848  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  849  		/*
05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  850  		 * To detect the hardware errata 733 we need to clear the
05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  851  		 * entry back to zero. This issue does not exist on SNP
05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  852  		 * enabled system. Also this buffer is not writeable on
05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  853  		 * SNP enabled system.
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  854  		 */
05d227efbd8d3c drivers/iommu/amd/iommu.c   Tom Lendacky 2023-01-17  855  		if (!amd_iommu_snp_en)
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  856  			raw[0] = raw[1] = 0UL;
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  857  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  858  		/* Update head pointer of hardware ring-buffer */
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  859  		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  860  		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  861  
d55b0d2e075ad3 drivers/iommu/amd/iommu.c   Vasant Hegde 2023-10-06  862  		/* TODO: PPR Handler will be added when we add IOPF support */
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  863  
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  864  		/* Refresh ring-buffer information */
eee53537c476c9 drivers/iommu/amd_iommu.c   Joerg Roedel 2012-06-01  865  		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  866  		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  867  	}
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  868  }
72e1dcc4192288 drivers/iommu/amd_iommu.c   Joerg Roedel 2011-11-10  869  

:::::: The code at line 829 was first introduced by commit
:::::: eee53537c476c947bf7faa1c916d2f5a0ae8ec93 iommu/amd: Fix deadlock in ppr-handling error path

:::::: TO: Joerg Roedel <joerg.roedel@amd.com>
:::::: CC: Joerg Roedel <joerg.roedel@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
