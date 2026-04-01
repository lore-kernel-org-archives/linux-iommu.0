Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FA35C1B1
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057181; cv=none; b=fsAy0DSN5epPnfHCOS3iVRuj+nHpd/7GBwYADxnqypBBTe5VsaWKCS9oJekQNrfu/Q/MKNXmKYpOKPigsHrGKtKdBVacUc9noGrHABGwREAMQaLyHAZiQwElO5fF03tWqwbOV6HSldjekXTXLvdV6uHDnMj6V3Z/WnudIWs9blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057181; c=relaxed/simple;
	bh=wgI+SVOkvgIgOkHOsP10HpUziCGVii7hr3xefXc2Vxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGCkJlDCbY/G4h5GzozoTYxlpgmjvrDfWrxHXl1t9FGdXUY6Gfz/OeTRK2RnZ3XOjBDHQfMrbhDTLEWW4J/vzgx1OK82rE3CizA7K9F8qYxnWXjhtu/7Cmii6eC97KIYjwXtPMvqRNs9vFi2pfNiqUmqchHrkMR0dC3XfZa0nNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RyvOPtCr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RyvOPtCr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93711F91;
	Wed,  1 Apr 2026 08:26:13 -0700 (PDT)
Received: from [10.57.77.192] (unknown [10.57.77.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AE93F641;
	Wed,  1 Apr 2026 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775057179; bh=wgI+SVOkvgIgOkHOsP10HpUziCGVii7hr3xefXc2Vxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RyvOPtCrsaxhbwyyXJ9/sJxTBCYbXkxvMc+iFf5L1/ntPvY+woD6bO16mABcc9fzV
	 TRRjRLZAcc2Nn8wIqx41NvyZRgmTLLMoST3hzqBUZIzl1WOZ+HRkzq+Y0o3H08c2yb
	 TuGDO7ocWaI0p0OlB0jJ5cAO9ZDJxmYha4jc0j0g=
Message-ID: <75f65aa7-4f89-4ef8-8941-51b1d54d1ad3@arm.com>
Date: Wed, 1 Apr 2026 16:26:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-debug: suppress cacheline overlap warning when
 arch has no DMA alignment requirement
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-mm@kvack.org,
 harry@kernel.org, vbabka@kernel.org, akpm@linux-foundation.org,
 stern@rowland.harvard.edu, linux@roeck-us.net, hch@lst.de,
 Jeff.kirsher@gmail.com, catalin.marinas@arm.com
References: <CGME20260327124211eucas1p10425a28f67736d2043e7e4dd77d58e72@eucas1p1.samsung.com>
 <20260327124156.24820-1-mikhail.v.gavrilov@gmail.com>
 <6270d4f0-85e4-496d-8db4-87ccb791ca4d@samsung.com>
 <c9ded35b-fc10-47d8-bfaa-cecb4fa91add@arm.com>
 <CAHp75VdrGk=foAzQBJNRNDZ1yfFY8p-tC_ApM8_gN4EehpmN_Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAHp75VdrGk=foAzQBJNRNDZ1yfFY8p-tC_ApM8_gN4EehpmN_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-04-01 2:25 pm, Andy Shevchenko wrote:
> On Wed, Apr 1, 2026 at 3:11 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2026-03-30 8:44 am, Marek Szyprowski wrote:
>>> On 27.03.2026 13:41, Mikhail Gavrilov wrote:
> 
> ...
> 
>> TBH I'd be inclined to have CONFIG_DMA_DEBUG raise ARCH_DMA_MINALIGN as
>> appropriate such that genuine false-positives can't happen, rather than
>> effectively defeat the whole check,
> 
> I dunno if you read v1 thread, where I proposed to unroll the check
> and use pr_debug_once() for the cases which we expect not to panic,
> but would be good to have a track of.

I had not seen v1, as I took the last 3 days off and hadn't got that far 
up my inbox yet - I guess it's at least reassuring to have reached 
similar conclusions independently :)

The fundamental issue here is that dma-debug doesn't realistically have 
a way to know whether the thing being mapped is intentionally a whole 
dedicated kmalloc allocation - where we can trust SLUB (and 
DMA_BOUNCE_UNALIGNED_KMALLOC if appropriate) to do the right thing 
across different systems - or just something which might happen to line 
up by coincidence on someone's development machine, but for portability 
they definitely do still need to take explicit care about (e.g. struct 
devres::data).

Certainly some milder and/or opt-in reporting of 
potential-false-positive overlaps wouldn't be a terrible idea, if 
someone wants to have a crack at it.

Thanks,
Robin.
