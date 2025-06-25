Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59317333F
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861009; cv=none; b=i+N+w1Jkty47tDKigdyEIvQEPO7fAGgnKDViOPbCnxEWNSrG2ImbO7jd34j+Fd4bjNfO3OhNbR4H06sS91iU4p5AinScIxcw1GQRmJY7SeOjsVoH+muqfAX3nrCBukVU068r2wR/VND6m/gGYj1FHQb/7g8r6ZBbv3CQ59vevm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861009; c=relaxed/simple;
	bh=qK+i+U+6rzfemAyvripjb73RvpT/DUf/CWO5dfpdbds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpqqui3VxEFWIWU8KOHCXwUq6QB+l7azoB0hqbNPs1jERRz/Vy9kKbvOMnm7QDQTH24IF5Su4OHQEW2V89lA5DAguonLBNBBFi8bVI2tqEgy8qdEdZum0m3AE8oVyNV0mYldbQkm6PsdYTRLOk7sdFdxuX+gJ6tOHbKBlN0ar1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C842B106F;
	Wed, 25 Jun 2025 07:16:28 -0700 (PDT)
Received: from [10.57.84.221] (unknown [10.57.84.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7E9B3F66E;
	Wed, 25 Jun 2025 07:16:42 -0700 (PDT)
Message-ID: <40c6e847-3be1-4d12-ab23-6ac5e0f1bd4a@arm.com>
Date: Wed, 25 Jun 2025 15:16:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 yang@os.amperecomputing.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
 broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 suzuki.poulose@arm.com, david@redhat.com, nicolinc@nvidia.com,
 jsnitsel@redhat.com, mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-5-miko.lenczewski@arm.com> <aFRlDSZ2PPnHixjc@arm.com>
 <7105112f-b0bb-4191-b3c9-93522162319c@arm.com>
 <636c8901-6e05-479f-ae06-ee391d4d36e8@arm.com>
 <20250625133735.GB213144@ziepe.ca>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250625133735.GB213144@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 14:37, Jason Gunthorpe wrote:
> On Wed, Jun 25, 2025 at 02:07:23PM +0100, Ryan Roberts wrote:
>> I think what you are saying is that despite going via invalid, the HW may see
>> this direct transition:
>>
>> +----+----+----+----+
>> |RO,n|RO,n|RO,n|RW,n|
>> +----+----+----+----+
>> to:
>> +----+----+----+----+
>> |RO,c|RO,c|RO,c|RO,c|
>> +----+----+----+----+
>>
>> There are 2 logical operations here. The first is changing the permissions of
>> the last entry. The second is changing the size of the entry.
>>
>> As I understand it, it's permissible in the architecture to update the
>> permissions of the a PTE without break-before-make and without issuing a tlbi
>> afterwards; in that case the HW may apply either the old permissions or the new
>> permissions up until a future tlbi (after which the new permissions are
>> guarranteed). That's the first logical operation.
>>
>> The second logical operation is permitted by FEAT_BBM level 2.
>>
>> So both logical operations are permitted and the Arm ARM doesn't mention any
>> requirement to "separate" these operations with a tlbi or anything else, as far
>> as I can see.
>>
>> So I would interpret that combining these 2 in the way we have should be safe.
>> RNGLXZ and RJQQTC give further insight into the spirit of the spec. But I agree
>> this isn't spelled out super clearly.
>>
>> Perhaps we can move forwards based on this understanding, and I will seek some
>> clarifying words to be added to the Arm ARM?
> 
> FWIW this matches my understanding as well.
> 
> AFAIK the actual physical issue for BBM < 2 is the TLB lookup HW
> cannot tolerate having two entries that overlap in address because of
> different sizes. Every lookup must return exactly one result. If more
> results are returned the HW fails in some way.
> 
> For BBM 2 if the HW lookup gets more than one result the HW selects
> one unpredictably and uses that.
> 
> Permissions shouldn't have any impact because they do not effect how
> the lookup is performed, they are the result of the lookup.

Totally agree with all of this! But ideally we want the Arm ARM to be
unambiguous so that we can implement against that rather than against our
understanding of the HW issues and what the Arm ARM "almost certainly intended".

> 
> I've been looking at implementing BBM 2 support on the iommu side and
> I didn't see anything that said we cannot do arbitary transformations
> under BBM 2? For instance when degrading from a contiguous range of
> block descriptors down to single page descriptors I'm expecting to go
> like:
>     16x2M -> 2M -> 4k -> FLUSH

If this is just changing sizes, it's definitely, explcitly safe in the Arm ARM
(I haven't read the equivalent SMMU text). And there isn't a requirement to
flush at the end. You only need to flush the (sub-)ranges where permissions or
whatever have changed.

> 
> Jason

