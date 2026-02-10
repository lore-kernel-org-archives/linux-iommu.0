Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFA319850;
	Tue, 10 Feb 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746640; cv=none; b=fP31hBezpuq+WyrbAHOp86peHvN3u1AJgOUkIDI9+ggTzRIbDLyjbFMwGJHjrxJ2Q+oqvvIa2BhTGSCnVRY188RFQp2k7lzRtgTQLY+SrkA2j93FbkpEVz9WpSsuKHV+/oO+MUPagQxxgltm5qewHqZaPW/PmaHIYKtmfxmVfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746640; c=relaxed/simple;
	bh=RCF0n7XHDUGKM+cjf33SZOFc4i4PkHY0jF5mOX8LCFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKpoqNPILaKezeS3jKPCiolCWU7z1TRAil3FAk/2SOcU4JJ/J0a3Md68u3F67xyq3Oe+16USu9mPJR/TGvJfyzvw72S52W/Qxx+c9g9X+I3AeqUBeoWTYcVK+ZLZUVIATt/hqVdMvh98wlgh8vbszPp1nXQB4MstGdpk8y2rqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMXifKy9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMXifKy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770746638; x=1802282638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCF0n7XHDUGKM+cjf33SZOFc4i4PkHY0jF5mOX8LCFE=;
  b=hMXifKy9/4SQOzymUlvohR5vdNAbCI4mOmkNl22JoiYWqiyw+T3vhcxF
   Mzgq1N01Bz4+fVYVJ+ScXLy5GvYbtnahf9iUEw3ORuWQ2rq8bPsZbRsuV
   IDrr189WtjNnypWhg7trcHpHEjoV3256hwPI67TyPRGLlSixQrijd2Y7e
   3DFS0Dj5pSTZ8v2aADSErNFLBoEOZ3FvcHtIcQJVk9SBm7UmydZT2HX9L
   Sczy+nd0Z6WD0mtHWcGYLQxo3X24rbUZM6ZDNN4FLNqkLtv+x3jCzHaXi
   Cdog2lfydHkspxIs6XcsP6ps56MGZX+GElbm2UEnWYXTRg8GqrGpUlNMA
   w==;
X-CSE-ConnectionGUID: meOjuHjkQaK5At1B/tlgyw==
X-CSE-MsgGUID: CnrNALMjT4yJ42H7uw7VYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75728596"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75728596"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 10:03:57 -0800
X-CSE-ConnectionGUID: zOeotsxLRKmN8lqHs702VQ==
X-CSE-MsgGUID: 7I9nDF1BShClWzSGAashTg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Feb 2026 10:03:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vps5V-00000000pHk-2Bfq;
	Tue, 10 Feb 2026 18:03:49 +0000
Date: Wed, 11 Feb 2026 02:03:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca,
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
	catalin.marinas@arm.com, aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH 5/5] dma-buf: heaps: system: add an option to allocate
 explicitly decrypted memory
Message-ID: <202602110149.tBUPP0bh-lkp@intel.com>
References: <20260209153809.250835-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209153809.250835-6-jiri@resnulli.us>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip trace/for-next linus/master v6.19]
[cannot apply to next-20260209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Pirko/dma-mapping-avoid-random-addr-value-print-out-on-error-path/20260209-234013
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260209153809.250835-6-jiri%40resnulli.us
patch subject: [PATCH 5/5] dma-buf: heaps: system: add an option to allocate explicitly decrypted memory
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260211/202602110149.tBUPP0bh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602110149.tBUPP0bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602110149.tBUPP0bh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma-buf/heaps/system_heap.c: In function 'system_heap_set_page_decrypted':
>> drivers/dma-buf/heaps/system_heap.c:66:15: error: implicit declaration of function 'set_memory_decrypted' [-Wimplicit-function-declaration]
      66 |         ret = set_memory_decrypted(addr, nr_pages);
         |               ^~~~~~~~~~~~~~~~~~~~
   drivers/dma-buf/heaps/system_heap.c: In function 'system_heap_set_page_encrypted':
>> drivers/dma-buf/heaps/system_heap.c:80:15: error: implicit declaration of function 'set_memory_encrypted' [-Wimplicit-function-declaration]
      80 |         ret = set_memory_encrypted(addr, nr_pages);
         |               ^~~~~~~~~~~~~~~~~~~~


vim +/set_memory_decrypted +66 drivers/dma-buf/heaps/system_heap.c

    59	
    60	static int system_heap_set_page_decrypted(struct page *page)
    61	{
    62		unsigned long addr = (unsigned long)page_address(page);
    63		unsigned int nr_pages = 1 << compound_order(page);
    64		int ret;
    65	
  > 66		ret = set_memory_decrypted(addr, nr_pages);
    67		if (ret)
    68			pr_warn_ratelimited("dma-buf system heap: failed to decrypt page at %p\n",
    69					    page_address(page));
    70	
    71		return ret;
    72	}
    73	
    74	static int system_heap_set_page_encrypted(struct page *page)
    75	{
    76		unsigned long addr = (unsigned long)page_address(page);
    77		unsigned int nr_pages = 1 << compound_order(page);
    78		int ret;
    79	
  > 80		ret = set_memory_encrypted(addr, nr_pages);
    81		if (ret)
    82			pr_warn_ratelimited("dma-buf system heap: failed to re-encrypt page at %p, leaking memory\n",
    83					    page_address(page));
    84	
    85		return ret;
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
