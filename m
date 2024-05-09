Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B017F13A3FF
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259305; cv=none; b=dhRk4ZybUx0qY41HA00dRzFLU6M/js82cTboOWBLGuFqVI/UPS50csNv97tKaYy8Aw24+La/11OQ14DhUb4YnTg23w6Pxof7S6K+i7CW3+0hvADn2N9ImAtlJCfpnvnxZ1rB3oD9kaXHmBzrldiCNlHZZqqdoOVwuoNjI615yRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259305; c=relaxed/simple;
	bh=aSkUfhv6SwKhbFuUelERURNoIkOHYjhPTf9RrMCE0mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehgKqrFlhj9uyz5F2TsvasuSAESJOnIcC9E0BJaqlPK5ZnzAIgYJ3utZzuj+keqReWC0oVC97qhNy1MA5gxWEvOGDuhATNRjh8BLtr0wAeN3UJr1ZsMtQ8cE/lHT3HafH2wyJ0nEjvATzuCwJwDm7lo96yrS+KgtY2AxZjgHrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94AC8106F;
	Thu,  9 May 2024 05:55:28 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EA1C3F6A8;
	Thu,  9 May 2024 05:55:02 -0700 (PDT)
Message-ID: <1be83f24-15bd-43a4-b310-f62c720cf064@arm.com>
Date: Thu, 9 May 2024 13:54:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>, "T.J. Mercier" <tjmercier@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, isaacmanjarres@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de>
 <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de>
 <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de>
 <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de>
 <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <20240508113353.GA31529@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240508113353.GA31529@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 12:33 pm, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
>> On Mon, May 6, 2024 at 10:43???PM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
>>>>> You should not check, you simply must handle it by doing the proper
>>>>> DMA API based ownership management.
>>>>
>>>> That doesn't really work for uncached buffers.
>>>
>>> What uncached buffers?
>>
>> For example these ones:
>> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/dma-buf/heaps/system_heap.c#141
> 
> Whatever that code is doing is probably not upstream because it's too
> broken to live.

Indeed, at a glance it appears to be trying to reinvent 
dma_alloc_noncontiguous(). What's not immediately obvious is whether 
it's particular about allocations being DMA-contiguous; if not then I 
think it comes down to the same thing as vb2-dma-sg and the ideas we 
were tossing around for that[1].

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-media/20231228074645.765yytb2a7hvz7ti@chromium.org/
