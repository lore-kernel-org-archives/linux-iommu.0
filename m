Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679535F165
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994661; cv=none; b=CUmDqpRvb8LBnzfHAt9ehOME/zSYxtSlSADJf0dyCz/8LI89FU6gusBCDuJH4AF8ln0reQEW//vk5dWDJWTJy5nRiQoNO0/GHGO4lRDtPeC4Gm9M6H08nJQtH2aY5Yi9kiWRuf32PVQgGqp3AMQpJZFPWaxiUFNXJN+1iwuUcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994661; c=relaxed/simple;
	bh=Wnn2Ksvw76sAIUTT1KSmFOtvZNloFjX2aZnafzdf1UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+yWjm4HcuOVT+JOGyKxt/NK1cdnvO0lAoFDGcnjBpjTJnnqQ6KMU/ymOVUCQWBnPGi9E/5zvw8vwQQTHjCvabGh56rtzaN2apvUmLlQC5taXIb5prKhejQL0yy3a7Di85xIcDrre44+o75yOXlOTSvWX6nizMLgk7S2myHBEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vK6IYk9g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vK6IYk9g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CA01D15;
	Thu,  2 Jul 2026 05:17:33 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4353F905;
	Thu,  2 Jul 2026 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782994658; bh=Wnn2Ksvw76sAIUTT1KSmFOtvZNloFjX2aZnafzdf1UQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vK6IYk9gGV1YLFWdtmNJ138PGUigoXO6KoGAs2xhe8xYj4Ie8oxMHU7qkepIguElP
	 keKbPz8EWxK01r1MWaM243c/uNeghukm+UWDWB2botZRsvuycY5oypm60m1JLQns60
	 R3uaSZGvWVURylQgZg0iJQivMo/r2FericMoXnDM=
Message-ID: <73b486cb-e082-4c3e-a193-6629960efede@arm.com>
Date: Thu, 2 Jul 2026 13:17:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <b65c0f9f-184e-42fb-85dd-aa6c06dc91d8@arm.com>
 <bbh4gbq6eolkqwhcuou2fufcbpthxklb2nmawglhhxdzea6tpg@2j7xekrl64pj>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <bbh4gbq6eolkqwhcuou2fufcbpthxklb2nmawglhhxdzea6tpg@2j7xekrl64pj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2026 7:22 am, Krzysztof Karas wrote:
> Hi Robin,
> 
> thanks for a quick response!
> 
> On 2026-07-01 at 12:59:29 +0100, Robin Murphy wrote:
>> On 01/07/2026 11:44 am, Krzysztof Karas wrote:
>>> It is possible, when a very large mapping uses a single
>>> scatterlist, that padding overflows scatterlist's length field.
>>> This results in:
>>>    1) silently wrapping the value
>>>    2) smaller than desired mappings produced by iommu_map_sg
>>>    3) leaving mapped bytes in memory (no iommu_unmap)
>>>
>>> Address this issue by adding overflow detection for previous
>>> scatterlist length field.
>>
>> Awesome, thanks for figuring it out! Looks like this must date all the way
>> back:
>>
>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Okay, thanks for pinpointing this commit, I'll add the tag in
> the next version of this series.
> 
>>
>>> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>>> ---
>>> v2:
>>>    * Address overflows instead of unmapping erroneously mapped
>>>    memory (Robin).
>>>    * Put this patch last for easier reproduction of the issue.
>>>
>>>    drivers/iommu/dma-iommu.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 9abaec0703ef..c403057577df 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>>    		 *   time through here (i.e. before it has a meaningful value).
>>>    		 */
>>>    		if (pad_len && pad_len < s_length - 1) {
>>> -			prev->length += pad_len;
>>> -			iova_len += pad_len;
>>> +			if (overflows_type(prev->length + pad_len, prev->length)) {
>>> +				/*
>>> +				 * For large mappings spanning multiple GBs we
>>> +				 * may not be able to fit all needed padding into
>>> +				 * sg->length.
>>> +				 */
>>> +				ret = -EOVERFLOW;
>>> +				goto out_restore_sg;
>>> +			} else {
>>
>> Nit: we don't really need an "else" after a goto, but it's hardly a big deal
>> (however if you did want to respin, note also that the preferred title tag
>> here is "iommu/dma: ...").
> I'll be making another version anyway, so I can remove the
> "else" and change the title :)

Cool :)

>> Either way,
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Thanks!
> 
> would this r-b still hold after above minor changes, or would
> you prefer to have one final look at the finished change and
> then decide whether you give your r-b?

Indeed if it's just those tweaks then feel free to keep it, that's 
usually what I mean by "either way".

Cheers,
Robin.

> 
>>
>> I'd imagine Joerg can take this as an IOMMU fix, but FWIW if you did want an
>> ack to take it through drm-fixes to keep it with the i915 patches, I
>> wouldn't foresee any significant risk of conflicts.
>>
>> Thanks,
>> Robin.
>>
>>> +				prev->length += pad_len;
>>> +				iova_len += pad_len;
>>> +			}
>>>    		}
>>>    		iova_len += s_length;
>>
> 

