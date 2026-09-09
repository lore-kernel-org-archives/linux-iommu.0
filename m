Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40C3DAAD2
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938044; cv=none; b=V7Q584RPIPHM5XhJQlHgSlrCcKIyh7s00MP0TCCOWq90Mmv+AUZwwiRSp29Z+lyJYpA6ViGp1/UW4mNbcxrn6z0JC0LoL9+v+dA0Mqq8Z5xWlcQD2nAk+AC1n76O/IjL0EBUQs2INDL8c98sEPAEgMowjjtGdoSdJS2yB7FPJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938044; c=relaxed/simple;
	bh=pTMV8fyt1QMv7TPyA7sTvTbRWstXxWaf1lFnzxWIXVg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KkPfpEa5LXZ5X01CZEb3vCAUbuIyjD6dW/eo6YIHIPkKqrjCucdWmcXxcbLnJzuYfEp9nf4PRNmgUNziHA8sZHWkq8oVRv6VJ5Xj07mRZ7o4/C/NIJhS0Ii7UouR5Ne970iJ/StJuHVdWOVrrrZ0f5fYa4X3Zw5knlPAPIZISZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShjKNXgz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShjKNXgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788938043; x=1820474043;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=pTMV8fyt1QMv7TPyA7sTvTbRWstXxWaf1lFnzxWIXVg=;
  b=ShjKNXgzgmIxIyV4VnCIVZ30g443kvcUxmPd+2ydgp9ElwPa2TylHi9g
   Ps4LSZmBmKBYEZnHdz88YJudKdS3CG3YyudQFYtm0W8D6mthIWUpDf50a
   Dxn55z3fsMr4/zxsipuy3XWzGZe5NCcwzGulgPtHT3pKBhTEtzakPZZaW
   uegDvGCwIcD4SFEHHUYx2UoRM435NztiFOF3Cx6knaBwCcPKpD36WTsed
   kvjXH/AREpo0u4V9qjUyTzkHBFttfM5vu6BpV7Yn1IIp1neZg2U5PHljK
   oTZLNNiEjPnjmbAcQTOGEn0gCYFSeL2BVyiRoG6MVAAtjPe0yQxZnQ98F
   A==;
X-CSE-ConnectionGUID: e9tBzP6QTF6PBJDw/Ahxcg==
X-CSE-MsgGUID: tabRRgV2SIqDnUqPEj0dvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106869272"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106869272"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:13:51 -0700
X-CSE-ConnectionGUID: 6C6fvPOdTdStR5JgemI8ZA==
X-CSE-MsgGUID: +CDBPrG5QMmd9Ze15oNBhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271725792"
Received: from unknown (HELO [10.238.1.188]) ([10.238.1.188])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:13:50 -0700
Message-ID: <2c0d1b6d-6844-4413-b399-1000cc6712e4@linux.intel.com>
Date: Wed, 9 Sep 2026 15:13:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 "bikuan . zbk" <bikuan.zbk@alibaba-inc.com>
Subject: Re: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in
 submission range
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
References: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
 <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>
 <71fbf215-44d7-47ee-8547-a350d4f700b1@linux.intel.com>
Content-Language: en-US
In-Reply-To: <71fbf215-44d7-47ee-8547-a350d4f700b1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/2026 10:56 AM, Baolu Lu wrote:
> On 8/20/26 22:47, Guanghui Feng wrote:
>> Currently, qi_check_fault() only handles IQE (Invalidation Queue Error)
>> when the faulting descriptor index exactly matches the first descriptor
>> of the current submission (head == index). This is too restrictive in
>> multi-descriptor submissions where the error could occur at any
>> descriptor within the batch.
>>
>> If the IQE is triggered by a descriptor that belongs to the current
>> submission but is not at the starting index, the function returns 0
>> without clearing the IQE fault status. Since hardware stops fetching
>> new descriptors until IQE is cleared, this leads to an indefinite wait
>> on the wait descriptor completion - effectively a deadlock.
>>
>> Fix this by expanding the IQE handling condition to cover all descriptors
>> within the circular range [index, wait_index]. Use explicit bounds
>> checking that properly handles the wrap-around case of the circular
>> queue.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index ba675b08cd20..ecc95af06f61 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1366,8 +1366,21 @@ static int qi_check_fault(struct intel_iommu 
>> *iommu, int index, int wait_index)
>>        * is cleared.
>>        */
>>       if (fault & DMA_FSTS_IQE) {
>> +        int head_idx;
>> +
>>           head = readl(iommu->reg + DMAR_IQH_REG);
>> -        if ((head >> shift) == index) {
>> +        head_idx = head >> shift;
>> +
>> +        /*
>> +         * The faulting descriptor can be anywhere within the current
>> +         * submission's range [index, wait_index]. Since the queue is
>> +         * circular, this submission may wrap around QI_LENGTH
>> +         * (index > wait_index in that case), so check both the
>> +         * non-wrapped and wrapped cases of the range.
>> +         */
>> +        if (index <= wait_index ?
>> +            (head_idx >= index && head_idx <= wait_index) :
>> +            (head_idx >= index || head_idx <= wait_index)) {
>>               struct qi_desc *desc = qi->desc + head;
>>               /*
> 
> Could you also please take a look at the comments from Sashiko?
> 
> https://sashiko.dev/#/patchset/20260805042012.2363698-1- 
> guanghuifeng%40linux.alibaba.com
> 
> https://sashiko.dev/#/patchset/20260820144741.920858-1- 
> guanghuifeng%40linux.alibaba.com

I think some points from the Sashiko review are valid, and we should
address them.

For example,

"
When an IQE is cleared and -EINVAL is returned, hardware is unhalted and
continues processing the rest of the abandoned batch. If another
descriptor in that batch faults, hardware halts again. Since the
original thread already returned -EINVAL and left its wait loop, a new
thread checking faults may compare that new IQE against its own
unrelated [new_index, new_wait_index] range, miss the fault, and leave
hardware permanently deadlocked.
"
and

"
When the wait loop aborts, qi_submit_sync() immediately marks the batch
slots as QI_FREE and reclaims them. But hardware may still be processing
descriptors from that batch asynchronously. Reusing those slots too
early allows concurrent overwrite, and hardware can then fetch corrupted
descriptors.
"

So it seems safer to overwrite all remaining slots in the failed batch
(starting from the faulting slot) with a wait descriptor (effectively a
no-op), then wait until hardware consumes them, and only then return
-EINVAL and let the caller abandon the batch.

As for the question, “...what if the hardware returns a large or
negative value?”, the IQ head register is in the root complex and is
expected to remain accessible as long as the platform is operational.

Thanks,
baolu
