Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109441F35C;
	Wed,  2 Sep 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341681; cv=none; b=cU5yet3sfL6fRvkY0xv35K/CXfyh8CfIim5uud8bUhOahEcU0RNA+Y7Yad5h8j4CWBJgdEFgJT9YE58+HNWLZBYg4cVXiD5B+vh/Q8RQberFf27vVa4PM5BCHY2zP9WOojGh8WuGTJbXWED1CoNK1UeqYwoswfSFVw+7ax6799w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341681; c=relaxed/simple;
	bh=nwC8aYYFaY5Tyx3HWiEDRZ3+KuRU1Y0WxaDl262CvF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/ia+YmltpT6P4VazqDSOpAlfX/MDbELEaSnFp3dvEFnm+hZqAPV80YOuGGOBdCAyjjIZtYWpsiMeDwUL6EXdMQrrQ95WyfXMQeudtBxkJFar5zLinkMse/jn9ytECJa9u5HbSAHN5zmPblNxjblHkf0j6HGnUGijsFheANYndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcZ2vw/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcZ2vw/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788341679; x=1819877679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwC8aYYFaY5Tyx3HWiEDRZ3+KuRU1Y0WxaDl262CvF0=;
  b=FcZ2vw/+BK0Ve8zzg4rouYTEGJVdir1ypBb78ZQlmRPeFj79xapEixi0
   IXqdCq5GAfM/UPjVDyfxWRiVxF5aATcEyZ5qDfffGUkltgqYlCPuxddUj
   PiiSrytKL8uLvZpn59JTkn1ktpIr+JPgXQDxVR7KDxBUbRzUFq4/5k3zL
   U4mB79i3TXdEbZUy6rQwfz6wfcOQ31Fmm9JB+Xwvd/hX3ZFhxyiKiqHNW
   pgZbyq8rlO9s0BIIxwjbRTnAevyqUjG1TR49vd4qp8t8UELPjXnCfPzL2
   g8GKRHtl9vVPXNjss8GVL9HGa5sqnnwR//qNh1YObgwH2dzVbKKPWXBIF
   Q==;
X-CSE-ConnectionGUID: kCvYV5rxTNmqqVvNjH6hGQ==
X-CSE-MsgGUID: CfVcLTKYT/GSM3ZcCVYNtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88720099"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88720099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 02:34:38 -0700
X-CSE-ConnectionGUID: CcsVaQg8Ss61fMs8jdko6g==
X-CSE-MsgGUID: HEVhHsv8R8mBRzgbLNiBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="266117153"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Sep 2026 02:34:36 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1hMX-000000002KM-3aac;
	Wed, 02 Sep 2026 09:34:33 +0000
Date: Wed, 2 Sep 2026 17:33:37 +0800
From: kernel test robot <lkp@intel.com>
To: Qingfang Deng <qingfang.deng@linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH] dma-mapping: use exact allocation for DMA pages
Message-ID: <202609021750.Ifwj5NHl-lkp@intel.com>
References: <20260901085348.53140-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901085348.53140-1-qingfang.deng@linux.dev>

Hi Qingfang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.3-rc1 next-20260901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qingfang-Deng/dma-mapping-use-exact-allocation-for-DMA-pages/20260901-165347
base:   linus/master
patch link:    https://lore.kernel.org/r/20260901085348.53140-1-qingfang.deng%40linux.dev
patch subject: [PATCH] dma-mapping: use exact allocation for DMA pages
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260902/202609021750.Ifwj5NHl-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021750.Ifwj5NHl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021750.Ifwj5NHl-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: 'saved_config' is COMMON symbol
>> WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages.isra.0+0xcc (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages.isra.0+0xe0 (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: dma_common_alloc_pages+0x10 (section: .text.unlikely) -> alloc_pages_exact_nid_noprof (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dma_common_alloc_pages+0x50 (section: .text.unlikely) -> alloc_pages_exact_nid_noprof (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
