Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF3329DB81
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373476; cv=none; b=kZU5sWTokAPOm+Gt5G1XoahXwqWkvMJsKI9qQeTtmnPJq8oCyW8spXQZ56M4NnaUDacWaGvmuxsSxY0Fy+8yXxXY5r1qmS3TA4A2BizHzLqRU4vGzgLEN5rJvo8Rwrk5NJ7kJjtyhJUwknsVGQNuUx5dCy0eEf58OvVqUyPe55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373476; c=relaxed/simple;
	bh=X+DN+3mbXF2eSdl3gYrRAxrQHeBLbRe3zMRKj7ZCiW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jv/EQS8QYlx5qjRae5TTr1JN3/FlGn8/NVmNM+BGkhwaWrTqUd0hlcufV+mBlQf49tTm+G8ykXQFHEiGZU0Sii2sJxougvjQYN5WIiZks43xfWnJtRHXsXynhyVnK9Wqj7bBTxqMMtE7Yh83HMCtLQlReHnsdXOCa0njUMvo6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0550106F;
	Fri, 11 Apr 2025 05:11:13 -0700 (PDT)
Received: from [10.57.71.210] (unknown [10.57.71.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9EC3F694;
	Fri, 11 Apr 2025 05:11:12 -0700 (PDT)
Message-ID: <b62f5ea3-99cd-4e9e-a2a8-cb325308ed34@arm.com>
Date: Fri, 11 Apr 2025 13:10:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: joro@8bytes.org, jgg@nvidia.com, jsnitsel@redhat.com, praan@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250411044706.356395-1-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250411044706.356395-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-11 5:47 am, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> ASPEED VGA card has two built-in devices:
>   0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
>   0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> 
> Its toplogy looks like this:
>   +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
>                               |               +-01.0-[04]--
>                               |               +-02.0-[05]----00.0  NVIDIA Corporation Device
>                               |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
>                               |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
>                               |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>                               \-00.1  PMC-Sierra Inc. Device 4028
> 
> Being a legacy PCI device that does not have RID on the wire, the system
> does not preserve a RID for that PCI bridge (0008:06), so the IORT code
> has to dma alias for iort_pci_iommu_init() via pci_for_each_dma_alias(),
> resulting in both of them getting the same Stream ID.
> 
> On a kernel prior to v6.15-rc1, there has been an overlooked warning:
>    pci 0008:07:00.0: vgaarb: setting as boot VGA device
>    pci 0008:07:00.0: vgaarb: bridge control possible
>    pci 0008:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>    pcieport 0008:06:00.0: Adding to iommu group 14
>    ast 0008:07:00.0: stream 67328 already in tree   <===== WARNING
>    ast 0008:07:00.0: enabling device (0002 -> 0003)
>    ast 0008:07:00.0: Using default configuration
>    ast 0008:07:00.0: AST 2600 detected
>    ast 0008:07:00.0: [drm] Using analog VGA
>    ast 0008:07:00.0: [drm] dram MCLK=396 Mhz type=1 bus_width=16
>    [drm] Initialized ast 0.1.0 for 0008:07:00.0 on minor 0
>    ast 0008:07:00.0: [drm] fb0: astdrmfb frame buffer device
> 
> As such a legacy system might not use DMA at all, an iommu_probe_device()
> failure didn't actually break it, except that warning that does not block
> the system boot flow.
> 
> With v6.15-rc, since the commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing
> into the proper probe path"), the error returned with the warning is moved
> to the IOMMU device probe flow, e.g. call trace with SMMUv3:
>    arm_smmu_probe_device+0x15c/0x4c0
>    __iommu_probe_device+0x150/0x4f8
>    probe_iommu_group+0x44/0x80
>    bus_for_each_dev+0x7c/0x100
>    bus_iommu_probe+0x48/0x1a8
>    iommu_device_register+0xb8/0x178
>    arm_smmu_device_probe+0x1350/0x1db0
> 
> This then fails the entire SMMU driver probe:
>    arm-smmu-v3 arm-smmu-v3.9.auto: found companion CMDQV device: NVDA200C:04
>    arm-smmu-v3 arm-smmu-v3.9.auto: option mask 0x10
>    arm-smmu-v3 arm-smmu-v3.9.auto: ias 48-bit, oas 48-bit (features 0x001e1fbf)
>    arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for cmdq
>    arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for evtq
>    arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for priq
>    arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for vcmdq0
>    arm-smmu-v3 arm-smmu-v3.9.auto: allocated 524288 entries for vcmdq1
>    arm-smmu-v3 arm-smmu-v3.9.auto: msi_domain absent - falling back to wired irqs
>    arm-smmu-v3 arm-smmu-v3.9.auto: no priq irq - PRI will be broken
>    pci 0008:00:00.0: Adding to iommu group 10
>    pci 0008:01:00.0: Adding to iommu group 11
>    pci 0008:01:00.1: Adding to iommu group 12
>    pci 0008:02:00.0: Adding to iommu group 13
>    pci 0008:02:01.0: Adding to iommu group 14
>    pci 0008:02:02.0: Adding to iommu group 15
>    pci 0008:02:03.0: Adding to iommu group 16
>    pci 0008:02:04.0: Adding to iommu group 17
>    pci 0008:02:05.0: Adding to iommu group 18
>    pci 0008:03:00.0: Adding to iommu group 19
>    pci 0008:05:00.0: Adding to iommu group 20
>    pci 0008:06:00.0: Adding to iommu group 21
>    pci 0008:07:00.0: stream 67328 already in tree
>    arm-smmu-v3 arm-smmu-v3.9.auto: Failed to register iommu
>    arm-smmu-v3 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
> 
> Given that a device bundled with a legacy PCI bridge could have duplicated
> Stream IDs, the concept of a stream_id tree with unique node in the SMMUv3
> driver doesn't work any more.
> 
> Change the arm_smmu_streams_cmp_node() to allow the stream table to hold
> multiple nodes with the same Stream ID. Meanwhile, the reverse lookup from
> the Stream ID to a device pointer will have to be broken, i.e. the eventq
> handler will no longer find the device with a Stream ID in such cases.

Heh, I was about to start looking at this one myself once I finished 
making sense of the Juno issue...

This is adding support for StreamID aliasing between devices, and as 
such it is incomplete. It's not OK to just allow devices to arbitrarily 
rewrite each other's STEs, that's the whole reason this uniqueness check 
exists in the first place! Aliases can only be permitted within a group, 
which means arm_smmu_device_group() also has to check and account for 
them in the first place - note that that applies to PCI devices as well, 
because as soon as we allow StreamID aliasing at all then we're 
inherently allowing RID->SID mappings to alias outside the PCI hierarchy 
in ways that pci_device_group() can't know about. It should work out 
basically the same as SMMUv2, just with the streams tree in place of the 
S2CR array.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b4c21aaed126..5ce64dc78e12 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1762,8 +1762,25 @@ static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
>   static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
>   				     const struct rb_node *rhs)
>   {
> -	return arm_smmu_streams_cmp_key(
> -		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
> +	struct arm_smmu_stream *stream_lhs =
> +		rb_entry(lhs, struct arm_smmu_stream, node);
> +	struct arm_smmu_stream *stream_rhs =
> +		rb_entry(rhs, struct arm_smmu_stream, node);
> +
> +	if (stream_lhs->id < stream_rhs->id)
> +		return -1;
> +	if (stream_lhs->id > stream_rhs->id)
> +		return 1;
> +
> +	/*
> +	 * The stream table can have multiple nodes with the same ID if there
> +	 * are DMA aliases.
> +	 */
> +	if (stream_lhs < stream_rhs)
> +		return -1;
> +	if (stream_lhs > stream_rhs)
> +		return 1;
> +	return 0;
>   }
>   
>   static struct arm_smmu_master *
> @@ -1776,6 +1793,16 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>   	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
>   	if (!node)
>   		return NULL;
> +	/*
> +	 * If there are DMA alises then there are multiple devices with the same
> +	 * stream ID and we cannot reliably convert from SID to master.
> +	 */
> +	if (node->rb_left &&
> +	    rb_entry(node->rb_left, struct arm_smmu_stream, node)->id == sid)
> +		return NULL;
> +	if (node->rb_right &&
> +	    rb_entry(node->rb_right, struct arm_smmu_stream, node)->id == sid)
> +		return NULL;

This doesn't really work - the whole mechanism needs to fundamentally 
change to mapping StreamIDs to groups rather than to devices. Then it's 
really up to individual callers what they want to do if the group has 
more than one device.

Thanks,
Robin.

>   	return rb_entry(node, struct arm_smmu_stream, node)->master;
>   }
>   

