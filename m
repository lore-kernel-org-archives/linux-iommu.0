Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A716311C27
	for <iommu@lists.linux.dev>; Sun,  1 Mar 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772337057; cv=none; b=tjzvCTv+SC6u2dVKfGpSVlfXRnLluEneziNyX3tezU6JN+SvHqEW8mrGNEvXa+zOXh1KHqcLteMx8opNQ9bP89UkHrpnaRnaeHdNcI8eJ9ZaD3UNFL1mhEThreBxsWvT00KOK0lC9pgv6WW3i7BStf2KLNtOteoMuIX0Fv8JtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772337057; c=relaxed/simple;
	bh=dMPwz83V0EGBSQGUv+05EFSISdqfMRyZjBUGlzSck3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwsWMvv4uDyIIUyt/GTvBVPgU2N1UbrEATBymjByIZJWVmH3nyhgvzHJpz4osRPHrfaSoMZ4FAxqEzhqt4umnj5o4TtHX2/n+vQyo8SrflTXm03gGNkVfWrT/mwBqZgahdyTMz3K5Ph1QAJHGwi6CloXpVhJ8Mg6Rql0TwRNPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYkgv0Rm; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYkgv0Rm"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1103113a12.3
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772337055; x=1772941855; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WmlZ9Q2/zs3s/Gu9x2MdBKtAiPtvLREfo+aflS322E=;
        b=dYkgv0RmBdCbokJapt/sif0vQMqzCwd37U+ebrHhwqRFnMHJNROxZZeo0or2gkMHxi
         wukBh6T5dnm3vyEHZpOrVFpzHPK+peYUWUgPEfRuNuziBu4hF3E7+gD8VJhyg4y7pb9U
         nltUqYF0uFTtYyWBkMRMuWqO8+U/avDvd+UJ/yexVwL05D94wQZShz4LDDnMZkw+iKLN
         tUROnQPOCjXiLzF/FlnRIbYUlrbFdDi5PpipNL3njN1r1pChJOYqbpSx8FD3sBJ3ZlFA
         VL0sW2spvk029nedZqcYoBhcz/ueYvYWwiSlC1ZRJyxnISrZgVHQ3ZEXWkyxOXTJsdwp
         /KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772337055; x=1772941855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WmlZ9Q2/zs3s/Gu9x2MdBKtAiPtvLREfo+aflS322E=;
        b=BEKhlE0djU9k1WAdv4PbFFlCyq2tXDpIr0+BmM8JviKwtFnaddgg6NsCUHDSfpo4d0
         dgJi0V7uC8gtTq6AY8j96b8UX885d6riCb/pzMfy0WOjIuCLaJ9nLEAk1nG4HeWZquHz
         6fJiCAaSKbgOUhEVxFkh/MOcpNwf1sjk2oIOOCcLQ5+d8oCba/2ej3xmODXIVJvTfqlY
         zg8f1x1AGV3ikhHlB8n4JPXxiJbwVg6RKNPrgfjGrHGKoBx3QRdqLWxkKUIRvMChUnLc
         WOlC/cGXqx9U9OLZrUdrO9ZhYzkNUxlzsGB+UhpsemHzD4PpqmwD4OgqFpzvk+JzsMr8
         WPwg==
X-Gm-Message-State: AOJu0Yw1L7smFAolbPPL0Bgpd1p0MI0ldWoKug7/xsLa+OPnbdxMY30d
	KxwYAK+T1PIc+g6U4buBzYTb6vL6JTz1HVsDAMlYYnsKcLNJ/6mXbYu6R9jme/Vo0PQ=
X-Gm-Gg: ATEYQzxY5ySPoTF5E7dNu/Gysr2UZCU/6G4wRCwj61XAlfNdFr4A7wVM+qIgjTCE08c
	YQr2APe3t30VfQ06rornso04UnzzECQMXErAmc4n/dDCrau0kxrvfsaBdGrblDKWF91OeOB/Hx+
	1puKBNSNtY0akWp0t7g52/F9BpLfws4FtN+4Umm8SSjX0eK60gSYiIQe1M1A0ytcQQrYr8DTSDR
	HAVMA5OIngAdkivtOaVzXjKHLfjo6Ui5AbrTzoiYf8P7DrCuaXPecCiqPVKvX1od5x/pvAv4Ehb
	qVAIcXOv+mHKYxDEje0r0qIRcM/+Bpx+uH7CysWawbQa09teoj1g+JPXmb+pwZu4+7wn/i26/Ug
	lVxSCzrRrl2TsG+eNMbLCZUmbHwHc7juSbQ1KfrxSoagFUDUjOi1WjU9s0uQ8N73cijbJK+H3w+
	Ji/lCmu7THmkXDDfXSOFzVbxqSPUMsY5rDEnIxwvCWX3uAqJMqaZ4I1jme63JZa9EC5xVfykIWC
	JQZc2zmp8T+Fj9FFYGILw4=
X-Received: by 2002:a05:6a00:4503:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-8274d94caf9mr6631233b3a.21.1772337055416;
        Sat, 28 Feb 2026 19:50:55 -0800 (PST)
Received: from [26.26.26.1] (107.153.212.35.bc.googleusercontent.com. [35.212.153.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d880sm9534477b3a.7.2026.02.28.19.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 19:50:55 -0800 (PST)
Message-ID: <0a506efc-a06d-4523-b149-eb74eb5df067@gmail.com>
Date: Sun, 1 Mar 2026 11:50:51 +0800
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
 baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/2025 11:59 AM, Jinhui Guo wrote:
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
If what I remembered right, using pci_device_is_present() to replace
pci_device_is_disconnected() might not be the correct choice against
link down case, you might misunderstand the function of pci_device_is
_present() when device is there but link is not up. if you want to check
link status, just check link status.

Bjorn, correct me if I am wrong.

Thanks,
Ethan


> 
> Best Regards,
> Jinhui
> 
> ---
> v1: https://lore.kernel.org/all/20251210171431.1589-1-guojinhui.liam@bytedance.com/
> 
> Changelog in v1 -> v2 (suggested by Baolu Lu)
>   - Simplify the pci_device_is_present() check in __context_flush_dev_iotlb().
>   - Add Cc: stable@vger.kernel.org to both patches.
> 
> Jinhui Guo (2):
>    iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
>      scalable mode
>    iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
>      scalable mode
> 
>   drivers/iommu/intel/pasid.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 

