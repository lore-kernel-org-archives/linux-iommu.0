Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFCB22157B;
	Sat, 28 Feb 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271124; cv=none; b=fgS7Myz6suUMYJ80oiNTY/u2YUbiLwqVFGSGP+Wmhc4Eggfm3ZaeXRkMbzWPwPMsJayjs6OEjY0GwOWFsep37E2676vYQwnhGOkwJLQ6e0NjvQi1nIVvNhIg1OmO9BUmp0ris5t48xqO1XSmUl3E3h0bte0H+zQtixpl7xaYgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271124; c=relaxed/simple;
	bh=Rrx8y/C17jrzfE6kvyZzwZwuPU1bRbyLhVZrjF/dgcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+qgM0OJznjEenSfYnX+XrEpuyGi7XoiksHacOl/LU8OTvqgetDfXG/fsCUjzd3LwCB7znz8Xq1wukpAS2Vnr/dadF6I5+O5vg8di1tDiohRRphZoEJ8MAC6MfNCwcaqcLr+BGRShDG/GoOn0kiypINHCzy2tO7zUrshcDHThDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pn8OEm8F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pn8OEm8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772271122; x=1803807122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rrx8y/C17jrzfE6kvyZzwZwuPU1bRbyLhVZrjF/dgcs=;
  b=Pn8OEm8FZ+ZYdXCvTbA95qzxmrp6F7CiVEktOyzhmn13OCW4MjtbHKk9
   9Rd8vhhaQPcaYiXjMIzTIayKlIcEgU2lwPJNPIYGLPJUf3bYd5QDHo/80
   hZTK21QFYc06xp7nvoOf79O8MLKpj2prfduLMcR56SZkf+wUU0fNt4/VG
   K1XsbRCiCr3neIoddkmLugHNWj1SWi0xaMY8VSlVcopaMfjINuhaDKavB
   +Z6C/0PaJEBvKVgVawr/To4ZuJ4OtaYY+YkQ26Dh1QcMucW1VNjdaBenX
   e8oTL+TQKukBwfrFsSHeqqBaHQyafD7LvExiUFMSUfkhqzWORIVdciamV
   Q==;
X-CSE-ConnectionGUID: t5p0aqw6Tb6/bWz4t859Rw==
X-CSE-MsgGUID: iPIu5J+hSie9hdCgnuGdPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="84053349"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="84053349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 01:32:01 -0800
X-CSE-ConnectionGUID: pykYmDP9SDaeLcRLYXMDlw==
X-CSE-MsgGUID: M64QioP1Qv+fcwnEXOpsQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="222113504"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 Feb 2026 01:31:55 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwGfw-00000000BQt-0KRK;
	Sat, 28 Feb 2026 09:31:52 +0000
Date: Sat, 28 Feb 2026 17:31:40 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Ripard <mripard@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 8/9] dma-buf: heaps: cma: Turn the heap into a module
Message-ID: <202602281751.KRAYsRVG-lkp@intel.com>
References: <20260227-dma-buf-heaps-as-modules-v2-8-454aee7e06cc@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-dma-buf-heaps-as-modules-v2-8-454aee7e06cc@kernel.org>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on 499a718536dc0e1c1d1b6211847207d58acd9916]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/dma-contiguous-Turn-heap-registration-logic-around/20260227-212606
base:   499a718536dc0e1c1d1b6211847207d58acd9916
patch link:    https://lore.kernel.org/r/20260227-dma-buf-heaps-as-modules-v2-8-454aee7e06cc%40kernel.org
patch subject: [PATCH v2 8/9] dma-buf: heaps: cma: Turn the heap into a module
config: x86_64-randconfig-002-20260227 (https://download.01.org/0day-ci/archive/20260228/202602281751.KRAYsRVG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281751.KRAYsRVG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281751.KRAYsRVG-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "dma_contiguous_get_reserved_region" [drivers/dma-buf/heaps/cma_heap.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
