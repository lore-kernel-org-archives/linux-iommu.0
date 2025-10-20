Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397882561C2
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986634; cv=none; b=WXL0TZ2avKACEINwFvLpbj0njlfauYC3xDiSvC9ULfSHMxcyAZ0ui+OEw731/630xZkuooR61qH38laXF3URkWep2o7atNA+pIvWKjnASsB7d1kjSkub3D7gA/G455F9EkvkMPuG3QPT8Ls2cfcVxnWYI+5O+24HD+SaKF46PxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986634; c=relaxed/simple;
	bh=JrFrMd47l2XVhkt3eYjK/w5R28XhYzYCka7O7bKiQjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU9c6oRwRK9Z3QfncIP1DLa6YLSRfzKSjQQHX38PHX0dm6+Hv+4S32ienX/lwpHFwjxL2s0XznS0H5YezHwyFwsESac2/QxbOgfpkV5S9VHC7FjiTNZ2ONC/ZFV/jhrHuCcW0SOogTYwNb+7ze+Yi5uZtafrgJr7mViVijagHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XcJMGB4k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XcJMGB4k"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1516B201A7D1;
	Mon, 20 Oct 2025 11:57:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1516B201A7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760986632;
	bh=ATUp/r2Zdqgu9QlD2Mqc7BR6SiPOtyKD1bLuikULXZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcJMGB4kInEz670G4w2FPbtuhqdjpPOYe3eLw5Vj6pyLbDYTUEx5pLYHGUhZqQmAG
	 fyqyuLFNCuzDvZKDZUvqnmRjvmlOie+laQe/hknDfbQ81b7GzAmXjEIV4riDNqqTI0
	 m70T8vip4OfcMxqEIDXghY3tLx5Z0WM8Pquv7Eh0=
Date: Mon, 20 Oct 2025 11:57:10 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Zhang Yu <zhangyu1@linux.microsoft.com>, Jean
 Philippe-Brucker <jean-philippe@linaro.org>, Alexander Grest
 <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251020115710.0000258b@linux.microsoft.com>
In-Reply-To: <20251020120240.GI316284@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
	<aPIhMGnzHiBkIEam@google.com>
	<20251017135145.GL3901471@nvidia.com>
	<20251017095031.00000b84@linux.microsoft.com>
	<20251020120240.GI316284@nvidia.com>
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

On Mon, 20 Oct 2025 09:02:40 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 17, 2025 at 09:50:31AM -0700, Jacob Pan wrote:
> > On Fri, 17 Oct 2025 10:51:45 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:  
> > > > On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:    
> > > > > Hi Will et al,
> > > > > 
> > > > > These two patches are derived from testing SMMU driver with
> > > > > smaller CMDQ sizes where we see soft lockups.
> > > > > 
> > > > > This happens on HyperV emulated SMMU v3 as well as baremetal
> > > > > ARM servers with artificially reduced queue size and
> > > > > microbenchmark to stress test concurrency.    
> > > > 
> > > > Is it possible to share what are the artificial sizes and does
> > > > the HW/emulation support range invalidation (IRD3.RIL)?
> > > > 
> > > > I'd expect it would be really hard to overwhelm the command
> > > > queue, unless the HW doesn't support range invalidation and/or
> > > > the queue entries are close to the number of CPUs.    
> > > 
> > > At least on Jacob's system there is no RIL and there are 72/144
> > > CPU cores potentially banging on this.
> > > 
> > > I think it is combination of lots of required invalidation
> > > commands, low queue depth and slow retirement of commands that
> > > make it easier to create a queue full condition.
> > > 
> > > Without RIL one SVA invalidation may take out the entire small
> > > queue, for example.  
> > Right, no range invalidation and queue depth is 256 in this case.  
> 
> I think Robin is asking you to justify why the queue depth is 256 when
> ARM is recommending much larger depths specifically to fix issues like
> this?
The smaller queue depth is chosen for CMD_SYNC latency reasons. But I
don't know the implementation details of HyperV and host SMMU driver.

IMHO, queue size is orthogonal to what this patch is trying to
address, which is a specific locking problem and improve efficiency.
e.g. eliminated cmpxchg
-	do {
-		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);

Even on BM with restricted queue size, this patch reduces latency of
concurrent madvise(MADV_DONTNEED) from multiple CPUs (I tested 32 CPUs,
cutting 50% latency unmap 1GB buffer in 2MB chucks per CPU).

