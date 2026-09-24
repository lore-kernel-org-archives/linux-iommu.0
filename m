Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4D35CB9C
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232563; cv=none; b=Ypv48IJfpeG2vsOsuaAQZiTMdkg0KbslWKE42nVvTdiRrLAumymjrLDREttSZQPPQISqfNEHt47XaWyFUk4VQoXqhae7E2cEFZdPepXe/Wb8HNnNDX5yN40AxK7Vi0bS6amE8BCBriBJYh5QrvDLy4eaKtHmuteauI1OPVWofAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232563; c=relaxed/simple;
	bh=V5Uuh88XO52RVWNdyxf+z2hKNa2jWExOrWZCQ+nQRIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm6CoA5VK/oTbOCT2rsDsw1BPlDoD/6Ythu9UPVBkZ3ed1519W9ns5pNH7rlj9HwmMxewnuUdW6OtWj7lLKXvQ/B3nUAaLBLVxgYmAbiqElWFhPg6wiGzeAcVW73MVmOLfVBHenUIIL9K8IsVH+cwjGrU8wBHZ9QfPD8VIDaO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQ0qMC+N; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQ0qMC+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232562; x=1821768562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V5Uuh88XO52RVWNdyxf+z2hKNa2jWExOrWZCQ+nQRIA=;
  b=WQ0qMC+NsRtdYd2QAAI6L/JqLE1pVYxmsNB7r4wMBYQlKCqMR0LHn2pJ
   Tw+TvWl3sqAyUPEVGji9oGjBUtqFN4Ufgf7ZDxz5ii3CGwy54UDOSZZM/
   L7XneC8McUSDTziFT+mg873bFiGAOWvWdbL7v91Woc5Ls+mTKuYUHukhv
   GLv/0aAXOXjUjoXZZQ6Q2miY7Lp7kzDJupQS/N46LISzeIfmJDl/zG/AX
   SimhoJt6kDcFe0LN4JLc2RenOsvzod9h4SyXIepflKFPhtiUOe9cKk7+E
   Bhj3JXUWSJdfugg+3gtUoQGFkTHqV9ijohQ83iOyciaxZfUBZbO4zx+d3
   Q==;
X-CSE-ConnectionGUID: 7Suq3sxxQgyw5zRyF8Svvw==
X-CSE-MsgGUID: 1+fLIscpT12nTIRDidpM7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101166602"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101166602"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:49:22 -0700
X-CSE-ConnectionGUID: Gou1ukaIRkiVYhH5nOuxQg==
X-CSE-MsgGUID: CHyr+1ZoRr+zMXMrY3jsLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="5181733"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:49:20 -0700
Message-ID: <3ca4360c-75b9-46a4-9cea-85d008d85ccf@linux.intel.com>
Date: Thu, 24 Sep 2026 14:49:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/vt-d: Fix IQE handling to cover all descriptors
 in submission range
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: bikuan.zbk@alibaba-inc.com, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org
References: <e56a23f2-216c-41ea-991d-495962e6b7af@linux.intel.com>
 <20260916081135.2038574-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260916081135.2038574-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 16:11, Guanghui Feng wrote:
> When an Invalidation Queue Error (IQE) occurs, hardware halts fetching
> and IQH points at the faulting descriptor. The previous code only
> checked whether IQH matched the first descriptor index of the current
> submission, missing faults on any other descriptor within the batch.
> 
> Expand the check to cover the entire submission range [index, wait_index],
> accounting for circular wrap-around.
> 
> Furthermore, after detecting IQE, the old recovery only replaced the
> single faulting slot with a copy of the wait descriptor and immediately
> returned -EINVAL. This left two problems:
> 
>    a) Hardware resumed fetching and could hit another invalid descriptor
>       in the same abandoned batch, raising a second IQE that no submitter
>       would claim — permanently deadlocking the queue.
> 
>    b) The caller reclaimed all batch slots (QI_FREE) while hardware might
>       still be asynchronously processing descriptors from that batch,
>       allowing concurrent overwrite and descriptor corruption.
> 
> Fix both by introducing qi_drain_remaining_descs(): upon IQE detection,
> overwrite the stranded slots in [IQH, wait_index) with fenced no-op wait
> descriptors, resubmit the wait descriptor at wait_index, clear IQE, and
> spin until hardware signals QI_DONE (with DMAR_OPERATION_TIMEOUT). This
> guarantees hardware has fully drained the batch before the caller
> reclaims slots.
> 

Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per 
qi_submit_sync()")

> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/dmar.c | 73 ++++++++++++++++++++++++++++++++------
>   1 file changed, 62 insertions(+), 11 deletions(-)

Queued for iommu/next. Thanks!
