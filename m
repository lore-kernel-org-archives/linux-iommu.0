Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333D178381
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468379; cv=none; b=qz8jTKUHHCpZXAMwqJNyuuhDt92ZOxQ0oUR3pDncpncQgxEnjq61mq88yTEidcVeFOPUiYgqafNTYt82LMQQawp7U2sW1Lgm/gc30EYbnTr+ivGQQg+Qn/ddvvbBvYHgHjOxYB3YxLnFcq7XMLs+DuBNOwPfP23iqASimm6gtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468379; c=relaxed/simple;
	bh=MyC2hHblwrVnukKV9w1fTfXIvSxlZnWzvCzec8YD93s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbOKMkDDOO6hcByjOHlqbQHZoEu9NBL8qVHUMx5kEYCd5Nb5sJOYBARBHvirh7mfy56SGFUhjlBD4Uq2iVnw/CtdnOjweV1+vCjCJ/6X177jfkpHfC2DaUMyhSxhzl03OlKA6ZSCbY9DmuGsUuZplyMQ5reXGz7S6USBh1/Qry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52CCFEC;
	Mon, 12 Aug 2024 06:13:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959D73F71E;
	Mon, 12 Aug 2024 06:12:53 -0700 (PDT)
Message-ID: <f549b436-b6f4-4ee8-9086-6f8d08e4e49e@arm.com>
Date: Mon, 12 Aug 2024 14:12:46 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@rivosinc.com,
 Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>
 <20240808131432.GB1985367@ziepe.ca>
 <7dfff1ba-44a6-465a-a47c-d344ef00c6d5@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <7dfff1ba-44a6-465a-a47c-d344ef00c6d5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2024 5:40 pm, Easwar Hariharan wrote:
> On 8/8/2024 6:14 AM, Jason Gunthorpe wrote:
>> On Tue, Aug 06, 2024 at 12:24:40PM -0700, Easwar Hariharan wrote:
>>> On 6/14/2024 10:27 PM, Tomasz Jeznach wrote:
>>>
>>>> @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
>>>>   
>>>>   static int riscv_iommu_device_domain_type(struct device *dev)
>>>>   {
>>>> -	return IOMMU_DOMAIN_IDENTITY;
>>>> +	return 0;
>>>>   }
>>>
>>> <snip>
>>> Sorry for the drive by comment, I just happen to be in the nearby code
>>> context.
>>>
>>> Nit: It may be better to use IOMMU_DOMAIN_BLOCKED here for readability
>>> rather than the bare value.
>>
>> It is weird and confusing, but 0 means "I have nothing to add" not
>> BLOCKED.
>>
>> You can't return BLOCKED from this op right now..
>>
>> Jason
> 
> Ok, that's weird and confusing as you say. I went back and looked at the
> kerneldoc for iommu_ops and it IS called out, but it's confusing that a
> function named get_default_domain_type() can return a value that's a
> valid domain type but isn't treated as one.
> 
> This was useful to fill in my mental model, thanks!

Yeah, it's perhaps a bit subtle, but the context is that not all domain 
types are valid *default domain* types, those are strictly only DMA or 
identity, because the other types would be nonsensical. If a driver 
really wanted to completely block a device for some specific reason, it 
should do that by refusing to attach it to the default domain at all.

Thanks,
Robin.
