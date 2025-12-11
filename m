Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927862BE029
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419337; cv=none; b=S0zB5LPXOvwdU0allKYFVYt0kE39lbngnLv6VVloXQ3sGIx5JSdr2Zj4pWrl7prpM6GdOomRGXooxqP4zX7yMxc5dq2bREULc9W5CyfZyXDcoJ7NgOIXG3LqBJYEE5EUYrBdm5mJxlJtckekIpf7DgzhVVTUodhYqXWlpdCXPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419337; c=relaxed/simple;
	bh=20V9RNXwWJcUCprLQFiNgRtVXkKwFnWwFfkyFxwgick=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnueY2W19eNMyUK3NlAEKNvHCH6KBL0duOCM68fJ4k5lzznUibX09n5FT/POTlwJRSsDic7NZMceNboUDtRjYpR8I0ba8ROi/Uctw1nTrA6K4Wl+c5NFVnPsyD7MUlgKcbkuymrLA3dEXYTLWvZAPHT/7jdKsi5YkcnbNVC0gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqOb/ayz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqOb/ayz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765419336; x=1796955336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=20V9RNXwWJcUCprLQFiNgRtVXkKwFnWwFfkyFxwgick=;
  b=SqOb/ayzP4btGauo/Shzkcryp+8IplZM5KzXpi3f3Bh0zitcZL453G8o
   R8ci8E0HZxESm4IYg1XTxZxM/7BqiIpvbYOFATWCzdd2LPlSxJydFCpC1
   gAu0vxZ1xlU9JMDk+HICyvvAuEHdB9/YFjbdeTiivrFmq8XVfN8gSgQWq
   t2Y+tE03wSfS3+9RdlJWG5hl9WU3s1UX4DtY18BB6VXkQddkUkqRJp0su
   4o4jUyKukr/TVNk03BPKtQ4Lh1ANbDhpZjHWDFSR1QXPjGX0xM+aBX2Em
   dZxPMvj1X2YQN0pR94jS/E0Nk0x/oS6DUo758B4/kaG4TbzlJGz1TluSR
   Q==;
X-CSE-ConnectionGUID: h8tkrN1zTECpUvHpA/YnKA==
X-CSE-MsgGUID: url7b3NSSTqtM7gG5YC/+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54944875"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="54944875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 18:15:35 -0800
X-CSE-ConnectionGUID: RBOBc7lUQSeZsP1D1iiD7Q==
X-CSE-MsgGUID: an2ce5yvRJ6SQOrGsZ0oKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="200839760"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 18:15:33 -0800
Message-ID: <98a2a099-0b90-4837-a20c-742c883e8eea@linux.intel.com>
Date: Thu, 11 Dec 2025 10:10:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible
 PCIe device without scalable mode
To: Jinhui Guo <guojinhui.liam@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
Cc: haifeng.zhao@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251210171431.1589-1-guojinhui.liam@bytedance.com>
 <20251210171431.1589-2-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251210171431.1589-2-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/25 01:14, Jinhui Guo wrote:
> PCIe endpoints with ATS enabled and passed through to userspace
> (e.g., QEMU, DPDK) can hard-lock the host when their link drops,
> either by surprise removal or by a link fault.
> 
> Commit 4fc82cd907ac ("iommu/vt-d: Don't issue ATS Invalidation
> request when device is disconnected") adds pci_dev_is_disconnected()
> to devtlb_invalidation_with_pasid() so ATS invalidation is skipped
> only when the device is being safely removed, but it applies only
> when Intel IOMMU scalable mode is enabled.
> 
> With scalable mode disabled or unsupported, a system hard-lock
> occurs when a PCIe endpoint's link drops because the Intel IOMMU
> waits indefinitely for an ATS invalidation that cannot complete.
> 
> Call Trace:
>   qi_submit_sync
>   qi_flush_dev_iotlb
>   __context_flush_dev_iotlb.part.0
>   domain_context_clear_one_cb
>   pci_for_each_dma_alias
>   device_block_translation
>   blocking_domain_attach_dev
>   iommu_deinit_device
>   __iommu_group_remove_device
>   iommu_release_device
>   iommu_bus_notifier
>   blocking_notifier_call_chain
>   bus_notify
>   device_del
>   pci_remove_bus_device
>   pci_stop_and_remove_bus_device
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist
> 
> Commit 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
> adds intel_pasid_teardown_sm_context() to intel_iommu_release_device(),
> which calls qi_flush_dev_iotlb() and can also hard-lock the system
> when a PCIe endpoint's link drops.
> 
> Call Trace:
>   qi_submit_sync
>   qi_flush_dev_iotlb
>   __context_flush_dev_iotlb.part.0
>   intel_context_flush_no_pasid
>   device_pasid_table_teardown
>   pci_pasid_table_teardown
>   pci_for_each_dma_alias
>   intel_pasid_teardown_sm_context
>   intel_iommu_release_device
>   iommu_deinit_device
>   __iommu_group_remove_device
>   iommu_release_device
>   iommu_bus_notifier
>   blocking_notifier_call_chain
>   bus_notify
>   device_del
>   pci_remove_bus_device
>   pci_stop_and_remove_bus_device
>   pciehp_unconfigure_device
>   pciehp_disable_slot
>   pciehp_handle_presence_or_link_change
>   pciehp_ist
> 
> Sometimes the endpoint loses connection without a link-down event
> (e.g., due to a link fault); killing the process (virsh destroy)
> then hard-locks the host.
> 
> Call Trace:
>   qi_submit_sync
>   qi_flush_dev_iotlb
>   __context_flush_dev_iotlb.part.0
>   domain_context_clear_one_cb
>   pci_for_each_dma_alias
>   device_block_translation
>   blocking_domain_attach_dev
>   __iommu_attach_device
>   __iommu_device_set_domain
>   __iommu_group_set_domain_internal
>   iommu_detach_group
>   vfio_iommu_type1_detach_group
>   vfio_group_detach_container
>   vfio_group_fops_release
>   __fput
> 
> pci_dev_is_disconnected() only covers safe-removal paths;
> pci_device_is_present() tests accessibility by reading
> vendor/device IDs and internally calls pci_dev_is_disconnected().
> On a ConnectX-5 (8 GT/s, x2) this costs ~70 µs.
> 
> Since __context_flush_dev_iotlb() is only called on
> {attach,release}_dev paths (not hot), add pci_device_is_present()
> there to skip inaccessible devices and avoid the hard-lock.
> 
> Fixes: 37764b952e1b ("iommu/vt-d: Global devTLB flush when present context entry changed")
> Fixes: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")

Cc: stable@vger.kernel.org

> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>   drivers/iommu/intel/pasid.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3e2255057079..b1e8eb6a6504 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -1099,9 +1099,20 @@ int intel_pasid_setup_sm_context(struct device *dev)
>    */
>   static void __context_flush_dev_iotlb(struct device_domain_info *info)
>   {
> +	struct pci_dev *pdev;
> +
>   	if (!info->ats_enabled)
>   		return;
>   
> +	/*
> +	 * Skip dev-IOTLB flush for inaccessible PCIe devices to prevent the
> +	 * Intel IOMMU from waiting indefinitely for an ATS invalidation that
> +	 * cannot complete.
> +	 */
> +	pdev = dev_is_pci(info->dev) ? to_pci_dev(info->dev) : NULL;
> +	if (pdev && !pci_device_is_present(pdev))
> +		return;

Could simply be

	if (dev_is_pci(info->dev) &&
	    !pci_device_is_present(to_pci_dev(info->dev)))
		return;

?

> +
>   	qi_flush_dev_iotlb(info->iommu, PCI_DEVID(info->bus, info->devfn),
>   			   info->pfsid, info->ats_qdep, 0, MAX_AGAW_PFN_WIDTH);
>   

Thanks,
baolu
