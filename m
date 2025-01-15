Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156C726AF6
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951533; cv=none; b=GAzy5BrQEX04qugquMixmx/qbjPkWgGrX7pmUOd6FPfYeLpM9sDW+5WjEiqXW4lGVlbWHuWhbPAEtrDctgtiukXFFTOiTHH+NznBIUuub56QzUzlCieD00DGM0R+svhh2hbETGLs1WvqUiBYtg7vEAAgZzPGEvyCEopr11/r6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951533; c=relaxed/simple;
	bh=7b5pMKyTzRrl48ohb4rhah7QBafC+3E9JsNto5bnxKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWo41FeVrjnTXUXr7+N2pUkxD5dJ/5KZf17lXZzhK6kF1Efg0bgrwNWAU2G2Jkj2gljz/7mid+oja429I+a3H5j8i8DwdJ389PQID7I6xwDbSlO3LWuDkZoPxHyY40Evp+zq13ffMAtTRKsC9CKH7EFTMD55PYRDgs4SOJbi6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2F7C11FB;
	Wed, 15 Jan 2025 06:32:39 -0800 (PST)
Received: from [10.57.4.211] (unknown [10.57.4.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B91CE3F63F;
	Wed, 15 Jan 2025 06:32:09 -0800 (PST)
Message-ID: <c8a8fdf8-5de2-40ad-9da4-bb7a63ee8ea9@arm.com>
Date: Wed, 15 Jan 2025 14:32:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu-dma: Fix Oops on zero-sized DMA memory allocation
To: hejiean@foxmail.com
Cc: jroedel@suse.de, mhklinux@outlook.com, petr@tesarici.cz,
 pasha.tatashin@soleen.com, nicolinc@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <tencent_999F11E711AD93EA6AB3B8A7B32D1FE9AD0A@qq.com>
 <20250115123923.GN3146852@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250115123923.GN3146852@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[ BTW I apparently never received the original mail and don't see it on 
the list either... ]

On 2025-01-15 12:39 pm, Leon Romanovsky wrote:
> On Wed, Jan 15, 2025 at 08:21:03PM +0800, hejiean@foxmail.com wrote:
>> From: Jiean He <hejiean@foxmail.com>
>>
>> In the `iommu_dma_ops.alloc` and `iommu_dma_ops.alloc_noncontiguous`
>> interfaces, the `size` parameter is user-provided. When `size` is 0,
>> an Oops occurs in `__iommu_dma_alloc_noncontiguous`, which is called
>> by both interfaces.
>>
>> The root cause lies in the fact that `__iommu_dma_alloc_noncontiguous`
>> calls `kvcalloc`, The `count` parameter of `kvcalloc` is controlled by
>> the user-provided `size`, and when `size` is 0, `count` is also 0.
>> `__iommu_dma_alloc_noncontiguous` uses `if (!pages)` to check the
>> return value of `kvcalloc`, but it returns `ZERO_SIZE_PTR` instead of
>> `NULL` while `count==0`. This leads to a kernel Oops when `pages` is
>> dereferenced in subsequent operations,as the following trace:
>>
>> kernel NULL pointer dereference at virtual address 0000000000000010.
>> Call trace:
>> sg_alloc_append_table_from_pages+0x208/0x430

So... what you're saying is that there's a bug in 
sg_alloc_append_table_from_pages() where it can dereference more of 
"pages" than "n_pages" says is valid?

Of course that's not to say that's the *only* issue that this scenario 
could or would run into - indeed many allocation paths in various DMA 
API implementations depend on get_order(size), and the kerneldoc 
explicitly states that get_order(0) is undefined. So if you really think 
it's worth formally accommodating zero-sized DMA API requests, rather 
than leaving them as a nonsensical thing that drivers should obviously 
not do in the first place, then iommu-dma is still not the logically 
appropriate place to do that.

Thanks,
Robin.

>> sg_alloc_table_from_pages_segment+0x3c/0xa0
>> __iommu_dma_alloc_noncontiguous.constprop.0+0x130/0x278
> 
> Who is this user?
> grep sg_alloc_append_table_from_pages shows only 4 users:
> drivers/infiniband/core/umem.c
> drivers/vfio/pci/mlx5/cmd.c
> drivers/vfio/pci/virtio/migrate.c
> lib/scatterlist.c
> 
> First 3 users have constant size and it is not 0.
> The latter is used in wrapper sg_alloc_table_from_pages_segment(), which
> is used by DRM and that layer already was supposed to catch nr_pages == 0.
> 
> Thanks
> 
>>
>> This commit addresses the issue by adding a check for the `size`
>> parameter in `__iommu_dma_alloc_noncontiguous`. If 0 is passed as `size`,
>> a warning is reported and `NULL` is returned. This approach clearly
>> indicates that the user-provided size might be illegal, helping users
>> adjust their programs. In contrast, using `ZERO_OR_NULL_PTR` to check the
>> return value of `kmalloc` (used by `kvcalloc` internally) does not
>> distinguish between insufficient memory and a zero-sized memory request.
>>
>> Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
>>
>> Signed-off-by: Jiean He <hejiean@foxmail.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 2a9fa0c8cc00..3c9c905e7a8f 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -956,6 +956,11 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
>>   	    iommu_deferred_attach(dev, domain))
>>   		return NULL;
>>   
>> +	if (unlikely(size == 0)) {
>> +		dev_err(dev, "DMA alloc Zero-Sized memory is unsupported\n");
>> +		return NULL;
>> +	}
>> +
>>   	min_size = alloc_sizes & -alloc_sizes;
>>   	if (min_size < PAGE_SIZE) {
>>   		min_size = PAGE_SIZE;
>> -- 
>> 2.40.0.windows.1
>>

