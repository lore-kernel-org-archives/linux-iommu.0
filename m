Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07822F14C
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792650; cv=none; b=UY19+n0MDbjV1My+O5IDNc/mMaV+4pLOVNQdGdSL+Hf3KowNXIhLiKw4wS+UAvgUGkFEPzQGJhn44BAnG778b1DR9svdAA0AeMY4oLrLfD6iv5z5nGvicwYMSAZrn02Q5762dPjMVTiF1jljEPXetWXt2hhUWeeXFgnL8BhqHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792650; c=relaxed/simple;
	bh=bOHU1ag3ybpYk2bJ2ey4Lc1aaW7UA9FGxTVXVxrHWBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBaic4oujz9dRnzX/Ksd6oH0gdz8qsJmOOekxDgvQwP1YnzgtidaYSfSQOrBL65xOd1upHFxJLtxtN3Y8fVszI/ZDBQ8IzC075cA+UWZm5ihNjpgK2nSFg6M/zLGEFEaRhyuGmRKpHdcyel+L7pCE5HJjLqQ6o6jq1Fl/8ix1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wd5mgpIU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wd5mgpIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744792649; x=1776328649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bOHU1ag3ybpYk2bJ2ey4Lc1aaW7UA9FGxTVXVxrHWBg=;
  b=Wd5mgpIUJ3NQ9i5FP/b3I0X3oaaSczsVLzTQWBIFE+1QMtS8xS29aFXt
   ZnBJsvesA1MXcvgfINLVTeUrbz9djLVHnYXThSv1FxkTlDRHJ8UgzIvOJ
   N8vxt/UK3pnZLKOJTE1m1x0qp3UwhJ6pjW0xfj4zMD/txZvmrTz3m65Jl
   ItIleQbU0YzRJCjpnXxYvGXsJrY5yNTtvcz4KLJSTNcEPETlpI57El1a0
   4JNFdmf2oDdmI72waSxcoTgEE714I5gUnxX1IZN/NZvLwlMbPEIu7fJg2
   jiq7zWGmsi9cE/32WD9bYLJIgZOkwrfW7p1kLzixoR15W6vorA70DzUpI
   A==;
X-CSE-ConnectionGUID: srAXNp2NTuyoHfutoBO2Lg==
X-CSE-MsgGUID: PWTjSa73SxKT5ju+WIKUgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50128127"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="50128127"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 01:37:25 -0700
X-CSE-ConnectionGUID: vuMyEEALRPCPg8nPad+VIw==
X-CSE-MsgGUID: l1DKvDFPQfef8WFgVEW8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="161419955"
Received: from mylly.fi.intel.com (HELO [10.237.72.50]) ([10.237.72.50])
  by fmviesa001.fm.intel.com with ESMTP; 16 Apr 2025 01:37:22 -0700
Message-ID: <ce37a94b-c15a-4c03-b8ed-76bbfa369d88@linux.intel.com>
Date: Wed, 16 Apr 2025 11:37:21 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Revert ATS timing change to fix boot
 failure
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20250416073608.1799578-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 10:36 AM, Lu Baolu wrote:
> Commit <5518f239aff1> ("iommu/vt-d: Move scalable mode ATS enablement to
> probe path") changed the PCI ATS enablement logic to run earlier,
> specifically before the default domain attachment.
> 
> On some client platforms, this change resulted in boot failures, causing
> the kernel to panic with the following message and call trace:
> 
>   Kernel panic - not syncing: DMAR hardware is malfunctioning
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #175
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x6f/0xb0
>    dump_stack+0x10/0x16
>    panic+0x10a/0x2b7
>    iommu_enable_translation.cold+0xc/0xc
>    intel_iommu_init+0xe39/0xec0
>    ? trace_hardirqs_on+0x1e/0xd0
>    ? __pfx_pci_iommu_init+0x10/0x10
>    pci_iommu_init+0xd/0x40
>    do_one_initcall+0x5b/0x390
>    kernel_init_freeable+0x26d/0x2b0
>    ? __pfx_kernel_init+0x10/0x10
>    kernel_init+0x15/0x120
>    ret_from_fork+0x35/0x60
>    ? __pfx_kernel_init+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>   RIP: 1f0f:0x0
>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>   RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX:
>        1f0f2e6600000000
>   RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX:
>        2e66000000000084
>   RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI:
>        00841f0f2e660000
>   RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09:
>        000000841f0f2e66
>   R10: 0000000000841f0f R11: 2e66000000000084 R12:
>        000000841f0f2e66
>   R13: 0000000000841f0f R14: 2e66000000000084 R15:
>        1f0f2e6600000000
>    </TASK>
>   ---[ end Kernel panic - not syncing: DMAR hardware is malfunctioning ]---
> 
> Fix this by reverting the timing change for ATS enablement introduced by
> the offending commit and restoring the previous behavior.
> 
> Fixes: 5518f239aff1 ("iommu/vt-d: Move scalable mode ATS enablement to probe path")
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Closes: https://lore.kernel.org/linux-iommu/01b9c72f-460d-4f77-b696-54c6825babc9@linux.intel.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
