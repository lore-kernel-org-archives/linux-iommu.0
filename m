Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBD43AB7
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088239; cv=none; b=JW0pKELrX2Zz2kK8uZdpotzkoYzr0nXdDzFbSCEXrVUAg96BONB/Yzj3qb9WpuO79/JhJvZMAREf57bfNcOxuYe15sR/AAVWbD7AmtT6exqy45aHKLcOpX8UfCTmgOwWofoC2a9JDGglX/Ou/1M3RW8z7DtpL3gX0TMQYJ9TXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088239; c=relaxed/simple;
	bh=L2zedyb12wUaY6qcBBTT/fTmDlGHuznd7/2zEFpuLFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ieo/j5En2PUlIWjFxuHX4ndqJjUzxh4AoUxJN3GJ9fu8e9GPQ///hkiR79aiN6SvGMzDvDCBleXAGk5RHGPWcHmXZTlNd1TmvDENfm5OhX6XVHbZ9Ti2Pv+C6Q3kWsKY5hgEQkLJ7ANi6/ASrl76oQ10/fiD5ecCWsNp97lCYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: F6xf+vXASuaWKFVrJSqTNA==
X-CSE-MsgGUID: VwLFuHlNRAW8NRIGYCbkig==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26105360"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="26105360"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 10:23:57 -0700
X-CSE-ConnectionGUID: SoTcYxTKSqSDTyL2IS24HQ==
X-CSE-MsgGUID: aUHpZW3WQquB+DZzOFPPVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60273429"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2024 10:23:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0EC0D2AA; Mon, 19 Aug 2024 20:23:51 +0300 (EEST)
Date: Mon, 19 Aug 2024 20:23:51 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, saravanak@google.com, klarasmodin@gmail.com,
	aisheng.dong@nxp.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	will@kernel.org, catalin.marinas@arm.com, kernel@quicinc.com
Subject: Re: [PATCH v7 0/2] Dynamic Allocation of the reserved_mem array
Message-ID: <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809184814.2703050-1-quic_obabatun@quicinc.com>

On Fri, Aug 09, 2024 at 11:48:12AM -0700, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node reference, start-address,
> and size of the different reserved memory regions.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> This can be fixed by making the reserved_mem array a dynamically sized
> array which is allocated using memblock_alloc() based on the exact
> number of reserved memory regions defined in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup.
> This is an issue because the current implementation initializes the
> reserved memory regions and stores their information in the array before
> the page tables are setup. Hence, dynamically allocating the
> reserved_mem array and attempting to write information to it at this
> point will fail.
> 
> Therefore, the allocation of the reserved_mem array will need to be done
> after the page tables have been setup, which means that the reserved
> memory regions will also need to wait until after the page tables have
> been setup to be stored in the array.
> 
> When processing the reserved memory regions defined in the DT, these
> regions are marked as reserved by calling memblock_reserve(base, size).
> Where:  base = base address of the reserved region.
> 	size = the size of the reserved memory region.
> 
> Depending on if that region is defined using the "no-map" property,
> memblock_mark_nomap(base, size) is also called.
> 
> The "no-map" property is used to indicate to the operating system that a
> mapping of the specified region must NOT be created. This also means
> that no access (including speculative accesses) is allowed on this
> region of memory except when it is coming from the device driver that
> this region of memory is being reserved for.[1]
> 
> Therefore, it is important to call memblock_reserve() and
> memblock_mark_nomap() on all the reserved memory regions before the
> system sets up the page tables so that the system does not unknowingly
> include any of the no-map reserved memory regions in the memory map.
> 
> There are two ways to define how/where a reserved memory region is
> placed in memory:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a set start address and size using the
>      "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>      be placed in memory using the "alloc_ranges" and "size" properties
>      in the DT.
> 
> The dynamically-placed reserved memory regions get assigned a start
> address only at runtime. And this needs to  be done before the page
> tables are setup so that memblock_reserve() and memblock_mark_nomap()
> can be called on the allocated region as explained above.
> Since the dynamically allocated reserved_mem array can only be
> available after the page tables have been setup, the information for
> the dynamically-placed reserved memory regions needs to be stored
> somewhere temporarily until the reserved_mem array is available.
> 
> Therefore, this series makes use of a temporary static array to store
> the information of the dynamically-placed reserved memory regions until
> the reserved_mem array is allocated.
> Once the reserved_mem array is available, the information is copied over
> from the temporary array into the reserved_mem array, and the memory for
> the temporary array is freed back to the system.
> 
> The information for the statically-placed reserved memory regions does
> not need to be stored in a temporary array because their starting
> address is already stored in the devicetree.
> Once the reserved_mem array is allocated, the information for the
> statically-placed reserved memory regions is added to the array.
> 
> Note:
> Because of the use of a temporary array to store the information of the
> dynamically-placed reserved memory regions, there still exists a
> limitation of 64 for this particular kind of reserved memory regions.
> >From my observation, these regions are typically small in number and
> hence I expect this to not be an issue for now.


This series (in particular the first patch) broke boot on Intel Meteor
Lake-P. Taking Linux next of 20240819 with these being reverted makes
things work again.

Taking into account bisectability issue (that's how I noticed the issue
in the first place) I think it would be nice to have no such patches at
all in the respective subsystem tree. On my side I may help with testing
whatever solution or next version provides.

git bisect start
# status: waiting for both good and bad commits
# good: [47ac09b91befbb6a235ab620c32af719f8208399] Linux 6.11-rc4
git bisect good 47ac09b91befbb6a235ab620c32af719f8208399
# status: waiting for bad commit, 1 good commit known
# bad: [469f1bad3c1c6e268059f78c0eec7e9552b3894c] Add linux-next specific files for 20240819
git bisect bad 469f1bad3c1c6e268059f78c0eec7e9552b3894c
# good: [3f6ea50f8205eb79e4a321559c292eecb059bfaa] Merge branch 'spi-nor/next' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
git bisect good 3f6ea50f8205eb79e4a321559c292eecb059bfaa
# good: [95ff8c994d58104a68eb12988d7bc24597876831] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect good 95ff8c994d58104a68eb12988d7bc24597876831
# bad: [9434b7c52128e9959dce1111b8e1078ffc91468d] Merge branch 'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git
git bisect bad 9434b7c52128e9959dce1111b8e1078ffc91468d
# bad: [791ba08d6d977046e8c4a7f01dabd8770d1eb94d] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 791ba08d6d977046e8c4a7f01dabd8770d1eb94d
# good: [2b3eb431609a479193044bba064090141a504b9a] Merge branch into tip/master: 'timers/core'
git bisect good 2b3eb431609a479193044bba064090141a504b9a
# good: [81b6ef7427cb4b90c913488c665414ba21bbe46d] Merge branch into tip/master: 'x86/timers'
git bisect good 81b6ef7427cb4b90c913488c665414ba21bbe46d
# bad: [f5d0a26ecd6875f02c6cf4fedf245812015b4cef] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect bad f5d0a26ecd6875f02c6cf4fedf245812015b4cef
# good: [5c80b13d27252446973a5ce14a5331b336556f28] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
git bisect good 5c80b13d27252446973a5ce14a5331b336556f28
# good: [84252c1d2c6efed706037e00f25455378fdda97c] dt-bindings: timer: nxp,lpc3220-timer: Convert to dtschema
git bisect good 84252c1d2c6efed706037e00f25455378fdda97c
# good: [ca35f2837927d73441cfb51174b824ae82a15f93] dt-bindings: soc: fsl: cpm_qe: convert network.txt to yaml
git bisect good ca35f2837927d73441cfb51174b824ae82a15f93
# bad: [a27afc7a6266f02703a6bd492e1f57e8d1ee069b] of: reserved_mem: Add code to dynamically allocate reserved_mem array
git bisect bad a27afc7a6266f02703a6bd492e1f57e8d1ee069b
# bad: [4be66e32070d1e8da72934dbe4dff44a49bd2e5f] of: reserved_mem: Restructure how the reserved memory regions are processed
git bisect bad 4be66e32070d1e8da72934dbe4dff44a49bd2e5f
# good: [d2a97be34548fc5643b4e9536ac8789d839f7374] scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b523429
git bisect good d2a97be34548fc5643b4e9536ac8789d839f7374
# first bad commit: [4be66e32070d1e8da72934dbe4dff44a49bd2e5f] of: reserved_mem: Restructure how the reserved memory regions are processed

-- 
With Best Regards,
Andy Shevchenko


