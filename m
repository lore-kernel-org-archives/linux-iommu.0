Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE4377ECC
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047146; cv=none; b=ByE7/WnfIa63ITaALE6vml3GgKHizzeCBlggwEuAFhFGp4fP+WP7fRKPsw1ZCbNnGR0Ny7mHuXwQpFAg2xyi1ET06a5yhSDVwz9Ih49Bom+0ydGS6r1Q2+ZEsLta+RhKaWcV/ki3qTNmGEklTLRRLz7t8tKw8VecGojKjzjy+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047146; c=relaxed/simple;
	bh=sV9ElFIwRkyf+zjiy2atRWnopV3CpK46mZXHfI/0WBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3sqs1lBKD6/dWbyjrr5z4ES0deCL9GXCpjxFPnhFcBw0Ts7QritpEW2JxeBbN5cViCLruJ4vQWKft1QCvcyJ5HGimdj9gorYVsQKj4dqzto4Jbo1OYQYjTuVuFVl91MpmX0IuoaElT0bagBwQWfxIY0hyFqb+kfK1V4hSaA1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i87Mn+G5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i87Mn+G5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773047137; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=8NhbjM007yXzMLCENKOCvFTWgxmUHEkIxUdjeaSgnjs=;
	b=i87Mn+G5i/Wczry5S39yVtGq2ZSwgoH2CShRR5XMqkB51bhFXuMDjAUGn01QgyL7VlxlDyEPGtCVoPkLZR7lhQMKva2flCOAzFXF5Sj6aNpjmb9JJ4HY2b8GP4t/P2xRtmLZbeNTJorksTH4u7CZFPy5eHEzsOU7vdGSbwPazS0=
Received: from 30.221.131.23(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X-WvXzO_1773047126 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 17:05:35 +0800
Message-ID: <f6af2887-a524-4bb0-8ea8-acdca50e66fe@linux.alibaba.com>
Date: Mon, 9 Mar 2026 17:05:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
To: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
 skhawaja@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

There are some concerns:

1. During the invalid request execution process, the IOMMU first fetches 
requests

     from the invalid queue to the internal cache.


2. If an ITE timeout occurs during the execution of a request fetched to 
the cache in step 1,

     the IOMMU driver clears the ITE status, allowing IOMMU to resume 
processing requests from the invalid queue.


3. For requests already fetched in step 1 that experience an ITE 
timeout, after the IOMMU driver clears the ITE,

     will IOMMU directly discard these timed-out/cached requests? or 
will it continue to execute these cached requests again?


Currently, the IOMMU driver implementation first clears ite to resume 
IOMMU execution

before setting desc_status to QI_ABORT.

If IOMMU will re-execute requests from the cache, then the IOMMU driver 
needs to be modified.

It should first set desc_status to QI_ABORT, then execute 
writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG)

to resume IOMMU execution(In this case, some requests will be 
resubmitted and executed twice.).

Otherwise, iommu may write the QI_DONE result back to desc_status after 
execution, and the iommu driver will

simultaneously set desc_status to QI_ABORT, leading to data modification 
contention and timing issues.


Thanks.


在 2026/3/6 18:15, Guanghui Feng 写道:
> During the qi_check_fault process after an IOMMU ITE event,
> requests at odd-numbered positions in the queue are set to
> QI_ABORT, only satisfying single-request submissions. However,
> qi_submit_sync now supports multiple simultaneous submissions,
> and can't guarantee that the wait_desc will be at an odd-numbered
> position. Therefore, if an item times out, IOMMU can't re-initiate
> the request, resulting in an infinite polling wait.
>
> This patch modifies the process by setting the status of all requests
> already fetched by IOMMU and recorded as QI_IN_USE status (including
> wait_desc requests) to QI_ABORT, thus enabling multiple requests to
> be resubmitted.
>
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>   drivers/iommu/intel/dmar.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d68c06025cac..69222dbd2af0 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   	if (fault & DMA_FSTS_ITE) {
>   		head = readl(iommu->reg + DMAR_IQH_REG);
>   		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
> -		head |= 1;
>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>   
> @@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   		do {
>   			if (qi->desc_status[head] == QI_IN_USE)
>   				qi->desc_status[head] = QI_ABORT;
> -			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
> +			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
>   		} while (head != tail);
>   
>   		/*
