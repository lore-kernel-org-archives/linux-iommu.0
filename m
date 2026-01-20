Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6031A568;
	Tue, 20 Jan 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934829; cv=none; b=H+4TnLrSpFYaGvODnieHC5R5GrMRgUYZpzRbhnevMlb1HHbWu9ytp29HCCMnEPUEBbccegk1xzk6qgH7fwSSceRnvbnvaApe5RUArmWhL+XFm8td8lUBptoghepxpj6TZn7iVbiHxeZYFYXimEjVMNutRO6o7R7sRXnPLg6xGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934829; c=relaxed/simple;
	bh=3jhjAuQGwodWtrq6trhTeLdHhRWLU9tMBsnlpPoSGOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M671Da1Z89CV91UqW0Krb0c9/nwuh5bAQ19PsQxoH1TRAZMLoCohbmDRo8a/onNJFG3kTXkhZ8uLLM2P6JPJFYQ1Y0WH/t97aeYZ57XqVAN+mVEmC4DOqz/trASRkM4Gn3OClqdmEBi5Jt0+gmtSOh40DddzT/VPHoBQ8JVUdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 569641517;
	Tue, 20 Jan 2026 10:46:59 -0800 (PST)
Received: from [10.57.49.114] (unknown [10.57.49.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807533F694;
	Tue, 20 Jan 2026 10:47:04 -0800 (PST)
Message-ID: <2c04d4a7-559a-42d1-bc99-66e60d9f78c4@arm.com>
Date: Tue, 20 Jan 2026 18:47:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 steven.price@arm.com, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com> <yq5atswgjrkp.fsf@kernel.org>
 <0da8b73c-5bec-44c3-9902-221a11142c34@arm.com>
 <20260120151127.GP961572@ziepe.ca>
 <a89e8fcc-29f0-4a6a-85f8-ca8ca41c53ce@arm.com>
 <20260120175454.GA1325733@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260120175454.GA1325733@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 5:54 pm, Jason Gunthorpe wrote:
> On Tue, Jan 20, 2026 at 05:11:27PM +0000, Robin Murphy wrote:
>>> But you could make an argument that a trusted device won't DMA to
>>> shared memory, ie it would SWIOTLB to private memory if that is
>>> required.
>>
>> I don't think we can assume that any arbitrary trusted device is *never*
>> going to want to access shared memory in the Realm IPA space,
> 
> Well, I can say it isn't supported with the DMA API we have today, so
> that's not *never* but at least for the present moment assuming that
> only private addresses are used with DMA would be consistent with the
> overall kernel capability.
> 
> Certainly I think we have use cases for mixing traffic, and someone
> here is looking at what it would take to extend things to actually
> make it possible to reach into arbitrary shared memory with the DMA
> API..
> 
>>   and while it might technically be possible for a private SWIOTLB
>> buffer to handle that, we currently only have infrastructure that
>> assumes the opposite (i.e. that SWIOTLB buffers are shared for
>> bouncing untrusted DMA to/from private memory).
> 
> We also don't support T=1 devices with the current kernel either, and
> the required behavior is exactly what a normal non-CC kernel does
> today. Basically, SWIOTLB should not be allocating or using shared
> memory with a T=1 device at all, and I think that is a important thing
> to have in the code for security.
> 
> Anyhow, I'm just saying either you keep the limit as we have now or if
> the limit is relaxed for T=1 then it would make sense to fixup SWIOTLB
> to do traditional bouncing to avoid high (shared) addresses.

Indeed those are essentially all the same points I was making too - even 
a T=1 device must support the full IPA range today, because if any 
generated DMA address led to trying to use SWIOTLB via the current code 
that would go horrifically wrong in ways likely to leak private data, or 
at best fault at S2 and/or corrupt Realm memory (and at worst, all 3).

>> Thus for now, saying we can only promise to support DMA if the
>> device can access the whole IPA space itself is accurate.
> 
> Right, that is where things are right now, and I don't think we should
> move away from those code limitations unless there are mitigations
> like bouncing..
> 
>>> Otherwise these two limitations will exclude huge numbers of real
>>> devices from working with ARM CCA at all.
>>
>> Pretty sure the dependency on TDISP wins in that regard ;)
> 
> You can use existing T=0 devices without TDISP
> 
> And bolting a TDISP capable PCI IP onto a device with an addressing
> limit probably isn't going to fix the addressing limit. :(
> 
>> However, assuming that Realms and RMMs might eventually come up with their
>> own attestation mechanisms for on-chip non-PCIe devices (and such devices
>> continue to have crippled DMA capabilities)
> 
> The fabric isn't the only issue here, and even "PCIe" appearing
> devices don't necessarily run over real-PCIe and may have limited
> fabrics.
> 
> There are enough important devices out there that have internal
> limitations, like registers and data structures that just cannot store
> the full 64 bit address space. HW folks have a big $$ incentive
> to take shortcuts like this..

Fair enough, guess I shall temper my optimism...

>> then the fact is still that DA requires an SMMU for S2, so at worst
>> there should always be the possibility for an RMM to offer S1 SMMU
>> support to the Realm, we're just not there yet.
> 
> Having a S1 would help a T=1 device, but it doesn't do anything for
> the T=0 devices.

If we have an SMMU we have an SMMU - S1 for T=0 devices is just regular 
VFIO/IOMMUFD in Non-Secure VA/IPA space, for which the VMM doesn't need 
the RMM's help. I've long been taking it for granted that that one's a 
non-issue ;)

The only thing we can't easily handle (and would rather avoid) is S1 
translation for T=0 traffic from T=1 devices, since that would require 
the Realm OS to comprehend the notion of a single device attached to two 
different vSMMUs at once. Rather, to be workable I think we'd need to 
keep the T=0 and T=1 states described as distinct devices - which 
*could* then each be associated with "shared" (VMM-provided) and 
"private" (RMM-provided) vSMMU instances respectively - and leave it as 
the Realm driver's problem if it wants to coordinate enabling and using 
both at the same time, kinda like the link aggregation model.

Thanks,
Robin.

> The other answer is to expect the VMM to limit the IPA size so that
> the IO devices can reach the full address space.
> 
> Jason

