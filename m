Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CA394492
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126619; cv=none; b=Ymk1FHi5C8iTW7RpIb9KL4Ijz3yOoAcxA6jciIgIPYLxQTn9AcAe1S18wzpaSoFKk9Ryi4REaL2+gs+17mXk2k2vD2M0sOEfgArF5pEDsHMI52xPjT02kr8FZZ2hXVPcVlfRUogLlrAPyDq7NGbwXduUqTb6Dl0Fta9fMaNfrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126619; c=relaxed/simple;
	bh=Xkt1y50fW8Ao12m72LJhND2tiKseNYuuHguQcakvv8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPUIhFe8/P61B4kUWupzIP2TQXYvg3Y0jOe+2OkSA0BYYwwlX7BMtVkAl0otc1s7FdpSmxJZSL8/Gfkw2yd1Na20LxSGvM0ds/BynhqPyqbYM51/B7leYuQ+A0rgsZwAwRVXd01w6/mAXB+jt/4WK6ToDyHi6EuOBRA4aCIOnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33860339;
	Tue,  3 Feb 2026 05:50:10 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1E63F632;
	Tue,  3 Feb 2026 05:50:14 -0800 (PST)
Message-ID: <4e375e54-e141-473c-ae71-fc013268d057@arm.com>
Date: Tue, 3 Feb 2026 13:50:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203094247.GP34749@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260203094247.GP34749@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-03 9:42 am, Leon Romanovsky wrote:
> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>> On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 2a52cf46d960..f944b747e1bd 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
>>>   		nvme_free_descriptors(req);
>>>   }
>>>   
>>> +static bool nvme_pci_alloc_dma_vecs(struct request *req,
>>> +		struct blk_dma_iter *iter)
>>> +{
>>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>>> +
>>> +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>>> +			GFP_ATOMIC);
>>> +	if (!iod->dma_vecs)
>>> +		return false;
>>> +	iod->dma_vecs[0].addr = iter->addr;
>>> +	iod->dma_vecs[0].len = iter->len;
>>> +	iod->nr_dma_vecs = 1;
>>> +	return true;
>>> +}
>>> +
>>>   static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>>   		struct blk_dma_iter *iter)
>>>   {
>>> @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>>   	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>>>   		return false;
>>>   	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>>> +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
>>> +			return false;
>>
>> In the case where this iteration caused dma_need_unmap() to toggle to
>> true, this is the iteration that allocates the dma_vecs, and it
>> initializes the first entry to this iter. But the next lines proceed to
>> the save this iter in the next index, so it's doubly accounted for and
>> will get unmapped twice in the completion.
>>
>> Also, if the allocation fails, we should set iter->status to
>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>> Otherwise, the caller will think the request is badly formed if you
>> return false from here without setting iter->status.
>>
>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>> tried to test the changing dma_need_unmap() scenario.
>> ---
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 9fc4a60280a07..233378faab9bd 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
>>   		nvme_free_descriptors(req);
>>   }
>>   
>> +static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
>> +				      struct request *req)
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +	if (!iod->dma_vecs) {
>> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>> +
>> +		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
>> +				GFP_ATOMIC);
>> +		if (!iod->dma_vecs) {
>> +			iter->status = BLK_STS_RESOURCE;
>> +			return false;
>> +		}
>> +	}
>> +
>> +	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>> +	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>> +	iod->nr_dma_vecs++;
>> +	return true;
>> +}
>> +
>>   static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>   		struct blk_dma_iter *iter)
>>   {
>> @@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>>   		return true;
>>   	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>>   		return false;
>> -	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
>> -		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
>> -		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
>> -		iod->nr_dma_vecs++;
>> -	}
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
> 
> Can dev->dma_skip_sync be modified in parallel with this check?
> If so, dma_need_unmap() may return different results depending on the
> time at which it is invoked.

It can if another thread is making mappings in parallel, however as 
things currently stand that would only lead to the current thread 
thinking it must save the unmap state for the mappings it's already made 
even if it technically didn't need to.

In principle it could also change back the other way if another thread 
reset the device's DMA mask, but doing that with active mappings would 
fundamentally break things in regard to the dma_skip_sync mechanism anyway.

Thanks,
Robin.

> 
>> +		return nvme_pci_prp_save_mapping(iter, req);
> 
> Thanks

