Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D019258B
	for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542510; cv=none; b=PSNXoJ0wy6E0UoV07LvxIPNJy/KdohhGkqtelyzH/90aoonKETH4Y6wrJmRQOQkGbe5PuowJFxtaapPks6mJngO27X4nGMtgQCu5mOv49ycM1QwfpGhJuCaR7lV9uZSOtcRmF81oqejqqqDfi32DIaGah2ECpkVUqhl+JbeJx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542510; c=relaxed/simple;
	bh=ZC52Rk/0Oueg4ywouABP+xhVd67yiKZZu5s5/4GdOIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjueImwka9TSHDgLxveRyctBLI546+M/3poHnNw6IRfnHlvxpXitHUYrMGHVc2ocj4gerSu/67S9ipdo/Vs5gkGj7ahS4W/dW1w1c+tHMxTcCBr/+Jk8tsNnZNx5I8F4NbOOo/V4wJ6VZtzqyVg1AZbUF6qzWDCYZ/vR7ToxBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4221692;
	Mon, 25 Nov 2024 05:48:52 -0800 (PST)
Received: from [10.57.93.75] (unknown [10.57.93.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F288D3F58B;
	Mon, 25 Nov 2024 05:48:19 -0800 (PST)
Message-ID: <22a79aa8-0327-4711-aa2a-616d28a7793a@arm.com>
Date: Mon, 25 Nov 2024 13:48:10 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] swiotlb: Mitigate potential DoS caused by BUG_ON()
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Raphael Isemann <teemperor@gmail.com>,
 Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
 <CAOZ5it0Yj8taexnFJiAqJhPP_8z5Dv_OjonyGXMbA3Tiu=9ugQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAOZ5it0Yj8taexnFJiAqJhPP_8z5Dv_OjonyGXMbA3Tiu=9ugQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-22 8:33 pm, Brian Johannesmeyer wrote:
> On Fri, Nov 22, 2024 at 12:13 PM Brian Johannesmeyer
> <bjohannesmeyer@gmail.com> wrote:
>>
>> We identified a security issue in the swiotlb unmapping operation, stemming
>> from the way some drivers save streaming DMA addresses. This issue can
>> potentially be exploited by a malicious peripheral device to cause a
>> denial-of-service (DoS) via a kernel panic.
>>
>> **Disclosure Context**
>> We previously reported a similar issue to the Linux kernel security team.
>> However, they advised submitting such cases directly to the relevant
>> subsystem maintainers and the hardening mailing list, because Linux
>> implicitly assumes hardware can be trusted.
>>
>> **Threat Model**
>> While Linux drivers typically trust their hardware, there may be specific
>> drivers that do not operate under this assumption. Hence, we consider a
>> malicious peripheral device that corrupts DMA data to exploit the kernel.
>> In this scenario, the device manipulates driver-initialized data (similar
>> to the attack described in the Thunderclap paper [0]) to achieve a DoS.
>>
>> **Background**
>> Streaming DMA is often used as follows:
>> (1) A driver maps a buffer to DMA using dma_map_single(), which returns a
>> DMA address. This address is then saved by the driver for later use.
>> (2) When the buffer is no longer needed, the driver unmaps it using
>> dma_unmap_single(), passing the previously saved DMA address.
>> (3) Under certain conditions---such as the driver using direct mapping
>> operations, and the mapped buffer requiring a swiotlb
>> buffer---dma_unmap_single() calls swiotlb_release_slots(). Here, the saved
>> DMA address is passed as its tlb_addr argument.

This is hardly a SWIOTLB problem. If a driver allows its device to 
corrupt what is effectively driver-internal data, then the device can 
still easily crash a non-coherent system without SWIOTLB, by writing a 
DMA address for which phys_to_virt() returns a bogus unmapped VA which 
causes a cache maintenance instruction to fault. Or potentially do far 
worse by redirecting a DMA_FROM_DEVICE cache invalidation to some other 
valid VA to destroy some recently-written data.

Even with an IOMMU, whilst it should be relatively contained, it would 
still be able to mess with the IOMMU pagetables by causing unmapping of 
wrong IOVAs, and spam up the kernel log with warnings and driver errors 
(more than it already could) as the iommu-dma state gets progressively 
more out-of-sync with itself over repeated shenanigans.

I also have no issue with changing a BUG_ON() to a WARN() where the 
former is gratuitously unnecessary anyway - a common precedent in the 
SWIOTLB code, it seems - but let's not pretend we're meaningfully 
mitigating anything here. If a driver has made this naive assumption 
about DMA addresses, who knows how many other ways it could also be 
confused by a malicious device writing unexepected values to descriptor 
fields?

Thanks,
Robin.

>> **Vulnerability**
>> It is common for drivers to store the DMA address returned by
>> dma_map_single() into a coherent DMA region, which can be manipulated by a
>> malicious device. For example, the E100 driver and RealTek 8139C+ driver
>> map socket buffers into streaming DMA and save their DMA addresses to
>> coherent DMA data. While these drivers might assume trusted hardware, this
>> behavior is not necessarily unique to them.
>>
>> If an untrusted device corrupts the DMA address, it can influence the
>> tlb_addr argument passed to swiotlb_release_slots(). Inside this function,
>> tlb_addr is used to calculate aindex, which is validated via BUG_ON(aindex
>>> = mem->nareas). By manipulating the DMA address, an attacker can trigger
>> this assertion, resulting in a kernel panic and DoS.
>>
>> I have a PDF document that illustrates how these steps work. Please let me
>> know if you would like me to share it with you.
>>
>> **Proposed mitigation**
>> To address this issue, two potential approaches are possible:
>>
>> (1) Mitigating the *initialization* of attacker data: Prevent drivers from
>> saving critical data, such as DMA addresses, in attacker-controllable
>> regions.
>> (2) Mitigating the *use* of attacker data: Modify the handling of critical
>> data, such as in the BUG_ON() statement, to not result in catastrophic
>> outcomes like kernel panics.
>>
>> While approach (1) is more complete, it is more challenging to deploy
>> universally. Hence, we propose mitigating this issue with approach (2):
>> i.e., replacing the BUG_ON() assertion with more graceful error handling.
>> The attached patch implements this change, ensuring the kernel can handle
>> the condition safely without triggering a panic.
>>
>> **Request for Feedback**
>> I am not deeply familiar with the swiotlb internals, so I would appreciate
>> any feedback on the patch. In particular, is there a more graceful way to
>> handle the error than returning?
>>
>> Thanks,
>>
>> Brian Johannesmeyer
>>
>> [0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf
>>
>> Brian Johannesmeyer (1):
>>    swiotlb: Replace BUG_ON() with graceful error handling
>>
>>   kernel/dma/swiotlb.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> --
>> 2.34.1
>>
> 
> Whoops -- didn't send to the hardening mailing list. Adding it now.
> 
> -Brian

