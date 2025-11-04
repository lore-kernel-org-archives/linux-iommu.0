Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C4D515
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218533; cv=none; b=OJ8ZD21wKRZ9g2k2UXIndxzjRQ+BAMRdDUHrsjqVLfEQqh0Hlq+azTNpwDbABlhSOtf6qGofmwmSCID8nm8k7o6PXiiKFIRdTArp4jYDpa447l+bvHT71aIC8heSUly3j2+bloJutYXzq3JAVwMs6QJ+k6TNhoEl7i4aa19glqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218533; c=relaxed/simple;
	bh=8I4GK4S4q7K9XqrL0+9xFm8+IiIPoGOnFunW253Wh3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx/8f0kTEWGyIiG7BG0JvczPPnaiSTDGqMRGL1M6F9TKbe1CKQudODIz8wCskPXoXHDHJypX8FbhauhfEWvbdtUPEj7qXstbjyA65DmBURwOaz6ALzXjA0EtyTcbX4U1lo4d7mWzRD2+LJ2mvE2R5dF4oBPijXw3lbyXpwqwA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=noYom8TG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="noYom8TG"
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 794A4201208F;
	Mon,  3 Nov 2025 17:08:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 794A4201208F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762218530;
	bh=KSXFQW64ZcSSVpRRiPa8R1BZW5fslHvWf05b4EavBCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=noYom8TGYSq8pqCaKTgRf+MIerhAHrheH6BF5UsL62Lijwt5WJxZl8/9eAIGIZRb4
	 pfOgneYgs15RWXWj+/tDVP76cX9K/awFNY4ZXctTWm8+pqU7C3BTEWPlL78CjUVFzX
	 NuMtUU2//3rf6zXCwiWRYJwvaV/k3DMpPC5s07UY=
Date: Mon, 3 Nov 2025 17:08:48 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness
 and efficiency
Message-ID: <20251103170848.000023aa@linux.microsoft.com>
In-Reply-To: <aQQYIkC9lmQnd27S@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
	<20251020224353.1408-3-jacob.pan@linux.microsoft.com>
	<aQQYIkC9lmQnd27S@Asurada-Nvidia>
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

On Thu, 30 Oct 2025 19:00:02 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Mon, Oct 20, 2025 at 03:43:53PM -0700, Jacob Pan wrote:
> > From: Alexander Grest <Alexander.Grest@microsoft.com>
> > 
> > The SMMU CMDQ lock is highly contentious when there are multiple
> > CPUs issuing commands on an architecture with small queue sizes e.g
> > 256 entries.  
> 
> As Robin pointed out that 256 entry itself is not quite normal,
> the justification here might still not be very convincing..
> 
> I'd suggest to avoid saying "an architecture with a small queue
> sizes, but to focus on the issue itself -- potential starvation.
> "256-entry" can be used a testing setup to reproduce the issue.
> 
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
> 
> It'd be nicer to have a graph to show how the starvation might
> happen due to a race:
> 
> CPU0 (exclusive)  | CPU1 (shared)     | CPU2 (exclusive)    |
> `cmdq->lock`
> --------------------------------------------------------------------------
> trylock() //takes |                   |                     | 0 |
> shared_lock()     |                     | INT_MIN | fetch_inc()
> |                     | INT_MIN | no return         |
>     | INT_MIN + 1 | spins // VAL >= 0 |                     | INT_MIN
> + 1 unlock()          | spins...          |                     |
> INT_MIN + 1 set_release(0)    | spins...          |
>   | 0  <-- BUG? 
Not sure we can call it a bug but it definitely opens the door for
starving shared lock.

>(done)            | (sees 0)          | trylock() //
> takes  | 0 | *exits loop*      | cmpxchg(0, INT_MIN) | 0
>                   |                   | *cuts in*           | INT_MIN
>                   | cmpxchg(0, 1)     |                     | INT_MIN
>                   | fails // != 0     |                     | INT_MIN
>                   | spins // VAL >= 0 |                     | INT_MIN
>                   | *starved*         |                     | INT_MIN
>
Thanks for the graph, will incorporate. The starved shared lock also
prevents advancing cmdq which perpetuate the situation of
!queue_has_space(&llq, n + sync)
 
> And point it out that it should have reserved the "+1" from CPU1
> instead of nuking the entire cmdq->lock to 0.
> 
Will do. reserved the "+1" is useful to prevent back to back exclusive
lock acquisition. Nuking to 0 wasted such info.

> > In a staged test where 32 CPUs issue SVA invalidations
> > simultaneously on a system with a 256 entry queue, the madvise
> > (MADV_DONTNEED) latency dropped by 50% with this patch and without
> > soft lockups.  
> 
> This might not be very useful per Robin's remarks. I'd drop it.
> 
Will do.

> > Reviewed-by: Mostafa Saleh <smostafa@google.com>
> > Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>  
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> > @@ -500,9 +506,14 @@ static bool
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
> > 			\  
> 
> Align the tailing spacing with other lines please.
> 
> Nicolin

