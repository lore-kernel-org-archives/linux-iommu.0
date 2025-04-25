Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E37C247DF9
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577755; cv=none; b=FOCtDjEenQtjauoDDINP2AQ3AHXWO003SebPx1G4JtZhW/ldV/LR+sz4GWWl0F9JIrfjQQgqyLer87sVEx0qqrKCRHtp0Ej+cqURSmHn9XD+FiS7W1uB4JSygjGtrBbWJImNyaS44N2UWcGafdP7U6+kwsWLcI0Jnk5R06pkCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577755; c=relaxed/simple;
	bh=EFJpJwh3Ql539hFsTdluqiVeUgPiTCX5hfXM5sxUzfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4mPaFfAkcFRpRGXCXedoGvBgr5TGwgZsIcukTeemabZGY5L5dTi6nDh/aikLMJ5pmbqn09JdRs9HWUSRtcdO4RR5C8PovvSaca5oDsrms9C0Z/3vjEoKMIADKFBwXrjsBb+V+5GROdy8EdvSUfzHU4w+8X3s7x6C2FBPEaGj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B603106F;
	Fri, 25 Apr 2025 03:42:26 -0700 (PDT)
Received: from [10.57.73.197] (unknown [10.57.73.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE90F3F66E;
	Fri, 25 Apr 2025 03:42:29 -0700 (PDT)
Message-ID: <0ec4d1f3-feaf-4c48-9e0d-ac3f872bcccc@arm.com>
Date: Fri, 25 Apr 2025 11:42:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
To: "Li, Hua Qian" <HuaQian.Li@siemens.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Su, Bao Cheng" <baocheng.su@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
 <20250422063719.121636-1-huaqian.li@siemens.com>
 <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
 <dc6f299b18f7870c7bffecca25cee9e436a32c7b.camel@siemens.com>
 <841c417b-c61a-4c3a-a9ed-236634d78331@arm.com>
 <824c8fa6acda7c840f856430b5d898c7fcd4702e.camel@siemens.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <824c8fa6acda7c840f856430b5d898c7fcd4702e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-25 6:32 am, Li, Hua Qian wrote:
> On Thu, 2025-04-24 at 13:58 +0100, Robin Murphy wrote:
>> On 24/04/2025 6:12 am, Li, Hua Qian wrote:
>>> On Tue, 2025-04-22 at 15:36 +0200, Marek Szyprowski wrote:
>>>> On 22.04.2025 08:37, huaqian.li@siemens.com wrote:
>>>>> From: Li Hua Qian <huaqian.li@siemens.com>
>>>>>
>>>>> This patchset introduces a change to make the IO_TLB_SEGSIZE
>>>>> parameter
>>>>> configurable via a new kernel configuration option
>>>>> (CONFIG_SWIOTLB_SEGSIZE).
>>>>>
>>>>> In certain applications, the default value of IO_TLB_SEGSIZE
>>>>> (128)
>>>>> may
>>>>> not be sufficient for memory allocation, leading to runtime
>>>>> errors.
>>>>> By
>>>>> making this parameter configurable, users can adjust the
>>>>> segment
>>>>> size to
>>>>> better suit their specific use cases, improving flexibility and
>>>>> system
>>>>> stability.
>>>>
>>>> Could You elaborate a bit more what are those certain
>>>> applications
>>>> that
>>>> require increasing IO_TLB_SEGSIZE? I'm not against it, but such
>>>> change
>>>> should be well justified and described, while the above cover-
>>>> letter
>>>> doesn't provide anything more than is written in the patch
>>>> description.
>>> Thank you for your feedback, Marek.
>>>
>>> To provide more context, one specific application that requires
>>> increasing IO_TLB_SEGSIZE is the Hailo 8 PCIe AI card. This card
>>> uses
>>> dma_alloc_coherent to allocate descriptor lists, as seen in the
>>> Hailo
>>> driver implementation here:
>>> https://github.com/hailo-ai/hailort-drivers/blob/7161f9ee5918029bd4497f590003c2f87ec32507/linux/vdma/memory.c#L322
>>> The maximum size (nslots) for these allocations can reach 160,
>>> which
>>> exceeds the current default value of IO_TLB_SEGSIZE (128).
>>>
>>> Since IO_TLB_SEGSIZE is defined as a constant in the kernel:
>>>
>>> `#define IO_TLB_SEGSIZE 128`
>>>
>>>
>>> this limitation causes swiotlb_search_pool_area,
>>> https://github.com/torvalds/linux/blame/v6.15-rc2/kernel/dma/swiotlb.c#L1085
>>> ,
>>> (or swiotlb_do_find_slots in older kernels) to fail when attempting
>>> to
>>> allocate contiguous physical memory (CMA). This results in runtime
>>> errors and prevents the Hailo 8 card from functioning correctly in
>>> certain configurations.
>>
>> Hmm, dma_alloc_coherent() should really not be trying to allocate
>> from
>> SWIOTLB in the first place - how is that happening?
>>
>> If you're using restricted DMA for a device which wants significant
>> coherent allocations, then it wants to have it's own shared-dma-pool
>> for
>> those *as well* as the restricted-dma-pool for bouncing streaming
>> DMA.
>>
>> Thanks,
>> Robin.
> 
> Hi Robin,
> 
> Regarding the specific Hailo Card case, the issue arises due
> to the capabilities of certain SoCs or CPUs. For example, many
> K3 SoCs lack an IOMMU, which is typically used to isolate the
> system against DMA-based attacks of external PCI devices.
> 
> Taking the TI AM65 as an example, it doesn't have an IOMMU, but
> instead includes a Peripheral Virtualization Unit (PVU). The
> PVU provides functionality similar to an IOMMU and is used to
> isolate PCI devices from the Linux host, and the SWIOTLB is
> used to manp all DMA buffers from a static memory carve-out.

And as I said, if you want to support general coherent allocations then 
you should use part of that carveout for a regular coherent DMA pool. 
The restricted pool is only intended for streaming DMA - swiotlb_alloc() 
is only meant as a convenience fallback for the kind of devices which 
mostly do streaming DMA but make one or two small coherent allocations 
from a suitable context. It does not work for *all* valid usage of 
dma_alloc_attrs(), and if you want to do this for arbitrary PCI devices 
then you almost certainly *do* need to be able to support drivers which 
make allocations in atomic context.

Thanks,
Robin.

> You can find more details and background information here:
> https://lore.kernel.org/all/20250422061406.112539-1-huaqian.li@siemens.com/
> 
>>
>>> By making IO_TLB_SEGSIZE configurable via a kernel configuration
>>> option
>>> (CONFIG_SWIOTLB_SEGSIZE), users can adjust the segment size to
>>> accommodate such use cases. This change improves flexibility and
>>> ensures that systems can be tailored to meet the requirements of
>>> specific hardware, such as the Hailo 8 PCIe AI card, without
>>> requiring
>>> kernel source modifications.
>>>
>>> I hope this example clarifies the need for this change. Please let
>>> me
>>> know if further details or additional examples are required.
>>>
>>> Best Regards,
>>> Li Hua Qian
>>>>
>>>>
>>>>> Li Hua Qian (1):
>>>>>      swiotlb: Make IO_TLB_SEGSIZE configurable
>>>>>
>>>>>     include/linux/swiotlb.h | 2 +-
>>>>>     kernel/dma/Kconfig      | 7 +++++++
>>>>>     2 files changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>> Best regards
>>>
> 
> --
> Hua Qian Li
> Siemens AG
> http://www.siemens.com/

