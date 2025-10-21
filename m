Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925F35950
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079075; cv=none; b=bSwkLnXiQ2svPPmHmLUmYoVxN1FAz9CCwN2QVHVjw5OaQlS3LK1HHr4OR+T7effiitNj2OsALhKIGUvlxfHGEfWrJsaXwHS9Z8DR90eAhk7CaTxWIXf83Y2+Ta99+SaqpI7uBtZV18nuPWijlMdg4AQqVBy8CnLFY8Ngz3QeGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079075; c=relaxed/simple;
	bh=HmECysQgda6YvOetuuCfUSWxczoogPdzJj9upSFshvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOp7X2WROdH+wYXENV5RAHD5vMmRbmqcsRqArkQZp4iYgOgBVKj8jgsMRHF5sSe3B5muX1mc31JlI6m8SbMBMMGlt1i6ESFW3ZpIeGIEOKfvsqkbnoaIwbECiotiLPSmfTGGBoQfiFuL8LbnJnJTjgXkYgWoQpxU829YJ4qBX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lMv+yxXz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lMv+yxXz"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F39C201DAC8;
	Tue, 21 Oct 2025 13:37:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F39C201DAC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761079072;
	bh=3phraGjaS/C+izoBKBNrnVVsq7XHeGxq+f7PQUzmclc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMv+yxXz1CbhzOPWDBnC7UAsZnKpAQQHrwV9evjF+MLEJOXyxchubKGxBXqLNkkfS
	 mfGJ03b0TsoofcZeB0ZBkRS45BoTjGWP37kHve+PcnYEY7F1SQGoGJZdo3xQsuqoW1
	 qfBSUvZFhO4ATsMK/x2gTDau/sSv7KRNnaUv68QY=
Date: Tue, 21 Oct 2025 13:37:51 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Will Deacon
 <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest
 <Alexander.Grest@microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251021133751.0000418f@linux.microsoft.com>
In-Reply-To: <336c5a8a-ac2c-4e4c-b2f9-a0bc056aa498@arm.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<aPIhMGnzHiBkIEam@google.com>
	<20251017135145.GL3901471@nvidia.com>
	<20251017095031.00000b84@linux.microsoft.com>
	<20251020120240.GI316284@nvidia.com>
	<20251020115710.0000258b@linux.microsoft.com>
	<336c5a8a-ac2c-4e4c-b2f9-a0bc056aa498@arm.com>
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

On Tue, 21 Oct 2025 12:45:48 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2025-10-20 7:57 pm, Jacob Pan wrote:
> > On Mon, 20 Oct 2025 09:02:40 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> >> On Fri, Oct 17, 2025 at 09:50:31AM -0700, Jacob Pan wrote:  
> >>> On Fri, 17 Oct 2025 10:51:45 -0300
> >>> Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>      
> >>>> On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:  
> >>>>> On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:  
> >>>>>> Hi Will et al,
> >>>>>>
> >>>>>> These two patches are derived from testing SMMU driver with
> >>>>>> smaller CMDQ sizes where we see soft lockups.
> >>>>>>
> >>>>>> This happens on HyperV emulated SMMU v3 as well as baremetal
> >>>>>> ARM servers with artificially reduced queue size and
> >>>>>> microbenchmark to stress test concurrency.  
> >>>>>
> >>>>> Is it possible to share what are the artificial sizes and does
> >>>>> the HW/emulation support range invalidation (IRD3.RIL)?
> >>>>>
> >>>>> I'd expect it would be really hard to overwhelm the command
> >>>>> queue, unless the HW doesn't support range invalidation and/or
> >>>>> the queue entries are close to the number of CPUs.  
> >>>>
> >>>> At least on Jacob's system there is no RIL and there are 72/144
> >>>> CPU cores potentially banging on this.
> >>>>
> >>>> I think it is combination of lots of required invalidation
> >>>> commands, low queue depth and slow retirement of commands that
> >>>> make it easier to create a queue full condition.
> >>>>
> >>>> Without RIL one SVA invalidation may take out the entire small
> >>>> queue, for example.  
> >>> Right, no range invalidation and queue depth is 256 in this case.
> >>>  
> >>
> >> I think Robin is asking you to justify why the queue depth is 256
> >> when ARM is recommending much larger depths specifically to fix
> >> issues like this?  
> > The smaller queue depth is chosen for CMD_SYNC latency reasons. But
> > I don't know the implementation details of HyperV and host SMMU
> > driver.  
> 
> TBH that sounds highly dubious. The only way I could imagine CMDQ
> size bearing any relation to CMD_SYNC at all is if a hypervisor is
> emulating a stage 1 vCMDQ in such a naive and lazy manner that a)
> performance is already off the table, and b) it has a good chance of
> being broken anyway.
> 
> For the hardware to actually process, say, 1023 invalidations
> followed by a sync takes as long as it takes, based on how busy the
> SMMU is. The only difference in issuing that sequence of commands on
> a 256-entry queue vs. a 1024-entry queue is that in the latter case,
> software does not have to sit waiting for the first 768 to actually
> be consumed before it can finish the submission and potentially get
> on with something else until the sync completes. Yes, one could claim
> that technically the time between *issuing* the CMD_SYNC and its
> completion is then lower, but only because that extra time has now
> been wasted in a polling loop waiting for CMDQ space instead - it's a
> meaningless distinction overall.
I agree that a smaller emulated queue size does not change the
time took the physical IOMMU to do the invalidation. I am not defending
the current emulation which I think can be improved overtime
transparent to the guest.

> > IMHO, queue size is orthogonal to what this patch is trying to
> > address, which is a specific locking problem and improve efficiency.
> > e.g. eliminated cmpxchg
> > -	do {
> > -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >=
> > 0);
> > -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1)
> > != val);
> > +	atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);
> > 
> > Even on BM with restricted queue size, this patch reduces latency of
> > concurrent madvise(MADV_DONTNEED) from multiple CPUs (I tested 32
> > CPUs, cutting 50% latency unmap 1GB buffer in 2MB chucks per CPU).  
> My point is that a 50% improvement on nonsense is likely still
> nonsense. With only 256 entries, every single one of those 2MB unmaps
> needs to fill the entire CMDQ more than twice over. 32 CPUs all
> jostling to issue about 34x as many commands as the queue can hold
> *each* is a ridiculous level of contention. If a hypervisor is
> advertising an SMMU_IDR1.CMDQS value that is absurdly tiny for the
> size of the VM then that represents such an obvious bottleneck that
> it's hardly mainline Linux's responsibility to maintain code to help
> "debug" it. As for "BM with restricted queue size", like I said, just
> don't do that.
I don't think we are asking the mainline Linux to debug our emulation
problem, quite the contrary, this setup helped to exposed mainline
Linux's bug (Patch 1/2 clearly shows that the queue space contention
has not been adequately tested)

This madvise test is intended to show:
a) the locking change is functionally sound, no harm to existing
mainline users
b) create extreme contentions that expose the problems with the current
code
c) performance differences

> What is the difference on an un-hacked bare-metal system with a 
> normally-sized queue? Is it even measurable?
Not measurable on my BM system with a large cmdq size. The condition
!queue_has_space() is rarely met, so the exclusive lock is almost never
acquired.

> That's what's actually 
> interesting. Furthermore, what exactly does that measurement even
> mean?
I agree this is not a measurement of real workload performance, but the
test shows:
a) no more occasional soft lockup as shared lock is no longer starved
b) shared lock can be taken quickly as we get rid of the unnecessary
cmpxchg.

> If we're still issuing the same number of commands I struggle
> to believe we could lose 50% of the *overall* time just bouncing a
> cacheline between shared and exclusive state - is this actually just
> the *maximum* per-CPU latency going down, at the cost of the minimum
> latency correspondingly increasing just as much (if not comparatively
> more) due to better fairness? And if so, how important is that
> really? I can imagine there are equally cases where other callers
> might prefer a lower minimum/mean latency at the price of some longer
> outliers.
The importance is that this change avoided a soft lockup where
exclusive lock is taken all the time. It is not about bouncing a
cacheline between shared and exclusive state. I have tried to flush the
lock cacheline after shared lock winning the cmpxchg but it didn't help
avoiding the lockup.

> Note I'm not saying I'm necessarily against making these changes,
> just that I'm against making them without a believable justification
> that it is actually beneficial to mainline users.
The benefit to mainline users ( I assume you meant SMMUs with large cmdq
size), at the minium, is that shared lock can be taken quicker when it
is released from the exclusive state.

> > -	do {
> > -		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >=
> > 0);
> > -	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1)
> > != val);
> > +	atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);

Here is the assembly code diff :

BEFORE:
    27bc:       14000008        b       27dc
<arm_smmu_cmdq_issue_cmdlist+0x364> val =
atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0); 27c0:       93407c00
     sxtw    x0, w0 __CMPWAIT_CASE(w,  , 32);
    27c4:       d50320bf        sevl
    27c8:       d503205f        wfe
    27cc:       885f7c22        ldxr    w2, [x1]
    27d0:       4a000042        eor     w2, w2, w0
    27d4:       35000042        cbnz    w2, 27dc
<arm_smmu_cmdq_issue_cmdlist+0x364> 27d8:       d503205f        wfe
    27dc:       b940ce60        ldr     w0, [x19, #204]
    27e0:       37ffff00        tbnz    w0, #31, 27c0
<arm_smmu_cmdq_issue_cmdlist+0x348> } while
(atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val); 27e4:
11000403        add     w3, w0, #0x1 27e8:       14000004        b
 27f8 <arm_smmu_cmdq_issue_cmdlist+0x380> __CMPXCHG_CASE(w,  ,     ,
32,   ) 27ec:       2a0003e2        mov     w2, w0
    27f0:       88a27c23        cas     w2, w3, [x1]
    27f4:       14000008        b       2814
<arm_smmu_cmdq_issue_cmdlist+0x39c> __CMPXCHG_CASE(    , 32)
    27f8:       93407c04        sxtw    x4, w0
__CMPXCHG_CASE(w,  ,     , 32,        ,  ,  ,         , K)
    27fc:       f9800031        prfm    pstl1strm, [x1]
    2800:       885f7c22        ldxr    w2, [x1]
    2804:       4a040045        eor     w5, w2, w4
    2808:       35000065        cbnz    w5, 2814
<arm_smmu_cmdq_issue_cmdlist+0x39c> 280c:       88057c23        stxr
w5, w3, [x1] 2810:       35ffff85        cbnz    w5, 2800
<arm_smmu_cmdq_issue_cmdlist+0x388> 2814:       6b02001f        cmp
w0, w2 2818:       54fffe21        b.ne    27dc
<arm_smmu_cmdq_issue_cmdlist+0x364>  // b.any

AFTER:
        atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);
    27bc:       b940ce60        ldr     w0, [x19, #204]
    27c0:       7100001f        cmp     w0, #0x0
    27c4:       5400006d        b.le    27d0
<arm_smmu_cmdq_issue_cmdlist+0x358>






> Thanks,
> Robin.

