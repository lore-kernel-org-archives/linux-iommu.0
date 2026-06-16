Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D13D0937;
	Tue, 16 Jun 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587908; cv=none; b=XQC7TSPPbq37AIBuwCdMmpofBeNOCbTbtMk3xrPC0SjgUyxLeEHUZw45dj6vOd6Og3597o5iM00HPsupyLEY6azALCPYA+KurufZrKHqJ8o7irNNiOHosw7NxDXm30+axjHzyLAGFKugbBgZKFMKsVoADKg2EhaOC87XEHFh1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587908; c=relaxed/simple;
	bh=2DHGdkh+LxkF8N/SJ1IAj8JluhHq4Cb1Ynj6/3QS7GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta0K5svlzRiToi6j2SoDKToM3eCqO0jBzwM1wa0dZ4dvCDa0CQbhbbYiB1zODJcH/d5+VhvSimseSmZmbqa2tgN8YcwX5UvjQqpIwubxPDli14wqmQTHCGEqfBpWHMOuXAogsP7v38mTZ06i1j+aNN9yFU2Ykei/WeQlmKSv5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRgLH8Lb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRgLH8Lb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781587906; x=1813123906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DHGdkh+LxkF8N/SJ1IAj8JluhHq4Cb1Ynj6/3QS7GQ=;
  b=BRgLH8LbqIixV1lzdvD+/kDlrpb2vNtWOKc8v3AranJxS4IsMhnK3M0P
   gVoIS8vSofNmQXRtQ8o/JH/1KaovXX4DDrhPsXSdtuN8pQy62Pz+ULriK
   M5JO3C7EC+177KCPatTklmI4ODzW4l1QpD3UCLa0ouv595OQNwMsdmB/S
   X2ThSmQY1KjF2IGpgF1CEnO9CcdwAVr88w2VLKNvzijeuhCWBMQP5OcP9
   wl3dCkdoyawPa4sD+rn9q2zh9iOD/ervPIzllZerFzeHwOp47hvQ2wN0x
   wUgYAGt00+pPDJG/htUMtdy5L/D5ppjufY7qlWbBB8PxFZxafEdUuwFgA
   Q==;
X-CSE-ConnectionGUID: mmYsfz6jRx2HgszIcWStFg==
X-CSE-MsgGUID: 1kC8CzRgRBK7Ji0GGflMAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="107772714"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="107772714"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 22:31:45 -0700
X-CSE-ConnectionGUID: n42ZcPFkR/isOZj3lnwUSg==
X-CSE-MsgGUID: gqesfjdSSDG/SZHim1et1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285784566"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Jun 2026 22:31:41 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZMOf-00000000Skg-0Hmh;
	Tue, 16 Jun 2026 05:31:37 +0000
Date: Tue, 16 Jun 2026 13:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <202606161322.zGyw68Qa-lkp@intel.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.1 next-20260615]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/swiotlb-avoid-double-copy-with-swiotlb-on-tx-socket/20260616-074655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260615234220.3946885-1-lrizzo%40google.com
patch subject: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
config: powerpc-pmac32_defconfig (https://download.01.org/0day-ci/archive/20260616/202606161322.zGyw68Qa-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e19d1f51a2c80b63cd8ca95bcc757b7077112808)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161322.zGyw68Qa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161322.zGyw68Qa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/core/sock.c:3215 function parameter 'sk' not described in '__skb_page_frag_refill'
>> Warning: net/core/sock.c:3215 expecting prototype for skb_page_frag_refill(). Prototype was for __skb_page_frag_refill() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
