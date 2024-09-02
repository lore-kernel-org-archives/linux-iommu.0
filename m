Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3221D6C75
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277828; cv=none; b=WS0NjlijZp6kbaFHtlcHE3KPSxOhNUXi3ToKDddre1EhJk+tac9m8BCkMRclm+y4nMdVcqCQ98LdM2+MaZ5m4+UJCun5uMxEA4Ssr8cPusnKlAOEQs53WTzCal3eMu/QxM1pCFa/G92Ra+5PFwpSIE1rbqq+a/7Ef0NCy4/YOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277828; c=relaxed/simple;
	bh=S6LYPGhjlejPA/K8wev/xGYeCjz1LCUfIcF2IcVAwpE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qjIXz6agKp+jzjihgE1DGoIICfHAN5rf2G6kjF0LXTSF4zbcV9pgZVoPGsQDgN2ezPlHUeIXONARaJppkwpCoNk3HTG+G5gGJV8VtxlnJRiXO5KrVM99fVrtjlhlQ95sGBoyig31AP0VU+VCyHMoin1xcL5BJJp/eTaQzc92WzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzmZd+1H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzmZd+1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277826; x=1756813826;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S6LYPGhjlejPA/K8wev/xGYeCjz1LCUfIcF2IcVAwpE=;
  b=IzmZd+1H+1Y9frULNcSTk9QrDuncEFmRb57BVBhjLYwvH3lBSgdcCfCx
   a7oUChwa4CAkXCDorBJIIN5X66W4vH63cKnPzrhhcKXijJwiuY4whXi9h
   2JLraVXA16WfC8epi7S69XJfYstgSVovwHpDONp+ZdWgMHchocq9o8p6f
   4onQX5IggKgwsY5n5eeC6zcYnNLuQitZXTIm+JdBJL33QzQZZYlaG40/p
   kr5wyFIe9C94ar97pVbI+vT0FLFqoqfJqLLgcDvnKeT4pCuZBAvXBfSxB
   WsYeY5I/RDpbFCHYdmzddTA4W+9xQYG+YzO25V6PAOg92JfF3RcIE9jGW
   w==;
X-CSE-ConnectionGUID: Sz6fMvSXTk2lGEuh+5H25A==
X-CSE-MsgGUID: Y4EXZDbfRI+6jg5kWbOGfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41330839"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41330839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:50:25 -0700
X-CSE-ConnectionGUID: FH9YAJgiTpKDyCQzz56mXQ==
X-CSE-MsgGUID: 2eGZ+HUaSU6e9/HVPwFNQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64267665"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:50:23 -0700
Message-ID: <03b62ac1-7d7e-4267-b55c-1b57651f55be@linux.intel.com>
Date: Mon, 2 Sep 2024 19:50:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
To: "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>
References: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527638BC2FD50C4D90508D578CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240724092540.6ef4d28a@jacob-builder>
 <BL1PR11MB5271D3D84F93BA16852233F98CAB2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240725141111.6889dd62@jacob-builder>
 <BN9PR11MB52766AC7AEFA103E5B1D067B8CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240725194159.41192480@jacob-builder>
 <BN9PR11MB52757A48BE716BECB20FB240CA922@BN9PR11MB5275.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52757A48BE716BECB20FB240CA922@BN9PR11MB5275.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/2 13:44, Kumar, Sanjay K wrote:
> Sorry, just catching up with emails.
> I noticed another thing.
> In qi_submit_sync() input parameters, when the count is 0, the expectation should be that desc should be NULL right?
> In that case, the below code will cause a problem.
> 
> type = desc->qw0 & GENMASK_ULL(3, 0);
> 
> The above line requires caller (when calling with count = 0) to pass a fake non-NULL desc pointer. Should we fix this as well? Alternatively, we can fix it whenever we create the use case of caller calling with count=0.

No worries, Sanjay. I will take care of this later. This is actually not
a fix, but rather an extension of the helper to support a new use case
(count=0).

Thanks,
baolu

> 
> Thanks,
> Sanjay
> 
> -----Original Message-----
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 25, 2024 7:42 PM
> To: Tian, Kevin <kevin.tian@intel.com>
> Cc: iommu@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>; Lu Baolu <baolu.lu@linux.intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Zhang, Tina <tina.zhang@intel.com>; Kumar, Sanjay K <sanjay.k.kumar@intel.com>; jacob.jun.pan@linux.intel.com
> Subject: Re: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
> 
> 
> On Fri, 26 Jul 2024 00:18:13 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> wrote:
> 
>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Sent: Friday, July 26, 2024 5:11 AM
>>>>>>> @@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu
>>>>> *iommu,
>>>>>>> struct qi_desc *desc,
>>>>>>>   		raw_spin_lock(&qi->q_lock);
>>>>>>>   	}
>>>>>>>
>>>>>>> -	for (i = 0; i < count; i++)
>>>>>>> -		qi->desc_status[(index + i) % QI_LENGTH] =
>>>>>>> QI_DONE;
>>>>>>> +	/*
>>>>>>> +	 * The reclaim code can free descriptors from multiple
>>>>>>> submissions
>>>>>>> +	 * starting from the tail of the queue. When count ==
>>>>>>> 0, the
>>>>>>> +	 * status of the standalone wait descriptor at the
>>>>>>> tail of the queue
>>>>>>> +	 * must be set to QI_TO_BE_FREED to allow the reclaim
>>>>>>> code to proceed.
>>>>>>> +	 */
>>>>>>> +	for (i = 0; i <= count; i++)
>>>>>>> +		qi->desc_status[(index + i) % QI_LENGTH] =
>>>>>>> QI_TO_BE_FREED;
>>>>>>
>>>>>> We don't really need a new flag. Just set them to QI_FREE and
>>>>>> then reclaim QI_FREE slots until hitting qi->head in
>>>>>> reclaim_free_desc().
>>>>> We do need to have a separate state for descriptors pending to
>>>>> be freed. Otherwise, reclaim code will advance pass the intended range.
>>>>>   
>>>>
>>>> The commit msg said that QI_DONE is currently used for conflicting
>>>> purpose.
>>>>
>>>> Using QI_FREE keeps it only for signaling that a wait desc is
>>>> completed.
>>>>
>>>> The key is that reclaim() should not change a desc's state before
>>>> it's consumed by the owner. Instead we always let the owner to
>>>> change the state and reclaim() only does scan and adjust the
>>>> tracking fields then such race condition disappears.
>>>>
>>>> In this example T2's slots are changed to QI_FREE by T2 after it
>>>> completes all the checks. Only at this point those slots can be
>>>> reclaimed.
>>>
>>> The problem is that without the TO_BE_FREED state, the reclaim code
>>> would have no way of knowing which ones are to be reclaimed and
>>> which ones are currently free. Therefore, it cannot track free_cnt.
>>>
>>> The current reclaim code is not aware of owners nor how many to reclaim.
>>>
>>> If I make the following changes and run, free_cnt will keep going up
>>> and system cannot boot. Perhaps you meant another way?
>>>
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu
>>> *iommu)
>>>    */
>>>   static inline void reclaim_free_desc(struct q_inval *qi)  {
>>> -       while (qi->desc_status[qi->free_tail] == QI_TO_BE_FREED) {
>>> -               qi->desc_status[qi->free_tail] = QI_FREE;
>>> +       while (qi->desc_status[qi->free_tail] == QI_FREE) {
>>>                  qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
>>>                  qi->free_cnt++;
>>
>> Here miss a check to prevent reclaiming unused slots:
>>
>> 		if (qi->free_tail == qi->free_head)
>> 			break;
>>
>> In the example flow reclaim_free_desc() in T1 will only reclaim slots
>> used by T1 as slots of T2 are either QI_IN_USE or QI_DONE. T2 slots
>> will be reclaimed when T2 calls reclaim_free_desc() after setting them
>> to QI_FREE, and reclaim will stop at qi->free_head.
>>
>> If for some reason T2 completes earlier than T1. reclaim_free_desc()
>> in T2 does nothing as the first slot qi->free_tail belongs to T1 still
>> IN_USE. T2's slots will then wait until reclaim is triggered by T1 later.
>>
> This makes sense. Unlike the original code, we now only allow freeing the submitter's own descriptors.
> 
>>>          }
>>> @@ -1466,10 +1465,10 @@ int qi_submit_sync(struct intel_iommu
>>> *iommu, struct qi_desc *desc,
>>>           * The reclaim code can free descriptors from multiple
>>> submissions
>>>           * starting from the tail of the queue. When count == 0, the
>>>           * status of the standalone wait descriptor at the tail of
>>> the queue
>>> -        * must be set to QI_TO_BE_FREED to allow the reclaim code to
>>> proceed.
>>> +        * must be set to QI_FREE to allow the reclaim code to proceed.
>>>           */
>>>          for (i = 0; i <= count; i++)
>>> -               qi->desc_status[(index + i) % QI_LENGTH] =
>>> QI_TO_BE_FREED;
>>> +               qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
>>>
>>>          reclaim_free_desc(qi);
>>>          raw_spin_unlock_irqrestore(&qi->q_lock, flags); diff --git
>>> a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h index
>>> 1ab39f9145f2..eaf015b4353b 100644
>>> --- a/drivers/iommu/intel/iommu.h
>>> +++ b/drivers/iommu/intel/iommu.h
>>> @@ -382,8 +382,7 @@ enum {
>>>          QI_FREE,
>>>          QI_IN_USE,
>>>          QI_DONE,
>>> -       QI_ABORT,
>>> -       QI_TO_BE_FREED
>>> +       QI_ABORT
>>>   };
>>>
>>> Thanks,
>>>
>>> Jacob
>>
> 
> 
> Thanks,
> 
> Jacob
> 

