Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07C4C6D
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787195402; cv=none; b=FCjrT6k133yVdULUHcPd297/XAUQVIKtnjvxOqZjvyULucxmO2zDMSyRRW5KVLqxuEt6tfEejyc4wFXgdgBKobZlPGjWBALYukxlvaVcKSHKDpQVIZqTQc0t7QgOSLqCZ8jwb45wiAtRvdO/QMrrKb11bTFIrV6cAGkRygxL6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787195402; c=relaxed/simple;
	bh=hlqTHgnX7dMCx2ddd00rYLMFRCeqZPvPKSWdQazupwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kd2WDOv5j+a4BVQF1lW/ASydyo1VkkfubWObSseyZ8C+GwdDN6gtjMakJj5AEqpXJ4mq0LQSx80E1s3HGqWa+++uqCX0hnnx0ukmdfK+tOvvuBZrCTrD1IWLhPxeGY0OlUnKfFPBeiwvvxtMmVkYB+cHEjQaUWVjZfYKiidinhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkifJXVF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkifJXVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787195401; x=1818731401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlqTHgnX7dMCx2ddd00rYLMFRCeqZPvPKSWdQazupwA=;
  b=dkifJXVFwQIvky98IALJMTF4AOT4zh980e/CDU0RIIWTJaDAJxLncehr
   1sQmmeoBuw9gbqfHMKnP6fpasX2g7gXghK036HOq7HN49BAQxUgZQyac8
   5d0ac6+ezOlA/vNdqmZ157jsuOKLhoVuuFpzA8qMSOUW6w1K5JPh1hC6n
   NDv5G009d1cVYtUp8VGz7Edb2EDdwfikkUBBipJLKoJxvdENClqbvqWno
   j8kgZwAVx0XqKJKb/IsAD4QHFIU1zal5Q10bYjt5ewEWvWJj7veTq6WX5
   aj2fvPonyFp3kK54RgI05neEatSUUENAYXIKFJ6gY7InYOwZ9/5V270Yp
   A==;
X-CSE-ConnectionGUID: QTxhzvTRRiy1IVvm8xyavg==
X-CSE-MsgGUID: TIe18j5nS9u2EFTRpKGFNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87784717"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87784717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:10:00 -0700
X-CSE-ConnectionGUID: 6GI8G2BMRIaDCl86RDfdbw==
X-CSE-MsgGUID: ztP4ZnSqS1W+aA3bPsP29Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="289291727"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:09:58 -0700
Message-ID: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
Date: Thu, 20 Aug 2026 11:09:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in
 submission range
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260805042012.2363698-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260805042012.2363698-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 12:20, Guanghui Feng wrote:
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

Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per 
qi_submit_sync()")
Cc: stable@vger.kernel.org

> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
> ---
>   drivers/iommu/intel/dmar.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 767ec092accd..8ae513593406 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1290,8 +1290,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   	 * is cleared.
>   	 */
>   	if (fault & DMA_FSTS_IQE) {
> +		int head_idx;
> +
>   		head = readl(iommu->reg + DMAR_IQH_REG);
> -		if ((head >> shift) == index) {
> +		head_idx = head >> shift;

How about adding a brief comment like this?

	/*
	 * The faulting descriptor can be anywhere within the current
	 * submission's range [index, wait_index]. Since the queue is
	 * circular, this submission may wrap around QI_LENGTH
	 * (index > wait_index in that case), so check both the
	 * non-wrapped and wrapped cases of the range.
	 */

> +		if (index <= wait_index ?
> +		    (head_idx >= index && head_idx <= wait_index) :
> +		    (head_idx >= index || head_idx <= wait_index)) {
>   			struct qi_desc *desc = qi->desc + head;
>   
>   			/*

Otherwise, this looks good to me.

Thanks,
baolu
