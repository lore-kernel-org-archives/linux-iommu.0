Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFA819
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717279; cv=none; b=W5x/SJpqmdsChQXMmnRmQ59zhHWOWPofduVUHOQLP+xqbbDYHD1DRQFck5QOky3yX8KZjA09Jxc4fr9o8vcO5TNLGhs9LKkb3s6uAyse04WyfnXJNiB6tulnbQDVJwzpuBgGCYJ9i/XVc1m9xRQ35qS9u1kf9a56BJtNbH/eUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717279; c=relaxed/simple;
	bh=aGYUH5HbbuTdEGmtcRd8nMDx1s4Tj/x00u0hxj3dDb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siTbNdsyl+WuoHbDm8GwDEC+Q9VJAslYBzpWTJscSGk+ivzsFnhIoZ5FGJLYE/ZkXGOerX/5QldnrCH+nmnZpYYDqyBsDixLKbKmZtIAlFgR/jW7LsJvCNhFSTMt93tFTRlGSicjOCpRlcSP335HdQ0YtMttIXQ33rsZH8kfUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi1KVM6A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi1KVM6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740717277; x=1772253277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aGYUH5HbbuTdEGmtcRd8nMDx1s4Tj/x00u0hxj3dDb8=;
  b=Bi1KVM6AaOlRDvIjZXh64KuSUOmJZaVmQkqFMBSlc908ZB4z6kxmKtoG
   +QqjNWS+zqTQDapPR62Et8++XmG1bTvJHU2OW9/tUBLUQ3HkrEjsXt77v
   V+ILhdGOvQrXpfIeaImDz2dIaLAcyJqjaZurRlVlXouvl+zdnkmO7Kzrc
   X1crsodmLat6GzazuYGvlKXy8BXSEMSP2MZgjEloqf2fNUd2dICJtB71R
   mlxfF7Yuy1Q6Y/818ZaIRE/CxK77UDcVjEFcMfCwIQvbflB/OVpaANy+7
   Fnr5La3qS7QAxxb+UKeN5Y544j63uge99ybcFaPX5yW5KF0bO8mwHhWO0
   A==;
X-CSE-ConnectionGUID: yfGmOUYEQcSS3o7qTRjdng==
X-CSE-MsgGUID: 02ngFgkERhaHK8dj9750+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="67007651"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="67007651"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 20:34:35 -0800
X-CSE-ConnectionGUID: b59wTbJXQFGLHnLXO8GfBw==
X-CSE-MsgGUID: ciJ46Be9Q6KSnrS2NRqu6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117756825"
Received: from unknown (HELO [10.238.129.58]) ([10.238.129.58])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 20:34:33 -0800
Message-ID: <c31b072a-7ec6-49f5-9ac7-a19cb6fbd5be@linux.intel.com>
Date: Fri, 28 Feb 2025 12:34:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] iommu/vt-d: fix system hang on reboot
 -f
To: yunhui cui <cuiyunhui@bytedance.com>, Ethan Zhao <etzhao1900@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
 <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
 <20250227203855.GI5011@ziepe.ca>
 <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
 <CAEEQ3w=1H7o7G56hYmwEGErfuFX-2nG=wesJYL7p0dDqLv_rpw@mail.gmail.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <CAEEQ3w=1H7o7G56hYmwEGErfuFX-2nG=wesJYL7p0dDqLv_rpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/28 10:18, yunhui cui 写道:
> Hi All,
>
> On Fri, Feb 28, 2025 at 8:51 AM Ethan Zhao <etzhao1900@gmail.com> wrote:
>>
>> On 2/28/2025 4:38 AM, Jason Gunthorpe wrote:
>>> On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
>>>> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
>>>>> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
>>>>>>> Provided the system does not respond to those events when this function
>>>>>>> is called, it's fine to remove the lock.
>>>>>> I agree.
>>>>> I think it is running the destruction of the iommu far too late in the
>>>>> process. IMHO it should be done after all the drivers have been
>>>>> shutdown, before the CPUs go single threaded.
>>>> Hmm... so far it is fine, the iommu_shutdown only has a little work to
>>>> do, disable the translation, the PMR disabling is just backward compatible,
>>>> was deprecated already. if we move it to one position where all CPUs are
>>>> cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
>>>> case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
>>>> transaction there on hardware when issue the translation disabling command.
>>> There is no guarentee device dma is halted anyhow at this point either.
>> The -f option to reboot command, suggests data corruption possibility.although
>>
>> the IOMMU strives not to cross the transaction boundaries of its address
>> translation.
>>
>> over all, we should make the reboot -f function works. not to hang
>> there. meanwhile
>>
>> it doesn't break anything else so far.
> patch v1:
> if (!down_write_trylock(&dmar_global_lock))
> return;

We should also think about the corner case of reboot without -f option, there might be something

wrong with one of the devices there on other CPUs they don't release the lock and were shutdown

by NMI, the dmar_global_lock is held by one of them, so we just bail out here at at once ?

leaving the IOMMU translation etc in enabling status. Is it better to loop with 10 seconds timeout

to try the lock then make sure no better choice, then continue the disabling of IOMMU translation & PMR ?.

Even the reboot -f case, leaving the IOMMU translation in enabling status is worse choice.

So seems we shouldn't bail out immediately after one time trylock whatever.

>
>   patch v3:
> /* All other CPUs were brought down, hotplug interrupts were disabled,
> no lock and RCU checking needed anymore*/
> list_for_each_entry(drhd, &dmar_drhd_units, list) {
> iommu = drhd->iommu;
> /* Disable PMRs explicitly here. */
> iommu_disable_protect_mem_regions(iommu);
> iommu_disable_translation(iommu);
> }
>
> Since we can remove down_write/up_write, it indicates that during the
> IOMMU shutdown process, we are not particularly concerned about
> whether others are accessing the critical section. Therefore, it can
> be understood that Patch v1 can successfully acquire the lock and
> proceed with subsequent operations. From this perspective, Patch v1 is
> reasonable and can prevent situations where there is an actual owner
> of dmar_global_lock, even though it does not perform a real IOMMU
> shutdown.
>
> However, if the IOMMU shutdown truly fails, IOMMU_WAIT_OP will trigger
> a panic(). Removing down_write/up_write offers better maintainability
> than Patch v1 (as we can retrieve the cause from the vmcore). But this
> might not be significant, since the reboot could have been completed
> successfully, and the occurrence of panic() might instead cause
> confusion.
>
> In summary, it is essential to complete the reboot action here rather
> than causing the system to hang. So, which do you prefer, v1 or v3?

Would v3 miss something ? please comment.

normal reboot/shutdown without -f case, function works right without any data corrupt or

leaving device in confusion status, good or bad situation.

reboot -f case, functions works, strives to not corrupt data or leave device in confusion status.

...

Thanks,

Ethan

>
>
>> Thanks,
>>
>> Ethan
>>
>>> Jason
> Thanks,
> Yunhui

-- 
"firm, enduring, strong, and long-lived"

