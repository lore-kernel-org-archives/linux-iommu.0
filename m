Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD72EA498
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227251; cv=none; b=dStGTADYi7Xw5GdJAFVMOxjWkk8NPM9uqFrjs5t2Mne8w3RsvFSAWjrpwT0+juRsBT3SrCg6j3ROZikOYwFIFKoS+amX0pT6eKtIDtTfmevpadaoXvPt/g6EjDvumXxQZ1lZHpGKetDg7vkmx6dx5C7sS3AUDIGcFMAwCqUMK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227251; c=relaxed/simple;
	bh=GUNx5hShdOh0rIUyMcWbNaaTOXFulxYmj/E28rjgtic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqATi4pg9o2Ah8gjUIm1UtzLHhybcoBWx9O06gTTlJMrViLXgIjNnJIDfN5BBxhYzyk9rGBpbw/05EIFdQyPH4IkPKVGplxCTDYr3JsCmmF1u3NchMZN9TdoNlwWHtv9bXULyMvBYZ6Zjxf88lotPKXIAQ1Z7IEfRtIlaTvEZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlUtmTWu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlUtmTWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227249; x=1809763249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GUNx5hShdOh0rIUyMcWbNaaTOXFulxYmj/E28rjgtic=;
  b=QlUtmTWux3p/OJhzrgJBdfHBkxnDMo4eOGcSoQu1phIgUnaK4jsYGucw
   +1/b4tZF+Gidq5NCxbBgUE+KVTsNPGjDooPMcteiArT+kNpDAnh42kY34
   2i+GXFrQjvYZumgsI6yeTyPCg+KrWdTQczOdSKqBHrOlzx0oDnRdDXCKe
   CiwVS7CNFTzMf703z70/8KOT1Gm/V4gW60ul2Cpj1pq97yNUOTCT78ji1
   fQi/AveVfumnJFetGT0q5b8y7h9rr1IX8iSa6YQnwz1qXsIh/dRrg7Jlm
   9Noq1iPxE5A9rYCUk9RBKTNY8PUW7uXejlviyBX+rh+TTuCWWwuu5XHUY
   g==;
X-CSE-ConnectionGUID: 2jYrpdiHRuCrry6sAkN9OQ==
X-CSE-MsgGUID: DANJVfQGTditpoaz4lKzPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90570247"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90570247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:00:49 -0700
X-CSE-ConnectionGUID: GIGlgAzJQJ+iX1biiyjCuQ==
X-CSE-MsgGUID: luwc1h9eQzecrtwmF8jcGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241049529"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:00:46 -0700
Message-ID: <3d33cb53-4571-47b8-bced-9d4122ba3aeb@linux.intel.com>
Date: Fri, 8 May 2026 15:58:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix oops due to out of scope access
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260421031347.1408890-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 11:13, Zhenzhong Duan wrote:
> Below oops triggers when kill QEMU process:
> 
>    Oops: general protection fault, probably for non-canonical address 0x7fffffff844eaaa7: 0000 [#1] SMP NOPTI
>    Call Trace:
>     <TASK>
>     do_raw_spin_lock+0xaa/0xc0
>     _raw_spin_lock_irqsave+0x21/0x40
>     domain_remove_dev_pasid+0x52/0x160
>     intel_nested_set_dev_pasid+0x1b9/0x1e0
>     __iommu_set_group_pasid+0x56/0x120
>     pci_dev_reset_iommu_done+0xe3/0x180
>     pcie_flr+0x65/0x160
>     __pci_reset_function_locked+0x5b/0x120
>     vfio_pci_core_close_device+0x63/0xe0 [vfio_pci_core]
>     vfio_df_close+0x4f/0xa0
>     vfio_df_unbind_iommufd+0x2d/0x60
>     vfio_device_fops_release+0x3e/0x40
>     __fput+0xe5/0x2c0
>     task_work_run+0x58/0xa0
>     do_exit+0x2c8/0x600
>     do_group_exit+0x2f/0xa0
>     get_signal+0x863/0x8c0
>     arch_do_signal_or_restart+0x24/0x100
>     exit_to_user_mode_loop+0x87/0x380
>     do_syscall_64+0x2ff/0x11e0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The global static blocked domain is a dummy domain without corresponding
> dmar_domain structure, accessing beyond iommu_domain structure triggers
> oops easily. Fix it by return early in domain_remove_dev_pasid() like
> identity domain.
> 
> Fixes: 7d0c9da6c150 ("iommu/vt-d: Add set_dev_pasid callback for dma domain")
> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued for v7.1-rc. Thanks!
