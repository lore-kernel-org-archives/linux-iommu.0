Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755726D4FB
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854426; cv=none; b=jrtTMXipnlv5rzXSGYBfpwrclUektod3TjcerO8q/VOGEZJVKxbv4QbeG6ngcAKY0hfxRzP3RjXLvWQjV3TOJMm7uUTjKHCH9L/WL3r0BsHw23P37GmG4W+Tr2v3t8kRKHYpS9F/3qVhRo1h9K/HVGYqJobQTaW5ygTz6/VQvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854426; c=relaxed/simple;
	bh=c4lzFxsgENeTiNfGEUAq65bbodJC1AJjZpxKVJ85yHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ED4Q/buprVJh8GV2VhV46Gw5taY4oWEHXt8njYESkFrad8TJyVdPZY8wmZDW67qqdiHqQI/eqpoDsfNc54aXSd1GyephSwsOa3X8n5HoSQ0cEyYd9mTfo2BHvE6gG3iJ8Sc2WhfxLRPIFHix/FFDYSu29Ibw/I7ZSUPrPlkHuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kDj7uUw7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kDj7uUw7"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250428153336euoutp02769b966e69a2d70d0836d5eb87cdbcfa~6hVdzwxlJ1547515475euoutp02K
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 15:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250428153336euoutp02769b966e69a2d70d0836d5eb87cdbcfa~6hVdzwxlJ1547515475euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745854416;
	bh=IJToYo52fUnx4/+2swkvXuGPm6uMEkAsbOCmRLB8n9Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kDj7uUw7P7RgTyFd6XO8hLzOPu3iIKBuRdYdc2vzPVQHPE+y2lM1SQP50BoHSZiFZ
	 ruuI0cO5n8/nnuCk4o4bal6kk9LdCAGWAlihwbleZ1nWYfL/MwP/2atkG+pPvMGqZG
	 oWI71uWmQDjrgXt7UbjsbDAHtP15iUkmm1NvhIE8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250428153335eucas1p2abd49e68cde41dd73cbc5e4897140053~6hVdm-o9X0606406064eucas1p2F;
	Mon, 28 Apr 2025 15:33:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250428153335eusmtip23c533ade2d8ce61384f50aeae061782d~6hVdK30Wy2124821248eusmtip2B;
	Mon, 28 Apr 2025 15:33:35 +0000 (GMT)
Message-ID: <d37ccb03-0d03-46ff-b62f-2fcb78263fe7@samsung.com>
Date: Mon, 28 Apr 2025 17:33:35 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] comedi: allocate DMA coherent buffer as individual
 pages
To: Christoph Hellwig <hch@lst.de>, Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, H Hartley Sweeten
	<hsweeten@visionengravers.com>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250428125648.GC27794@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250428153335eucas1p2abd49e68cde41dd73cbc5e4897140053
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250428125655eucas1p105937dfbffe2d5f3e0ed6a46772bb2f0
X-EPHeader: CA
X-CMS-RootMailID: 20250428125655eucas1p105937dfbffe2d5f3e0ed6a46772bb2f0
References: <20250415114008.5977-1-abbotti@mev.co.uk>
	<20250415114008.5977-5-abbotti@mev.co.uk>
	<CGME20250428125655eucas1p105937dfbffe2d5f3e0ed6a46772bb2f0@eucas1p1.samsung.com>
	<20250428125648.GC27794@lst.de>

On 28.04.2025 14:56, Christoph Hellwig wrote:
> On Tue, Apr 15, 2025 at 12:35:59PM +0100, Ian Abbott wrote:
>> +			vma->vm_start = start;
>> +			vma->vm_end = start + PAGE_SIZE;
>> +			retval = dma_mmap_coherent(bm->dma_hw_dev, vma,
>> +						   buf->virt_addr,
>> +						   buf->dma_addr, PAGE_SIZE);
> I'm not  fan of the vm_start/vm_end manipulation, but I've seen it in
> other places.  In a perfect world we'd have a dma_mmap_coherent_offset
> or similar helper that encapsulates it, and then maybe later replace
> that hack with passing on the offset.

Indeed the dma_mmap_*() makes too many assumptions about the vma. The 
case You mentioned is probably in drivers/infiniband/hw/hfi1/file_ops.c 
but I also see that the vma->vm_pgoff is being adjusted before most 
dma_mmap_*() calls, which proves that the current API is somehow 
limited. It would be great to fix this too while touching the 
dma_mmap_attrs() API.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

