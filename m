Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CD7FBA2
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375442; cv=none; b=R+q8JSq5+bXOqRwWpqDXwf81nsKeLfvX5Zva/q+Z+R44Q+9lBinSAROoADOa23hZYVbyPadmy0sayZJgq/zBBGmC84e8DBM3Xl1f5Z/3GAHjEGgbWwln6vsnXKmaCKP8zrhKYYp8hT2dfFX0cFzaacOIafRFV2GmwWBlG+RJfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375442; c=relaxed/simple;
	bh=2ZMkSb6trC+SEAQqJvNr5wgOhGHKgnO4D6C6UvpvLs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qts4Xy7jWL80raZY3zwOL+NWRXDVVJegLtChKHVGGPcyFyDGJZ9Z4eR1LtgNwV44DYnAwlpjLyKpS35ePqH3bBUt/qRcyv85/9LG0Yt7lc3FY9ptlGFJ9mM7Ug8G7QPpA364zrPkC3Bh76omi7dillRjmxarva8jmsp+rQvEX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ1EMYg0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ1EMYg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740375439; x=1771911439;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2ZMkSb6trC+SEAQqJvNr5wgOhGHKgnO4D6C6UvpvLs8=;
  b=SQ1EMYg0NV0epITPKeSidjmj8cBit805iIVULy0dXgXy8+f7f2tsHKLx
   zWTL4JLCx3V2HWh0ECkdJ6F6XHFaiSfOt/JstsLwROw5dPBDv98jk3xS5
   MIP3OJKsvxCmLegV6NsCTR6VyN+y2GMXhgiIABKOcIFsMlRLAvmAMoC7S
   abUOZnyml3tcHP1VrqHt8jW3vaierPhcxvbE8KJKO3C2PqTESY2ICxkG9
   iAE2aaYgcDaI3Kq4HTbw6hoQ3MBfbIwYRXibd8e871sy1EHYpcN/5sMjl
   9Vck6/oC8H8O4SAINxNools77kavFbNPWKuW6PUg3f/SpNfJDbpZN4H9M
   A==;
X-CSE-ConnectionGUID: NlfkdUWkSomxDczO4Ujaxg==
X-CSE-MsgGUID: zDoY+fZqSH2TiEUnCRpd3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41237465"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41237465"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:37:18 -0800
X-CSE-ConnectionGUID: ChFmT8HVS8yvUZW28bp72g==
X-CSE-MsgGUID: D9inMDO4QyaLx8nGBNeISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121049022"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.124.242.192]) ([10.124.242.192])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:37:16 -0800
Message-ID: <9e20168a-0498-4d98-8852-b3342d46d693@linux.intel.com>
Date: Mon, 24 Feb 2025 13:37:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250220101511.37602-1-cuiyunhui@bytedance.com>
 <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/2/24 9:02, Baolu Lu 写道:
> On 2/20/25 18:15, Yunhui Cui wrote:
>> When entering intel_iommu_shutdown, system interrupts are disabled,
>> and the reboot process might be scheduled out by down_write(). If the
>> scheduled process does not yield (e.g., while(1)), the system will hang.
>>
>> Signed-off-by: Yunhui Cui<cuiyunhui@bytedance.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index cc46098f875b..76a1d83b46bf 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
>>       if (no_iommu || dmar_disabled)
>>           return;
>>   -    down_write(&dmar_global_lock);

Only BSP is running at this point, no DMAR concurrency access protection is needed
anyore, even there is interrupt (only legacy & NMI) coming in, it is impossible to for
scheduler to run any other iommu access code.**
Thanks,
Ethan**

>> +    if (!down_write_trylock(&dmar_global_lock))
>> +        return;
>
> If system interrupts are disabled here, locking is unnecessary. Hotplug
> operations depend on interrupt events, so it's better to remove the
> lock. The shutdown helper then appears like this:
>
> void intel_iommu_shutdown(void)
> {
>         struct dmar_drhd_unit *drhd;
>         struct intel_iommu *iommu = NULL;
>
>         if (no_iommu || dmar_disabled)
>                 return;
>
>         /*
>          * System interrupts are disabled when it reaches here. Locking
>          * is unnecessary when iterating the IOMMU list.
>          */
>         list_for_each_entry(drhd, &dmar_drhd_units, list) {
>                 if (drhd->ignored)
>                         continue;
>
>                 iommu = drhd->iommu;
>                 /* Disable PMRs explicitly here. */
>                 iommu_disable_protect_mem_regions(iommu);
>                 iommu_disable_translation(iommu);
>         }
> }
>
> Does it work for you?
>
> Thanks,
> baolu
>
-- 
"firm, enduring, strong, and long-lived"

