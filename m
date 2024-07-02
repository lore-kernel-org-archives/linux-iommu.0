Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768A4963F
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908552; cv=none; b=edz+P2zgIeJMZNSiZh1DDUQsZTMJFkXes1OVH4JIEaAh0EWs7cEr/EeJ/0cfgTGmvKj9/m1+6tg9vOIUWJt7uTYse9qeRLdfjcnYZj4QBjDcnQLnTCaZI0U2K35yM43WzwWOGv3Rn+AKQgdZGLIJ5eHr8IvGYht9+eMjZ5j0zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908552; c=relaxed/simple;
	bh=L4wANw7bibJeARYVnjbpuTxscHO30ohMv7CM9IO+khw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YOtk/q0Jm095QsCPV9/rOv8T5jFiNLSW353yLHYp/6ijpQTYMfW4N+PpzMJQilKzAIn75GfpbBVHBLSIUZCSsRMl8wkeydv9sDvs16t/mgMnZVlIyGNmeX8zbk2kvmUzXgjgjaRhUzMfBoHhmcM6N6ZHJW4dXlmmGcvJvGQyfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VT8S+aZc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VT8S+aZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719908552; x=1751444552;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L4wANw7bibJeARYVnjbpuTxscHO30ohMv7CM9IO+khw=;
  b=VT8S+aZcmSvWCjoCMieiuyCBsewyj8Th+CCS+jQDzBYCWfg100X45+Rg
   KlkEyHQAklpO49Ys8PFq+gq2J+qutIxBgWDh7PVqh+N2vjCFITWW9DO2Q
   bhuOkvw3/dII4x2Snpp66oRuX0l2RSjEj2+sypepWVPYnRA0iycwOLaTv
   /Kx54zXSKMuHUxhXBgb2dXmydfF1bG56Y27Eh+4gmoXBtMcmJoDREBsqr
   wi6Lbk5kannyWZ162nyOLzJu1Cqqr+Q2PoXKFIbBBMSWBJc+6p8LDpfS8
   O0evC4i0/s4xq2vqDYBOVO/yZQsZWC9X9dscPIS2kzIlPR8TZfq0c7wf7
   w==;
X-CSE-ConnectionGUID: nL+8OOcfTNmEwjeqpFn4Lw==
X-CSE-MsgGUID: pTFlMWg6Q02WjNSAOOgx3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34518316"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="34518316"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 01:22:30 -0700
X-CSE-ConnectionGUID: fvzdAku4T66buPDS3uC+Kg==
X-CSE-MsgGUID: 9GY7+NEOSSyHMeNCPKpLzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45829222"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 01:22:28 -0700
Message-ID: <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
Date: Tue, 2 Jul 2024 16:22:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
To: Christoph Hellwig <hch@infradead.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org> <ZoO0KxkU_JNO0av4@infradead.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZoO0KxkU_JNO0av4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 16:02, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 12:46:59AM -0700, Christoph Hellwig wrote:
>> Hi all,
Hi Christoph,

>>
>> we've recently had an interesting case where a device unexpectedly
>> modified a dma buffer passed to it.  On AMD systems this caused iommu
>> faults because the buffer was mapped read only (DMA_FROM_DEVICE), but
>> on an Intel system everything worked fine as the IOMMU did not trip up
>> on the device writes to that buffer.  Any idea why that could sneak
>> through?
> Sorry if this was confusing, the permission checking is of course about
> the device reading from a buffer mapped read-only for the device
> (as that is what DMA_FROM_DEVICE is), which on intel still allows it
> to read.

Is it about IOMMU blocking "device reading from buffer" or "device
writing to buffer"?

The intel iommu driver might use first-stage translation for kernel DMA.
It seems not to block the "device reading from buffer" if I remember it
correctly.

Best regards,
baolu
