Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF537A4AB
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045418; cv=none; b=P4duGxdqOpJzT7WunRGJ7Sj1SUMPQff+wQ0aliqzxE2Ld+lQGnTkTVkvlK1TyTDUhe7lxPkM63ttH6J9GNnyYrHR34QkjeY6bOWv0EHr/Ct5nnkGFOOkLms1dS3slUtzA9cV2TayKyfv2llO8/VV5/B+nyb4SsoT5MpkjtbrivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045418; c=relaxed/simple;
	bh=AC/VkGV/EwGQnbVNV2ojOv9bZOi6Wld/Ma1nCt5NG80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjK1p8zfKp5OzcO/ns+G3AVs5KIlgshjo47pCWDDmmGBxNZhrmK3xW6kTymRMivK+SgLK7dpKRIUjJkVkRgWoFczn8ZGc+PqED76LFIPNkmI1PJqHJbybxqGomff/yHxs5QyCc2rv4v6uPQBZbZVMMJ7Mn5cQ+GjhfciYDMM960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24DC339;
	Mon,  2 Feb 2026 07:16:48 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518813F740;
	Mon,  2 Feb 2026 07:16:53 -0800 (PST)
Message-ID: <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
Date: Mon, 2 Feb 2026 15:16:50 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260202143548.GA19313@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>> when SWIOTLB bounce buffering becomes active during runtime.
>>
>> The issue occurs when SWIOTLB activation changes the device's DMA
>> mapping requirements at runtime,
>>
>> creating a mismatch between
>> iod->dma_vecs allocation and access logic.
>>
>> The problem manifests when:
>> 1. Device initially operates with dma_skip_sync=true
>>     (coherent DMA assumed)
>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>     memory encryption, or IOMMU bounce buffering requirements
>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>     dma_skip_sync=false
>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>     iod->dma_vecs
> 
> I think this patch just papers over the bug.  If dma_need_unmap
> can't be trusted before the dma_map_* call, we've not saved
> the unmap information and the unmap won't work properly.

The dma_need_unmap() kerneldoc says:

"This function must be called after all mappings that might
  need to be unmapped have been performed."

Trying to infer anything from it beforehand is definitely a bug in the 
caller.

> So we'll need to extend the core code to tell if a mapping
> will set dma_skip_sync=false before doing the mapping.

I don't see that being possible - at best we could reasonably infer that 
a fully-coherent system with no sync ops, no SWIOTLB and no DMA_DEBUG 
shouldn't ever set it to true, but as for the other way round, by the 
time you've run through all the SWIOTLB logic to guess whether a 
particular mapping would be bounced or not, you've basically performed 
the mapping anyway. Thus at best, such an API to potentially do a whole 
dry-run mapping before every actual mapping would seem like a pretty 
pointless anti-optimisation.

Thanks,
Robin.
