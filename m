Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419003CF675;
	Fri, 13 Mar 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424159; cv=none; b=n3oTq0sQXmujKx9n3kqib7Vvx9WyPcoUTZY3iCV61+JQmFGgKj6oD4yXG5aHxOuQZJpa+Z1g201LfBv/UdAKpTvMV+5PxbkXVf68ZbIg3YQZPe7a0EwfKbamTsRuz7q22N9lABecZNPnisSYpsbGaR6DM1QqNx1cOBT1qKRMHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424159; c=relaxed/simple;
	bh=G/54pfVHu+8/L9MXfBV5Snw0zRxYz9KVsVsRO/3Kr/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2tbB+fU+rZ22OmbIW4v5q3fgQR8iHj79Q4IDx4e0N76T8uma+dmKkBg6lJuu/dh9HHNA9bKgDLOyeYZ99EbD1I+m9GjlcqQXqfBpUABxzTCO9uttwgOoDsvguyqZBNbsnLzaNsUQ+r8RBZxiVkEFgNqoaw6ZKQGbd+5yXqHzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIdK8aWY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIdK8aWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773424158; x=1804960158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/54pfVHu+8/L9MXfBV5Snw0zRxYz9KVsVsRO/3Kr/I=;
  b=YIdK8aWYsyCL5wu0iFOf6h6npOlUZUxKZhQLaI0V2D9GhbmFeG7OV9TD
   vDyUifs0iUYKeYUhHW2ABanb2l5Ng8mtAKpbll0sJgTHDjTVhznTUz2mp
   h3vuRceA3WnkCmY8RE+tLH98HoIy3I+q9dofIVui+8fZgKJQe+D+YxL4u
   h47I1rhNmJ0FNDkbver5d2t72p04ytr52F7p9Ji8n3dG3qIqXcyYAiTAw
   F0bk7QYbPoPdrPDA6otWITDTTpiHlSb5jrn2xiKMxcUHVByjzr6mFtHz3
   EMTHkiwVzoiLsvzSHeEnk5pu0J71uzrYbMtIlOh8sWvQKlulajBPPrCJz
   Q==;
X-CSE-ConnectionGUID: 2eecNKtmQQCYwwgunlaXdA==
X-CSE-MsgGUID: La1F8wE1RFOiycgHDOLuUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74430208"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74430208"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:49:18 -0700
X-CSE-ConnectionGUID: f1KlYN4GR5qvqkZ0NQajuQ==
X-CSE-MsgGUID: BacbP7FVRMy8Xu9xQ5yFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225923777"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 13 Mar 2026 10:49:14 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w16dM-000000003gn-1G9t;
	Fri, 13 Mar 2026 17:49:12 +0000
Date: Fri, 13 Mar 2026 18:48:15 +0100
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 11/11] Doc: Update VFIO NOIOMMU mode
Message-ID: <202603131832.GiQt3WWE-lkp@intel.com>
References: <20260312155637.376854-12-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-12-jacob.pan@linux.microsoft.com>

Hi Jacob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20260313]
[cannot apply to awilliam-vfio/next awilliam-vfio/for-linus v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommufd-Support-a-HWPT-without-an-iommu-driver-for-noiommu/20260313-182818
base:   linus/master
patch link:    https://lore.kernel.org/r/20260312155637.376854-12-jacob.pan%40linux.microsoft.com
patch subject: [PATCH V2 11/11] Doc: Update VFIO NOIOMMU mode
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260313/202603131832.GiQt3WWE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603131832.GiQt3WWE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Ring Design
   ----------- [docutils]
   WARNING: ./include/linux/usb/typec_altmode.h:44 struct member 'priority' not described in 'typec_altmode'
   WARNING: ./include/linux/usb/typec_altmode.h:44 struct member 'mode_selection' not described in 'typec_altmode'
>> Documentation/driver-api/vfio.rst:382: WARNING: Inline substitution_reference start-string without end-string. [docutils]
>> Documentation/driver-api/vfio.rst:382: WARNING: Inline interpreted text or phrase reference start-string without end-string. [docutils]
>> Documentation/driver-api/vfio.rst:382: WARNING: Inline emphasis start-string without end-string. [docutils]
>> Documentation/driver-api/vfio.rst:382: WARNING: Inline interpreted text or phrase reference start-string without end-string. [docutils]
   Documentation/driver-api/vfio.rst:392: ERROR: Malformed table.
   Right border not aligned or missing.
--
   +-------------------+---------------------+---------------------+
   | VFIO container    | No                  | No                 |
   +-------------------+---------------------+---------------------+
   | IOMMUFD IOAS      | No                  | Yes*               |
   +-------------------+---------------------+---------------------+ [docutils]
>> Documentation/driver-api/vfio.rst:400: WARNING: Blank line required after table. [docutils]
>> Documentation/driver-api/vfio.rst:405: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
   WARNING: ./include/linux/virtio.h:188 struct member 'map' not described in 'virtio_device'
   WARNING: ./include/linux/virtio.h:188 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'
   WARNING: ./include/linux/virtio.h:188 struct member 'vmap' not described in 'virtio_device'
   Documentation/gpu/amdgpu/display/display-manager:47: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:61: ERROR: Unexpected section title.


vim +382 Documentation/driver-api/vfio.rst

   381	
 > 382	/dev/vfio/
   383	|-- devices
   384	|   `-- noiommu-vfio0	/* VFIO device cdev */
   385	|-- noiommu-0		/* VFIO group */
   386	`-- vfio
   387	
   388	The capabilities vary depending on the device programming interface and kernel
   389	configuration used. The following table summarizes the differences:
   390	
   391	+-------------------+---------------------+---------------------+
   392	| Feature           | VFIO group          | VFIO device cdev   |
   393	+===================+=====================+=====================+
   394	| VFIO device UAPI  | Yes                 | Yes                |
   395	+-------------------+---------------------+---------------------+
   396	| VFIO container    | No                  | No                 |
   397	+-------------------+---------------------+---------------------+
   398	| IOMMUFD IOAS      | No                  | Yes*               |
   399	+-------------------+---------------------+---------------------+
 > 400	Note that the VFIO container case includes IOMMUFD provided VFIO compatibility
   401	interfaces when either CONFIG_VFIO_CONTAINER or CONFIG_IOMMUFD_VFIO_CONTAINER is
   402	enabled.
   403	
   404	* IOMMUFD UAPI is available for VFIO device cdev to pin and map user memory with
 > 405	the ability to retrieve physical addresses for DMA command submission.
   406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
