Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1615216E
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911559; cv=none; b=sxBQmR5GDpRKvWnVKi+UvWgaEn2rXUmQmOnyID82t23Qm0pd1W8WZmfGklwu/85kQrnelR38LHJVy9DUHht7t/h4Ea+WlaoqhSsMySOt3P5e2p1s5fAXzKYllOMUjlPyP8sNQMzO8yUgjtN3Zs9OO8461YpuGpLp3FuJkUFF2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911559; c=relaxed/simple;
	bh=2AQLCROGvl6FnLYlO8E5aMSOqdDwA7X0OxeZoDHkccA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ULeZBpfwHaSo2KJ8E9asRDdejBjN44pIUMPWZO7FLVC0SGMaIEsUge1zVNTkpj1FQps0e0wSr8Effx6cM7H08ExNEEtwiDmjCyGhhQ+b+nt1/Z0RtCUiH4IMdRe38rpLoJCGvCKLEgL8/kpnX55Lige/cLlyWZYEtpyAKpogZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZsUfMC+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZsUfMC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719911558; x=1751447558;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2AQLCROGvl6FnLYlO8E5aMSOqdDwA7X0OxeZoDHkccA=;
  b=BZsUfMC+cNe02TOehpDE/3/cZPDvtr9ZrLGxxY78KO28VfVa3vJIoDsn
   cYoUNyRMf+T+tHmFsBOH6/qsJgk8/Md/dnY33T3ON98iWK8btAcLusj1i
   JN9l9UbLvIWEqZ8ALFNXA6Y/Q7x6FswkVHso5IyONe7mOXG5+/Q444Z+1
   UY0rmb5v4+fzYWRADQ3zkWXZexP7jejucRPd37oiHb/V2PDuyuRxirCEA
   Uiqlvj0ss8i4xIaWNnk3bUFRwAqAR+6CLfqx2Vgf1WbbvSfyxegrLDuCs
   X/xpEnwYdNy0Vh8B1bBpmU36Q1M5KR9CFFr0SjgiBnKxEWPhZd03IUDJH
   g==;
X-CSE-ConnectionGUID: bVkZAtUhQBGMsuFWgfI9Ng==
X-CSE-MsgGUID: Biq7nTX1Q6ixq3tkhPBpzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17213929"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17213929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 02:12:37 -0700
X-CSE-ConnectionGUID: cgLMRFCeTmu+8gcbcrWMqw==
X-CSE-MsgGUID: ba3P/etTSCmu+eh3D0CcPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45810536"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 02:12:34 -0700
Message-ID: <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
Date: Tue, 2 Jul 2024 17:12:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
To: Christoph Hellwig <hch@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
 <ZoO5ZeYtA6qLIs21@infradead.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZoO5ZeYtA6qLIs21@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 16:25, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 04:22:25PM +0800, Baolu Lu wrote:
>> Is it about IOMMU blocking "device reading from buffer" or "device
>> writing to buffer"?
>>
>> The intel iommu driver might use first-stage translation for kernel DMA.
>> It seems not to block the "device reading from buffer" if I remember it
>> correctly.
> This is about device reading from buffer it is only supposed to write
> to (but doesn't).

In this case, Intel IOMMU doesn't block device reading as the first-
stage page table only grants two types of permissions: Read-only or
Read-write. Write-only permission is not available.

Do you have a functional requirement for Write-only permission? If so,
we can choose the second-stage page table.

Best regards,
baolu
