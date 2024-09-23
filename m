Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD128479
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085040; cv=none; b=f/lnq2kI6NEi13N2eXG9/UqIx22zdx6p2iJKy9VfkWSSggMGf3iwMU9tcip8js5xNGbMGNHXVBooPIiKCGi5MERThgF6Fcb/jiDW79D32biNWh3ngR4zX4b6yX3MB8ngtuZYTEMGTsMnQu8C9drETwJNIccQEvu3lczszMXtsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085040; c=relaxed/simple;
	bh=l2cXnP8hD5gDksFidpEdhhevxeP0zUgeRW27wG9NI2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTqxuGLNxSTUQp7RjtKPhreWNb1YUEl8qnTQ4tgIqm7DOSj7j5exWhmhlsyY2izhHNVRMeChn0S4hB2zvm355Wi3htsX+2KJ/jenP9khsV4PtYyWfBinmWgkCB6aPQYNIjNFVPjSbCQTg7EDQNMt+S9joqUGEmrfDkn4ITyu7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B2CFEC;
	Mon, 23 Sep 2024 02:51:07 -0700 (PDT)
Received: from [10.57.79.116] (unknown [10.57.79.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26A503F71A;
	Mon, 23 Sep 2024 02:50:36 -0700 (PDT)
Message-ID: <4f37251f-b1a5-42e6-9680-beb0606659fc@arm.com>
Date: Mon, 23 Sep 2024 10:50:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-mapping: report unlimited DMA addressing in IOMMU
 DMA path
To: Gerd Bayer <gbayer@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>,
 Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Xi Ruoyao <xry111@xry111.site>
References: <c2671009f217bfc3c9f7fbda2eefb0c44768fc3b.1727028402.git.leon@kernel.org>
 <31152f4714c644584db1e7e2506d0b434dff3fbc.camel@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <31152f4714c644584db1e7e2506d0b434dff3fbc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-23 10:34 am, Gerd Bayer wrote:
> On Sun, 2024-09-22 at 21:09 +0300, Leon Romanovsky wrote:
>> While using the IOMMU DMA path, the dma_addressing_limited() function
>> checks ops struct which doesn't exist in the IOMMU case. This causes
>> to the kernel panic while loading ADMGPU driver.
>>
>> BUG: kernel NULL pointer dereference, address: 00000000000000a0
>> PGD 0 P4D 0
>> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 10 UID: 0 PID: 611 Comm: (udev-worker) Tainted: G
>> T  6.11.0-clang-07154-g726e2d0cf2bb #257
>> Tainted: [T]=RANDSTRUCT
>> Hardware name: ASUS System Product Name/ROG STRIX Z690-G GAMING WIFI,
>> BIOS 3701 07/03/2024
>> RIP: 0010:dma_addressing_limited+0x53/0xa0
>> Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f
>> 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c>
>> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
>> RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
>> RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
>> RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
>> R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
>> FS:  00007fe6ba881900(0000) GS:ffff894fdf700000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
>> PKRU: 55555554
>> Call Trace:
>>   <TASK>
>>   ? __die_body+0x65/0xc0
>>   ? page_fault_oops+0x3b9/0x450
>>   ? _prb_read_valid+0x212/0x390
>>   ? do_user_addr_fault+0x608/0x680
>>   ? exc_page_fault+0x4e/0xa0
>>   ? asm_exc_page_fault+0x26/0x30
>>   ? dma_addressing_limited+0x53/0xa0
>>   amdgpu_ttm_init+0x56/0x4b0 [amdgpu]
>>   gmc_v8_0_sw_init+0x561/0x670 [amdgpu]
>>   amdgpu_device_ip_init+0xf5/0x570 [amdgpu]
>>   amdgpu_device_init+0x1a57/0x1ea0 [amdgpu]
>>   ? _raw_spin_unlock_irqrestore+0x1a/0x40
>>   ? pci_conf1_read+0xc0/0xe0
>>   ? pci_bus_read_config_word+0x52/0xa0
>>   amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
>>   amdgpu_pci_probe+0x1b7/0x4c0 [amdgpu]
>>   pci_device_probe+0x1c5/0x260
>>   really_probe+0x130/0x470
>>   __driver_probe_device+0x77/0x150
>>   driver_probe_device+0x19/0x120
>>   __driver_attach+0xb1/0x1e0
>>   ? __cfi___driver_attach+0x10/0x10
>>   bus_for_each_dev+0x115/0x170
>>   bus_add_driver+0x192/0x2d0
>>   driver_register+0x5c/0xf0
>>   ? __cfi_init_module+0x10/0x10 [amdgpu]
>>   do_one_initcall+0x128/0x380
>>   ? idr_alloc_cyclic+0x139/0x1d0
>>   ? security_kernfs_init_security+0x42/0x140
>>   ? __kernfs_new_node+0x1be/0x250
>>   ? sysvec_apic_timer_interrupt+0xb6/0xc0
>>   ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>>   ? _raw_spin_unlock+0x11/0x30
>>   ? free_unref_page+0x283/0x650
>>   ? kfree+0x274/0x3a0
>>   ? kfree+0x274/0x3a0
>>   ? kfree+0x274/0x3a0
>>   ? load_module+0xf2e/0x1130
>>   ? __kmalloc_cache_noprof+0x12a/0x2e0
>>   do_init_module+0x7d/0x240
>>   __se_sys_init_module+0x19e/0x220
>>   do_syscall_64+0x8a/0x150
>>   ? __irq_exit_rcu+0x5e/0x100
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> RIP: 0033:0x7fe6bb5980ee
>> Code: 48 8b 0d 3d ed 12 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
>> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48>
>> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0a ed 12 00 f7 d8 64 89 01 48
>> RSP: 002b:00007ffd462219d8 EFLAGS: 00000206 ORIG_RAX:
>> 00000000000000af
>> RAX: ffffffffffffffda RBX: 0000556caf0d0670 RCX: 00007fe6bb5980ee
>> RDX: 0000556caf0d3080 RSI: 0000000002893458 RDI: 00007fe6b3400010
>> RBP: 0000000000020000 R08: 0000000000020010 R09: 0000000000000080
>> R10: c26073c166186e00 R11: 0000000000000206 R12: 0000556caf0d3430
>> R13: 0000556caf0d0670 R14: 0000556caf0d3080 R15: 0000556caf0ce700
>>   </TASK>
>> Modules linked in: amdgpu(+) i915(+) drm_suballoc_helper intel_gtt
>> drm_exec drm_buddy iTCO_wdt i2c_algo_bit intel_pmc_bxt
>> drm_display_helper iTCO_vendor_support gpu_sched drm_ttm_helper cec
>> ttm amdxcp video backlight pinctrl_alderlake nct6775 hwmon_vid
>> nct6775_core coretemp
>> CR2: 00000000000000a0
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:dma_addressing_limited+0x53/0xa0
>> Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f
>> 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c>
>> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
>> RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
>> RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
>> RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
>> R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
>> FS:  00007fe6ba881900(0000) GS:ffff894fdf700000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
>> PKRU: 55555554
>>
>> Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219292
>> Signed-off-by: Leon Romanovsky <leon@kernel.org>
>> ---
>> Changelog:
>> v2: Added missed bracket.
>> ---
>>   kernel/dma/mapping.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index b839683da0ba..bcb7a4aa8fa4 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -569,6 +569,10 @@ u64 dma_get_required_mask(struct device *dev)
>>   
>>   	if (dma_alloc_direct(dev, ops))
>>   		return dma_direct_get_required_mask(dev);
>> +
>> +	if (use_dma_iommu(dev))
>> +		return DMA_BIT_MASK(32);
>> +
>>   	if (ops->get_required_mask)
>>   		return ops->get_required_mask(dev);
>>   
>> @@ -926,7 +930,7 @@ bool dma_addressing_limited(struct device *dev)
>>   			 dma_get_required_mask(dev))
>>   		return true;
>>   
>> -	if (unlikely(ops))
>> +	if (unlikely(ops) || use_dma_iommu(dev))
>>   		return false;
>>   	return !dma_direct_all_ram_mapped(dev);
>>   }
> 
> Hi,
> 
> sorry for being nosy on this one - and I have to applogize for not
> following the original discussion.
> 
> I'm just wondering, if it would not suffice to move the presence check
> for "ops" before the call to dma_get_required_mask() and make an early
> return in dma_addressing_limited()?

No, because then it may give the wrong answer for ops which do implement 
dma_get_required_mask to express a limitation.

Thanks,
Robin.

> Like this:
> 
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b1c18058d55f..e825b0a6db9e 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -848,12 +848,13 @@ bool dma_addressing_limited(struct device *dev)
>   {
>          const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> +       if (unlikely(ops))
> +               return false;
> +
>          if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
>                           dma_get_required_mask(dev))
>                  return true;
>   
> -       if (unlikely(ops))
> -               return false;
>          return !dma_direct_all_ram_mapped(dev);
>   }
>   EXPORT_SYMBOL_GPL(dma_addressing_limited);
> 
> 
> Thanks,
> Gerd
> 
