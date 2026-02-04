Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262713A9002
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197550; cv=none; b=lTzYBlVLJQaYE5Vn1SLEmXaQQZS2PkkTBtRNrcAytYkWbUmUK/9/6fhj0xOXhxsXXqCT1E8tmR2MmB1ERHlKF40UgdwHK6FBwbjLefMD3BtyXC29mkALV1q1IlY7ZnfNGlreoPOjEGgZYZthUldvCxsJDRnaypqk+ioOgyPgQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197550; c=relaxed/simple;
	bh=hw28N7bNC2X0YIF060cZpgYKSy+ML2KzC4mbg9iBs1k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EmCHlqkTWahDOgqLK//HcChqU413sHSRYU3FrJ7l9GknRenac5KSvLW7sYSD2t2NTmcAJERKBEJ2ueE2TkCsTFkxMgVc5bOTkE/3WFNfrtSOXt1vvkhBDSA8Zc5u5o3mR+tpvyQcr+VYSIVZ7qPNOzTojcfMdl3kzyKDZEagSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUMKO6AD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUMKO6AD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770197550; x=1801733550;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hw28N7bNC2X0YIF060cZpgYKSy+ML2KzC4mbg9iBs1k=;
  b=eUMKO6ADc1OMqrjPcJdqUwMrZh4nQRlfn9R1VbCJNx1bgqZ/WioTQEsE
   86YbkbibmR1IIcx+bDiEcCSsw/HNpy26sTt9cRNVtHnNX0+4P4IjJi95y
   mxomzvAROgXogxpAd1N1Gky2yE3D+QGzyUGVK/DiKcbBqX+vMkZZqchOL
   BCljOcvtcEc9ftXHyI89Ph+nU8z65fqZGaNPeaIIj3gQoWyko+IgpocOc
   N0UVnceNVpv2adZibZ8aYgUiuLTJQuLiHuuLTuQgTVMfyx83SVtXXv8KZ
   bTK2t8Dnk1bLrSg+DvUIaMmFFDkepMcSNGZMeUO0PZtQ2HsZ58vw+CwZH
   w==;
X-CSE-ConnectionGUID: J9dMyMVLQsqtAxtTd2z61A==
X-CSE-MsgGUID: 5WnHdURwTgS7q7/xH7GdGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71283301"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71283301"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:32:29 -0800
X-CSE-ConnectionGUID: 0jEBThiaSDa7vo1gLEo+/g==
X-CSE-MsgGUID: 3Lwh0Ds6SfWFvIBWL7dHww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214650871"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:32:26 -0800
Message-ID: <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
Date: Wed, 4 Feb 2026 17:32:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/2026 10:09 AM, Guanghui Feng wrote:
> Device-TLB Invalidation Response Time-out (ITE) handling was added in
> commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695.
> 
> When an ITE occurs, iommu will sets the ITE (Invalidation Time-out
> Error) field in the Fault Status Register. No new descriptors are
> fetched from the Invalidation Queue until software clears the ITE field
> in the Fault Status Register. Tail pointer Register updates by software
> while the ITE field is Set does not cause descriptor fetches by
> hardware. At the time ITE field is Set, hardware aborts any
> inv_wait_dsc commands pending in hardware and does not increment
> the Invalidation Queue Head register. When software clears the
> ITE field in the Fault Status Register, hardware fetches
> descriptor pointed by the Invalidation Queue Head register.
> 
> But in the qi_check_fault process, it is implemented by default
> according to the 2009 commit: 6ba6c3a4cacfd68bf970e3e04e2ff0d66fa0f695,
> that is, only one struct qi_desc is submitted at a time. A qi_desc request is
> immediately followed by a wait_desc/QI_IWD_TYPE for
> synchronization. Therefore, the IOMMU driver implementation
> considers invalid queue entries at odd positions to be
> wait_desc. After ITE is set, hardware aborts any pending
> inv_wait_dsc commands in hardware. Therefore, qi_check_fault
> iterates through odd-position as wait_desc entries and sets
> desc_status to QI_ABORT. However, the current implementation
> allows multiple struct qi_desc to be submitted simultaneously,
> followed by one wait_desc, so it's no longer guaranteed that
> odd-position entries will be wait_desc. When the number of submitted
> struct qi_desc is even, wait_desc's desc_status will not be set to QI_ABORT,
> qi_check_fault will return 0, and qi_submit_sync will then
> execute in an infinite loop and cause a hard lockup when
> interrupts are disabled and the PCIe device does not respond to
> Device-TLB Invalidation requests.

Yes. This appears a real software bug.

> 
> Additionally, if the device remains online and an IOMMU ITE
> occurs, simply returning -EAGAIN is sufficient. When processing
> the -EAGAIN result, qi_submit_sync will automatically reclaim
> all submitted struct qi_desc and resubmit the requests.
> 
> Through this modification:
> 1. Correctly triggers the resubmission of struct qi_desc when
> an ITE occurs.
> 2. Prevents the IOMMU driver from disabling interrupts and
> executing in an infinite loop within qi_submit_sync when an
> ITE occurs, avoiding hardlockup.

But I think this fix changes the behavior of the driver.

Previously, when an ITE error was detected, it cleared the ITE so that
hardware could keep going, aborted all wait-descriptors that were being
handled by hardware, and returned -EAGAIN if its own wait-descriptor was
impacted.

This patch changes the behavior; it returns -EAGAIN directly whenever it
detects an ITE error, regardless of whether its wait-desc is impacted.
In the single-threaded case, it works as expected, but race condition
might occur when qi_submit_sync() is called in multiple threads at the
same time.

> 
> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/dmar.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)

Have you tried to fix it by dropping the "odd position" assumption? For
example, removing "head |= 1" and decrementing by 1 instead of 2 in the
loop?

      do {
              if (qi->desc_status[head] == QI_IN_USE)
                      qi->desc_status[head] = QI_ABORT;
              head = (head - 2 + QI_LENGTH) % QI_LENGTH;
      } while (head != tail);

Thanks,
baolu
