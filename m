Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D103B9D83
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539814; cv=none; b=CsGnnkpb3Bo5ylnAAfInAKz0J1Jyl+/ituhmxSBITvi69hJTJzhU8VSd3znY7ROYTx58NXtOwgUkHP9CM51XyZr/+XZinEUPQaZPBhyAfWcfQbKmJl3ZVouXYV9MCqR/N+tvIKck1BvbTRjvOsEK8z63HkFLsd1C8uM1BGt/Rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539814; c=relaxed/simple;
	bh=KUtBdq12OEY1wSIMIJXVPi81koLSIF0WSo9YTwXXD4s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oO4kTyvbPdI74Y2NlWeUpgx2JIvi0kKue8TrqTKU+Oa4JuhEtt+4+ocWWUQ7rZGTMU0EOOeEFR8xOkMLvc+1Ah/0rMWrra4CwEeMHXtpJdVAvcitGuzv/RW9kc7lFhhtRJPIihHTwRDkh7Gh3N3BrfNbNSvYWqS5qXlVMV7hMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brqwwvhe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brqwwvhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789539813; x=1821075813;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KUtBdq12OEY1wSIMIJXVPi81koLSIF0WSo9YTwXXD4s=;
  b=brqwwvhecDCJGLjTTaKDKp7BcYGH8JjyPr+irR4/qaSuM5X+/6nCwxkT
   bD2hn2AVQPnl95XlPFUjBEV8BQvYdvniTJMos1z8nwrzHvzko0nD8Oc2r
   xF8UDBWT9MSJxg+e1tJrSjLU2bnNO7yDuHB3q8wqVTQOGfxlkL2unh9If
   w7zyJnfdJhFzEg4doctOeFM+kbetOo8uHdRfExK0gw8kT/SR9IHL0QEpK
   ACxRwv2bnaNh9zV0AyG6N6ukA1a92SpO4cOqh+3W4Zej9VwNhdGePXm60
   q7MaNwhnfDkGfpfL+P4yqc82sGyQk57gAVESItmKe0QXjx1ymEzbtO7QK
   w==;
X-CSE-ConnectionGUID: OAB9mT1qQdWk7inIvD+fxA==
X-CSE-MsgGUID: o79xXDaZTsCoRSSWz8+Zlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93612114"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93612114"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:23:32 -0700
X-CSE-ConnectionGUID: mkW9Ij6OR6qOzjT60bIdvw==
X-CSE-MsgGUID: NUUKZEE9SvOVMQPDRRHlfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271796302"
Received: from unknown (HELO [10.238.1.188]) ([10.238.1.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:23:30 -0700
Message-ID: <e56a23f2-216c-41ea-991d-495962e6b7af@linux.intel.com>
Date: Wed, 16 Sep 2026 14:23:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, bikuan.zbk@alibaba-inc.com,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v3] iommu/vt-d: Fix IQE handling to cover all descriptors
 in submission range
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
References: <2c0d1b6d-6844-4413-b399-1000cc6712e4@linux.intel.com>
 <20260914141958.584919-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260914141958.584919-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/14/2026 10:19 PM, Guanghui Feng wrote:
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
> overwrite the stranded slots in [IQH, wait_index) with no-op wait
> descriptors, resubmit the wait descriptor at wait_index, then clear IQE.
> The caller's existing poll loop naturally waits for QI_DONE — which per
> VT-d spec §6.5.2.12 is only written after ALL preceding descriptors
> complete — guaranteeing hardware has fully drained the batch before
> slots are reclaimed.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
> ---
>   drivers/iommu/intel/dmar.c | 78 ++++++++++++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ba675b08cd20..db92fb247131 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1344,6 +1344,43 @@ static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
>   	       (unsigned long long)desc->qw1);
>   }
>   
> +/**
> + * qi_drain_remaining_descs - drain descriptors stranded by an IQE
> + * @iommu: the affected IOMMU
> + * @wait_index: slot index of the wait descriptor of the current submission
> + * @shift: qi_shift(iommu), converts a slot index into a byte offset
> + * @options: QI_OPT_* flags of the current submission
> + *
> + * Overwrite the slots in [IQH, @wait_index) with no-op descriptors, resubmit
> + * the wait descriptor at @wait_index, and clear IQE so hardware resumes and
> + * eventually signals QI_DONE. Must be called with qi->q_lock held.
> + */
> +static void qi_drain_remaining_descs(struct intel_iommu *iommu,
> +				     int wait_index, int shift,
> +				     unsigned long options)

This is only an internal helper, so there is no need to add a kernel-doc
comment like this.

> +{
> +	struct q_inval *qi = iommu->qi;
> +	struct qi_desc desc;
> +	int head_idx;
> +	int cur;
> +
> +	head_idx = (readl(iommu->reg + DMAR_IQH_REG)) >> shift;
> +
> +	memset(&desc, 0, sizeof(desc));
> +	desc.qw0 = QI_IWD_TYPE;
> +	for (cur = head_idx; cur != wait_index; cur = (cur + 1) % QI_LENGTH)
> +		memcpy(qi->desc + (cur << shift), &desc, 1 << shift);
> +
> +	desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
> +			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
> +	if (options & QI_OPT_WAIT_DRAIN)
> +		desc.qw0 |= QI_IWD_PRQ_DRAIN;
> +	desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
> +	memcpy(qi->desc + (wait_index << shift), &desc, 1 << shift);
> +
> +	writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
> +}

I would like this helper to be self-contained; that is, it should
replace all abandoned descriptors with wait descriptors and then wait
until hardware fetch passes those descriptors. Something like this (not
tested yet):

+static int qi_drain_remaining_descs(struct intel_iommu *iommu, int head,
+				    int wait_index)
+{
+	struct q_inval *qi = iommu->qi;
+	int shift = qi_shift(iommu);
+	struct qi_desc wait_desc = {};
+	struct qi_desc nop_desc = {};
+	cycles_t start;
+
+	nop_desc.qw0 = QI_IWD_FENCE | QI_IWD_TYPE;
+
+	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
+			QI_IWD_STATUS_WRITE | QI_IWD_FENCE | QI_IWD_TYPE;
+	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
+
+	while (head != wait_index) {
+		memcpy(qi->desc + (head << shift), &nop_desc, 1 << shift);
+		head = (head + 1) % QI_LENGTH;
+	}
+
+	WRITE_ONCE(qi->desc_status[wait_index], QI_IN_USE);
+	memcpy(qi->desc + (wait_index << shift), &wait_desc, 1 << shift);
+
+	/*
+	 * Order the descriptor rewrites before the writel() that restarts
+	 * the fetch engine.
+	 */
+	wmb();
+
+	writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
+
+	start = get_cycles();
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
+		if (DMAR_OPERATION_TIMEOUT < (get_cycles() - start)) {
+			pr_err("Timeout draining invalidation queue after IQE\n");
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+	}
+
+	return 0;
+}

> +
>   static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   {
>   	u32 fault;
> @@ -1366,21 +1403,22 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>   	 * is cleared.
>   	 */
>   	if (fault & DMA_FSTS_IQE) {
> +		int head_idx;
> +
>   		head = readl(iommu->reg + DMAR_IQH_REG);
> -		if ((head >> shift) == index) {
> -			struct qi_desc *desc = qi->desc + head;
> +		head_idx = head >> shift;
>   
> -			/*
> -			 * desc->qw2 and desc->qw3 are either reserved or
> -			 * used by software as private data. We won't print
> -			 * out these two qw's for security consideration.
> -			 */
> -			memcpy(desc, qi->desc + (wait_index << shift),
> -			       1 << shift);
> -			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
> -			pr_info("Invalidation Queue Error (IQE) cleared\n");
> +		/*
> +		 * The faulting descriptor can be anywhere within the current
> +		 * submission's range [index, wait_index]. Since the queue is
> +		 * circular, this submission may wrap around QI_LENGTH
> +		 * (index > wait_index in that case), so check both the
> +		 * non-wrapped and wrapped cases of the range.
> +		 */
> +		if (index <= wait_index ?
> +		    (head_idx >= index && head_idx <= wait_index) :
> +		    (head_idx >= index || head_idx <= wait_index))
>   			return -EINVAL;
> -		}
>   	}

Then call the above helper directly here.

@@ -1366,18 +1409,25 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
  	 * is cleared.
  	 */
  	if (fault & DMA_FSTS_IQE) {
+		int head_idx, ret;
+
  		head = readl(iommu->reg + DMAR_IQH_REG);
-		if ((head >> shift) == index) {
-			struct qi_desc *desc = qi->desc + head;
+		head_idx = (head >> shift) % QI_LENGTH;
+
+		/*
+		 * The faulting descriptor can be anywhere within the current
+		 * submission's range [index, wait_index]. Since the queue is
+		 * circular, this submission may wrap around QI_LENGTH
+		 * (index > wait_index in that case), so check both the
+		 * non-wrapped and wrapped cases of the range.
+		 */
+		if (index <= wait_index ?
+		    (head_idx >= index && head_idx <= wait_index) :
+		    (head_idx >= index || head_idx <= wait_index)) {
+			ret = qi_drain_remaining_descs(iommu, head_idx, wait_index);
+			if (ret)
+				return ret;

-			/*
-			 * desc->qw2 and desc->qw3 are either reserved or
-			 * used by software as private data. We won't print
-			 * out these two qw's for security consideration.
-			 */
-			memcpy(desc, qi->desc + (wait_index << shift),
-			       1 << shift);
-			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
  			pr_info("Invalidation Queue Error (IQE) cleared\n");
  			return -EINVAL;
  		}

>   
>   	/*
> @@ -1452,7 +1490,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	int wait_index, index;
>   	unsigned long flags;
>   	int offset, shift;
> -	int rc, i;
> +	int rc = 0, fault, i;
>   	u64 type;
>   
>   	if (!qi)
> @@ -1528,9 +1566,19 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   		 * a deadlock where the interrupt context can wait indefinitely
>   		 * for free slots in the queue.
>   		 */
> -		rc = qi_check_fault(iommu, index, wait_index);
> -		if (rc)
> +		fault = qi_check_fault(iommu, index, wait_index);
> +		if (fault == -EINVAL) {
> +			/*
> +			 * IQE in our batch: drain the remaining descriptors
> +			 * and keep polling until hardware completes.
> +			 */
> +			qi_drain_remaining_descs(iommu, wait_index, shift,
> +						  options);
> +			rc = -EINVAL;
> +		} else if (fault) {
> +			rc = fault;
>   			break;
> +		}

As a result, there is no need to change the caller of qi_check_fault().

>   
>   		raw_spin_unlock(&qi->q_lock);
>   		cpu_relax();

Thanks,
baolu
