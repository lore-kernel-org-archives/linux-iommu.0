Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A73AAF62;
	Wed,  2 Sep 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347941; cv=none; b=uD7+WXpMgc1AkemdcmQvxmXxpImEDnY18Z9m781dEyAwuw52gvrKMk7GJlVV4bc4BzWeoDToDJzWiSczR5zb0zT6ecBdjfXh9/sxSMFNgzt7hQ0FYGrouGDbrYImJDnV3EJQjiZgmshqI4vG65BnGzHnxFoQ1cW1Zabr73h3VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347941; c=relaxed/simple;
	bh=YG86Tsd5NYoxHqXO1/4RjI2Hwk53MaPPEvTOL3eNPGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLoIOxQum4vywXvHgdpHu4GydMi8U0RAiSbomCAyleBnABfCktSUyGj3nqwbkQFJ2XR4vWB6r/c3s2kBgQJ7isJgQix1QYc7iEumuiK0l8lqINjXuWyca8IZO67E1HNdgIA2+FoKtapMdDcM/WGlJV4WZqSjeeT9dGru2iFw/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kclkmO4Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kclkmO4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788347939; x=1819883939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YG86Tsd5NYoxHqXO1/4RjI2Hwk53MaPPEvTOL3eNPGI=;
  b=kclkmO4ZvrkCq3GAgh1ah6XOnJLUlcmgy3QYs/owomseziG5lFKgfUOu
   X+f504/cwENY7B0c1/N7d5uizgVY6eOqii9voWzhputSZZeyA/aoFWe5G
   qQ632tmmSTosCDhxwOkPDTf3zMSkGLFZy6zKGVGUXsDmjeqKBKHWqSxIJ
   ya0LY298htHcvq+jd+DtEDnI+OJsh0KNzfK/SJ3+vWbCOBE+AnZyYRcrf
   geAK7rl2PMlM/EKek3VHprqS9y9r2e2MSR9ROrSTQra2kO/B+ZrcN7qth
   ZjyupWcnn8E/iCBGItjwrMOGsyxRf9k0ZBp+yNLM4lYRM5sSOE+7HVqXQ
   g==;
X-CSE-ConnectionGUID: RL6csouKT/iDzZsvAHrImQ==
X-CSE-MsgGUID: TwwuSTAdTCqlsyXtVSAVTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87738081"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="87738081"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:18:58 -0700
X-CSE-ConnectionGUID: BYFYmw2iQLyOKvLknLn45w==
X-CSE-MsgGUID: XIK0qokdTzKqWtv/Tl3PxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268078884"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2026 04:18:56 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1izV-000000002UI-3sbM;
	Wed, 02 Sep 2026 11:18:53 +0000
Date: Wed, 2 Sep 2026 19:18:02 +0800
From: kernel test robot <lkp@intel.com>
To: Qingfang Deng <qingfang.deng@linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH] dma-mapping: use exact allocation for DMA pages
Message-ID: <202609021920.kdbedjPR-lkp@intel.com>
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
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260902/202609021920.kdbedjPR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021920.kdbedjPR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021920.kdbedjPR-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages+0xdd (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: dma_common_alloc_pages+0x17 (section: .text) -> alloc_pages_exact_nid_noprof (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
