Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA05192B85
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090416; cv=none; b=P9JzlUqvSXFuOxZWhDXwfhlLWxy4fHndA9lWnq8Mb3cccnB4Sgvkrm9rDC7MA+/9c5HJU9BjfyFbYOXkJuWDnaItGw0kHb7pAKKHatvfI27IvDJmK1o6tfqxDAofC2S4/YAwKQb9LDDg3zVUZ6OdSirX7jXM38fAlNK2h3txafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090416; c=relaxed/simple;
	bh=vlR8oz58U7sdUeVLG6j7/Sci+rAFqSU8RhEBYeU8yJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc90TxRZhpmhh7LG6Jhb8nsmwubqI6HYIPfPL/e9lpYYDiWYuBNnwhiUgZQmqFhvGzINLS/kEzI7DpN/U9Xb503SNVe3qrqEjjky9v5BKnOrgGKH/OUjop8K6sLhpBhD2PJcJSmjrRnm/o1N2WAtvOm9QXR47Wkwq1pagDkhlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7BC497;
	Tue, 28 Jan 2025 10:53:59 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F023F63F;
	Tue, 28 Jan 2025 10:53:32 -0800 (PST)
Message-ID: <741c6f7d-e36b-4ddf-a92b-9bbed2ce75c2@arm.com>
Date: Tue, 28 Jan 2025 18:53:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/dma: dma_common_find_pages returns pages for
 requested address
To: Dima Stepanov <dstepanov.src@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
 <50b71ac2-b84f-4f09-8795-d1c89a7c56af@arm.com>
 <CAEHp+GZRNApNBxznU8YioJO7+ezosKtUmTqaQXe8J6r2QyGjcw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAEHp+GZRNApNBxznU8YioJO7+ezosKtUmTqaQXe8J6r2QyGjcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/01/2025 5:47 pm, Dima Stepanov wrote:
> On Mon, Jan 27, 2025 at 12:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> No, that's a bug in the caller of dma_mmap_attrs(). As the kerneldoc
>> says, cpu_addr/dma_addr/size must still represent the whole buffer as
>> returned by the allocator - any offset for the mapping itself relative
>> to the start of the buffer is expressed in vma->pgoff.
>>
>> Thanks,
>> Robin.
> 
> I see, thanks for clarification Robin. I was confused, because depending
> on the backend it will work or not work. But i believe that in this case it is
> undefined behavior. That is unfortunate to me, since the idea behind was:
> - The memory allocated once because of device/firmware
> - Different users could request a part of this memory from the kernel and
> mmap it
> 
> And i didn't want to expose this offset information to the user. Wanted to
> rely on the kernel to mmap the proper part of the buffer.

In principle I don't see why you shouldn't be able to create multiple 
files representing different parts of one large buffer - seems like the 
ops for said files would just need to be a bit cleverer, and remain 
aware of the whole buffer as well as the range of their own part within 
it. Then they can adjust vma->vm_pgoff accordingly before calling 
dma_mmap_*() (and possibly perform their own stricter bounds checking as 
well.)

Thanks,
Robin.
