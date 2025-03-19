Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585E24DFE3
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349576; cv=none; b=q6sJtjm3TLqeBt8E6PAp2Gs/vTZFasG5YF+d8v5R+JNsUN3VI4S85wYPjWK24C+j2t9OJVG7PP3/8sMLfMyYUmRR9I7ZpSQRUnbwBkXNNafSWh05VnQqr90K626Nhr4wPpor2iot1pF2Nfl4bSV0Nene68fZfsHo2zooz+hPPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349576; c=relaxed/simple;
	bh=EyyFyODnsEzMciEgu+arJe3dUVPI6ukPATE0SwvOo+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idICR2N0wxZ8susPbyap6GQxm0Ov5Wpm4sGwuE79SlZ7Y07/JgfRQtse9mFy4BYslFP5+npULaFALTCR2OQhoEWt3OoJhKW4u5Daxh5q+s5HDjDA8JvdpOCtT4VbyNhNvOS4RhZz7+DNUSMUD9CI03YAzFI/sv92+ykk9cBy/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFpCYspw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFpCYspw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742349575; x=1773885575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EyyFyODnsEzMciEgu+arJe3dUVPI6ukPATE0SwvOo+k=;
  b=FFpCYspw+GDwDA+tk5f6ouird8KbKSvnD7bqjpSr3zgcHyB9FuHIF89o
   Cdyo0g9cpxeOlxkBx+WNvUydkXvig5Ag2e8f93dEzWupmLXM8yydr1NgJ
   0gp/1ogK+/+sgbpebTOnOvTo5QbWqxDl4ZXD+7c1mi/58/tSXWA3r6v+d
   i9BV8GBKmA0rXb8X/mzrtKXOcoJKAp9K3sa+mXV4BNCRbzSRzvOEXfgGT
   1lGo+pLdxvpPk4fKj5SC/rYCTeDoKmOM2oGx0es/HY0P4Q15bdwzZQ6ae
   z67P25a6L8zVqwmZUdkURMnqGdaSwfTqWJRRy3WpPlr08kiU4zWk85bog
   A==;
X-CSE-ConnectionGUID: UzbbEbCuRjubfXLl0Ip3nA==
X-CSE-MsgGUID: HZDPzXlHQgWaQOMv1Nvmvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53734818"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="53734818"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:59:35 -0700
X-CSE-ConnectionGUID: Kg9WWkAJQcSasLF9z61Sjw==
X-CSE-MsgGUID: qiiq/t0wT/iImM2ZB3AAcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123185683"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:59:33 -0700
Message-ID: <67630ed5-7ace-4e7f-9d26-3d259c381488@linux.intel.com>
Date: Wed, 19 Mar 2025 09:56:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible circular locking dependency
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 chaitanya.kumar.borah@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250317035714.1041549-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250317035714.1041549-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 11:57, Lu Baolu wrote:
> We have recently seen report of lockdep circular lock dependency warnings
> on platforms like skykale and kabylake:
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.14.0-rc6-CI_DRM_16276-gca2c04fe76e8+ #1 Not tainted
>   ------------------------------------------------------
>   swapper/0/1 is trying to acquire lock:
>   ffffffff8360ee48 (iommu_probe_device_lock){+.+.}-{3:3},
>     at: iommu_probe_device+0x1d/0x70
> 
>   but task is already holding lock:
>   ffff888102c7efa8 (&device->physical_node_lock){+.+.}-{3:3},
>     at: intel_iommu_init+0xe75/0x11f0
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #6 (&device->physical_node_lock){+.+.}-{3:3}:
>          __mutex_lock+0xb4/0xe40
>          mutex_lock_nested+0x1b/0x30
>          intel_iommu_init+0xe75/0x11f0
>          pci_iommu_init+0x13/0x70
>          do_one_initcall+0x62/0x3f0
>          kernel_init_freeable+0x3da/0x6a0
>          kernel_init+0x1b/0x200
>          ret_from_fork+0x44/0x70
>          ret_from_fork_asm+0x1a/0x30
> 
>   -> #5 (dmar_global_lock){++++}-{3:3}:
>          down_read+0x43/0x1d0
>          enable_drhd_fault_handling+0x21/0x110
>          cpuhp_invoke_callback+0x4c6/0x870
>          cpuhp_issue_call+0xbf/0x1f0
>          __cpuhp_setup_state_cpuslocked+0x111/0x320
>          __cpuhp_setup_state+0xb0/0x220
>          irq_remap_enable_fault_handling+0x3f/0xa0
>          apic_intr_mode_init+0x5c/0x110
>          x86_late_time_init+0x24/0x40
>          start_kernel+0x895/0xbd0
>          x86_64_start_reservations+0x18/0x30
>          x86_64_start_kernel+0xbf/0x110
>          common_startup_64+0x13e/0x141
> 
>   -> #4 (cpuhp_state_mutex){+.+.}-{3:3}:
>          __mutex_lock+0xb4/0xe40
>          mutex_lock_nested+0x1b/0x30
>          __cpuhp_setup_state_cpuslocked+0x67/0x320
>          __cpuhp_setup_state+0xb0/0x220
>          page_alloc_init_cpuhp+0x2d/0x60
>          mm_core_init+0x18/0x2c0
>          start_kernel+0x576/0xbd0
>          x86_64_start_reservations+0x18/0x30
>          x86_64_start_kernel+0xbf/0x110
>          common_startup_64+0x13e/0x141
> 
>   -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>          __cpuhp_state_add_instance+0x4f/0x220
>          iova_domain_init_rcaches+0x214/0x280
>          iommu_setup_dma_ops+0x1a4/0x710
>          iommu_device_register+0x17d/0x260
>          intel_iommu_init+0xda4/0x11f0
>          pci_iommu_init+0x13/0x70
>          do_one_initcall+0x62/0x3f0
>          kernel_init_freeable+0x3da/0x6a0
>          kernel_init+0x1b/0x200
>          ret_from_fork+0x44/0x70
>          ret_from_fork_asm+0x1a/0x30
> 
>   -> #2 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
>          __mutex_lock+0xb4/0xe40
>          mutex_lock_nested+0x1b/0x30
>          iommu_setup_dma_ops+0x16b/0x710
>          iommu_device_register+0x17d/0x260
>          intel_iommu_init+0xda4/0x11f0
>          pci_iommu_init+0x13/0x70
>          do_one_initcall+0x62/0x3f0
>          kernel_init_freeable+0x3da/0x6a0
>          kernel_init+0x1b/0x200
>          ret_from_fork+0x44/0x70
>          ret_from_fork_asm+0x1a/0x30
> 
>   -> #1 (&group->mutex){+.+.}-{3:3}:
>          __mutex_lock+0xb4/0xe40
>          mutex_lock_nested+0x1b/0x30
>          __iommu_probe_device+0x24c/0x4e0
>          probe_iommu_group+0x2b/0x50
>          bus_for_each_dev+0x7d/0xe0
>          iommu_device_register+0xe1/0x260
>          intel_iommu_init+0xda4/0x11f0
>          pci_iommu_init+0x13/0x70
>          do_one_initcall+0x62/0x3f0
>          kernel_init_freeable+0x3da/0x6a0
>          kernel_init+0x1b/0x200
>          ret_from_fork+0x44/0x70
>          ret_from_fork_asm+0x1a/0x30
> 
>   -> #0 (iommu_probe_device_lock){+.+.}-{3:3}:
>          __lock_acquire+0x1637/0x2810
>          lock_acquire+0xc9/0x300
>          __mutex_lock+0xb4/0xe40
>          mutex_lock_nested+0x1b/0x30
>          iommu_probe_device+0x1d/0x70
>          intel_iommu_init+0xe90/0x11f0
>          pci_iommu_init+0x13/0x70
>          do_one_initcall+0x62/0x3f0
>          kernel_init_freeable+0x3da/0x6a0
>          kernel_init+0x1b/0x200
>          ret_from_fork+0x44/0x70
>          ret_from_fork_asm+0x1a/0x30
> 
>   other info that might help us debug this:
> 
>   Chain exists of:
>     iommu_probe_device_lock --> dmar_global_lock -->
>       &device->physical_node_lock
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&device->physical_node_lock);
>                                  lock(dmar_global_lock);
>                                  lock(&device->physical_node_lock);
>     lock(iommu_probe_device_lock);
> 
>    *** DEADLOCK ***
> 
> This driver uses a global lock to protect the list of enumerated DMA
> remapping units. It is necessary due to the driver's support for dynamic
> addition and removal of remapping units at runtime.
> 
> Two distinct code paths require iteration over this remapping unit list:
> 
> - Device registration and probing: the driver iterates the list to
>    register each remapping unit with the upper layer IOMMU framework
>    and subsequently probe the devices managed by that unit.
> - Global configuration: Upper layer components may also iterate the list
>    to apply configuration changes.
> 
> The lock acquisition order between these two code paths was reversed. This
> caused lockdep warnings, indicating a risk of deadlock. Fix this warning
> by releasing the global lock before invoking upper layer interfaces for
> device registration.
> 
> Fixes: b150654f74bf ("iommu/vt-d: Fix suspicious RCU usage")
> Closes:https://lore.kernel.org/linux-iommu/ 
> SJ1PR11MB612953431F94F18C954C4A9CB9D32@SJ1PR11MB6129.namprd11.prod.outlook.com/
> Cc:stable@vger.kernel.org
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued this patch for iommu tree.
