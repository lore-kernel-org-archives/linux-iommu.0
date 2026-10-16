Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A212F6188;
	Fri, 16 Oct 2026 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126556; cv=none; b=Bz93yNZkasQll/0oAkAMZ9kAk4vaxDzIPKVtpLH+ejGa0rDVTDt9b4UNIZMWbiy+DP0CWA2YPb3Ufg7GgnLFBESbUS/hw10FO4tXe0N2oo4XGKB5BzGKl6EpkYI03Lq9YbxvCRu6qVeF4r2hZ4mL6BUaktSMLsN6yw8RgSzLGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126556; c=relaxed/simple;
	bh=MM1H5CppfKe9TFwEMwX1JK9hEtOIhOo/5H8CuYa9jW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT5SkFbhYJ9m8hA5Rx0uQYPpcprxsXlcmIp1IOYhpxEo5CbOYMy9DvFRXHw+MOAFe3LZ7ha4zlvAK94sMepiJsNi6UWYAp9wRURfHTjALulX413/ksI9WsFJQanpW0QYdKG8qeuxWxFdOjhsvfYhhmmpC50IZwTuA48eLIdoR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lvu4Vs+Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lvu4Vs+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792126554; x=1823662554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MM1H5CppfKe9TFwEMwX1JK9hEtOIhOo/5H8CuYa9jW8=;
  b=Lvu4Vs+YV1NbPs3dU19GI3fZN/HgCP/Ye7N3cicc5uXdVRP3q7QtUAOC
   xcVOt0IkE+Cz8DnvJwpgDuJbUezV6KggyhW7hW5s6q5pZI7Ud0yFpNCAw
   jiUvANj7/JkYfAnmYgTsPeXJmiSNx6bdmDhnUjAjvvjq1Ie1gkbu2+k/n
   l32lTpIPZrOk2tbUV/dxRr48N5NrzSt+s4Z996erktWBvAtO2K4PWwA3h
   13rQMKut/wslr4QEbnULh9+GO6JuI5JX1EONkgnG6aVZt243b2jfTuEAj
   10KRQYCJ7k3hIT73xCoId4CnE+jtxpSWUyH+rnZFw6/sPDpkH4FWKjVlM
   Q==;
X-CSE-ConnectionGUID: fIzl9Ct9QkamVjI1pyhZ+A==
X-CSE-MsgGUID: CMNolirpRJCj5BYMHmm1HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="798382"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="798382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 21:55:53 -0700
X-CSE-ConnectionGUID: YMJcPrrdS6OhA32mx6YObA==
X-CSE-MsgGUID: xpfQAwhUTNmbU4hYwfo8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1814166"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Oct 2026 21:55:48 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHZyq-00000000Hcw-0SDE;
	Fri, 16 Oct 2026 04:55:44 +0000
Date: Fri, 16 Oct 2026 12:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Kiryl Shutsemau <kas@kernel.org>,
	Li RongQing <lirongqing@baidu.com>, Marco Elver <elver@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v5 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI
 wakeup when IRTE[IsRun] = 0
Message-ID: <202610161241.OoInPYLr-lkp@intel.com>
References: <20261015064515.10700-5-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015064515.10700-5-sarunkod@amd.com>

Hi Sairaj,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4056b3c9d3c92ea45955641dbafeb9b960e146ef]

url:    https://github.com/intel-lab-lkp/linux/commits/Sairaj-Kodilkar/iommu-amd-KVM-SVM-Rename-cpu-to-apicid-in-IOMMU-interface/20261015-121509
base:   4056b3c9d3c92ea45955641dbafeb9b960e146ef
patch link:    https://lore.kernel.org/r/20261015064515.10700-5-sarunkod%40amd.com
patch subject: [PATCH v5 4/7] iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] = 0
config: x86_64-randconfig-1017-20261016 (https://download.01.org/0day-ci/archive/20261016/202610161241.OoInPYLr-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610161241.OoInPYLr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610161241.OoInPYLr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/amd/init.c:163:6: error: redefinition of 'false' as different kind of symbol
     163 | bool amd_iommu_gappi;
         |      ^
   include/linux/amd-iommu.h:65:25: note: expanded from macro 'amd_iommu_gappi'
      65 | #define amd_iommu_gappi false
         |                         ^
   include/linux/stddef.h:11:2: note: previous definition is here
      11 |         false   = 0,
         |         ^
   drivers/iommu/amd/init.c:164:15: error: redefinition of 'false' as different kind of symbol
     164 | EXPORT_SYMBOL(amd_iommu_gappi);
         |               ^
   include/linux/amd-iommu.h:65:25: note: expanded from macro 'amd_iommu_gappi'
      65 | #define amd_iommu_gappi false
         |                         ^
   include/linux/stddef.h:11:2: note: previous definition is here
      11 |         false   = 0,
         |         ^
>> drivers/iommu/amd/init.c:164:1: error: cannot take the address of an rvalue of type 'int'
     164 | EXPORT_SYMBOL(amd_iommu_gappi);
         | ^             ~~~~~~~~~~~~~~~
   include/linux/export.h:89:29: note: expanded from macro 'EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^              ~~~
   include/linux/export.h:86:38: note: expanded from macro '_EXPORT_SYMBOL'
      86 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                         ^               ~~~
   include/linux/export.h:77:2: note: expanded from macro '__EXPORT_SYMBOL'
      77 |         __ADDRESSABLE(sym)                                      \
         |         ^             ~~~
   include/linux/compiler.h:276:2: note: expanded from macro '__ADDRESSABLE'
     276 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^              ~~~
   include/linux/compiler.h:273:63: note: expanded from macro '___ADDRESSABLE'
     273 |         __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
         |                                                                      ^~~~
   3 errors generated.


vim +/false +163 drivers/iommu/amd/init.c

   162	
 > 163	bool amd_iommu_gappi;
 > 164	EXPORT_SYMBOL(amd_iommu_gappi);
   165	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
