Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366F41C2F4;
	Thu,  2 Jul 2026 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980671; cv=none; b=WJt2gOeDpYrvwLTqn6Vgq7wSyO5x57PX2e63Yhoz3eU3xKcUEldVEtYFWPWS6SoroGezL7AJLqeEDVhCFA5vFEvECBkeV1SvA5Kf7XCB4mqCKpE+SOqvOHn414LtDdWT1IaFtneieGI5UR9elHsa3qJk09CpxmaBTR9P/kqbzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980671; c=relaxed/simple;
	bh=mYcH+RpK3j//gjCyK0LcEBAgi9QNV5XnGpeS1sqmovA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg19wRqXXZmNMsa9EldxQ4hBT56JxzZT12zQ/Z5aGzevoBhTn5av7+HpV4A+9HgXe5+lOtAsi12kwQCqHmqSHotxtLB+jvZs0lMwV4ok9wx4i0UF3h5QqhJKAWNXiVJD5WU6O2kmksboNlLzXuGwEgpnwjFKN/7HtD9Ot0/EOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UKpox/91; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UKpox/91"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/vkCxUYdGc6HsGe8axtJlLSoi45F53TgZTi4SvtWs1s=; b=UKpox/91JI/L79cCRqnEpQdtc5
	s2/XQRarW1t80sqshDVMAeJs35evT6IKdH66ZvNe9kOIYH74jF505hNFvLMveN+HiFqwteAgyxO1X
	dHwrrpoK4appFfILDkF9ML94tGPjkenYUj3d1Y6nYz6wx8z5s4MJxWrXNAc3B+vmB6glkBIAZkT1N
	45CaWj7ihuZKmSgiEMZf8iEpEC/YVuvIwFf42jbgaq0Cyssr4QzMZ1wGswJ3n7BP6sPZ3lOEqSc3+
	gix9Gn/9eqpw3U6zpMm3quj6EbIN11lJJgMbiFjum3PTy4nSi4vLowj24hrMDMX+4OLUKeQbJEtd9
	PN5Ixq7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfCiQ-008Ue0-3A;
	Thu, 02 Jul 2026 08:24:11 +0000
Date: Thu, 2 Jul 2026 01:24:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Kyle McMartin <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <akYf9JXqAakxJEHF@gmail.com>
References: <20260701154528.768976-1-kas@kernel.org>
 <20260702001603.GN7525@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702001603.GN7525@ziepe.ca>
X-Debian-User: leitao

On Wed, Jul 01, 2026 at 09:16:03PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2026 at 04:45:28PM +0100, Kiryl Shutsemau (Meta) wrote:
> > The command, event and PRI queues are sized from the maxima the hardware
> > advertises in IDR1, which can be several megabytes each. On systems with
> > many SMMUv3 instances that cost is paid per instance and adds up to tens
> > of megabytes of coherent DMA in the capture kernel.
> > 
> > A kdump capture kernel runs from a small crashkernel reservation and only
> > has to drive the few devices used to save the dump, so deep queues serve
> > no purpose. The queues carry invalidation commands and fault records, not
> > DMA data, so dump throughput is unaffected; a shallower queue only bounds
> > how many commands may be in flight before a sync, which does not matter for
> > the capture kernel's small device count and modest I/O.
> > 
> > Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> > it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> > in one place. The command queue still holds at least one batch plus a sync
> > (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> > command batching keeps working.
> > 
> > Suggested-by: Kyle McMartin <jkkm@meta.com>
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> Make sense to me
> 
> > +	if (is_kdump_kernel()) {
> > +		u32 ent_sz_shift = ilog2(dwords) + 3;
> > +
> > +		q->llq.max_n_shift = min_t(u32, q->llq.max_n_shift,
> > +					   PAGE_SHIFT - ent_sz_shift);
> 
> I saw lately many people saying you should not use min_t, why is it
> needed here?

Good point, it seems that both of them are u32

    - q->llq.max_n_shift is u32 (struct arm_smmu_ll_queue)
    - ent_sz_shift is u32, and PAGE_SHIFT is a small int constant, so
      PAGE_SHIFT - ent_sz_shift promotes to u32 too.

min() should be enough, I would say. With that, please feel free to add:

Reviewed-by: Breno Leitao <leitao@debian.org>

