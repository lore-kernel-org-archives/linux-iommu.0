Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A84734CC
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324100; cv=none; b=Cmwj7cvvBoSwlw+qOukkrOaJr4WNQtD8W2aOt5z7PM56t3Oxhje5SVjzwAp+4Irdni7MuZAwCdlZqDXj7UskzdOlrm68n8fDgoskm7TXgDIxmxi14LB7YrMEtmTIMjTcOLNLu4QOxVhjNjJ9ktBwbVMf7ezXiM3kHXyXTwgsCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324100; c=relaxed/simple;
	bh=MB28ZDQXnRUEjS0QpfpMx6wHRzIxNI4OeS25bP12DFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhtHkm4Gjxpf7nouOiEy/t+Wmf8RKewm+f/czypLEFtzkIm4q0PfpCi8ZHUtCUGtTw9s/SDZhA6QAoP5LQuVZDXnk0arvkxnMnwr8YnUtyv6KN0o0PIkWn1NTA4S7j3e4bSLaRMoXdidyRG7gR6VgxO6yHP1D6fUHAuwMgbwqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qATPPOOi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qATPPOOi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89C231688;
	Wed, 29 Jul 2026 04:21:34 -0700 (PDT)
Received: from [10.57.44.102] (unknown [10.57.44.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463383F86F;
	Wed, 29 Jul 2026 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785324098; bh=MB28ZDQXnRUEjS0QpfpMx6wHRzIxNI4OeS25bP12DFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qATPPOOiKFq2WOesC8q1NUuqO8LSLfmyaDs5deWapEMmKkCbPR0dThDjYWrbdPVZf
	 dE4OeQNPo2A07MypAALO2HOPX2h9phA76VaX6TLEkiyyCiKdhJ4DG2Cph/4s2dfyBL
	 e8VzRjDJQSsry1xjPn//P0JB30WEF1h5KK4iZn+c=
Message-ID: <1361ff13-fd24-4ba6-a048-eb2091d989ea@arm.com>
Date: Wed, 29 Jul 2026 12:21:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Drake <dan@reactivated.net>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 nick.hollinghurst@raspberrypi.com
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com> <amlE8rEgryPqrUZd@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <amlE8rEgryPqrUZd@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-29 1:10 am, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2026 at 11:51:04AM +0100, Robin Murphy wrote:
>>> +	ret = pt_iommu_bcm2712_init(&domain->pt, &cfg, GFP_KERNEL);
>>> +	if (ret)
>>> +		goto err;
>>> +
>>> +	/* Set up a default (error) page used to catch illegal reads/writes */
>>> +	domain->default_page = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE);
>>> +	if (!domain->default_page)
>>> +		goto err;
>>> +
>>> +	domain->base.geometry.aperture_start = BCM2712_APERTURE_BASE;
>>> +	domain->base.geometry.aperture_end = BCM2712_APERTURE_END - 1;
>>> +	domain->base.geometry.force_aperture = true;
>>
>> ...and thus (as things stand) this is a lie :(
> 
> Well, it shouldn't be here, the iommupt core code should be setting
> this from its own internal information. If there is something missing
> to add in the full_va_prefix we should fix it.
> 
> But, AFAIK this is the correct way to declare a page table that has a
> range of IOVA - which I think is what this is doing..

Nope, aperture_start and aperture_end already indicate the range of what 
can be used as translatable IOVAs; force_aperture is supposed to 
indicate whether addresses _outside_ that range are blocked, or may 
still be able to access memory as with a GART-style device.

Heck, a "proper" IOMMU doesn't even have an "aperture", it simply has an 
entire input address space.

>> If you want to operate like an IOMMU, then the translation aperture and the
>> bypass window should really be mutually-exclusive;
> 
> I think it is operating like an iommu..
> 
> It uses generic_single_device_group() so there is only ever one
> translation.

Also like a GART.

> If identity is attached then it clears MMMU_CTRL_OPERATING_FLAGS which
> I guess fully disables the IOVA aperture

Not unlike a GART.

> If paging is attached then it sets MMMU_CTRL_OPERATING_FLAGS and
> places the aperture at 40G. Based on the comments about blocking I
> wonder if the "bypass" even works when paging is on?

Rather like a GART.

> If blocking is attached then it sets MMMU_CTRL_OPERATING_FLAGS with
> some 0 address cap which aborts everything?

Disabling the aperture is also GART-like, but also disabling the bypass 
window would seem the be the exclusively IOMMU-like behaviour there ;)

> It looks to me like some of those comments and choices don't reflect
> what the driver actually does. Since there is only ever one
> translation we never need to be worried about where the aperture is,
> it could be anything so long as the HW gives it priority to bypass.

I'm looking at the BYPASS_START/BYPASS_END stuff, where (assuming that's 
intuitive and not completely misnamed) bcm2712_iommu_attach_dev() sure 
seems to be opening up a giant hole in all paging domains per the commit 
message, thus while they can offer the convenience of IOVA remapping, 
they aren't providing any real memory protection.

Thanks,
Robin.

> Could the aperture be placed at 0 with the bypass fully disabled? Then
> it would basically be a normal iommu.
> 
> Jason

