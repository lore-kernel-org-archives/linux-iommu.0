Received: from smtp113.iad3b.emailsrvr.com (smtp113.iad3b.emailsrvr.com [146.20.161.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68E21ADC7
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947020; cv=none; b=GSXQTIgjmoSthbbyYq6jjQ8qDH1HjbiqOlIxFUKrvl1y2o1wuTZU9L27reOHDOsMLe0/6L4oHAtVQnkItOXearM6dCN1TbCvvBhqG3tVjQu/w8x//IiXDdvLqxOtjE5eJgzlnRlEaLlKcEbgRVZPt0tJPowSbw8lEmqBW5pYWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947020; c=relaxed/simple;
	bh=qbNf/BglnOnpaq0ZIO90vZjsm4NGpFlHPSiTeYpNijQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYGlqI0PnJu2GMsQD3O+lAN3bJ3vb26taZP6k+plkUTdztZ/rtD0f0TITE+sv0YsEVtjKsBDMuy+qygsQvcZU1d4I7T2Tv4Ggld3N4xiChx4axciYlS+8x8WgtvihKOZlyJ1uQJSFT19nP0kGdibx8hmuKuMyr5Br0Z4xyr/UKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Qt59iGP5; arc=none smtp.client-ip=146.20.161.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Qt59iGP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745942378;
	bh=qbNf/BglnOnpaq0ZIO90vZjsm4NGpFlHPSiTeYpNijQ=;
	h=Date:Subject:To:From:From;
	b=Qt59iGP5O6240eOxD48APw85G7SSnBkxrOU+GPSNwpXpkPXEwBtUduCeDN7WZSNTf
	 n/RKUfktKKQ2Y66M2EEyXLwRg52ypsAeQJV7ZdaE4Gcj/cleR0J2/gYRD0gQqVrj5y
	 jV9/+FzkQUVOA0u7FMhtpdkoOvBty9e5Ho/0sR4w=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D0738A01E6;
	Tue, 29 Apr 2025 11:59:37 -0400 (EDT)
Message-ID: <3cabb8d7-0b1f-4c95-a3d0-cc0d957354a1@mev.co.uk>
Date: Tue, 29 Apr 2025 16:59:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] comedi: allocate DMA coherent buffer as individual
 pages
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20250415114008.5977-1-abbotti@mev.co.uk>
 <20250415114008.5977-5-abbotti@mev.co.uk>
 <CGME20250428125655eucas1p105937dfbffe2d5f3e0ed6a46772bb2f0@eucas1p1.samsung.com>
 <20250428125648.GC27794@lst.de>
 <d37ccb03-0d03-46ff-b62f-2fcb78263fe7@samsung.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <d37ccb03-0d03-46ff-b62f-2fcb78263fe7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 996621d9-fa40-4a61-b733-68d474ae896a-1-1

On 28/04/2025 16:33, Marek Szyprowski wrote:
> On 28.04.2025 14:56, Christoph Hellwig wrote:
>> On Tue, Apr 15, 2025 at 12:35:59PM +0100, Ian Abbott wrote:
>>> +			vma->vm_start = start;
>>> +			vma->vm_end = start + PAGE_SIZE;
>>> +			retval = dma_mmap_coherent(bm->dma_hw_dev, vma,
>>> +						   buf->virt_addr,
>>> +						   buf->dma_addr, PAGE_SIZE);
>> I'm not  fan of the vm_start/vm_end manipulation, but I've seen it in
>> other places.  In a perfect world we'd have a dma_mmap_coherent_offset
>> or similar helper that encapsulates it, and then maybe later replace
>> that hack with passing on the offset.
> 
> Indeed the dma_mmap_*() makes too many assumptions about the vma. The
> case You mentioned is probably in drivers/infiniband/hw/hfi1/file_ops.c
> but I also see that the vma->vm_pgoff is being adjusted before most
> dma_mmap_*() calls, which proves that the current API is somehow
> limited. It would be great to fix this too while touching the
> dma_mmap_attrs() API.

Drivers would probably have to continue manipulating vma->vm_pgoff 
anyway if they use its value in a special way, like 
drivers/infiniband/hw/hfil/file_ops.c or drivers/uio/uio.c.  The 
dma_mmap_*() calls already use vma->vm_pgoff as an offset into the VMA 
area, so I think all the new API would need is a parameter to restrict 
the number of pages being mapped, or something similar.

The new API doesn't necessarily have to be reflected all the way down to 
the dma_mmap_direct(), iommu_dma_mmap(), and ops->mmap() functions, as 
the new dma_mmap_*() function could modify vma->vm_end temporarily in 
order to restrict the number of pages being mapped by the lower-level 
functions.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
