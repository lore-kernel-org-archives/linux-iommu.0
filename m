Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40C28B4E2
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195551; cv=none; b=VL7HnXOyrhkhXtYBwpJB/BH2cMKaFkJzbdIJ7NtXTMrRqg2vyRq4VMWo0lc5Pgg9cdZfGazWFET18jxey0Yd4erLI3AlKAP9oNz3DJ0CqmVqkCT89fVZo8iRNXKl6JBe3vJZzpHc+Xh+Lc+gijtteqJGiD1yCmS2rXJSuVp6yV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195551; c=relaxed/simple;
	bh=N4KsE/zfUBhI/s1F4SOG5vhwAiA0/gamqK4ASaZkQcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNUG4MsGq5wLgrnr4z4oFD6z7Tw6F+aob6/hAQI5Z/z4xb+C2fStmlJNSk5NV6VWcY85x7s24iM1x2TlVY32Hsy7XCirB+P8vpaVzpiP5Cw5rQuRSH9QPY3+motklq1lA8J9vJHSDJ0xHkqEbc2oEtgKtLqW3P65But51bz3Cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYfYZiPW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYfYZiPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773195550; x=1804731550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N4KsE/zfUBhI/s1F4SOG5vhwAiA0/gamqK4ASaZkQcM=;
  b=jYfYZiPWPQI0hjHBM0eEGWCugpb/muiqwZxTnMqPoHHFCOq+QcaXZ88y
   FnSDK6d4IcDfNLnVv7jrJl2gveiHILIJb3hKeRw5yia/BwRDkzVtqNChQ
   hcqjEzmuk0ITtknpuVlP3aSvcmnVWfheWhbLebyzvH9hhDGwQVTWEAvAP
   +TsW+9hHALwuQDYumgUPvY7Zqrx1c04Y1kqdODt873pX67/TOpxrONmdN
   Q0/vK7m3xi8p2+k4epI6anWtp/rodnLsC69wabnemy5LVg81xkyKo3Zbp
   4i8bE/ozYzwTvrCOYxU5wZge6pJNwkudWDAcV0rO77jf3DPS6EIZK/uXv
   Q==;
X-CSE-ConnectionGUID: c/SrvpHQSd6RK+n6eWRogg==
X-CSE-MsgGUID: assWDq/jTaCcKeE1UFKD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74154197"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74154197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:19:06 -0700
X-CSE-ConnectionGUID: LwmHeLn+Tn+FD1lKmIrfFw==
X-CSE-MsgGUID: aQydXn9JSOatHqeZ3aKreA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225270853"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:19:02 -0700
Message-ID: <8b71a63c-9374-4a7e-95f3-85399ccec84b@linux.intel.com>
Date: Wed, 11 Mar 2026 10:18:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
To: Shuai Xue <xueshuai@linux.alibaba.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
 <92f15414-3f8a-49c7-80e9-408703e41ab5@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <92f15414-3f8a-49c7-80e9-408703e41ab5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/26 20:59, Shuai Xue wrote:
> On 3/6/26 6:15 PM, Guanghui Feng wrote:
>> During the qi_check_fault process after an IOMMU ITE event,
>> requests at odd-numbered positions in the queue are set to
>> QI_ABORT, only satisfying single-request submissions. However,
>> qi_submit_sync now supports multiple simultaneous submissions,
>> and can't guarantee that the wait_desc will be at an odd-numbered
>> position. Therefore, if an item times out, IOMMU can't re-initiate
>> the request, resulting in an infinite polling wait.
>>
>> This patch modifies the process by setting the status of all requests
>> already fetched by IOMMU and recorded as QI_IN_USE status (including
>> wait_desc requests) to QI_ABORT, thus enabling multiple requests to
>> be resubmitted.
>>
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index d68c06025cac..69222dbd2af0 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu 
>> *iommu, int index, int wait_index)
>>       if (fault & DMA_FSTS_ITE) {
>>           head = readl(iommu->reg + DMAR_IQH_REG);
>>           head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>> -        head |= 1;
>>           tail = readl(iommu->reg + DMAR_IQT_REG);
>>           tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>> @@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu 
>> *iommu, int index, int wait_index)
>>           do {
>>               if (qi->desc_status[head] == QI_IN_USE)
>>                   qi->desc_status[head] = QI_ABORT;
>> -            head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>> +            head = (head - 1 + QI_LENGTH) % QI_LENGTH;
>>           } while (head != tail);
>>           /*
> 
> Hi, all
> 
> I hacked IOMMU driver to submit a duplicate desc to trigger the bug:
> 
> @@ -1435,6 +1463,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
> struct qi_desc *desc,
>          s64 iec_start_ktime = 0;
>          struct qi_desc wait_desc;
>          int wait_index, index;
> +       int dup_slot = -1;
>          unsigned long flags;
>          int offset, shift;
>          int rc, i;
> @@ -1466,7 +1495,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
> struct qi_desc *desc,
>           * the calculation is based on:
>           * # of desc + 1 wait desc + 1 space between head and tail
>           */
> -       while (qi->free_cnt < count + 2) {
> +       while (qi->free_cnt < count + 3) {
>                  raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>                  cpu_relax();
>                  raw_spin_lock_irqsave(&qi->q_lock, flags);
> @@ -1476,6 +1505,24 @@ int qi_submit_sync(struct intel_iommu *iommu, 
> struct qi_desc *desc,
>          wait_index = (index + count) % QI_LENGTH;
>          shift = qi_shift(iommu);
> 
> +       /*
> +        * DEBUG HACK: force wait_index to even position to reproduce the
> +        * ITE qi_check_fault bug where "head |= 1" causes the traversal
> +        * to skip even-indexed wait_desc. Duplicate desc[0] as an extra
> +        * submission when wait_index would be odd, so it stays harmless
> +        * (same request type, same content, just redundant).
> +        */
> +       if (wait_index & 1) {
> +               dup_slot = index;
> +               offset = index << shift;
> +               memcpy(qi->desc + offset, &desc[0], 1 << shift);
> +               qi->desc_status[index] = QI_IN_USE;
> +               index = (index + 1) % QI_LENGTH;
> +               qi->free_head = index;
> +               qi->free_cnt--;
> +               wait_index = (index + count) % QI_LENGTH;
> +       }
> +
>          for (i = 0; i < count; i++) {
>                  offset = ((index + i) % QI_LENGTH) << shift;
>                  memcpy(qi->desc + offset, &desc[i], 1 << shift);
> @@ -1532,6 +1579,8 @@ int qi_submit_sync(struct intel_iommu *iommu, 
> struct qi_desc *desc,
>           */
>          for (i = 0; i <= count; i++)
>                  qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
> +       if (dup_slot >= 0)
> +               qi->desc_status[dup_slot] = QI_FREE;
> 
> When head is odd and tail is even, qi_check_fault will loop infinitely
> in the abort loop without this patch, since step -2 only visits
> odd-indexed slots and never reaches the even-valued tail. With step -1,
> the loop correctly visits all slots and terminates as expected.
> 
>      DMAR: VT-d detected Invalidation Time-out Error: SID 603
>      DMAR: QI HEAD: Invalidation Wait qw0 = 0x200000025, qw1 = 0x100364878
>      DMAR: DRHD: handling fault status reg 40
>      DMAR: QI PRIOR: Device-TLB Invalidation qw0 = 0x600060300000003, 
> qw1 = 0x7ffffffffffff001
>      DMAR: Invalidation Time-out Error (ITE) cleared
>      DMAR: ITE debug: head=29 tail=32 wait_index=32
>      DMAR: ITE debug: after loop, desc_status[wait_index=32]=2
> 
> Free free to add:
> 
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

I will queue this for v7.0-rc. Thank you!
