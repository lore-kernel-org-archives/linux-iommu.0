Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DCD200C2
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728538; cv=none; b=YtwgTh5k2l0ezhowGF5ABeIyYxIYbN0KPANxhETxQG0KZvLHrm1jw0QrGhM+DRwx3qY9yqNqKxdMur+k5OLXSSh/KjwDXANAubVcYczSovnZPDF4ZiVv0AK1ejERJzNbpKecp9Es+HBrOLWYDLTplf1wZzVUGxbRia5cgcqAeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728538; c=relaxed/simple;
	bh=QhqHT75S4UlfvkWScu619H8AY/C3C61gu2dk9d7U6X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k32hNLgTvdj1706HTF0uanTOeU58hGshIXU2yNbbkKWCEPQ4qwHWrQKvSavWtg7oK0TVgRTXABbyQ3xVqfO/o3aXwV1m0KYMA0miREOF0tAYt3qMwjOp1iaEyzEUXvk5ScVB2DLQElPVNAT3ax0JU/f4ijbWDxLml8bO+FOIMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01059497;
	Tue,  6 Jan 2026 11:42:09 -0800 (PST)
Received: from [10.57.46.241] (unknown [10.57.46.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 259E33F5A1;
	Tue,  6 Jan 2026 11:42:13 -0800 (PST)
Message-ID: <73c533b9-1315-409f-baad-ef9a46ab6bf0@arm.com>
Date: Tue, 6 Jan 2026 19:42:10 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 8/8] dma-iommu: Support DMA sync batch mode for
 iommu_dma_sync_sg_for_{cpu, device}
To: Barry Song <21cnbao@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, will@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Joerg Roedel <joro@8bytes.org>, Tangquan Zheng <zhengtangquan@oppo.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-9-21cnbao@gmail.com> <20251227201642.GQ11869@unreal>
 <CAGsJ_4xssfB7hNOWLDianQfx+9wC2e4qZKtRBUzEZ-v97Sa63Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGsJ_4xssfB7hNOWLDianQfx+9wC2e4qZKtRBUzEZ-v97Sa63Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-12-27 8:59 pm, Barry Song wrote:
> On Sun, Dec 28, 2025 at 9:16 AM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Sat, Dec 27, 2025 at 11:52:48AM +1300, Barry Song wrote:
>>> From: Barry Song <baohua@kernel.org>
>>>
>>> Apply batched DMA synchronization to iommu_dma_sync_sg_for_cpu() and
>>> iommu_dma_sync_sg_for_device(). For all buffers in an SG list, only
>>> a single flush operation is needed.
>>>
>>> I do not have the hardware to test this, so the patch is marked as
>>> RFC. I would greatly appreciate any testing feedback.
>>>
>>> Cc: Leon Romanovsky <leon@kernel.org>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
>>> Signed-off-by: Barry Song <baohua@kernel.org>
>>> ---
>>>   drivers/iommu/dma-iommu.c | 15 +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index ffa940bdbbaf..b68dbfcb7846 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1131,10 +1131,9 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
>>>                        iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>>>                                                      sg->length, dir);
>>>        } else if (!dev_is_dma_coherent(dev)) {
>>> -             for_each_sg(sgl, sg, nelems, i) {
>>> +             for_each_sg(sgl, sg, nelems, i)
>>>                        arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>>> -                     arch_sync_dma_flush();
>>> -             }
>>> +             arch_sync_dma_flush();
>>
>> This and previous patches should be squashed into the one which
>> introduced arch_sync_dma_flush().
> 
> Hi Leon,
> 
> The series is structured to first introduce no functional change by
> replacing all arch_sync_dma_for_* calls with arch_sync_dma_for_* plus
> arch_sync_dma_flush(). Subsequent patches then add batching for
> different scenarios as separate changes.
> 
> Another issue is that I was unable to find a board that both runs
> mainline and exercises the IOMMU paths affected by these changes.
> As a result, patches 7 and 8 are marked as RFC, while the other
> patches have been tested on a real board running mainline + changes.

FWIW if you can get your hands on an M.2 NVMe for the Rock5 then that 
has an SMMU in front of PCIe (and could also work to test non-coherent 
SWIOTLB, with the SMMU in bypass and either some fake restrictive 
dma-ranges in the DT or a hack to reduce the DMA mask in the NVMe driver.)

Cheers,
Robin.
