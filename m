Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE044C7D
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365640; cv=none; b=piytqlRoSn9m490kvBF9aSSWRIyC5KLHw1PFstFwCi33e0pl5AMoOjtBi7D9We1PSdfCObq9HlHWMAXYs2fCRgvvzosa1RtURNwCWpEZOWjx6rnsVZ98lkanLo1c72F77GI8+Mm10+TyWtBi8uZX9H+Inl63gjr2WF7eYQIcYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365640; c=relaxed/simple;
	bh=h+Xk9Y6Pmk9iA0GahcG5PLNKXQIF4StDKJwWHIq1NZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svOBKvIe0F0/eaqZznlsWFB3fLrb4BtXL9+xZGWoYOzgtlVFQTZL1OpcqChSA4PFDm1i6u07sD/0eECjufLMFDNt43GrESa1aRqUrNThPeVFQZHc4fuh14LMAFfHLnSWp+fU6PwmC+er+BMqPRBHpab0Klni5wDUs69s2trF2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mf/4lgRU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mf/4lgRU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740365639; x=1771901639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+Xk9Y6Pmk9iA0GahcG5PLNKXQIF4StDKJwWHIq1NZc=;
  b=Mf/4lgRUT6ixd3kt98SoepNNzawkx1OSvpiFw+nbD2zwegfitKH507rq
   xMLbFRMPzZgHMXkdQqL3Ocqu54vX1YCAF9prRCPoTDXsFRvv/ZQ+hXDEq
   vaoJHdliCC99l3NiVIZfNvPGNWY9yyxKbK1y8EDZZr9dfo6rGeZe6jNxW
   H5fwjw47M7ngLVonf8EVmM8zi2EJNmJKbJQqasjh/egJHGw4NrMSWW9+O
   KiqL7gVaKUr6GUE1IvWhUsnq2v7RqO6YXgKlq00MsQLJKGoUSynrPFW2j
   dXUi8vOEFXOYwuEYiFr+pTo0u3rmySHs2pX27O/Yq1/QW+r68e/+D116I
   Q==;
X-CSE-ConnectionGUID: i42gN0BJS8+wSdmQDAc7mQ==
X-CSE-MsgGUID: hQ9jmUOuRxOnBMNlylhkcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40297090"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40297090"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 18:53:58 -0800
X-CSE-ConnectionGUID: LjSHFoouSb23b3YU9LnzIA==
X-CSE-MsgGUID: XHAJHJT6R4WxF4g+JxtBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115738067"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.124.242.192]) ([10.124.242.192])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 18:53:56 -0800
Message-ID: <f4626354-b466-4fb7-9555-646877fd88d6@linux.intel.com>
Date: Mon, 24 Feb 2025 10:53:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250220101511.37602-1-cuiyunhui@bytedance.com>
 <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
 <CAEEQ3wkygXexsu9x16Q+6yMtmtM+9aD=-DH1tMVNq1yuyZ7Dcg@mail.gmail.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <CAEEQ3wkygXexsu9x16Q+6yMtmtM+9aD=-DH1tMVNq1yuyZ7Dcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/21 17:46, yunhui cui 写道:
> Hi Ethan,
>
> On Fri, Feb 21, 2025 at 4:40 PM Ethan Zhao <haifeng.zhao@linux.intel.com> wrote:
>>
>> 在 2025/2/20 18:15, Yunhui Cui 写道:
>>> When entering intel_iommu_shutdown, system interrupts are disabled,
>> System interrupts were disabled ? you mean all interrupts were disabled
>> when entering intel_iommu_shutdown(), perhaps it is not true, at least
>> for upstream latest code.
>>
>>> and the reboot process might be scheduled out by down_write(). If the
>>> scheduled process does not yield (e.g., while(1)), the system will hang.
>> No NMI lockup watchdog jumping out here ?
> Steps to reproduce:
>
> 1. Avoid return in:
> if (no_iommu || dmar_disabled)
>      return;
>
> 2. Write a.out with while(1).
>
> 3. ./a.out &; reboot -f.
>
> 4. Observe. Send NMI via BIOS to check system response.
>
> 5. Add console=ttyS0,115200 to cmdline to increase reproduction chance.
>
> Let's continue discussing based on the above.

I will try these steps to reproduce.

Per the lastest upstream code, the local processor's interrupt mask is cleaned. so

the processor could accept interrupts and handle them. and lagacy interrupt should

be restored for later boot if there is lagacy device and as to NMI, no one could stop

it. In a short, perhaps it is fact under your hardware configureation that no interrupt

event come in to kick the scheduler to run when the a.out (while(1)) got scheduled in,

but not because all system interrupts are disabled.


Thanks,
Ethan

>> Thanks,
>> Ethan
>>
>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index cc46098f875b..76a1d83b46bf 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
>>>        if (no_iommu || dmar_disabled)
>>>                return;
>>>
>>> -     down_write(&dmar_global_lock);
>>> +     if (!down_write_trylock(&dmar_global_lock))
>>> +             return;
>>>
>>>        /* Disable PMRs explicitly here. */
>>>        for_each_iommu(iommu, drhd)
>> --
>> "firm, enduring, strong, and long-lived"
>>
> Thanks,
> Yunhui
>
-- 
"firm, enduring, strong, and long-lived"

