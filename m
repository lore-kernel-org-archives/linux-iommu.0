Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7A36C0CE
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891813; cv=none; b=MDwGuJHN1DUaPo71TIz5Lby6X5suKorYgeg9P/KZ+lFKqPBn8XOX6yW/zb+q4UkpZHpCYqzhskDAEJ58Gl5VD8O3VgQU0d31mcypOZulMF6qBDI8SPryfdSwrqvDycOi+Ik8KH/W9OqX+pT19l0hBSnuBbzL4RQbJsilaN3yh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891813; c=relaxed/simple;
	bh=La9XdNKDvIlNLu3KgpfvxzV/fhd4Lv/FNSjmGr2QPwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCG1AZJbLcczYrl/LgvL/S84Q9v74P8UVQNbSn0wtZHy9Ote7AalccBcnR0cvRByUPoZ5CIqe/y+RE0JtlGxMBI2toJFEKhJQylpnFFSP6qpZ9G0BLLCE9L0Qvm8LlyROKZgHleOMa9yUFMR5gmlwkttXpxV9oY+bDJLdrU7OkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQob5zWU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQob5zWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768891808; x=1800427808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=La9XdNKDvIlNLu3KgpfvxzV/fhd4Lv/FNSjmGr2QPwI=;
  b=OQob5zWUYhsQqPjKytLH0ybDG0lqN1Y2MqwGrZepXPqzqk5rO7I3/fea
   sYG/EVkpcKkHUyaA3uecrtRTByv6il7TCICnSGvn/bn3iPSyGr0ohrfNn
   9EbLystb/cK6HLCBZK7QeI5A4KY1kzyd4CCqTF51WdNBcts641l+XoGik
   0TM24fYjFYGTAy4gnLIFfOq2FRm8oLmCpXz9TGdLX5lJ4m/vDgY7mGvhq
   IJDbgIJ1nN5jFHa/zCQZFX45Q9a38DGKnVahKVI40yfTKGf+fcQVcYod+
   Rpp/VBCHxf+fMWUbqE1vGB5mZ6x2FMA9fXnJ9HVIs9lGsh00H47/9rB9q
   Q==;
X-CSE-ConnectionGUID: JLxY31EIRQuRUKQFiZ5Ykw==
X-CSE-MsgGUID: lQUMmGCAQmqfxbeG0MGR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81201843"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81201843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:50:02 -0800
X-CSE-ConnectionGUID: BJ/NJHRjTWqgV0G2QdEGdQ==
X-CSE-MsgGUID: jHn1saJITG+v2MLV21VjKg==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:49:59 -0800
Message-ID: <8908354f-4962-4ecb-85f1-b1c58ce45385@linux.intel.com>
Date: Tue, 20 Jan 2026 14:49:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible
 PCIe device
To: Jinhui Guo <guojinhui.liam@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/25 11:59, Jinhui Guo wrote:
> Hi, all
> 
> We hit hard-lockups when the Intel IOMMU waits indefinitely for an ATS invalidation
> that cannot complete, especially under GDR high-load conditions.
> 
> 1. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
>     non-scalable mode. Two scenarios exist: NIC link-down with an explicit link-down
>     event and link-down without any event.
> 
>     a) NIC link-down with an explicit link-dow event.
>        Call Trace:
>         qi_submit_sync
>         qi_flush_dev_iotlb
>         __context_flush_dev_iotlb.part.0
>         domain_context_clear_one_cb
>         pci_for_each_dma_alias
>         device_block_translation
>         blocking_domain_attach_dev
>         iommu_deinit_device
>         __iommu_group_remove_device
>         iommu_release_device
>         iommu_bus_notifier
>         blocking_notifier_call_chain
>         bus_notify
>         device_del
>         pci_remove_bus_device
>         pci_stop_and_remove_bus_device
>         pciehp_unconfigure_device
>         pciehp_disable_slot
>         pciehp_handle_presence_or_link_change
>         pciehp_ist
> 
>     b) NIC link-down without an event - hard-lock on VM destroy.
>        Call Trace:
>         qi_submit_sync
>         qi_flush_dev_iotlb
>         __context_flush_dev_iotlb.part.0
>         domain_context_clear_one_cb
>         pci_for_each_dma_alias
>         device_block_translation
>         blocking_domain_attach_dev
>         __iommu_attach_device
>         __iommu_device_set_domain
>         __iommu_group_set_domain_internal
>         iommu_detach_group
>         vfio_iommu_type1_detach_group
>         vfio_group_detach_container
>         vfio_group_fops_release
>         __fput
> 
> 2. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
>     scalable mode; NIC link-down without an event hard-locks on VM destroy.
>     Call Trace:
>      qi_submit_sync
>      qi_flush_dev_iotlb
>      intel_pasid_tear_down_entry
>      device_block_translation
>      blocking_domain_attach_dev
>      __iommu_attach_device
>      __iommu_device_set_domain
>      __iommu_group_set_domain_internal
>      iommu_detach_group
>      vfio_iommu_type1_detach_group
>      vfio_group_detach_container
>      vfio_group_fops_release
>      __fput
> 
> Fix both issues with two patches:
> 1. Skip dev-IOTLB flush for inaccessible devices in __context_flush_dev_iotlb() using
>     pci_device_is_present().
> 2. Use pci_device_is_present() instead of pci_dev_is_disconnected() to decide when to
>     skip ATS invalidation in devtlb_invalidation_with_pasid().
> 
> Best Regards,
> Jinhui
> 
> ---
> v1:https://lore.kernel.org/all/20251210171431.1589-1- 
> guojinhui.liam@bytedance.com/
> 
> Changelog in v1 -> v2 (suggested by Baolu Lu)
>   - Simplify the pci_device_is_present() check in __context_flush_dev_iotlb().
>   - Add Cc:stable@vger.kernel.org to both patches.
> 
> Jinhui Guo (2):
>    iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
>      scalable mode
>    iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
>      scalable mode

Queued for iommu next.

Thanks,
baolu
