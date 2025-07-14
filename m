Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A726136D;
	Mon, 14 Jul 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506090; cv=none; b=HKyJl5qJoOOcX9fM5P4CcHWmiyOq/+u/q2nA43GuFrqF3X0zYcFK8dmqkwmX4HeFYNONrmGQqamFdp+QajC8bwfdEjYalx7g4nOZO27bKG/1tH3a4zRTYUPeT6DqQOwW9LiDV60D3QTEhAPrUZNvJNIPWigmvagtMz0upL1pkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506090; c=relaxed/simple;
	bh=uhR4oTtyTLRPzkqDzPtiWEgon2j5NRv9mdaGjQ0k3OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIi42md/X1hQw9EVtsDkcwrX+I6+uUuLJEYaQdun0ivHZmZcHWKVvNpPc/ccXM9iCNeYpQVj9WTLzhhHnDHakg4Ew1VZ0WRV7Hil3wFHhQFu1Pr5/Gkd8WXcSUZm0kKQu63/j14HpVARPc+msc5wBNN5FrtCuzKART2NrJpmgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuPPhnj7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuPPhnj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752506090; x=1784042090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uhR4oTtyTLRPzkqDzPtiWEgon2j5NRv9mdaGjQ0k3OM=;
  b=KuPPhnj70PYcDjE/y62sfZ5TYqzxITMITws4JVQvJBVRVuteD7fYZXi0
   yhsNUz+pClEE45SC2udopz92RhxICBgHjbBY8m0umWS4ADqLpRZMu4ey0
   NtzGkZY+WtUWJAdh12Lk4gOQKRL1NUTDG98TcBYksOfRJF35CljgTDhQ1
   7OR8+Gisq+xzgQXT9XaoULTlze5HbUSz2c/p6pEa7nb2A8szzsY/JRRoL
   N7poiTgoM74PU2XyUWMbPRGzNOQoSdHUE5CCXlqjB/KdPY8SUcNC8C7QZ
   w/RtUIB/rX02+XMIH8HzgFT/arb05aZ2lJLlLZETNWdSvJ6qIxqyEMi0e
   g==;
X-CSE-ConnectionGUID: cB3mIsixRnuROG+gnAiOUQ==
X-CSE-MsgGUID: Eh/BCvRVRvK49FbJNAoOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66147842"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="66147842"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 08:13:30 -0700
X-CSE-ConnectionGUID: QsmEd6zUTNqnT0GaVeEtLA==
X-CSE-MsgGUID: 47IN3f/gR+WROpmruZ/DZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="187943702"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 08:13:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubKro-00092V-1w;
	Mon, 14 Jul 2025 15:13:20 +0000
Date: Mon, 14 Jul 2025 23:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
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
Subject: Re: [PATCH v7 8/9] fbcon: Use screen info to find primary device
Message-ID: <202507142313.iWVTOSVB-lkp@intel.com>
References: <20250706143613.1972252-9-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706143613.1972252-9-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus tiwai-sound/for-next tiwai-sound/for-linus tip/x86/core linus/master v6.16-rc6 next-20250714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PCI-Add-helper-for-checking-if-a-PCI-device-is-a-display-controller/20250706-223745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250706143613.1972252-9-superm1%40kernel.org
patch subject: [PATCH v7 8/9] fbcon: Use screen info to find primary device
config: i386-randconfig-053-20250714 (https://download.01.org/0day-ci/archive/20250714/202507142313.iWVTOSVB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250714/202507142313.iWVTOSVB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507142313.iWVTOSVB-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/video/video-common.o: in function `video_is_primary_device':
>> arch/x86/video/video-common.c:45: undefined reference to `screen_info_pci_dev'


vim +45 arch/x86/video/video-common.c

    28	
    29	bool video_is_primary_device(struct device *dev)
    30	{
    31		struct screen_info *si = &screen_info;
    32		struct pci_dev *pdev;
    33	
    34		if (!dev_is_pci(dev))
    35			return false;
    36	
    37		pdev = to_pci_dev(dev);
    38	
    39		if (!pci_is_display(pdev))
    40			return false;
    41	
    42		if (pdev == vga_default_device())
    43			return true;
    44	
  > 45		if (pdev == screen_info_pci_dev(si))
    46			return true;
    47	
    48		return false;
    49	}
    50	EXPORT_SYMBOL(video_is_primary_device);
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
