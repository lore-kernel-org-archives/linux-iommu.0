Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4497628152F
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284837; cv=none; b=t48txRp2OZwZe9VKJK6rU0zIkxkoOrOr1zITJtgBInjcE54TpEWn/BMgTi/TMFa15diewte9CxbMnGFxxc90zM0NGorrF8yupM7AyqaK1ujd/EJ0If3Sq5gwp/VWqLUvmkALzCA3+p0RONbm0xxorQLlMPuxqcnCrCYqJdPmJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284837; c=relaxed/simple;
	bh=qOf+23fX3M4tREIIA6VvcWMilSTEU39Y4UDbtsGf1ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvduenJ2PEge3GJGbk71aqzlkqo0YTFH//000uoSbnAQhv8ZW9KQe8IFFsty14d9YR8x5KudlHmZcR4T9FlJURFZX5UAj+Wlzd609vc4ZGhhf8E9SLIK5uL1j8u1OdeLm59ZO+jfnYG0trApMV+m4jD5UVGET//xP/ZrW4LiXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7ABC106F;
	Thu, 10 Apr 2025 04:33:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EDF63F6A8;
	Thu, 10 Apr 2025 04:33:53 -0700 (PDT)
Message-ID: <9bd6cbaa-3a1f-4cc5-8581-3a99dc6ac2c2@arm.com>
Date: Thu, 10 Apr 2025 12:33:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Remove an unnecessary call set_dma_ops()
To: Baolu Lu <baolu.lu@linux.intel.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>, iommu@lists.linux.dev
Cc: Petr Tesarik <ptesarik@suse.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
References: <20250403165605.278541-1-ptesarik@suse.com>
 <20250409174430.00ff4a09@meshulam.tesarici.cz>
 <5543e3a5-dda5-49b5-aa59-fbc599d24bab@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5543e3a5-dda5-49b5-aa59-fbc599d24bab@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2025 3:59 am, Baolu Lu wrote:
> On 4/9/25 23:44, Petr Tesařík wrote:
>> On Thu,  3 Apr 2025 18:56:05 +0200
>> Petr Tesarik<ptesarik@suse.com> wrote:
>>
>>> Do not touch per-device DMA ops when the driver has been converted to 
>>> use
>>> the dma-iommu API.
>>>
>>> Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the 
>>> iommu ops")
>>> Signed-off-by: Petr Tesarik<ptesarik@suse.com>
>> Does anyone agree? Or see any issues?

At least it definitely serves no purpose since b5c58b2fdc42 
("dma-mapping: direct calls for dma-iommu"). FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> This change looks good to me. The iommu driver should not call
> set_dma_ops() anyway. I will queue this for v6.15-rc.
> 
> I ever wondered whether we could clean up dev->dma_iommu when the device
> is released by the iommu core. But, iommu_release_device() is only
> called in the device removal path, so keeping dev->dma_iommu set doesn't
> impose any functional impact AFAICS.

Funnily enough I've just been looking at that - I'd long held the same 
assumption, but I'd been forgetting the edge case that's always been 
there if bus_set_iommu(), and now iommu_device_register(), failed and 
groups and default domains were torn down for existing devices. So in 
fact it seems Intel was one of the few drivers/architectures managing to 
do the right thing before :)

Cheers,
Robin.
