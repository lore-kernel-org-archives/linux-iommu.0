Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AC1DE3DB
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860973; cv=none; b=HDbkbZVYuWyYxqTnX8R72Z7yzdvGLDfu4gLynlQEf7mMGl073jvmKQEqVwjiYaa/KNvB7xmHfGtos9D0CQQplcZ6pry1Mt+lNiWCaYeQDXejdY2wRDCPrRlD+NCa3rb65liL9nlhI6AeQTlLf9Kjgj2ACk32D8lUjNIcxLWKWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860973; c=relaxed/simple;
	bh=IJn6+OEr5PRU7LqFeUIorEgBVqq+3a+QNqJUq7/206c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC7gZ6icP382tpQBEZpvEteR7n+Z2FhxiQ00WU+FAuA+IFRC93f00LwmCMjWZ7wKKC1QOJgTf2umVDIoFCkoLQGmz0oyS4oxMagcHumXgAYdtD11L+jFhjHpkWtg+UVRQSSj2Qp2mFghY7kEDuxq+vh9zo/Kp2d5iDv7WBfWXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cPd3DRCZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cPd3DRCZ"
Received: from localhost (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1AFE62038B48;
	Tue,  7 Oct 2025 11:16:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AFE62038B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759860967;
	bh=fZIQkg/lZu7LWCnMY/qKlx0r16KjPbDICAsGIgA4a6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPd3DRCZ4Bo1hvEdRn1FWDtIg473rOqmqGmK8L8glzW4oTZtVF0fY1borNltKl4pY
	 ghW0NIUkUx4R4zpImDLs1NlZ7po+2Zi2U1SFWvALh6vZCMTWu1CaZmHwQF75KaGXR5
	 T4MWuzGthou6snnVNEDclcdI4RYvnpLEJnUb18/E=
Date: Tue, 7 Oct 2025 11:16:06 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and
 efficiency
Message-ID: <20251007111606.00005849@linux.microsoft.com>
In-Reply-To: <aORn/vKfVL88q05w@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<20250924175438.7450-3-jacob.pan@linux.microsoft.com>
	<aORn/vKfVL88q05w@nvidia.com>
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

On Mon, 6 Oct 2025 18:08:14 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Wed, Sep 24, 2025 at 10:54:38AM -0700, Jacob Pan wrote:
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
> > +	 * hurt as the value will remain negative.  
> 
> It seems to me that the change at the first statement is not very
> necessary.
> 
I can delete "We can simply increment the lock counter." since it is
obvious. But the change to delete cmpxchg in the comment matches the
code change the follows.

> > This will also signal the
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
> The returned value is not captured for anything. Is this read()
> necessary? If so, a line of comments elaborating it?
We don't need the return value, how about this explanation?
/*
 * Someone else is holding the lock in exclusive state, so wait
 * for them to finish. Since we already incremented the lock counter,
 * no exclusive lock can be acquired until we finish. We don't need
 * the return value since we only care that the exclusive lock is
 * released (i.e. the lock counter is non-negative).
 */
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
> > 			\  
> 
> By a quick skim, the whole thing looks quite smart to me. But I
> need some time to revisit and perhaps test it as well.
> 
> It's also important to get feedback from Will. Both patches are
> touching his writing that has been running for years already..
Definitely, really appreciated your review. I think part of the reason
is that cmdq size is usually quite large, queue full is a rare case.


