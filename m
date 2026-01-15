Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860129ACC6
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447609; cv=none; b=pCFzcGT5lcZuhEeTVHpmlt07LPdxid5tKO8ItvkNasf0SwJWrT5KL9p3cxMsRpGad+InDFOCLS5gd9yj20C+yf9Ow3mNc3CSHo+B307mJkOE1KFb/R5a2hVuKrgETEFRg1JopBOYQWHRONlRg5XTgZcenBR5mXLFkhziyOjDCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447609; c=relaxed/simple;
	bh=Oe+gaZZ6grkVr27jqZrZV1xRAtQa0X5snW3MPucT+mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiHC6PIL16TtYcAuY6jGPdxy92KYRfQw2TxWJyBC4trr6GA6Uz+geViJR3oGoSdTr/k7slgV8c6KrdNqqXwKb9mCf5z1YJ0IYMLaAXi81C/Mp7rRcXQTOItb62pzNaxQH4JZC1YdBTG95elrOd0a3vK7+7qm16TUWBAvVjOZDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmooTGof; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmooTGof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768447608; x=1799983608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oe+gaZZ6grkVr27jqZrZV1xRAtQa0X5snW3MPucT+mY=;
  b=FmooTGof2lRuF0bj7qmAgnAmIxMEMeymWwL2Irj6U14rUASQiDTesgAA
   JACOBuw+y0IXsZxxOB2+fHNUmUD5RB1J7Ji6zuT2cQFdcp8a+sUvLQFak
   oBZazqtWF7iFSNZYle0EhvmzFs6ehVC6vQb9IBevbdsHoO7ZF9vXFj1SL
   Mmw8dOFtngQJGoPXdmj6rT58EI/6NUZVFc0MtLQcgNDimbQSBms9a7tPP
   crpM91Iqx+Nd/GkKseVyw3Na/Xg9m9kjACzFn1B39ja79+OJpFI+s9hUQ
   RSeUbN0CtZEOi3p8fRgK05V7KZT2VSybC5hneKiQ0tu6iOHso/4xm71dN
   g==;
X-CSE-ConnectionGUID: 4v6w6Dq4QUWubRhsxL+ZqQ==
X-CSE-MsgGUID: VRvURpzvTCKcLk3+CeWL4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87165039"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="87165039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 19:26:48 -0800
X-CSE-ConnectionGUID: 88hg6QZzRkmymDD4NacBgg==
X-CSE-MsgGUID: jwxD2HRjR72Frcg0fvqn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="236105173"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 19:26:45 -0800
Message-ID: <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
Date: Thu, 15 Jan 2026 11:26:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 15:54, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, January 13, 2026 11:01 AM
>>
>> On Intel IOMMU, device context entries are accessed by hardware in
>> 128-bit chunks. Currently, the driver updates these entries by
>> programming the 'lo' and 'hi' 64-bit fields individually.
>>
>> This creates a potential race condition where the IOMMU hardware may
>> fetch
>> a context entry while the CPU has only completed one of the two 64-bit
>> writes. This "torn" entry — consisting of half-old and half-new data —
>> could lead to unpredictable hardware behavior, especially when
>> transitioning the 'Present' bit or changing translation types.
> 
> this is not accurate. context entry is 128bits only. Scalable context
> entry is 256bits but only the lower 128bits are defined. so hardware always
> fetches the context entry atomically. Then if software ensures the right
> order of updates (clear present first then other bits), the hardware won't
> look at the partial entry after seeing present=0.
> 
> But now as Dmytro reported there is no barrier in place so two 64bits
> updates to the context entry might be reordered so hw could fetch
> an entry with old lower half (present=1) and new higher half.
> 
> then 128bit atomic operation avoids this ordering concern.

You're right. I will update the commit message to be more precise. Since
the hardware fetches the 128-bit context entry atomically, the issue is
essentially a software ordering problem.

We considered three approaches to solve this:

- Memory barriers (to enforce Present bit clearing order)
- WRITE_ONCE() (to prevent compiler reordering)
- 128-bit atomic updates

This patch uses the atomic update approach.

> 
>> @@ -1170,19 +1170,19 @@ static int domain_context_mapping_one(struct
>> dmar_domain *domain,
>>   		goto out_unlock;
>>
>>   	copied_context_tear_down(iommu, context, bus, devfn);
>> -	context_clear_entry(context);
>> -	context_set_domain_id(context, did);
>> +	context_set_domain_id(&new, did);
> 
> I wonder whether it's necessary to use atomic in the attach path, from
> fix p.o.v.
> 
> The assumption is that the context should have been cleared already
> before calling this function (and following ones). Does it make more
> sense to check the present bit, warning if set, then fail the operation?
> We could refactor them to do atomic update, but then it's for cleanup> instead of being part of a fix.

Yes. For the attach path, this is a cleanup rather than a fix.

> 
> Then this may be split into three patches:
> 
> - change context_clear_entry() to be atomic, to fix the teardown path
> - add present bit check in other functions in this patch, to scrutinize the
>    attach path
> - change those functions to be atomic, as a clean up

Perhaps this also paves the way for enabling hitless replace in the
attach_dev path?

> Does it make sense?

Yes, it is.

Thanks,
baolu
