Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99128725F
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798297; cv=none; b=DEf+T9rhb9jx3XiZJRTJRejKE2GNnDVRZQKUAOVafkNh44EZTdKGpcyjwV2JP7OvFxVgRqFdunjcAoFJ7NxDb+yQ9u4Cw19qR9UdE25fZqKF06HJDFWOJkzbUEiyQ4YfGtxMohspI2b6J7RdfZSnVLGCpEBwo5beUMffguNr/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798297; c=relaxed/simple;
	bh=i2V/Oj7CsLrfmO1ZK174ElOiEO6iDH6d9PRLEXx4i4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE92cBDTSm9VtpcLiZr2K5WQZoO03shbvs2v/Zo2TfbT0/EIqj07kgdMF3uNgUM6dq3fPRcef9W5x3qUpUmyope93VJAPHKQrbDT12xd1gggsJxSxl3eafDqqWWT2qGZ/RB5q4WMPc0WCR8ZzS8J71hFtLxRAq9XcFeRU3lroQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 777B3497;
	Mon, 15 Dec 2025 03:31:27 -0800 (PST)
Received: from [10.57.44.191] (unknown [10.57.44.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B950C3F73B;
	Mon, 15 Dec 2025 03:31:33 -0800 (PST)
Message-ID: <1d552f40-74b3-4c6d-874d-508ecb0e75d2@arm.com>
Date: Mon, 15 Dec 2025 11:31:32 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for
 offsets
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Christoph Hellwig <hch@infradead.org>,
 Andrei-Edward Popa <andrei.popa105@yahoo.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251212200914.138310-1-andrei.popa105.ref@yahoo.com>
 <20251212200914.138310-1-andrei.popa105@yahoo.com>
 <CGME20251215055807eucas1p2c04cd0536dd2d100547c90f3a99df8b8@eucas1p2.samsung.com>
 <aT-jZyXGTVz-ziff@infradead.org>
 <c71603c6-fa05-4cd6-836a-4bbf55ba5ca9@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c71603c6-fa05-4cd6-836a-4bbf55ba5ca9@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-12-15 8:13 am, Marek Szyprowski wrote:
> On 15.12.2025 06:57, Christoph Hellwig wrote:
>> On Fri, Dec 12, 2025 at 10:09:14PM +0200, Andrei-Edward Popa wrote:
>>> dma_common_find_pages() previously assumed that the CPU virtual address
>>> always pointed to the start of a DMA-coherent allocation. This fails when
>>> memory is allocated via dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS
>>> and then subdivided into smaller blocks using a gen_pool, relevant only
>>> when an IOMMU is enabled.
>>>
>>> In such cases, userspace may request a mapping via dma_mmap_attrs()
>>> for a CPU address that is offset inside the original allocation. The
>>> previous code could return the wrong struct page pointer.
>> No, you can't mmap part of a dma coherent allocation.  What caller is
>> trying to do this?  It needs to be fixed instead.
> 
> I wonder if this was ever explicitly stated.

Seems it never made it into the text documentation, but it is stated in 
the kerneldoc.

> dma_mmap_coherent() was initially added for mmapeing a
> dma_alloc_coherent()-allocated buffer for fbdev and alsa, and at least
> the first one allowed to mmap the buffer partially or starting at
> non-zero offset. I doubt that this feature was useful for anything, but
> I'm quite sure this was at least allowed and there were some comments in
> the code about that.

Mapping part of a buffer in general is fine, provided the fd advertised 
to userspace represents the entire buffer - then the offset/size of the 
VMA determine how much of it actually gets mapped. What you can't do is 
advertise parts of a buffer *as separate fds* and then expect to pass 
mmap calls on those straight through, without adjusting them to be 
relative to the whole buffer.

We don't provide such a generic helper for mmap'ing from a generic 
dma_pool, largely because the main point of those is for drivers that 
want to allocate lots of buffers smaller than PAGE_SIZE, such that 
trying to mmap them to userspace would most likely be a giant security 
hole anyway.

Thanks,
Robin.
