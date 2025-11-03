Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B021ADCB
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211802; cv=none; b=owJn3J4HYvR29PQtPP0h1vRQLPc1+vjeamc1IO27KF1wauICmeziidGskI0tei+3E+j5bDCvpY0ia8c6iNojBIKYL5Z09GenZRhbAd4KL23PXzGbyuqE6fbnWEL9jXyenv5glj10GNWBLi0eZG5qiZ6aDQiruhqMD1LVsR1j3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211802; c=relaxed/simple;
	bh=layV8a/eSfEJHAorhxoLXgjYYWppCbPhwTIpTKL2sbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3g3uEHxOvCPt0IIa62dUJrRTsakB44YdlIacjvwkuDfJ8bfHI48QnlO6TsVWE7UR68A/nGqo5ZPpzCRghzVDOsIclHTRnnmSrPfJB+54XjtBEvW96B7ltITWkNtsGI0qxtOP8S/4EhRw54rgqJ/wRXutoQQRUCL2DrwVfWgyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=auEBmJSJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="auEBmJSJ"
Received: from localhost (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B1AE2012087;
	Mon,  3 Nov 2025 15:16:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B1AE2012087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762211792;
	bh=Yo/btQCGKfEDVe5aBR9fTocjuGyxyeQcgsG9HlUVYWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=auEBmJSJ7MV4XjrDOfXAGCYoN9Wpug7JZcztqCUelMDTH/I3SxtbRYacmuHsheSUZ
	 XK3hwfbaC1N2Hx1Y97BWsu6NaGwAFM7739MWoN/dAugQMte+YcJLpZ4upR4uURar9i
	 m+k9cWD0VgDmMweDk2Y6jkBmsQJjKZudGuOFvXTQ=
Date: Mon, 3 Nov 2025 15:16:31 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251103151631.0000703a@linux.microsoft.com>
In-Reply-To: <aQPptXsqzt6kJS7f@Asurada-Nvidia>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
	<20251020224353.1408-2-jacob.pan@linux.microsoft.com>
	<aQPptXsqzt6kJS7f@Asurada-Nvidia>
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

On Thu, 30 Oct 2025 15:41:57 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Mon, Oct 20, 2025 at 03:43:52PM -0700, Jacob Pan wrote:
> > @@ -785,10 +748,33 @@ static int arm_smmu_cmdq_issue_cmdlist(struct
> > arm_smmu_device *smmu, do {
> >  		u64 old;
> >  
> > +		queue_poll_init(smmu, &qp);
> >  		while (!queue_has_space(&llq, n + sync)) {
> > +			unsigned long iflags;
> > +
> >  			local_irq_restore(flags);
> > -			if
> > (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> > -				dev_err_ratelimited(smmu->dev,
> > "CMDQ timeout\n");
> > +			/*
> > +			 * Try to update our copy of cons by
> > grabbing exclusive cmdq access. If
> > +			 * that fails, spin until somebody else
> > updates it for us.
> > +			 */
> > +			if
> > (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, iflags)) {
> > +				WRITE_ONCE(cmdq->q.llq.cons,
> > readl_relaxed(cmdq->q.cons_reg));
> > +
> > arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, iflags);
> > +				llq.val =
> > READ_ONCE(cmdq->q.llq.val);
> > +				local_irq_save(flags);  
> 
> I don't quite get the reason why it moves queue_poll_init() and
> add local_irq_save(). It's quite different than what the driver
> has, so it's nicer to explain in the commit message at least.

Let me add the following to the commit message.

The original code has three nested while loops,
do {
	while (!queue_has_space(&llq, n + sync)) {
		// inside arm_smmu_cmdq_poll_until_not_full
		queue_poll_init(smmu, &qp);
		do {
			if(!queue_full(llq))
				break;
			ret = queue_poll(&qp);

		}while (!ret);
	}
	check exit condition

} while (1);

Now, with this patch we reduced to two nested while loops and
calling queue_has_space() only without checking queue_full.

do {
	queue_poll_init(smmu, &qp);
	while (!queue_has_space(&llq, n + sync)) {
		ret = queue_poll(&qp);
		if (ret == -ETIMEDOUT) {
			dev_err();
			queue_poll_init(smmu, &qp);
		} 
	}
	check exit condition
} while (1);

An additional queue_poll_init is added outside inner while loop to arm
the timer. We can merge the two queue_poll_init with a local bool
variable to track whether init is needed, but IMHO it is not any better.

Adding local_irq_save() just to make sure it pairs up with
local_irq_restore(), no functional changes.

> I still feel that we could just replace the _until_not_full()
> with a _until_has_space()?
Since the current code uses three nested while loops, replacing the
inner _until_not_full() function means means retaining all three nested
while loops and calling queue_has_space in two places - once in the
middle while loop then again in this _until_has_space() function.

I tried to extract the inner loop into a function but it requires
passing in irqflags to restore. Not pretty.

