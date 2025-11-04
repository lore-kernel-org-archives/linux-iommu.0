Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207C33F8A4
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280743; cv=none; b=pB3QR6ZrzngWHFwlrOiYRvTUh4rr9K43G0F1M8y5dgPHJIlxnxhLHVvaaCLxMyMzHCZqLBNBXUvaeA2XzE5+kn2Li7hPDgFjc8aaFwNKCidZF3y6UyGkFBaqTCLqRUl7UQPXF8mj0VtXgeCDDNqrb76/cY+PIHIQYyj5SuLh4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280743; c=relaxed/simple;
	bh=R0WzQZ2eAWcgFdw6UFqXxOnbz12aR8pFzKAsf70px8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B21WNOXPsFZGq9HSBJ8PfRXA+igZEaEELLYloRKjtXnILayo0lcGlPnmIOs6CxQAePkxH6QS4Xyq3v2hvXl+9FA1jX8jKhNEbMExg0w9wMoEU/jZj/BLy+CgPpuNTRuiCHvtefYXCqbP+/kp4uyULtlzyTxYtckjsr/mh2ptamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W/YFme5J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W/YFme5J"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6150420120A5;
	Tue,  4 Nov 2025 10:25:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6150420120A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762280740;
	bh=WdskQM+QspCrSjFnE3pe3t3FXVlQNkGV5vIeU9z2J5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/YFme5J80beBzeExVaXRS8yDspmj1/KiAMjubeXlv0FUUUeyP2ZYFmFkQMzd0Hsv
	 /j2d063ChqDhdKLzNEU8KWXVN5yIzPf0q8BKXd1nmnWy1ry5z+6ER9lxD2t0TosYSq
	 5Tx8JA4j05NYQv1SroRR2jFmzzgDDel/s5ExLSck=
Date: Tue, 4 Nov 2025 10:25:39 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251104102539.00001110@linux.microsoft.com>
In-Reply-To: <aQlVjtTiqd34I+NC@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
	<20251020224353.1408-2-jacob.pan@linux.microsoft.com>
	<aQPptXsqzt6kJS7f@Asurada-Nvidia>
	<20251103151631.0000703a@linux.microsoft.com>
	<aQlVjtTiqd34I+NC@Asurada-Nvidia>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On Mon, 3 Nov 2025 17:23:26 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Mon, Nov 03, 2025 at 03:16:31PM -0800, Jacob Pan wrote:
> > On Thu, 30 Oct 2025 15:41:57 -0700 Nicolin Chen
> > <nicolinc@nvidia.com> wrote:  
> > > On Mon, Oct 20, 2025 at 03:43:52PM -0700, Jacob Pan wrote:
> > > I still feel that we could just replace the _until_not_full()
> > > with a _until_has_space()?  
> 
> > Since the current code uses three nested while loops, replacing the
> > inner _until_not_full() function means means retaining all three
> > nested while loops and calling queue_has_space in two places - once
> > in the middle while loop then again in this _until_has_space()
> > function.
> > 
> > I tried to extract the inner loop into a function but it requires
> > passing in irqflags to restore. Not pretty.  
> 
> I think we could do:
> 
> -----------------------------------------------------------------
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> 2a8b46b948f05..1211e087dedca 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -138,12 +138,6 @@
> static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
> return space >= n; }
>  
> -static bool queue_full(struct arm_smmu_ll_queue *q)
> -{
> -	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
> -	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
> -}
> -
>  static bool queue_empty(struct arm_smmu_ll_queue *q)
>  {
>  	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
> @@ -633,14 +627,13 @@ static void arm_smmu_cmdq_poll_valid_map(struct
> arm_smmu_cmdq *cmdq, __arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod,
> eprod, false); }
>  
> -/* Wait for the command queue to become non-full */
> -static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device
> *smmu,
> -					     struct arm_smmu_cmdq
> *cmdq,
> -					     struct
> arm_smmu_ll_queue *llq) +/* Poll command queue PROD and CONS, using a
> continued timer */ +static inline void arm_smmu_cmdq_poll(struct
> arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq *cmdq,
> +				      struct arm_smmu_ll_queue *llq,
> +				      struct arm_smmu_queue_poll *qp)
>  {
>  	unsigned long flags;
> -	struct arm_smmu_queue_poll qp;
> -	int ret = 0;
>  
>  	/*
>  	 * Try to update our copy of cons by grabbing exclusive cmdq
> access. If @@ -650,19 +643,18 @@ static int
> arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
> WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
> arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags); llq->val =
> READ_ONCE(cmdq->q.llq.val);
> -		return 0;
> +		return;
>  	}
>  
> -	queue_poll_init(smmu, &qp);
> -	do {
> -		llq->val = READ_ONCE(cmdq->q.llq.val);
> -		if (!queue_full(llq))
> -			break;
> -
> -		ret = queue_poll(&qp);
> -	} while (!ret);
> -
> -	return ret;
> +	/* queue_poll() returns 0 or -ETIMEDOUT only */
> +	if (queue_poll(qp)) {
I would still prefer more a defensive approach to prevent future change
of queue_poll returning other error being treated as ETIMEOUT.

> +		dev_err_ratelimited(smmu->dev,
> +				    "CMDQ timeout at prod 0x%08x
> cons 0x%08x\n",
> +				    llq->prod, llq->cons);
> +		/* Restart the timer */
> +		queue_poll_init(smmu, qp);
> +	}
> +	llq->val = READ_ONCE(cmdq->q.llq.val);
>  }
>  
>  /*
> @@ -804,12 +796,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct
> arm_smmu_device *smmu, local_irq_save(flags);
>  	llq.val = READ_ONCE(cmdq->q.llq.val);
>  	do {
> +		struct arm_smmu_queue_poll qp;
>  		u64 old;
>  
> +		queue_poll_init(smmu, &qp);
>  		while (!queue_has_space(&llq, n + sync)) {
>  			local_irq_restore(flags);
> -			if (arm_smmu_cmdq_poll_until_not_full(smmu,
> cmdq, &llq))
> -				dev_err_ratelimited(smmu->dev, "CMDQ
> timeout\n");
> +			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
>  			local_irq_save(flags);
>  		}
>  
yeah, that should work. it is more readable than open coding.

> -----------------------------------------------------------------
> 
> And the commit message should point out:
> 
> The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit
> efficiently nor ideally to the only caller
> arm_smmu_cmdq_issue_cmdlist():
>  - It uses a new timer at every single call, which fails to limit to
> the preset ARM_SMMU_POLL_TIMEOUT_US per issue.
Not following what you mean.
The original code below does honor the timeout of
ARM_SMMU_POLL_TIMEOUT_US

-       queue_poll_init(smmu, &qp);
-       do {
-               llq->val = READ_ONCE(cmdq->q.llq.val);
-               if (!queue_full(llq))
-                       break;
-
-               ret = queue_poll(&qp);
-       } while (!ret);

>  - It has a redundant internal queue_full(), which doesn't detect
> whether there is a enough space for number of n commands.
will incorporate, though the same points already mentioned in the
current commit message.
 
> So, rework it to be an inline helper to work with the
> queue_has_space().
> 

> Nicolin

