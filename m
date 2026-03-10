Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C140DFB7
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147545; cv=none; b=KvRl6sjn4bCytjJ1Yy8KTsHKCiUFHbZxIkoOvlweuO0oMVN2QYcY3mxnzg15rmGu4bttxMWowuTsdTYvIIgl7AphKIy7OB++9khoBENMBSb9hmz2YXNUFEfy+LXuKROb9KvFx6PF+ZtnO1Z+4PtHB+KS6nl+QH+1zCIZJxBI1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147545; c=relaxed/simple;
	bh=MNPtxubD3xONx0kCWlyqSRA8MJGsFnkga3ZPB/ouL+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzlBZoeaSL8IIQVdVcaq3U172XPzASUeWDgEPBfemYRU7yUFhLYuT0FyJSme2B5gNWbUWw/smRxryP/aIWLjSKTrMl7+aIVrU8rUonMNxCZtzB/0GZT7nHB85bfh+EfqQEXwCgfRrUee4aMyoIeZ/jPTwmZFiCrWOME17XevnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wk0keUHb; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wk0keUHb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773147539; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TPnyKj9py6c+SERsOnyWkfKGlAsbair3+7xhPihuwZ4=;
	b=wk0keUHbvPP/KlEbfuubUthYZYnczXaF2WFy8fLf7GBRQQpFjd2qkccMsM5SSSWCtcNUlkoe8heBgEmWr3hb0P+fc6nInnXZuZnB9KK18PjYcl2CdgN8lJktqRc9+C4O1hC9fjAC6v/qxrsxHKK7HcVDeKdvIhvk3Fy8FBKLIr4=
Received: from 30.246.163.43(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X-gIK59_1773147538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 20:58:58 +0800
Message-ID: <92f15414-3f8a-49c7-80e9-408703e41ab5@linux.alibaba.com>
Date: Tue, 10 Mar 2026 20:59:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/vt-d: fix intel iommu iotlb sync hardlockup and
 retry
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, baolu.lu@linux.intel.com,
 dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260306101516.3885775-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/26 6:15 PM, Guanghui Feng wrote:
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

Hi, all

I hacked IOMMU driver to submit a duplicate desc to trigger the bug:

@@ -1435,6 +1463,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
         s64 iec_start_ktime = 0;
         struct qi_desc wait_desc;
         int wait_index, index;
+       int dup_slot = -1;
         unsigned long flags;
         int offset, shift;
         int rc, i;
@@ -1466,7 +1495,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
          * the calculation is based on:
          * # of desc + 1 wait desc + 1 space between head and tail
          */
-       while (qi->free_cnt < count + 2) {
+       while (qi->free_cnt < count + 3) {
                 raw_spin_unlock_irqrestore(&qi->q_lock, flags);
                 cpu_relax();
                 raw_spin_lock_irqsave(&qi->q_lock, flags);
@@ -1476,6 +1505,24 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
         wait_index = (index + count) % QI_LENGTH;
         shift = qi_shift(iommu);

+       /*
+        * DEBUG HACK: force wait_index to even position to reproduce the
+        * ITE qi_check_fault bug where "head |= 1" causes the traversal
+        * to skip even-indexed wait_desc. Duplicate desc[0] as an extra
+        * submission when wait_index would be odd, so it stays harmless
+        * (same request type, same content, just redundant).
+        */
+       if (wait_index & 1) {
+               dup_slot = index;
+               offset = index << shift;
+               memcpy(qi->desc + offset, &desc[0], 1 << shift);
+               qi->desc_status[index] = QI_IN_USE;
+               index = (index + 1) % QI_LENGTH;
+               qi->free_head = index;
+               qi->free_cnt--;
+               wait_index = (index + count) % QI_LENGTH;
+       }
+
         for (i = 0; i < count; i++) {
                 offset = ((index + i) % QI_LENGTH) << shift;
                 memcpy(qi->desc + offset, &desc[i], 1 << shift);
@@ -1532,6 +1579,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
          */
         for (i = 0; i <= count; i++)
                 qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
+       if (dup_slot >= 0)
+               qi->desc_status[dup_slot] = QI_FREE;

When head is odd and tail is even, qi_check_fault will loop infinitely
in the abort loop without this patch, since step -2 only visits
odd-indexed slots and never reaches the even-valued tail. With step -1,
the loop correctly visits all slots and terminates as expected.

     DMAR: VT-d detected Invalidation Time-out Error: SID 603
     DMAR: QI HEAD: Invalidation Wait qw0 = 0x200000025, qw1 = 0x100364878
     DMAR: DRHD: handling fault status reg 40
     DMAR: QI PRIOR: Device-TLB Invalidation qw0 = 0x600060300000003, qw1 = 0x7ffffffffffff001
     DMAR: Invalidation Time-out Error (ITE) cleared
     DMAR: ITE debug: head=29 tail=32 wait_index=32
     DMAR: ITE debug: after loop, desc_status[wait_index=32]=2

Free free to add:

Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai


