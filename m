Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0B1F91E3
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881012; cv=none; b=FpbENOQdTkXou+BBdWhwhjdsKkJDIqzhKr5EPRWwYDv057jc9q4wdM3VnfpMvs25hiADkGaWdX5D1mB8Yk3C8CkGtpE9piQdlt0eR/Oeav4zSgF4t0MgGeg1lj45OB2daAZFRO2jmNKOdDADD1oXl4Wv4PWnHk721+Yanu9HB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881012; c=relaxed/simple;
	bh=cdO5eb1mpdd48MIqU7gFur0NAuLj29gr8djf2dB0r6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpMLxYx81fxbMBigK/ek6kMKJCvqSymYOh9raq/Xs27LyLf6byau5TQDtoa2eJMC836ee0gX4qBZJHBFzTeTIuVYkDk/D00Hw/GrFyNd0uB3nUFx4vaGbXNeWDiMoorR3CCIGdB6gBdIAqCtt7stoMeJWSsjAvlzsyBt/++DQOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiQM+ixN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiQM+ixN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787881011; x=1819417011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cdO5eb1mpdd48MIqU7gFur0NAuLj29gr8djf2dB0r6Y=;
  b=PiQM+ixNdI19dNjbO7TIMPbiRtgzLU354wBPbZ6m6uxq5wtuXzi5E8mT
   yX4YsRIAq3RL5raGW4IlXIHDRzYmAvYkMLsfOOC533duxyS1KvUQaMls2
   ku98r+QZ2bOkFnqZSNHlalvDH3CxBXzmXEnd3m5omdD5cApcbbQFH/8tl
   XKNxShyH78MA0Xx78TDSMal4R7kCVWsiMNsfby2cfOiZcuAjRMZDUtORY
   agZzWpAeRpT+7IM/M0UyNB2zsyw/siQpSB8N0cc8Q9tKPv+bwjxO6U3B8
   wnTznTu3lBmFjo4ELJ3iQ5uf9/05o3PF4ExFWxZDJgVNgdiEvJIt08mUX
   Q==;
X-CSE-ConnectionGUID: bbHQ9QLmQ8yhxaxDnZ64tg==
X-CSE-MsgGUID: N781SChOTL2rkNShtudQlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99739764"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99739764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:36:50 -0700
X-CSE-ConnectionGUID: zdx/iSvHSzaJJ8Y+xCV3lw==
X-CSE-MsgGUID: nXBAuRgORAiVCoPizAgZqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="267432266"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 18:36:46 -0700
Message-ID: <1f6d5804-8f96-4963-995c-2bafa69505f5@linux.intel.com>
Date: Fri, 28 Aug 2026 09:36:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-11-skhawaja@google.com>
 <5f8963c4-f6b1-44b3-ab2c-ed658822efb4@linux.intel.com>
 <apCC3xMkYkEyQRID@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <apCC3xMkYkEyQRID@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/26 02:47, Samiullah Khawaja wrote:
>>> +/**
>>> + * intel_iommu_liveupdate_restore_root_table() - Restore root table 
>>> and reclaim domain IDs
>>> + * @iommu: Target IOMMU
>>> + * @iommu_ser: Serialized IOMMU hardware state from previous kernel
>>> + *
>>> + * Restores the preserved root table and context tables for the 
>>> IOMMU hardware
>>> + * instance across Live Update, and reclaims all domain IDs 
>>> previously allocated
>>> + * to preserved devices so they are not reused.
>>> + */
>>> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu 
>>> *iommu,
>>> +                           struct iommu_hw_ser *iommu_ser)
>>> +{
>>> +    if (!iommu_ser->intel.restored)
>>> +        iommu_restore_pages(iommu_ser->intel.root_table);
>>> +
>>> +    iommu->root_entry = __va(iommu_ser->intel.root_table);
>>> +
>>> +    if (!iommu_ser->intel.restored)
>>> +        restore_iommu_context(iommu);
>>> +
>>> +    iommu_ser->intel.restored = 1;
>>
>> This uses iommu_ser->intel.restored to prevent restoring the root and
>> context tables multiple times. For this to work safely, iommu_ser-
>>> intel.restored must be 0 the first time restore runs after kexec.
>>
>> The problem is: this field is inside struct iommu_hw_ser, and that
>> struct is allocated in the old kernel. How to ensure that the previous
>> kernel has zeroed this out? Maybe I’m overthinking this.
> 
> This is a valid point. However, the old kernel allocates this struct
> with GFP_ZERO and it never touches the restored field prior to kexec.
> So it should be zero in the new kernel.

That should be fine.

I just found it a bit odd that a variable used only by the incoming
kernel depends on initialization done in the old kernel. :-)

Thanks,
baolu
