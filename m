Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD71272A8
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261317; cv=none; b=OJLD5qBDm/adjJ7xKgIruBsLl+zRSr38QkN8Qba/FcRJuoaWjz/O61SpiaxiqUJAKFYFi5pjDKNfcLZZxzf6WMfkt9TdSxp+YoYtN81oBH7D9Ro0Co3waCA/XOr55gs6utNzRV+xhNh0EWgLgFjQgO1UqHlsKNgctUt1UE58lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261317; c=relaxed/simple;
	bh=wAq7VQoIZQxMDiS0TmZ5x9R83JFv4jz3MrrxIGBehzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+58Kgag2rOUXXoiW5BgwhMtsqIyFLyCjqWqyxkxemlze0MDx9ceh3ciGbKVTlwaka5qO0suLl87adW+fjCXdNckqOJ+ipBRYFrKNjFaUrBtvI7vB9U41RPN+E8Qr4w/ytGGZzPJYhN+ShJg6Cg0M54+4swKyjRnqzkrtywchQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB36F106F;
	Thu,  9 May 2024 06:29:00 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973BD3F6A8;
	Thu,  9 May 2024 06:28:34 -0700 (PDT)
Message-ID: <9af152ec-e68f-4f10-833b-400f9fe87bda@arm.com>
Date: Thu, 9 May 2024 14:28:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, isaacmanjarres@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240504105319.75eec54a@meshulam.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240504105319.75eec54a@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/05/2024 9:53 am, Petr Tesařík wrote:
> On Fri,  3 May 2024 18:37:12 +0000
> "T.J. Mercier" <tjmercier@google.com> wrote:
> 
>> As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
>> not cacheline-aligned") sg_dma_mark_swiotlb is called when
>> dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
>> of a scatterlist. It is never set for the direct path, so drivers
>> cannot always rely on sg_dma_is_swiotlb to return correctly after
>> calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
>> direct path like it is in the IOMMU path.
>>
>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>> ---
>>   kernel/dma/direct.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 4d543b1e9d57..52f0dcb25ca2 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -12,7 +12,7 @@
>>   #include <linux/pfn.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/set_memory.h>
>> -#include <linux/slab.h>
>> +#include <linux/swiotlb.h>
>>   #include "direct.h"
>>   
>>   /*
>> @@ -497,6 +497,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   			goto out_unmap;
>>   		}
>>   		sg_dma_len(sg) = sg->length;
>> +		if (is_swiotlb_buffer(dev, dma_to_phys(dev, sg->dma_address)))
>> +			sg_dma_mark_swiotlb(sg);
>>   	}
>>   
>>   	return nents;
> 
> I'm not sure this does the right thing. IIUC when the scatterlist flags
> include SG_DMA_SWIOTLB, iommu_dma_sync_sg_for_*() will call
> iommu_dma_sync_single_for_*(), which in turn translates the DMA address
> to a physical address using iommu_iova_to_phys(). It seems to me that
> this function may not work correctly if there is no IOMMU, but it also
> seems to me that the scatterlist may contain such non-IOMMU addresses.

In principle dma-direct *could* make use of the SG_DMA_SWIOTLB flag for 
an ever-so-slightly cheaper check than is_swiotlb_buffer() in sync_sg 
and unmap_sg, the same way as iommu-dma does. However the benefit would 
be a lot less significant than for iommu-dma, where it's really about 
the overhead of needing to perform iommu_iova_to_phys() translations for 
every segment every time in order to *get* the right thing to check 
is_swiotlb_buffer() on - that's what would be unreasonably prohibitive 
otherwise.

Thanks,
Robin
