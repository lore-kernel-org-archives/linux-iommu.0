Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3540B10C
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801853; cv=none; b=APzZQiugBjFTZe6EIfQqJHmLod1HXRMqOzZR5BBlc1kqGlnJHmLB5RdFtPzZJW8PScKMB0R8SoK+rrVZyOirfx7k021b1i8FvGHDdKAId71WVrtFOZwYVDdwGTUPJlCjjLycFMiKvx+EL1v/d9RCKKTuO+p43ncm6I//omD/Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801853; c=relaxed/simple;
	bh=L1m3MUf9HdB6smbydn/5kyJHGKIZREc1qWiC8Gfmw2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eR9whBWb2xZats1OT4yzTgs3zD5PrFd+KyIbdxv3Yz4ku/Gj+R0smNoYTSxQ9MPc7iljQN+RnDNP7YyikrSAf0KjX36ayZApmwUOU7rwKicif64883RxIaNaUeWrg5Uz0N5G5Wfb75XTz0Gj9yhLCURt1EOpzyrzxQUrOR83JbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dDm9HslZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dDm9HslZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397561477;
	Thu, 23 Jul 2026 03:17:27 -0700 (PDT)
Received: from [10.57.84.160] (unknown [10.57.84.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26FD13F86F;
	Thu, 23 Jul 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784801851; bh=L1m3MUf9HdB6smbydn/5kyJHGKIZREc1qWiC8Gfmw2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dDm9HslZhm45IuPb1j5hpjkORQpy9s/ibxROOurSfSxxTLupEUTjDIM3R+MiA7P3b
	 FeQUE7b5KDyyhVy0cjpTZGBE87mN8YsakvXmD6uUF0bDmF2sHHLZIzrP90P8GT+seF
	 rkleTBScwDj7RkXQo3F8sIfE+lfvTQbwjsTBocrE=
Message-ID: <2772e7ec-9310-4669-83dd-b0fd9d4f8b6e@arm.com>
Date: Thu, 23 Jul 2026 11:17:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: fix grammar in comments
To: Will Deacon <will@kernel.org>, weimin xiong <15927021679@163.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
 xiongweimin <xiongweimin@kylinos.cn>
References: <20260714024502.188501-1-15927021679@163.com>
 <amE5CSp8bTSjm-ii@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <amE5CSp8bTSjm-ii@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-07-22 10:41 pm, Will Deacon wrote:
> On Tue, Jul 14, 2026 at 10:45:02AM +0800, weimin xiong wrote:
>> From: xiongweimin <xiongweimin@kylinos.cn>
>>
>> Clarify two slightly mangled DMA-IOMMU mapping comments.
>>
>> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
>> ---
>>   drivers/iommu/dma-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 9abaec070..2c28b951f 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1489,7 +1489,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   		 *   based purely on segment lengths without needing to know
>>   		 *   the actual addresses beforehand.
>>   		 * - The mask must be a power of 2, so pad_len == 0 if
>> -		 *   iova_len == 0, thus we cannot dereference prev the first
>> +		 *   iova_len == 0, thus we cannot dereference prev, the first
> 
> I don't think adding the extra comma makes much sense here:        ^.

Indeed, "the first time through here" is not a separate clause, it makes 
no grammatical sense on its own. The existing sentence is correct.

("it the address" does appear to be botched editing on my part though, 
oops!)

Thanks,
Robin.

(Whose email provider sends 163.com and various other domains straight 
to /dev/null, not even quarantine...)

> I'll hoover up your other typo fixes onto their own 'typo' branch and
> leave it up to Joerg as to whether he decides to apply/squash/ignore
> them.
> 
> Will

