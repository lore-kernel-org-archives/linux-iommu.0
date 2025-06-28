Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74223C50E;
	Sat, 28 Jun 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121634; cv=none; b=sO2P+Z17B4CEsloxCCLbpdn5p5yTw5dztgGLrQ3udZjSyXmnFeS8ftdSQHNzPPrj/8Rjsau1ICHPd7LwVIBHPAf0q/y5QHd+Q6mg0a0m9X2u43CQh3yN4MVz7TBfRXhrdv1jzeOVclqQ6KkSk7YXTb0ny6LQfvZ6Tcj4s/06NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121634; c=relaxed/simple;
	bh=/Lu5LTfcFXkeWsxjRBcxgn1uQUXHqbZ5PSxmsunseSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYBOSnLJIuRY+h3FE2L8LYVv+HLbt36KOUCC6yhc9O4H+BRoqe/vKicvtcAL30gO4LcmOZC+Rwj776ozeaIbi+bruCVCU9q+gBmNOOcnPN0r/nxqV7otGAi5iV34uwo2uzy0fYQGCQl6vk4LBHdXeu3DT3oXSquSVe5cwr3Ag+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlxdowWT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlxdowWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751121633; x=1782657633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Lu5LTfcFXkeWsxjRBcxgn1uQUXHqbZ5PSxmsunseSs=;
  b=nlxdowWTsbMG/M6aPTc71gGJ+8WJMH66TRF6StRaq/gMYQ4Bzq5+ZFlc
   uMmumP9Ikj4QNlqiOB9r99/p+7w+iV4NCC2WgQR5n2/IgO+lWQ2iny9O6
   tWCArLziTNCpL1QSd9UNvYmpgl+gCVoUZ4yeFaf2TGsjqNw7hp5DynnHg
   FpG/48/4ThI7ro8LdkCwmGHo3L3pHSQrebkNi7kCAG0gKJfpR/kT+7nvr
   IVEaFMWa81XXovwJfJBcD5mhgVn2kOaKUtg8TsERdL/C2894mFvNV/E7W
   a48JLZL5f2Nyp3lGwQgr4udranEl440WXLdnS9xEKyegVwaWNxHLO52tj
   g==;
X-CSE-ConnectionGUID: N8dYUnLgQbiSlZuJWAQzHw==
X-CSE-MsgGUID: 23MaVvsGTz+VvYtlTgr1Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="57189743"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="57189743"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 07:40:32 -0700
X-CSE-ConnectionGUID: j1rXOS1xRES1LHHDv8h1yw==
X-CSE-MsgGUID: bzHqMp1BQXeH9Myq/cxsjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="176727413"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jun 2025 07:40:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVWjB-000X7V-05;
	Sat, 28 Jun 2025 14:40:25 +0000
Date: Sat, 28 Jun 2025 22:39:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	"(open list:INTEL IOMMU (VT-d))" <iommu@lists.linux.dev>,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-sound@vger.kernel.org, Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 9/9] PCI: Add a new 'boot_display' attribute
Message-ID: <202506282240.aqA0j5M3-lkp@intel.com>
References: <20250627043108.3141206-10-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627043108.3141206-10-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus tiwai-sound/for-next tiwai-sound/for-linus tip/x86/core linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PCI-Add-helper-for-checking-if-a-PCI-device-is-a-display-controller/20250627-123349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250627043108.3141206-10-superm1%40kernel.org
patch subject: [PATCH v6 9/9] PCI: Add a new 'boot_display' attribute
config: powerpc-bluestone_defconfig (https://download.01.org/0day-ci/archive/20250628/202506282240.aqA0j5M3-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e04c938cc08a90ae60440ce22d072ebc69d67ee8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506282240.aqA0j5M3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506282240.aqA0j5M3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:688:8: warning: unused variable 'dev_attr_boot_display' [-Wunused-variable]
     688 | static DEVICE_ATTR_RO(boot_display);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:199:26: note: expanded from macro 'DEVICE_ATTR_RO'
     199 |         struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
         |                                 ^~~~~~~~~~~~~~~~
   <scratch space>:54:1: note: expanded from here
      54 | dev_attr_boot_display
         | ^~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/dev_attr_boot_display +688 drivers/pci/pci-sysfs.c

   682	
   683	static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
   684					 char *buf)
   685	{
   686		return sysfs_emit(buf, "1\n");
   687	}
 > 688	static DEVICE_ATTR_RO(boot_display);
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
