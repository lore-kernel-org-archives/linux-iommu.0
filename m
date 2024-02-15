Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC59219E2
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998500; cv=none; b=UgEyZaUEIWmMdtqU60NxnamOz54RW6uS4KW1El7WAJbjesMwgDsQr02bXGbNASHR+/TOawBbsEeZgOcjnlaieNEL8jlmO+SMJ+a7xCB1Ujzdz1cUrZck8RD1E2HJWEUlyZp3LRmxB9TrlpRjCvB32jyddrpvfl9xiJwkcybp1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998500; c=relaxed/simple;
	bh=yeRfrgFGI1JNXuBvjNlNp7FlKvvlRC/kM8jgLEuiinY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faVD4QDTVN1r3HonVF5UAzZXQ+Tt8iW6j5jMbPjReQr1PP8lYWoOJS5mrUkLHsKrkB8NCUGWjs/+mRAZZAlq6J/aqA6QRDhIHUislQ59kEFv6BYHmvqAcH0NtlQXgHPMKtxEP78YryDW0Qh1p+w+JqjBHy8gKxl0AOprE/W+7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B836F1FB;
	Thu, 15 Feb 2024 04:02:18 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559813F766;
	Thu, 15 Feb 2024 04:01:36 -0800 (PST)
Message-ID: <7f14727d-3ca6-45ec-9251-f166f74a8f7c@arm.com>
Date: Thu, 15 Feb 2024 12:01:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
 joro@8bytes.org, jgg@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, murphyt7@tcd.ie,
 baolu.lu@linux.intel.com
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp> <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
 <Zc1qpr4zCy1N0OND@kbusch-mbp> <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Zc2XHbcXZzV2a61n@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 4:46 am, Nicolin Chen wrote:
> On Wed, Feb 14, 2024 at 06:36:38PM -0700, Keith Busch wrote:
>> On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
>>> On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
>>>> On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
>>>>> @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>>>>>                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
>>>>>        else
>>>>>                dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>>>> -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
>>>>> +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
>>>>>        dma_set_max_seg_size(&pdev->dev, 0xffffffff);
>>>>
>>>> I recall we had to do this for POWER because they have 64k pages, but
>>>> page aligned addresses IOMMU map to 4k, so we needed to allow the lower
>>>> dma alignment to efficiently use it.
>>>
>>> Thanks for the input!
>>>
>>> In that case, we might have to rely on iovad->granule from the
>>> attached iommu_domain:
>>
>> I explored a bit more, and there is some PPC weirdness that lead to
>> NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
>> path. It looks like swiotlb is the only user for this, so your original
>> patch may be just fine.
> 
> Oh, that'll be great if we confirmed. And I think I forgot to add
> CC line to the stable trees: the two patches should be applicable
> cleanly to older kernels too. Let's wait for some day, so people
> can give some tests and reviews. Then I will respin a v2 with the
> CC line.

Hmm, as far as I understand, NVME_CTRL_PAGE_SIZE represents the 
alignment that NVMe actually cares about, so if specifying that per the 
intended purpose of the API doesn't work then it implies the DMA layer 
is still not doing its job properly, thus I'd rather keep digging and 
try to fix that properly.

FWIW I have a strong suspicion that iommu-dma may not be correctly doing 
what it thinks it's trying to do, so I would definitely think it 
worthwhile to give that a really close inspection in light of Will's 
SWIOTLB fixes.

Thanks,
Robin.
