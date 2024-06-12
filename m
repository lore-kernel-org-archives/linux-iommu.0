Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67E250EC
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211750; cv=none; b=K1sdHhNq63N8Ykrl8LO3Qj7W50Tsqv5HxDIETCXKXPaKjjao6iQEQ7dvwmgjSqYtMxdwvowv3di1S14ZQPr4eQheoObG3sa8qi29TyjS6QIU5WYDmC9xpDCQJJQiup0U4pjUF9NR9FOL7Z2XzC+vYl8Difyzpx+Ma2TShF9X7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211750; c=relaxed/simple;
	bh=tPaPDXQBKWJBH0zp97r539gFVfFHyf06AeUg/RMJ+dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF3l6ybE9j6b2nBwhdnFe16Kn8QeqaNf7SL+uCkL6ts8XeqcRs3XUZTFxq8KJkmime8Awz4J0QJsUfhDpHD26E9PNWNijJRwRcSlD56aK5lopj9+C2V71teLCap8PRmrGufdJEnsv045NjEz/gPCv0SM74Fc6u+BHJCHSvgdQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D731063;
	Wed, 12 Jun 2024 10:02:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B233F64C;
	Wed, 12 Jun 2024 10:02:27 -0700 (PDT)
Message-ID: <86167c43-fc4a-4531-b430-7fbfd98d5da3@arm.com>
Date: Wed, 12 Jun 2024 18:02:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About iommu_dma_alloc_iova() missing incremental change
To: John Garry <john.g.garry@oracle.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com
References: <7f8d95a1-9dde-492c-9eaa-84a17607495d@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <7f8d95a1-9dde-492c-9eaa-84a17607495d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/06/2024 2:02 pm, John Garry wrote:
> Hi Robin,
> 
> Was your code at the following missed for iommu_dma_alloc_iova():
> 
> https://lore.kernel.org/lkml/54083e3b-cba3-c719-651d-bf99d6eca16d@arm.com/
> 
> Maybe not, since no one has complained about it :)
> 
> I just noticed this code change again by chance.

Yes, I did prepare v5 with that tweak included, but for reasons now 
forgotten, never got round to sending it before v4 then got queued 
as-was. Indeed I've just been sat on it since, waiting to see if anyone 
notices and still thinks it's worth doing something about...

Cheers,
Robin.
