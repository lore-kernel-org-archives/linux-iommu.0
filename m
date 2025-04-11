Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A62367D1
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381616; cv=none; b=AMasN+IF461iYWJHRdNtfW6JuWDy6OXstwWPcRCNDFd47URLiZmc6rp3GaS7iHZe56tVQr4XjZVszeXgDMvgsPrbhrAd/QP7uuh95A0N5JW7ggiASt04RFt/wdRp0kcPYqNE0Ys+ngUe0wcgXSU32URsQSIPiXpvu9KM0Jif9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381616; c=relaxed/simple;
	bh=STQlMC7BdBDPu8U/eRLrGB8IIj1H4SK9wzoWpaZBbUE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ACArS4Op5g7ZbVGLhwzPL8aDCLk+2ErbLa2B9X4LOVgxPmIgodovPXe9yYIZpF3MVd7HeSTrEWv0Us5Up3VNDbkOheVIZToH9Z2exxFneWjIjb71oYelO5xuz+4/phQ4TunHYKViiz1G64RL9OkAkAed03QO1+YcNI4QxRky4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OewrP0GA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OewrP0GA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744381615; x=1775917615;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=STQlMC7BdBDPu8U/eRLrGB8IIj1H4SK9wzoWpaZBbUE=;
  b=OewrP0GAw8X7mJnvuuJ4r6sBsjRA94qsTcb3ZuHlhP1hjrijivEcveUz
   L5aPLb1q1u0BfkfmymO3XTwWDqkNXMIyNADb/ppGxkpTtRhAk08mCRU0P
   laGaDaaUUAUmcEuRwdFH9AzLCashEytrXo5Ka/LJKAc0adj25eNIi2xE0
   UsmQnA6Hbi1eVhJSdEyAw78MjCo39czOnVPHV2wCMUimV9kR8ZoXYBHQf
   BQ0n5Fl9+/jObSyEaWImDByko9F+fPtmdQ4q5eMIe9kLZsatTfGUH8bfl
   jXde2YpLBBby6E5GRkmjJ+ia/kCEYqqefWwip9Zve9FLNxwc0+fYhuWsg
   Q==;
X-CSE-ConnectionGUID: 0I7dHXXFTs62c2Vbfi73eQ==
X-CSE-MsgGUID: wDCzdGgtTOGOAmBLF26zAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56117287"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56117287"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 07:26:55 -0700
X-CSE-ConnectionGUID: DhkBh23yTnWI9mGh5CXQ5w==
X-CSE-MsgGUID: y5vuTJExS9eZg2rn7pNAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="130048013"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2025 07:26:53 -0700
Message-ID: <01b9c72f-460d-4f77-b696-54c6825babc9@linux.intel.com>
Date: Fri, 11 Apr 2025 17:26:51 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Regression with "iommu/vt-d: Move scalable mode ATS enablement to
 probe path"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

v6.15-rc1 stopped booting on a Lunar Lake and Panther Lake based test 
machines when "intel_iommu=on" is set on the kernel command line.

I narrowed regression down to the commit 5518f239aff1 ("iommu/vt-d: Move 
scalable mode ATS enablement to probe path"). Trace below at that commit.

Previous commit 607ba1bb0961 ("iommu/vt-d: Check if SVA is supported 
when attaching the SVA domain") boots fine and also v6.15-rc1 when 
setting "intel_iommu=off".

[    6.005272] pci 0000:00:1f.0: Adding to iommu group 17
[    6.010476] pci 0000:00:1f.3: Adding to iommu group 17
[    6.015684] pci 0000:00:1f.4: Adding to iommu group 17
[    6.020888] pci 0000:00:1f.5: Adding to iommu group 17
[    6.026091] pci 0000:00:1f.6: Adding to iommu group 17
[    6.031318] pci 0000:7f:00.0: Adding to iommu group 18
[    6.040492] Kernel panic - not syncing: DMAR hardware is malfunctioning
[    6.040492] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.14.0-rc3+ #175
[    6.040492] Call Trace:
[    6.040492]  <TASK>
[    6.040492]  dump_stack_lvl+0x6f/0xb0
[    6.040492]  dump_stack+0x10/0x16
[    6.040492]  panic+0x10a/0x2b7
[    6.040492]  iommu_enable_translation.cold+0xc/0xc
[    6.040492]  intel_iommu_init+0xe39/0xec0
[    6.040492]  ? trace_hardirqs_on+0x1e/0xd0
[    6.040492]  ? __pfx_pci_iommu_init+0x10/0x10
[    6.040492]  pci_iommu_init+0xd/0x40
[    6.040492]  do_one_initcall+0x5b/0x390
[    6.040492]  kernel_init_freeable+0x26d/0x2b0
[    6.040492]  ? __pfx_kernel_init+0x10/0x10
[    6.040492]  kernel_init+0x15/0x120
[    6.040492]  ret_from_fork+0x35/0x60
[    6.040492]  ? __pfx_kernel_init+0x10/0x10
[    6.040492]  ret_from_fork_asm+0x1a/0x30
[    6.040492] RIP: 1f0f:0x0
[    6.040492] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[    6.040492] RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX: 
1f0f2e6600000000
[    6.040492] RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 
2e66000000000084
[    6.040492] RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 
00841f0f2e660000
[    6.040492] RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 
000000841f0f2e66
[    6.040492] R10: 0000000000841f0f R11: 2e66000000000084 R12: 
000000841f0f2e66
[    6.040492] R13: 0000000000841f0f R14: 2e66000000000084 R15: 
1f0f2e6600000000
[    6.040492]  </TASK>
[    6.040492] ---[ end Kernel panic - not syncing: DMAR hardware is 
malfunctioning ]---

