Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BC17BB35
	for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546994; cv=none; b=XbIfCF7U6Ut9+/VdgC0V/EcxwU3EzQnU6RGwbVGHaSiUCzb8nj/cfnA+m/K9f+Tloedt+rXvoGPwcLPIloeBIDN+sO7F0pK2lKNs9GXZ76c3ak1gik8E6l08mEoR5Lc2l/x0hQaZivw9ADN4KUF11+h4AdCYsufibWut4uJ+uMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546994; c=relaxed/simple;
	bh=nwnrJljMgTpFHCoIrnfxv3WcVBFeN5K9HDZgBh4R0j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGBdQxUfKf1pIKH0gvjrMQd9KXqoV9DJrFgIhhgigJ7bszjX3ZakbAzuG27vYhTuR+FrBRrtJhnDTf1N7dN5BpeIe3SGtTM8C1XUpByuHgrR9hXyvrxz3oOi+j1sAgrp31PWY1ICBxFk8Ayb9GtgqWqde6zy9W0xomYPmPyUYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14BA202C;
	Mon, 25 Nov 2024 07:03:41 -0800 (PST)
Received: from [10.57.93.75] (unknown [10.57.93.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244313F66E;
	Mon, 25 Nov 2024 07:03:10 -0800 (PST)
Message-ID: <3d1642fb-79f9-4abe-8856-0ee67da9666c@arm.com>
Date: Mon, 25 Nov 2024 15:03:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Raphael Isemann <teemperor@gmail.com>,
 Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
 <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-22 7:13 pm, Brian Johannesmeyer wrote:
> Replace the BUG_ON() assertion in swiotlb_release_slots() with a
> conditional check and return. This change prevents a corrupted tlb_addr
> from causing a kernel panic.

Hmm, looking again, how exactly *does* this happen? To get here from 
swiotlb_unmap_single(), swiotlb_find_pool() has already determined that 
"tlb_addr" is within the range belonging to "mem", so if it is somehow 
possible for it to then convert into an out-of-bounds index, maybe that 
does actually imply some bug in SWIOTLB itself where "mem" is 
misconfigured...

Thanks,
Robin.

> Co-developed-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> ---
>   kernel/dma/swiotlb.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa0a4a220719..54b4f9665772 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -834,7 +834,11 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
>   	 * While returning the entries to the free list, we merge the entries
>   	 * with slots below and above the pool being returned.
>   	 */
> -	BUG_ON(aindex >= mem->nareas);
> +	if (unlikely(aindex >= mem->nareas)) {
> +		dev_err(dev, "%s: invalid area index (%d >= %d)\n", __func__,
> +			aindex, mem->nareas);
> +		return;
> +	}
>   
>   	spin_lock_irqsave(&area->lock, flags);
>   	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))

