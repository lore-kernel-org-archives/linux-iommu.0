Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C629DB65
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749539; cv=none; b=dBRP3aSncnYHY/f4rGH6BRn6ntQDs6x2koY4lrm5HWbKrKt79L6dM2zu5+NYw6nhQE7M4liSutFbIL1xVhjiYXxhfmodH7mYdtPNpMNfoX1200/hUp3Efy3UdAG68f3770A9MMmnuF1WFcsHqYX6vnD2aQDwpcdgWvgOYDF4SMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749539; c=relaxed/simple;
	bh=xWXh5hxpAy7hAlqJoBXRKLh/7sluFwmTqolY8OMuAak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op8n0X9aEgpEy8X9c8Zzis7AFo+Leal6BNt9LPM3oVxpSNdDPKNw5kzkWQJvFs03M4gX9o/YijRB0wCr1V180a9Z71jyWfyTJJ6OWqdxZSA+YShdFT71nJKqSHyPnR4Z2Yq3gQVjDJUUYmIGG5flHuUB/NWUl9c0e4F9WLp+MP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5531AC1;
	Wed, 29 Oct 2025 07:52:08 -0700 (PDT)
Received: from [10.57.40.110] (unknown [10.57.40.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F53A3F673;
	Wed, 29 Oct 2025 07:52:15 -0700 (PDT)
Message-ID: <ddb99a47-3869-4605-8404-807cdcb2d07e@arm.com>
Date: Wed, 29 Oct 2025 14:52:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about IOMMU and streaming DMA
To: zhang bruce <brucezhang5337@gmail.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, chenglingfei22s@ict.ac.cn
References: <CAJZPk7T0K51zBKNNQXw2qx9OYrPa8BJ6jQTvOM-YrxwBndPbzQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAJZPk7T0K51zBKNNQXw2qx9OYrPa8BJ6jQTvOM-YrxwBndPbzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 12:45 pm, zhang bruce wrote:
> Hello,
> 
> The driver invokes the dma_sync_single_for_cpu API to access the
> current state of the dma_buffer data.
> However, dma_sync_sync_single_for_cpu does not unmap the IOMMU
> mapping. In this case, while the
> driver is reading the dma_buffer data, can the device still modify the
> data concurrently?
> 
> If the IOMMU mapping remains valid, how is the ownership of the buffer
> transferred from the device to the CPU [1]?

The same way it is when there is no IOMMU at all. Consider that a 
sync_for_device doesn't unmap the CPU's view(s) of the buffer either - 
the "ownership" here is purely a logical notion between the device 
driver and the hardware it controls. It's not the IOMMU layer's 
responsibility to try to police whether drivers are making use of their 
own DMA buffers appropriately; the IOMMU's main role is to prevent the 
device from accessing any other memory that *isn't* one of its 
currently-mapped DMA buffers.

Thanks,
Robin.

> 
> [1]https://lwn.net/Articles/75780/
> 
> Best regards!

