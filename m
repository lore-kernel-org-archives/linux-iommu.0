Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D45481674
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329001; cv=none; b=kcOnbVCO1l1XIlcFtnfUKl8aX6ejhfG/73iFbcwR3qBS9FhmLSkMWeInb6q4OVU3QAxfXb673QpJi9CVDNMVcnCxdDJvL+IYM/y1wgFsOAm3FNpSpVxe+RTHuqP0Gkr0tDdzn7UapvSzNZfAl26Ikawst8vHB4GqZBq0R891sMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329001; c=relaxed/simple;
	bh=WQuy6wDcjMkD2ClUQsZ/7ZMCTaygWPENfKsVb3uRDfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrbSoZQHALAofDu3lykjKZRdTrvft+sWfw6MtYx/n0R29UxFDYqETXMM+Ogptm2ui7/Zla6LPrNxwQqpp6NzlWogMsFyKleilbB7JTG6isjwls8HwhE5EvXhxxTUSqDtIko6m7UFSDiJu0K3Nmva6/efW201S8IQ3FIxBRgoi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cza126NN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cza126NN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 957571684;
	Wed, 29 Jul 2026 05:43:10 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970013F66F;
	Wed, 29 Jul 2026 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785328994; bh=WQuy6wDcjMkD2ClUQsZ/7ZMCTaygWPENfKsVb3uRDfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cza126NNeWRrJvg3V4NcGUBbwBV+9Z9nCo1So7P8Rht1Ta/l9Pav8RDYgc08M10HT
	 QPHuLOBp87wGZOCGd79CK7eQ8zq+F3UcF2zW8QJGhHsxpx6JbjdRV4VzGLhNh+Iq82
	 ahablYuII2UapL3ll2JkPs5goXnlDYIpWA0Kiknw=
Message-ID: <766354f0-968e-4bb3-a824-589398174d1f@arm.com>
Date: Wed, 29 Jul 2026 13:43:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-3-krzysztof.karas@intel.com>
 <DKB1JMBPFCNM.2PUIUI31WOCHF@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DKB1JMBPFCNM.2PUIUI31WOCHF@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2026 1:07 pm, Sebastian Brzezinka wrote:
> Hi,
> On Thu Jul 23, 2026 at 12:25 PM CEST, Krzysztof Karas wrote:
>> It is possible, when a very large mapping uses only one
>> scatterlist, that padding overflows scatterlist's length field.
>> This results in:
>>   1) silently wrapping the value
>>   2) smaller than desired mappings produced by iommu_map_sg
>>   3) leaving mapped bytes in memory (no iommu_unmap)
>>
>> Address this issue by adding overflow detection for scatterlist
>> length field.
>>
>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
>> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> v4:
>>   * Added value wrap check before s->length assignment (Robin);
>>
>>   drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 381b60d9e7ce..3ca3196a41b0 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/iommu-dma.h>
>>   #include <linux/iova.h>
>>   #include <linux/irq.h>
>> +#include <linux/limits.h>
>>   #include <linux/list_sort.h>
>>   #include <linux/memremap.h>
>>   #include <linux/mm.h>
>> @@ -1477,6 +1478,12 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   		sg_dma_len(s) = s_length;
>>   		s->offset -= s_iova_off;
>>   		s_length = iova_align(iovad, s_length + s_iova_off);
>> +		if ((s_length & UINT_MAX) == 0) {
> Might be better to go with  s_length > UINT_MAX . Right now it's 64 &
> 32, so only the lower bits count. Or just ignore this comment  it if
> it's intended.

Yes, this code also needs to support 32-bit size_t, wherein the overflow 
already happens within the calculation of s_length itself.

Thanks,
Robin.
