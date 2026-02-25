Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBEC2EFD95
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044036; cv=none; b=El/sMB+vBvcLqHYvMUcnKFaJUAWrwznuaaJnvZ7bPnsxBrnW0s1ynA+6/m21Umg3BECQSZ6Ts1HbXQkUHzN8gzMnEJ1EkX3umdlh23EFvqv0Xh+cVzUT2Q/uTVXO2U/MyWQsHgLgX5WG+zmJe9VrvOA6n0QXl2HYcDBczuntf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044036; c=relaxed/simple;
	bh=EkxkOvzKGkGHUAbSsHHto+3gbr95iY7aunDxZfIN8dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B74x3tbz9m1FMfKyMhzj4iyxyzrKJ8auS+2sD1/Zyilp66Ub356ww8diNGyParL1opelQlFe1Tk3AqdYrAiDThtikPZuYUo0zrq1vJyLZ7LIviWWGSpDhtttPngB1H6jkXcSwUXqCWxO+bUL+aGTQQsXLXEFRox+uBtw8iWpP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06F5165C;
	Wed, 25 Feb 2026 10:27:06 -0800 (PST)
Received: from [10.57.58.107] (unknown [10.57.58.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819373F99C;
	Wed, 25 Feb 2026 10:27:11 -0800 (PST)
Message-ID: <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
Date: Wed, 25 Feb 2026 18:27:09 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Antheas Kapenekakis <lkml@antheas.dev>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
 Mario.Limonciello@amd.com
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-24 7:51 pm, Antheas Kapenekakis wrote:
> On Tue, 24 Feb 2026 at 20:43, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
>>> On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
>>>>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>>>>> introduces the shared iommu page table for AMD IOMMU. Some bioses
>>>>> contain an identity mapping for address 0x0, which is not parsed
>>>>> properly (e.g., certain Strix Halo devices). This causes the DMA
>>>>> components of the device to fail to initialize (e.g., the NVMe SSD
>>>>> controller), leading to a failed post.
>>>>
>>>> I'm trying to understand the issue here, is it that the old AMD code
>>>> incorrectly succeeded iommu_map() on top of an existing mapping while
>>>> the new code returns -EADDRINUSE?
>>>>
>>>> Then the existing guard for double mapping doesn't work since 0 is an
>>>> ambiguous return?
>>>
>>> Hi Jason,
>>>
>>> It seems like the previous code correctly handled the 0 case, and the
>>> new code does not due to the ambiguous return.
>>
>> I checked the old AMD driver it is definately returning 0 from
>> iommu_iova_to_phys(), so that hasn't changed.
>>
>>>> reasonabe. Just please clean up the commit message to be a bit clearer
>>>> on what caused this regression and add a short comment above the new if:
>>>>
>>>>   0 return from iommu_iova_to_phys() is ambiguous, it could mean a
>>>>   present mapping. EADDRINUSE is reliable when supported, it means the
>>>>   IOVA is already mapped, so ignore it to resolve the ambiguity.
>>>
>>> If you think that this patch is a long term solution, I can drop the
>>> print, the addr == 0 check, add a comment on top, then repost a V2
>>> with an updated description to be more concrete.
>>
>> I think it is a good solution as-is, I just want clarity on what
>> actually regressed here, and I think it is that iommu_map() behavior
>> changed.
> 
> Reverting 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> plus two follow-up fixes also worked.
> 
> Looking through it, the removed amd_iommu_map_pages() /
> amd_iommu_iova_to_phys() in the previous ops might have behaved
> differently.

Yes, the old AMD code would happily replace an existing mapping without
question (but whether it would correctly invalidate TLBs if just
replacing a leaf entry with a different leaf entry at the same level
I'm not entirely sure...)

However, waiting for a mapping to fail (which may scream its own
warning) and then attempting to paper over it seems like an awful bodge.
Why not just do something like this?

Cheers,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db51780954..682e95c94236 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1212,8 +1212,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
  
  			if (addr == end)
  				goto map_end;
-
-			phys_addr = iommu_iova_to_phys(domain, addr);
+			/*
+			 * Check for existing translations using an offset, to
+			 * distinguish a mapping of the page at PA 0 from none.
+			 */
+			phys_addr = iommu_iova_to_phys(domain, addr + 1);
  			if (!phys_addr) {
  				map_size += pg_size;
  				continue;

