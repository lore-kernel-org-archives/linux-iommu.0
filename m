Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3A1F584C
	for <iommu@lists.linux.dev>; Sun, 19 Oct 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760851958; cv=none; b=TWfN4xeE78pLZoVOJroj9RHPeW0nWJ4dSPlg7w4M6TLEbgGj/vkp40lrj3M2nC8rm84fySjBeMH0FI6iYTZoy1k6rl2tygmnDPTtL2GVWA/I59X3Z5Y1Ax8jMka2PIlQELmTm+Ei2/D/yCH+qCfhLnYkeV+/kyqSPNJ2jwsgTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760851958; c=relaxed/simple;
	bh=auvBzOHy8mqDxDox8yVlPg29HCGxPLPcO6/REPYPsEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdJ6rwflfBeu8Y1WX3H9HRHrb64v+ZyN/+M8QrkGY4+1+abdtdnYOd97LvlQVnQhcQirOP0yuZnfoy9OG05C7UqGlYuX8twkBp/d3tFBcYfunI/m3CayMxFql4CvIRhtngFHpf73qEDCNrqb2xIz+gsXSgj3crdftKHNSMeP8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GG+IKFTF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GG+IKFTF"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A620320145B6;
	Sat, 18 Oct 2025 22:32:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A620320145B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760851950;
	bh=zvjRO3+lNPqmC2L9Fk1X5NWMcmOrpzqKtgUxpYAXtZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GG+IKFTFl+IbTwk9/qoxkHu0oChT1BD0uuhMHFe85aO9krgLNC7C3D9KXTYpeWpTk
	 PkiJt0dAVeC16YuoGLzbJ0uQOBx7e0aV7ZNX+kElN3g4Vwae4vX3t1/hBxmGlPPl2M
	 yW/ONpZp7yqHNRXC7jQFwiyiceJ6XYxiW2Vkv/Yc=
Date: Sat, 18 Oct 2025 22:32:28 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Zhang Yu <zhangyu1@linux.microsoft.com>, Jean
 Philippe-Brucker <jean-philippe@linaro.org>, Alexander Grest
 <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <20251018223228.00005eff@linux.microsoft.com>
In-Reply-To: <aPIiuLj9c4IJlmIn@google.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<20250924175438.7450-3-jacob.pan@linux.microsoft.com>
	<aPIiuLj9c4IJlmIn@google.com>
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

On Fri, 17 Oct 2025 11:04:24 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> On Wed, Sep 24, 2025 at 10:54:38AM -0700, Jacob Pan wrote:
> > From: Alexander Grest <Alexander.Grest@microsoft.com>
> > 
> > The SMMU CMDQ lock is highly contentious when there are multiple
> > CPUs issuing commands on an architecture with small queue sizes e.g
> > 256 entries.
> > 
> > The lock has the following states:
> >  - 0:		Unlocked  
> >  - >0:		Shared lock held with count  
> >  - INT_MIN+N:	Exclusive lock held, where N is the # of
> > shared waiters
> >  - INT_MIN:	Exclusive lock held, no shared waiters
> > 
> > When multiple CPUs are polling for space in the queue, they attempt
> > to grab the exclusive lock to update the cons pointer from the
> > hardware. If they fail to get the lock, they will spin until either
> > the cons pointer is updated by another CPU.
> > 
> > The current code allows the possibility of shared lock starvation
> > if there is a constant stream of CPUs trying to grab the exclusive
> > lock. This leads to severe latency issues and soft lockups.
> > 
> > To mitigate this, we release the exclusive lock by only clearing
> > the sign bit while retaining the shared lock waiter count as a way
> > to avoid starving the shared lock waiters.
> > 
> > Also deleted cmpxchg loop while trying to acquire the shared lock
> > as it is not needed. The waiters can see the positive lock count
> > and proceed immediately after the exclusive lock is released.
> > 
> > Exclusive lock is not starved in that submitters will try exclusive
> > lock first when new spaces become available.
> > 
> > In a staged test where 32 CPUs issue SVA invalidations
> > simultaneously on a system with a 256 entry queue, the madvise
> > (MADV_DONTNEED) latency dropped by 50% with this patch and without
> > soft lockups.
> > 
> > Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24
> > ++++++++++++--------- 1 file changed, 14 insertions(+), 10
> > deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> > 9b63525c13bb..9b7c01b731df 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -481,20 +481,19 @@
> > static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu) */
> >  static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
> >  {
> > -	int val;
> > -
> >  	/*
> > -	 * We can try to avoid the cmpxchg() loop by simply
> > incrementing the
> > -	 * lock counter. When held in exclusive state, the lock
> > counter is set
> > -	 * to INT_MIN so these increments won't hurt as the value
> > will remain
> > -	 * negative.
> > +	 * We can simply increment the lock counter. When held in
> > exclusive
> > +	 * state, the lock counter is set to INT_MIN so these
> > increments won't
> > +	 * hurt as the value will remain negative. This will also
> > signal the
> > +	 * exclusive locker that there are shared waiters. Once
> > the exclusive
> > +	 * locker releases the lock, the sign bit will be cleared
> > and our
> > +	 * increment will make the lock counter positive, allowing
> > us to
> > +	 * proceed.
> >  	 */
> >  	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
> >  		return;
> >  
> > -	do {
> > -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >=
> > 0);
> > -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1)
> > != val);
> > +	atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);  
> 
> I think that should be "VAL > 0", as it is guaranteed that we hold
> the shared lock at this point.
> 
Indeed, will do.

Though there is no functional difference since we did inc already, VAL
will never be 0 when it comes to this line.

> Otherwise,
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> 
> Thanks,
> Mostafa
> 
> >  }
> >  
> >  static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
> > @@ -521,9 +520,14 @@ static bool
> > arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
> > __ret;
> > 	\ }) 
> > +/*
> > + * Only clear the sign bit when releasing the exclusive lock this
> > will
> > + * allow any shared_lock() waiters to proceed without the
> > possibility
> > + * of entering the exclusive lock in a tight loop.
> > + */
> >  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq,
> > flags)		\ ({
> > 				\
> > -	atomic_set_release(&cmdq->lock, 0);
> > 	\
> > +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);
> > 			\ local_irq_restore(flags);
> > 			\ })
> >  
> > -- 
> > 2.43.0
> >   

