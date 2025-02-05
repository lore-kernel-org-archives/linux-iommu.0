Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D5151986
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755979; cv=none; b=QKdZoUxYTQAsl5e42xYTeNc+DjlegODTdjApq0Udb8k6CADAycCFPkfvyR7ZJGsu9tPgt1wgVyEQ0RUOWmIKdsJ/StoyORech70nDJ6ecqZuBT2JICCLGLdDelc0tr1KqvOpQu34lJMSEkwtjbWaoqsnT7kXdT0bzpWIYKjP4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755979; c=relaxed/simple;
	bh=6MW5WOwEQE4zj5HdzDmZoolczUr5/7vLmQKUoV+raf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFiIg0bL3AmG79gqjLGJxqT2tYRnesM6vFJ4uJFtkV+XL3PZBf87UrjNl3+dqyIjrEXXz12eeMN1rKIh32aGSsPfkJOLClV6VRxi6qUGpW7HehndD1DZ4qWZulZaFU4Lls6ITbeQ4Oj/TGe7BKyAXbtwvvsjLyyX1duryfHX+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9483911FB;
	Wed,  5 Feb 2025 03:46:38 -0800 (PST)
Received: from [10.57.35.21] (unknown [10.57.35.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3FB13F5A1;
	Wed,  5 Feb 2025 03:46:12 -0800 (PST)
Message-ID: <3b3b66ec-8e40-49ef-941b-4d98a6d0ed91@arm.com>
Date: Wed, 5 Feb 2025 11:46:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Add an option for devices to skip SWIOTLB
 pre-copy on read.
To: Jianxiong Gao <jxgao@google.com>, Keith Busch <kbusch@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Erdem Aktas
 <erdemaktas@google.com>, Vishal Annapurve <vannapurve@google.com>,
 Ryan Afranji <afranji@google.com>, linux-nvme@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250204233630.3407878-1-jxgao@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250204233630.3407878-1-jxgao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-04 11:36 pm, Jianxiong Gao wrote:
> Removes an extra memory copy that occurs during IO read
> operations through the SWIOTLB. During high throughput
> read workloads, this extra copy is causing a lot of stress
> on the SWIOTLB.
> 
> With high performance devices, for example NVMe devices,
> the device will be overwriting the entire buffer. In such
> cases the entire pre-copy is redundent, only to slow down
> the overall bounce buffering.
> 
> We propose to add a full_buffer_write flag to the
> device_dma_parameters flag. When the flag is set the pre-copy
> can be omitted to boost performance.

No. We already went through this a couple of weeks ago[1]. It's not 
about what the driver intends the device to do, it's about what happens 
if for whatever reason it then *doesn't* do that.

Thanks,
Robin.

[1] 
https://lore.kernel.org/lkml/9582878b-1ce7-4fc4-9b45-b72bba722f49@arm.com/

> 
> Jianxiong Gao (3):
>    add full_buffer_write flag to struct device_dma_parameters
>    skip swiotlb pre copy if the device does full buffer write.
>    set full_buffer_write for nvme devices.
> 
>   drivers/nvme/host/pci.c     |  1 +
>   include/linux/device.h      |  1 +
>   include/linux/dma-mapping.h | 15 +++++++++++++++
>   kernel/dma/swiotlb.c        |  3 ++-
>   4 files changed, 19 insertions(+), 1 deletion(-)
> 

