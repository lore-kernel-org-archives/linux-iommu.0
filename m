Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B4312825
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280972; cv=none; b=aqGxkWkj34yr/KwUO6t1ciDIDzRnZFrmu7S7sUSe6617rhj0BtsAs7GAkrubLqdU76KqJDHKgt1GpjWXEqS2OggMjZS8e7MUrJNHBhZLiG5QI0AlSU2R2RApmcVR8egeklq1r/4yA8Pa7uLF+z67Lw8iz0113q+JDHG71/bLfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280972; c=relaxed/simple;
	bh=DztewEmxdznEGYNm94ex45zp9piryX8jkeXvMHBKcXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1oBwcQVVSl3DVYdGAGvdCoHCQAMnF+0Ls8BIPmq14FMLyEDM1kP7hV6yvnxfVj18ioh5gfR2an7H/QH58BEbOH7oir6vo2PHUDnaoruTI6nrwSrxyhVr9lwuawZhz18yWp/bQ1ghqTnUerUOBbZ+QiiVdngLABCwEvNptehqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOO6gCpo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOO6gCpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787280971; x=1818816971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DztewEmxdznEGYNm94ex45zp9piryX8jkeXvMHBKcXs=;
  b=FOO6gCpoAQlCq54K+9lMwAND78g0LKmGBSXJCHwSmPTZ/lyoQ35rHVM8
   8eBHEkHmOxrKVJDs5MqJa3Qvgz5I60VG6tKGgCEvS+v0VRlCkKksTDT/9
   Fa1FmK2xp2zPEAsiM/aLF8LUBAdbo1D8m/3FKBUIwuiq5EIBWCFEm55yI
   NyBzsXpyzUGN7vQxXjqu3GzWZ0oznyIryG65kfk4/ovYufxpQUqYDFUCx
   CvEI5HvElwgcjrhU41DjyR4LzuCf9tiFabNaLOcFSlQZNTA4CiImO/tFY
   /bOFScb2SxVeLYY05U5fp4ftg+isoA5JJE87GGa3rD3CcmJfogz92G5PM
   A==;
X-CSE-ConnectionGUID: CulNf6WbRaG4S9PH8M51LA==
X-CSE-MsgGUID: wO1jerOJRiGkfXhHNA3doQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105207036"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="105207036"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 19:56:10 -0700
X-CSE-ConnectionGUID: 2GkNYpCvQjqgZow+RdLsQw==
X-CSE-MsgGUID: BXy1LgDKSMyaE31+OFJMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="296123647"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 19:56:08 -0700
Message-ID: <71fbf215-44d7-47ee-8547-a350d4f700b1@linux.intel.com>
Date: Fri, 21 Aug 2026 10:56:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in
 submission range
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 "bikuan . zbk" <bikuan.zbk@alibaba-inc.com>
References: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
 <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/26 22:47, Guanghui Feng wrote:
> Currently, qi_check_fault() only handles IQE (Invalidation Queue Error)
> when the faulting descriptor index exactly matches the first descriptor
> of the current submission (head == index). This is too restrictive in
> multi-descriptor submissions where the error could occur at any
> descriptor within the batch.
> 
> If the IQE is triggered by a descriptor that belongs to the current
> submission but is not at the starting index, the function returns 0
> without clearing the IQE fault status. Since hardware stops fetching
> new descriptors until IQE is cleared, this leads to an indefinite wait
> on the wait descriptor completion - effectively a deadlock.
> 
> Fix this by expanding the IQE handling condition to cover all descriptors
> within the circular range [index, wait_index]. Use explicit bounds
> checking that properly handles the wrap-around case of the circular
> queue.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
> ---
>   drivers/iommu/intel/dmar.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ba675b08cd20..ecc95af06f61 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1366,8 +1366,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   	 * is cleared.
>   	 */
>   	if (fault & DMA_FSTS_IQE) {
> +		int head_idx;
> +
>   		head = readl(iommu->reg + DMAR_IQH_REG);
> -		if ((head >> shift) == index) {
> +		head_idx = head >> shift;
> +
> +		/*
> +		 * The faulting descriptor can be anywhere within the current
> +		 * submission's range [index, wait_index]. Since the queue is
> +		 * circular, this submission may wrap around QI_LENGTH
> +		 * (index > wait_index in that case), so check both the
> +		 * non-wrapped and wrapped cases of the range.
> +		 */
> +		if (index <= wait_index ?
> +		    (head_idx >= index && head_idx <= wait_index) :
> +		    (head_idx >= index || head_idx <= wait_index)) {
>   			struct qi_desc *desc = qi->desc + head;
>   
>   			/*

Could you also please take a look at the comments from Sashiko?

https://sashiko.dev/#/patchset/20260805042012.2363698-1-guanghuifeng%40linux.alibaba.com

https://sashiko.dev/#/patchset/20260820144741.920858-1-guanghuifeng%40linux.alibaba.com

No worries about the pre-existing issues. I’ll take care of them.

Thanks,
baolu
