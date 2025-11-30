Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7E2E174B
	for <iommu@lists.linux.dev>; Sun, 30 Nov 2025 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543989; cv=none; b=FPxJkv05O5eEepzTZ3eC3Dn6+dULcv46iC45fCfbqvMEIxWtTF+LT+8BdF9IdR3zbFMnLSDziq75Va15eAB45AdaqEVtA0JvXw9HRq8VNCiYm8vOi20bnPAPBpnRIK+RE9vwXqxdcZ/zYe4tBnK9lce7ZQoohVNHYVHfGkb9qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543989; c=relaxed/simple;
	bh=g5yvOzo7c6xX6rYopnZszTcS5wvfEhudD5Qk2af7SaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0qH/So9IjaT9aFcY+8lqAtxBvPhYAWcm+ecr99UyEKKvV9r2hSrwUbeTQdtuzJG4cIlU6378140K4BwBopxrE1ZM6KFwMsQl++wO+dBI3AHh/a84YTdnJkoJOk4PHZ5ZylFhBsfHKWDU0KxNoQLnuYvS4akr+PM3OalKkKqYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XBU5NBBF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XBU5NBBF"
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE149200DFD7;
	Sun, 30 Nov 2025 15:06:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE149200DFD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764543986;
	bh=RnUpxN1N4KtYTM7ucfVIdft/DvXqIYr8m/DVjMFJWjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XBU5NBBFy6mc6MZK1lrNzAGwIV8cz5wl+jqCgLKaLjFjg1k+WLcFKDnpi38Nx7p+k
	 Xm8f3bqETJGYM2/FD6XxHALXkWASQ1u9OufyFp0nCtfyM6q5tZjWPtVOYZhu5vsgmz
	 MFSkJ4j8oZmpw0j148nYRagEZzNI6MGkn0RmYhYs=
Date: Sun, 30 Nov 2025 15:06:24 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251130150624.000053e7@linux.microsoft.com>
In-Reply-To: <aSXlFDAa672dZGVm@willie-the-truck>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
	<20251114171718.42215-2-jacob.pan@linux.microsoft.com>
	<aSXlFDAa672dZGVm@willie-the-truck>
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

Hi Will,

On Tue, 25 Nov 2025 17:19:16 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Nov 14, 2025 at 09:17:17AM -0800, Jacob Pan wrote:
> > While polling for n spaces in the cmdq, the current code instead
> > checks if the queue is full. If the queue is almost full but not
> > enough space (<n), then the CMDQ timeout warning is never triggered
> > even if the polling has exceeded timeout limit.
> > 
> > The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit
> > efficiently nor ideally to the only caller
> > arm_smmu_cmdq_issue_cmdlist():
> >  - It uses a new timer at every single call, which fails to limit
> > to the preset ARM_SMMU_POLL_TIMEOUT_US per issue.
> > - It has a redundant internal queue_full(), which doesn't detect
> > whether there is a enough space for number of n commands.
> > 
> > This patch polls for the availability of exact space instead of
> > full and emit timeout warning accordingly.
> > 
> > Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during
> > command-queue insertion") Co-developed-by: Yu Zhang
> > <zhangyu1@linux.microsoft.com> Signed-off-by: Yu Zhang
> > <zhangyu1@linux.microsoft.com> Signed-off-by: Jacob Pan
> > <jacob.pan@linux.microsoft.com>  
> 
> I'm assuming you're seeing problems with an emulated command queue?
> Any chance you could make that bigger?
> 
This is not related to queue size, but rather a logic issue when
anytime queue is nearly full.

> > @@ -804,12 +794,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct
> > arm_smmu_device *smmu, local_irq_save(flags);
> >  	llq.val = READ_ONCE(cmdq->q.llq.val);
> >  	do {
> > +		struct arm_smmu_queue_poll qp;
> >  		u64 old;
> >  
> > +		queue_poll_init(smmu, &qp);
> >  		while (!queue_has_space(&llq, n + sync)) {
> >  			local_irq_restore(flags);
> > -			if
> > (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> > -				dev_err_ratelimited(smmu->dev,
> > "CMDQ timeout\n");
> > +			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
> >  
> 
> Isn't this broken for wfe-based polling? The SMMU only generates the
> wake-up event when the queue becomes non-full.
I don't see this is a problem since any interrupts such as scheduler
tick can be a break evnt for WFE, no?

I have also tested this with WFE on BM with no issues. HyperV VM does
not support WFE.

