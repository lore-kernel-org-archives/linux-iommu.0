Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD9145326
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911249; cv=none; b=MXU92HFJR1EB96FaIyu3oNxPntkX/J7Za59nqhu8k5P+3O7urPUgoFMz72YqkaK9tRe7vYQ1FFoPuRuTdAqTkfXW2FD9MViz/gLV3nkfzFMkwJEC8ngp2qGlT0oUBCfpQUvFXSeBbVYcIE/N5Rjp0DRf2bj/S5ZprTMc8QQwN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911249; c=relaxed/simple;
	bh=aAAae3EScws/PyiASBXGrVfTI6KXIgX5vCfvlrHmw6A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YpL+cbnqtyQZ5XK8QpcZUF9gprazq4l0gfMKsGHhzlpUBIrgm2YeMYdMykGmmyeNQfjoU3UoCZpfpUOiXZEHF6uFoHk7vEHlpI7Zba8t6inBMLwoQ8GvFW/WdpGduLFH4Mlsq/i9EBOjnoNOkSF0Se5inDZpQrfW737yUfT9RXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ59EGsG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ59EGsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719911248; x=1751447248;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aAAae3EScws/PyiASBXGrVfTI6KXIgX5vCfvlrHmw6A=;
  b=ZZ59EGsGd37YLol4Nd/oyJPiPf/nT0Q2FLhG8c6GiXnR0MyTDOZMAGnu
   vudIpJylFhuyuMGyNxWgzjbioHObsxWOe9O3oMs66DlyZ0azlVOtEh5QV
   QTCiUVO6re5Pu02dF29f5WAZoKw2tvU/xbXKca0wGgl+b1VhN4Gu62yM/
   nHTn8ePgHbGeQ1EqNl9W4gpSSfr17ucC2ou8SIrpuAoQ+ruNg4edrnUJE
   dqM6c0D+AwxNjgtFY2nkwSOdGOKRGmKNPQE8OhJj6Xv6V1V2kCnb4e9cV
   EUQD8GjjZyitBwhLGGDibo4KzNDPoJfXz2rdADLcoNIji90+rjl6RTsEZ
   Q==;
X-CSE-ConnectionGUID: Ahn+jEt6QuqQUNiiFNv/PQ==
X-CSE-MsgGUID: ltiRJKEHQi2vqbmKalnUnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28468248"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28468248"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 02:07:26 -0700
X-CSE-ConnectionGUID: pq2UvnR3Qkq+YZOUiHz1lA==
X-CSE-MsgGUID: iOMeDIJIQ1q1fzr2ZYHMTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="51030085"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 02:07:25 -0700
Message-ID: <09af1efa-a9b7-4db1-aa14-da22aeafe7e7@linux.intel.com>
Date: Tue, 2 Jul 2024 17:07:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
To: Yi Liu <yi.l.liu@intel.com>, Christoph Hellwig <hch@infradead.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
 <fb388a2b-9ffc-42c5-893c-0c620e6977fc@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <fb388a2b-9ffc-42c5-893c-0c620e6977fc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/2 16:47, Yi Liu wrote:
>>>>
>>>> we've recently had an interesting case where a device unexpectedly
>>>> modified a dma buffer passed to it.  On AMD systems this caused iommu
>>>> faults because the buffer was mapped read only (DMA_FROM_DEVICE), but
>>>> on an Intel system everything worked fine as the IOMMU did not trip up
>>>> on the device writes to that buffer.  Any idea why that could sneak
>>>> through?
>>> Sorry if this was confusing, the permission checking is of course about
>>> the device reading from a buffer mapped read-only for the device
>>> (as that is what DMA_FROM_DEVICE is), which on intel still allows it
>>> to read.
>>
>> Is it about IOMMU blocking "device reading from buffer" or "device
>> writing to buffer"?
>>
>> The intel iommu driver might use first-stage translation for kernel DMA.
>> It seems not to block the "device reading from buffer" if I remember it
>> correctly.
> 
> does the current kernel use the first-stage page table by default?

Use first-stage page table for kernel DMA by default.

Best regards,
baolu
