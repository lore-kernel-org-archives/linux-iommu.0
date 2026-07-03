Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74C285061
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105118; cv=none; b=SXsJlxISXlDpoENG8qNpAUvMdHpZe1q5zebjGk6p0sFfwbQPHXPhzRHJ6VKLZuM+AuBC+qUpemkt3f2SI4gYrv2Em9LjgeRK2NlyX301PUxLEp2AwDgLur8WE36gEIdUt3Q+IMFRfnop/eTtRNzsgfsSHERg2H2Ro8G/1Iyfqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105118; c=relaxed/simple;
	bh=eJi3Q668y9RAPTvxGdrmsu4bbQ/DxsV+6g+FezUkJLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVjKiCbJZHSbxwT9Y91DzjTHfcX/+iT/k8+Z0ImxKFDc8SqxTfu6p89My85Qe3BJvjsddWj/D2hk7u082wU15goxnNHcopziemNFk4myyd6Htj3HU1iWrt4kcKrDah4WrqjYMOdDypEzDXOxnFnH9NBaDsLawrHjhAZzVEFVO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XE7CPE5M; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XE7CPE5M"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53471756;
	Fri,  3 Jul 2026 11:58:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6348A3F905;
	Fri,  3 Jul 2026 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783105116; bh=eJi3Q668y9RAPTvxGdrmsu4bbQ/DxsV+6g+FezUkJLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XE7CPE5MdLDFjPysJeNjbm56qsnl/g7p4caBxL49moaNJ8FjVu9pvtO+g+sItZO1a
	 M0c8apqFxgI3llPzzC9FgK/HOZzcjhOlNNLMsp/Z0vrDdddNLxgQ/hC8moCoEuhyOY
	 ksTufc2hx7lIKBU3LHszq3cPrKRBfccmqELbFOg4=
Message-ID: <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
Date: Fri, 3 Jul 2026 19:58:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, =?UTF-8?Q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260703162236.GX7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2026 5:22 pm, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
>> It is possible, when a very large mapping uses a single
>> scatterlist, that padding overflows scatterlist's length field.
>> This results in:
>>   1) silently wrapping the value
>>   2) smaller than desired mappings produced by iommu_map_sg
>>   3) leaving mapped bytes in memory (no iommu_unmap)
>>
>> Address this issue by adding overflow detection for previous
>> scatterlist length field.
> 
> Urk, this is unfortunate, it means we cannot map certain kinds of
> scatterlists? Meaning there is a condition that makes a scatterlist
> ill formed?
> 
> This seems like something that needs to be more clearly documented and
> we need to ensure at least the common scatterlist builders don't hit
> it..

Well, it's taken 10 years to be caught by a test which seemingly expects 
the mapping of a single absurdly giant scatterlist to fail anyway, so 
combined with the great urgency to get rid of scatterlists, I hardly see 
it being a big deal... This will always have returned an error due to 
the "ret < iova_len" condition at the end, the fix just means we can now 
error out earlier without passing a mangled list to iommu_map_sg() and 
corrupting the pagetable in the process.

Certainly if a list was initially malformed with an individual segment 
longer than the segment boundary mask then it's not going to do any 
favours here, but I suspect this is likely just regular iova_granule 
rounding overflowing when the segment boundary is the maximum 4GB, since 
the largest representable segment length is 4GB - 1. Note the 
off-by-an-exact-multiple-of-4GB error in Krzysztof's logging from the v1 
thread:

[   79.915571] iommu_dma_map_sg: ret = 7138717696, iova_len = 20023619584

Quite simply this code was never written with the expectation of mapping 
4GB+ of _physically contiguous_ memory in one go. We could possibly try 
adding a bunch of special-case complexity to allow treating UINT_MAX as 
4GB through iommu_map_sg() if there was a real need to make something 
which never worked start working, but going back to my initial point, it 
really doesn't seem worth the bother.

Thanks,
Robin.

>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9abaec0703ef..c403057577df 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   		 *   time through here (i.e. before it has a meaningful value).
>>   		 */
>>   		if (pad_len && pad_len < s_length - 1) {
>> -			prev->length += pad_len;
>> -			iova_len += pad_len;
>> +			if (overflows_type(prev->length + pad_len, prev->length)) {
>> +				/*
>> +				 * For large mappings spanning multiple GBs we
>> +				 * may not be able to fit all needed padding into
>> +				 * sg->length.
>> +				 */
>> +				ret = -EOVERFLOW;
>> +				goto out_restore_sg;
>> +			} else {
>> +				prev->length += pad_len;
>> +				iova_len += pad_len;
>> +			}
> 
> It is better to use
>    check_add_overflow(prev->length, pad_len, &prev->length)
> 
> instead of overflows_type()..
> 
> Jason

